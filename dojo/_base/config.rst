.. _dojo/_base/config:

===============================
dojo.config (dojo/_base/config)
===============================

:since: V0.4

.. contents ::
   :depth: 2

Configuring Dojo with dojoConfig (formerly known as djConfig)


Introduction
============

Dojo allows developers to override certain global settings that control how the framework operates, including:

* When using dojo.parser to trigger automatic parsing of dijit objects
* During the debugging phase of application development
* When setting specific :ref:`i18n <dojo/i18n>` or localization settings
* If you rename core dojo components or place dojo resources in non-standard locations


Usage
=====

How to Populate dojo.config
---------------------------

dojo.config is an object defined during Dojo's bootstrap process, which can be populated in one of three ways:

* By specifying its properties in the data-dojo-config="..." attribute of the <script> element in which the dojo core gets included in the document (but see the **warning** below)
* By explicitly creating a dojoConfig object BEFORE including the dojo core (i.e. dojo.js)
* By inclusion within a custom build.

Each of these methods will be explained now.

1. Specifying dojo.config options via the data-dojo-config="..." attribute
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A common way to populate dojo.config is via the data-dojo-config="..." attribute of the <script> tag that is used to include the dojo framework in the page (i.e. dojo.js). Typically this looks something like this:

.. html ::
  
  <!DOCTYPE html>
  <html lang="en">
  <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Dojo dojo.config Tutorial</title>
      <script type="text/javascript"
              src="//ajax.googleapis.com/ajax/libs/dojo/1.8/dojo/dojo.js"
              data-dojo-config="parseOnLoad: true, isDebug: true"></script>
  </head>
  <body>
      <p>...</p>
  </body>
  </html>

Note that the use of the data- attribute in the script tag is new and recommended since 1.6. The old djConfig attribute is deprecated but will continue to work until 2.0.

The content of the data-dojo-config="..." attribute is a comma-delimited list of name/value pairs the same as one would use when creating any JavaScript object.

**Warning:  This approach may not work correctly if** your code goes through a proxy that re-writes the HTML and possibly inlines script src files in the HTML. One known case this happens is with UMTS broadband connections. Favor approach #2 below for those cases.

2. Explicitly creating a dojoConfig object BEFORE including the dojo core
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In cases where lots of attributes must be set in the dojo.config object, or for developers who prefer not to use the data attribute, dojo.config can be populated by declaring a dojoConfig variable BEFORE the main dojo.js library is included in the document. This looks something like:

.. html ::
  
  <!DOCTYPE HTML>
  <html lang="en">
  <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Dojo dojoConfig Tutorial</title>
      <script type="text/javascript">
          var dojoConfig = {
              parseOnLoad: true,
              isDebug: true,
              locale: 'en-us',
              extraLocale: ['ja-jp']
          };
      </script>
      <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/dojo/1.8/dojo/dojo.js"></script>
  </head>
  <body>
      <p>...</p>
  </body>
  </html>

As of Dojo 1.6, the variable name djConfig has been deprecated in favor of dojoConfig. The old spelling will continue to work until 2.0.
Note in this example that we've explicitly set a locale for this dojo instance (i.e. US English), and also specified that alongside that the locale resources for Japanese be loaded as well.

Both the data-dojo-config script attribute and the dojoConfig global have the same result - their properties are copied over into dojo.config. In the data attribute case, no dojoConfig global gets created; after bootstrap, dojo.config is the single source of truth for configuration properties. For that reason it is also typically treated as a read-only object - use one of these 2 methods for providing initial values. For brevity's sake, we'll speak of dojoConfig properties from here on.

3. Including dojoConfig in a Custom Build
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When creating a custom build it is possible to bake the dojoConfig object into the build via the scopeDjConfig parameter. You can learn more about the scopeDjConfig parameter in the :ref:`Dojo build system build script docs <build/buildScript>`.

dojoConfig Parameters
---------------------

So now that you know *how* to set global parameters for dojo using dojoConfig, you'd probably like to know *what* parameters are available for setting. For a quick reference, check out the `dojo.config API page <http://dojotoolkit.org/api/dojo/_base/config>`_.

The parameters you specify in dojoConfig are meant to **override** the default settings and do several basic things:

* Tell dojo to load resources for **debugging** along with the core libraries
* Tell dojo which **language and localization** resources to load with the core libraries
* Tell dojo where to find key resources in the event that you are using a **customized naming scheme or a cross-domain (xdomain) build**

Now we'll describe the configuration settings that apply to each of these purposes.

Debugging settings in dojoConfig
--------------------------------

dojoConfig is a quick and easy way to turn dojo's built-in debugging features on and off. Regardless of whether you are using a custom build, or the uncompressed source, the debugging features will be available for you to turn on whenever necessary. The parameters you'll use are the following:

isDebug: true
  When set to "true", isDebug will load dojo's extended debugging tools via Firebug, or Firebug Lite. You will have access to a debugging window regardless of what browser you are using. You can run arbitrary code statements from the debugging console, and also view output statements via dojo's built-in `console.* functions <http://api.dojotoolkit.org/jsdoc/dojo/HEAD/console>`_. When isDebug is "false" (default) some additional debugging information like warning when using deprecated or experimental code are not printed out. Default value is "false".

debugContainerId: "yourContainerId"
  If specified, when the page is rendered dojo will look for an element with the specified id and will put the Firebug Lite console window inside that element. This allows developers extra control over the display of the console window and to easily reference it in their own scripts. By default the div containing the console window does not have an id associated with it.

debugAtAllCosts: true (Dojo < 1.7 only)
  This setting forces the use of the xdomain loader to ensure all loaded modules have their own script tag. This gives you real line numbers in error messages and a complete list of script urls in most debugging tools. There is much more information here on `this tutorial on debugging with dojo <quickstart/debugging>`_. Note, this will break your application, if you pass a variable to dojo.require() instead of a string literal, and if you have code that relies on the synchronous loader i.e. not wrapped in dojo.ready/dojo.ready.
  Version 1.6 has issues with this setting; see http://bugs.dojotoolkit.org/ticket/12608 for more information.  It has been removed in 1.7; see the :ref:`release notes <releasenotes/1.7>`.

.. _dojo/_base/config#locale:

Language and Localization Settings in dojoConfig
------------------------------------------------

There is an extensive discussion of the i18n features of dojo in the :ref:`tutorial on i18n <quickstart/internationalization/index>`. Here we'll briefly cover the two dojoConfig variables that apply to these settings:

locale: "en-us"
  By default, dojo determines the locale of the application by pulling the locale from the browser navigator object.  However, developers can force the default locale by using the dojoConfig locale setting, often done by app servers to establish locale based on user preferences.  Dojo's locale must be established at bootstrap time and cannot be changed later.  Locales must be specified in all lowercase with dashes separating variants.

extraLocale: ["ja-jp"]
  In addition to the locale, developers can specify that extra locale files also be downloaded in parallel.  The argument to the extraLocale parameter is an array of strings representing locales.
  The extraLocale is used only for edge cases like multi-lingual pages or for dynamically switching languages. It is generally more efficient and preferred to switch languages by reloading the page and changing the locale setting.  An example use case for extraLocale would be a language tutorial – a page in the user's native language that teaches Japanese.

Finding Resources in Non-Standard Locations
-------------------------------------------

On occasion, developers may choose not to locate dojo resources in the standard location (i.e. relative to the dojo/dojo.js core file). In such cases it is necessary to tell dojo where to find those resources. The dojoConfig parameters available for this are as follows:

baseUrl: "/assets/mydojo/"
  When using multiple versions of dojo in parallel in a given site, or if the core dojo.js file has been renamed when creating a custom build, the baseUrl parameter should be used to indicate where the dojo core is located. This may also be necessary for sites that use the <base> tag which can confuse some browsers (e.g. IE6). The value for baseUrl should be the directory that contains the dojo.js file. The value should always be defined with an ending slash (/) character.

paths: {"foo": "../../bar"}
  Using this parameter is equivalent of calling require({ paths:{ "foo": "../../bar" }}) and allows dojo to locate custom modules. See more details on this and other loader related configurations in :ref:`AMD loader identifiers <loader/amd#module-identifiers>` and :ref:`AMD loader configuration <loader/amd#configuration>`

Other Options
-------------

afterOnLoad: true
  (defaults to false). Set to true if you are attempting to inject dojo.js into the page after the initial page load has occurred. Only works with a **built** dojo.js; does not work with dojo.js directly from source control.

.. js ::

        var dojoConfig = { afterOnLoad:true };
        window.onload = function(){
            var d = document.getElementsByTagName("head")[0].appendChild(document.createElement('script'));
            d.src = "my/dojo.js";
            d.type = "text/javascript";
        }

addOnLoad: Function or Array
	Adds a callback via dojo.ready(). Useful when Dojo is added after
	the page loads and djConfig.afterOnLoad is true. Supports the same
	arguments as dojo.addOnLoad. When using a function reference, use
	`djConfig.addOnLoad = function(){};`. For object with function name use
	`djConfig.addOnLoad = [myObject, "functionName"];` and for object with
	function reference use `djConfig.addOnLoad = [myObject, function(){}];`

require: Array
	An array of module names to be loaded immediately after dojo.js has been included
	in a page.

dojoBlankHtmlUrl: "dojo/resources/blank.html"
	Used by some modules to configure an empty iframe. Used by dojo.io.iframe and
	dojo.back, and dijit popup support in IE where an iframe is needed to make sure native
	controls do not bleed through the popups. Normally this configuration variable
	does not need to be set, except when using cross-domain/CDN Dojo builds.
	Save dojo/resources/blank.html to your domain and set `djConfig.dojoBlankHtmlUrl`
	to the path on your domain your copy of blank.html.

ioPublish:false
	Set this to true to enable publishing of topics for the different phases of
	IO operations. Publishing is done via dojo.publish. See dojo.__IoPublish for a list
	of topics that are published.

useCustomLogger: Anything?
	If set to a value that evaluates to true such as a string or array and
	isDebug is true and Firebug is not available or running, then it bypasses
	the creation of Firebug Lite allowing you to define your own console object.

transparentColor: [255,255,255]
	Array containing the r, g, b components used as transparent color in dojo.Color;
	if undefined, [255,255,255] (white) will be used.

skipIeDomLoaded: false
  For IE only, skip the DOMContentLoaded hack used. Sometimes it can cause an Operation Aborted error if the rest of the page triggers script defers before the DOM is ready. If this is config value is set to true, then dojo.ready callbacks will not be triggered until the page load event, which is after images and iframes load. If you want to trigger the callbacks sooner, you can put a script block in the bottom of your HTML that calls dojo._loadInit();. If you are using multiversion support, change "dojo." to the appropriate scope name for dojo.


defaultDuration: 200
  Default duration, in milliseconds, for wipe and fade animations within dijits. Assigned to dijit.defaultDuration.

Configuring dojox Modules
-------------------------

There is one final way in which dojoConfig is used, and that is to set preferences or configuration options for dojo extension (i.e. dojox) modules. Since the dojoConfig object is created and available globally on every page request, if you are creating a new dojox module this may be a good location to store global resources. Since dojox modules are by their very nature new and/or experimental, you may need to consult the specific documentation or the source code for the dojox module in question to discover what parameters are available for setting and what they do. A good way to do this is to search the API and/or source code for the string "dojoConfig" which should turn up cases in which it is used. A good example of a dojox extension that uses dojoConfig is dojox.storage, which specifies options for client-side storage providers like Google Gears, and the What WG storage providers. The documentations for the storage providers indicates that you can disable a specific provider by setting an appropriate dojoConfig parameter such as:

.. js ::
  
  var dojoConfig = { disableWhatWGStorage: true }


Using dojoConfig in your Code
-----------------------------

The ambiguity of dojoConfig is very helpful. You can provide functionality and configuration options for users through the pattern outlined by this doc.

If you are developing a widget or otherwise providing an API not available in Dojo, you are still able to utilize the global nature of the dojoConfig variable with one minor caveat: After dojo.js is loaded on a page, the settings passed to dojoConfig (as outlined above) are moved to ``dojo.config``. This is an artifact of the scopeName changing capabilities of Dojo.

.. js ::
  
  var dojoConfig = { parseOnLoad:true, myCustomVariable:true }

This creates a `new` configuration parameter named ``myCustomVariable``. To use this in your application code or widgets, use the ``dojo.config`` member. For instance, a simple :ref:`dojo.declare <dojo/declare>` call:

.. js ::
  
    require(["dojo/_base/declare", "dojo/_base/config"], function(declare, config){
        declare("my.Thinger", null, {
            thingerColor: (config.myCustomVariable ? "wasTrue" : "wasFalse"),
            constructor: function(){
                if(config.myCustomVariable){ ... }
            }
        });
    });

By referencing ``dojo.config.myCustomVariable`` as opposed to relying on ``dojoConfig.myCustomVariable`` you will be able to utilize the variable safely in built versions using an alternate scopeName.

Backwards Compatibility and Order of Precedence
===============================================

For backwards compatibility, the deprecated variable ``djConfig`` is still recognized.

Note, however, that if both ``dojoConfig`` and ``djConfig`` are defined, ``djConfig`` is ignored.

Also note that if the ``dojoConfig`` or ``djConfig`` variable exists *and* the ``data-dojo-config`` attribute is defined, both are consumed, with values in ``data-dojo-config`` taking precedence over those in the variable.
