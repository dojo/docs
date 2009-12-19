#format dojo_rst

dojox.editor.plugins.Save
=========================

:Authors: Jared Jurkiewicz
:Project owner: Jared Jurkiewicz
:Available: since V1.4

.. contents::
    :depth: 2

Have you ever wanted a simple toolbar based 'Save' action for the editor that just posts the content back to some URL?   If so, then this plugin is for you!  This plugin provides a 'save' capability, a simple toolbar action for saving the editor contents by POSTing the content to a remote URL.

========
Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* Button with icon in toolbar for saving the content by POSTing it back to a designated URL.
* Designed to be simple and easily extendable.

=====
Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.  The first thing you need to do is require into the page you're using the editor.  This is done in the same spot all your dojo.require calls are made, usually a head script tag.  For example:

.. code-block :: javascript
 
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.Save");


Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.  For example:

.. code-block :: html

  <div dojoType="dijit.Editor" id="editor" extraPlugins="[{name: 'save', url: 'myRemoteSaveService'}]"></div>


You also need to include the CSS for it.  For example:

.. code-block :: html

  <style>
    @import "dojox/editor/plugins/resources/css/Save.css";
  </style>


And that's it.  The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the basic Save plugin!  When you click the save button, the content is sent via xhrPort to the url 'myRemoteSaveService'.

===========
Limitations
===========

* The basic implementation uses xhrPost, and therefore is bound by the same domain restriction of the browser.  This means the content can only be posted back to the same hostname and port that served the page that initialized the editor.

* When extending the plugin, you will need to assign a new custom name to it, such as 'mySave', because of how the plugin infrastructure of Editor loads the plugins.  It uses a publish/subscribe mechanism and each plugin definition needs a unique name.

========
Examples
========

Basic Usage
-----------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. javascript::

    <script>
      dojo.require("dijit.Editor");
      dojo.require("dojox.editor.plugins.Save");
    </script>

  .. css::

    <style>
      @import "{{baseUrl}}dojox/editor/plugins/resources/css/Save.css";
    </style>
    
  .. html::

    <b>Enter whatever you like in the editor, then press the 'Save' button.  The console will emit a message about no post-back URL, since there is no service assigned to the demo.</b>
    <br>
    <div dojoType="dijit.Editor" height="250px"id="input" extraPlugins="['save']">
    <div>
    <br>
    blah blah & blah!
    <br>
    </div>
    <br>
    <table>
    <tbody>
    <tr>
    <td style="border-style:solid; border-width: 2px; border-color: gray;">One cell</td>
    <td style="border-style:solid; border-width: 2px; border-color: gray;">
    Two cell
    </td>
    </tr>
    </tbody>
    </table>
    <ul> 
    <li>item one</li>
    <li>
    item two
    </li>
    </ul>
    </div>

Customizing a save
------------------

.. code-example::
  :djConfig: parseOnLoad: false
  :version: 1.4

  .. javascript::

    <script>
      dojo.require("dojo.parser");
      dojo.require("dijit.Editor");
      dojo.require("dojox.editor.plugins.Save");

      dojo.addOnLoad(function(){

        dojo.declare("mySavePlugin", [dojox.editor.plugins.Save],{
          save: function(content){
            alert(content);
            this.inherited(arguments);
          }
        });

        dojo.subscribe(dijit._scopeName + ".Editor.getPlugin",null,function(o){
          if(o.plugin){ return; }
          var name = o.args.name.toLowerCase();
          if(name ===  "mysave"){
             o.plugin = new mySavePlugin({
               url: ("url" in o.args)?o.args.url:"",
               logResults: ("logResults" in o.args)?o.args.logResults:true
             }); 
           }
         });
         //Now we can parse the page since we defined our save plugin above.
         dojo.parser.parse();
        });
    </script>

  .. css::

    <style>
      @import "{{baseUrl}}dojox/editor/plugins/resources/css/Save.css";
    </style>
    
  .. html::

    <b>Enter whatever you like in the editor, then press the 'Save' button.  An alert will appear with the content before the actual save is invoked.</b>
    <br>
    <div dojoType="dijit.Editor" height="250px"id="input" extraPlugins="['mySave']">       
    <div>
    <br>
    blah blah & blah!
    <br>
    </div>
    <br>
    <table>
    <tbody>
    <tr>
    <td>One cell</td>
    <td>
    Two cell
    </td>
    </tr>
    </tbody>
    </table>
    <ul> 
    <li>item one</li>
    <li>
    item two
    </li>
    </ul>
    </div>

========
See Also
========

* `dijit.Editor <dijit/Editor>`_
* `dojox.editor.plugins <dojox/editor/plugins>`_
