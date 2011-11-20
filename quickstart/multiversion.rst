.. _quickstart/multiversion:

Multiple Versions of Dojo on a Page
====================================

:Authors: James Burke
:Available: since V1.1

.. contents::
   :depth: 3

Dojo has some special configuration and build options to allow more than one version of Dojo to be used on a web page.

============
Introduction
============

As of Dojo  1.1, it is possible to run multiple versions of Dojo in a page, or to even rename the global "dojo", "dijit" and "dojox" variables to some other variable. This capability is useful if:

    * You want to provide your own custom, namespaced library that uses Dojo underneath. It will be possible to use your own private Dojo version without having another version of Dojo on the page interfering with your code.
    * You want to experiment with Dojo 1.1 features with a project using Dojo 1.0 or earlier.

See the Limitations section below for important restrictions on this feature.

Provide custom namespaced library
----------------------------------

You want to create a JavaScript library that you want to distribute to others to use in their pages. The users of your library may be using Dojo on their page, and you want your version of Dojo to not interact with their version.

You call your code "coolio". As you are developing your code, you are using a normal build of Dojo 1.1+ and have your scripts laid out like so:

.. code-block :: text
  
  -scripts
    -dojo
    -dijit
    -dojox
    -coolio
      -actions.js
  -tests
    -test.html

The interface you want to publish to others consists of just one function: coolio.actions.foo(), and it is defined inside the scripts/coolio/actions.js file:

.. code-block :: javascript
  
  dojo.provide("coolio.actions");
  dojo.require("dojo.dnd");
  dojo.require("dijit.ProgressBar");
  coolio.actions.foo = function() { /* Does something that uses dojo.dnd and dijit.ProgressBar */ }

You want to use Dojo, but you do not want it to conflict with other Dojo versions on the page. In this case you can use a djConfig.scopeMap to map dojo, dijit and dojox to different names. Your test page, tests/test.html, might be set up like so:

.. code-block :: html
  
  <head>
  <script type="text/javascript">
  djConfig = {
      scopeMap: [
          ["dojo", "coolio"],
          ["dijit", "cooliow"],
          ["dojox", "cooliox"],
      ],
      modulePaths: {
          "coolio.actions": "../coolio/actions"
      }
  }
  </script>
  <script type="text/javascript" src="../scripts/dojo/dojo.js"></script>
  <script type="text/javascript">
      coolio.require("coolio.actions");
     
      //Notice if you want to include some dojo functionality,
      //you need to reference the "dojo" name in the require call,
      //but it will be added to the "coolio" object:
      coolio.require("dojo.string");
      coolio.addOnLoad(function(){
          //do something with coolio.actions.foo();
          //Can call coolio.string.trim() too.
      });
  </script>
  </head>

For this test page, djConfig.scopeMap has mapped "dojo" to "coolio", "dijit" to "cooliow" and "dojox" to "cooliox". dojo, dijit and dojox will not be visible to this HTML page, just coolio, cooliow and cooliox.

It is not recommended that you map dojo, dijit and dojox all to coolio. Doing so may result in some inadvertent clobbering of variables or objects, since you are basically collapsing dojo, dijit and dojox on top of each other. For example, if dojo.bar was defined and dijit.bar was defined, then one of them would clobber the other.

Also notice the modulePaths configuration for coolio.actions. If we did not do that, the coolio.require("coolio.actions") call would fail.

You can now develop your coolio.actions library in this manner. You can even use djConfig.debugAtAllCosts to do debugging (note that using debugAtAllCosts exposes dojo, dijit and dojox as global variables, so only test with your code in the page, and not mixed with code from another Dojo version).

Once you are ready to deliver your code to other people, use the Dojo build system to wrap up your code into a deliverable to give to others.

Build time
-----------

The build system allows you to "burn in" the scopeMap into the built JS file, avoiding the need for others to do that work.

Define a build profile like the below and save it as coolio.profile.js:

.. code-block :: javascript
  
  dependencies = {
        layers: [
                {
                        name: "dojo.js",
                        dependencies: [
                                "coolio.actions"
                        ]
                }
        ],
        prefixes: [
                [ "dijit", "../dijit" ],
                [ "dojox", "../dojox" ]
                //The mapping below assumes you placed "coolio"
                //as a sibling to the dojo directory. If not, adjust
                //the path accordingly.
                [ "coolio", "../coolio" ]
        ]
  }

Notice the layer name is "dojo.js". This will make it so that your code is merged in with the base dojo.js, so that there is just one layer file that end users have to use. Once the build is complete, feel free to rename the file to "coolio.js" if you like.

The build command to burn in the scope map will look something like this (For Windows, change build.sh to build.bat and use ' instead of \"):

.. code-block :: text
  
  ./build.sh profile=coolio releaseName=coolio version=0.1.0coolio action=release scopeMap=[[\"dojo\",\"coolio\"],[\"dijit\",\"cooliow\"],[\"dojox\",\"cooliox\"]]

The build command above assumes you saved coolio.profile.js in util/buildscripts/profiles. If you have it saved somewhere else, then replace profile=coolio with profileFile=path/to/coolio.profile.js.

This build command will generate a release/coolio directory. At this point you can rename release/coolio/dojo.js to release/coolio/coolio.js if you like.

Deliver the contents of release/coolio to the developers using your library. You can try to deliver just release/coolio/coolio.js, but depending on which dojo/dijit/dojox modules you use, that file may not be enough. You will likely need to do testing to see exactly what files are needed. If you only used the Dojo Base functionality (what comes with the normal dojo.js file), then you are fine just delivering the release/coolio/coolio.js file.

XDomain Build
--------------

If you plan on making an XDomain Build, there are a couple of other build arguments you need to pass:

.. code-block :: text
  
  ./build.sh profile=coolio releaseName=coolio version=0.1.0coolio action=release loader=xdomain xdDojoScopeName=coolio xdDojoPath=http://some.domain.com/path/to/coolio scopeMap=[[\"dojo\",\"coolio\"],[\"dijit\",\"cooliow\"],[\"dojox\",\"cooliox\"]]

This command assumes you will be hosting your code at http://some.domain.com/path/to/coolio/. Under that directory would be the dojo, dijit, dojox and coolio directories.

For xdomain builds, you will want to rename release/coolio/dojo.xd.js to release/coolio/coolio.xd.js, and tell developers to reference http://some.domain.com/path/to/coolio/dojo/coolio.xd.js in their pages.

Using Dojo 1.1 with previous versions of Dojo
----------------------------------------------

You may have an application running Dojo 0.4.3, but you might want to start playing with Dojo 1.1 features. It is always more efficient for the browser if you only use one version of Dojo in your page, but you may not have the time to port your whole application to Dojo 1.1 yet.

Suppose you have your code laid out like so:

.. code-block :: text
  
  -scripts
    -dojo110 (Dojo 1.1.0 build)
      -dojo
        -dojo.js
      -dijit
      -dojox
    -dojo043 (Dojo 0.4.3 build)
      -dojo.js
      -src
      -...
  -tests
    -test.html

To use both versions in a page, the tests/test.html file would look like

.. code-block :: html
  
  <head>
  <script type="text/javascript">
  djConfig = {
      parseOnLoad: true,
      baseUrl: "../scripts/dojo110/dojo/",
      scopeMap: [
          ["dojo", "dojo11"],
          ["dijit", "dijit11"],
          ["dojox", "dojox11"]
      ]
  }
  </script>
  <script type="text/javascript" src="../scripts/dojo110/dojo/dojo.js"></script>
  <script type="text/javascript">
  //Notice that djConfig is being redefined here.
  djConfig = {
      isDebug: true,
      baseRelativePath: "../scripts/dojo043/"
  }
  </script>
  <script type="text/javascript" src="../scripts/dojo043/dojo.js"></script>
  <script type="text/javascript">
      dojo.require("dojo.widget.DropdownDatePicker");
      //Notice the require strings use "dojo" and "dijit"
      //instead of "dojo11" and "dijit11". However, the objects
      //will be used on the page by their "dojo11" and "dijit11"
        //names. For instance, you do a dojo11.require("dojo.string");,
      //but in this page you would call dojo11.string.trim().
      dojo11.require("dijit._Calendar");
      dojo11.require("dojo.date.locale");
      dojo11.require("dojo.parser"); // scan page for widgets
      dojo.addOnLoad(function(){
          //Do something with Dojo 0.4.3 in here.
      });
      dojo11.addOnLoad(function(){
          //Do something with Dojo 1.1 in here.
      });
  </script>
  </head>
  </body>
   
        <input dojoType="dropdowndatepicker" value="2006-10-31" containerToggle="wipe" containerToggleDuration="300" >
   
               
    <p class="tundra">
        <input id="calendar1" dojo11Type="dijit11._Calendar">
   
  </body>

The important points to remember:

 * You can redefine djConfig after Dojo 1.1 is included in the page. This is because Dojo 1.1 keeps an internal copy of the djConfig structure.
 * Only use debugAtAllCosts with Dojo 1.1 if you remove the Dojo 0.4.3 code from the page. Otherwise, bad things will happen. You probably can use debugAtAllCosts with the Dojo 0.4.3 code while Dojo 1.1 is in the page.

For doing builds with multiple versions of Dojo, see the preceding section on custom namespaced libraries. Just replace coolio, cooliow and cooliox with dojo11, dijit11 and dojox11 respectively.

Limitations
-----------

There are some limitations to this feature:

   1. Always use dojo.require() to load code. Do not use script tags in HTML to load the modules. The scoping is accomplished by using the dojo.require machinery. Using raw script tags will break things.
   2. djConfig.debugAtAllCosts only works with one version of Dojo in the page. You can use a scopeMap, but no other versions of Dojo can be in the page.
   3. You must use a build of Dojo to get this behavior. It does not work with running Dojo from a source distribution.
   4. The order of the djConfig.scopeMap array items is important. It always needs to be dojo, dijit then dojox. In addition to the order being important, you must define mappings for all three.
   5. dojo.back only works with one version of Dojo in the page, and it must be named "dojo". Do not use a scopeMap.
