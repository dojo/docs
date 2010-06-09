#format dojo_rst

dojox.editor.plugins.StatusBar
==============================

:Authors: Jared Jurkiewicz
:Project owner: Jared Jurkiewicz
:Available: since V1.5

.. contents::
    :depth: 2

Have you ever wanted a status bar on the editor to display things like 'saving' and so on?  Have you ever wanted a resize handle on the editor that lets you resize it?  If so, then this plugin if for you. 

========
Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* Footer toolbar with a status field that can be updated either via direct statusbar.set("value", "someValue") calls or through publishing to a topid named {editor ID]_statusBar.
* Resize handler that allows users to resize the editor.  It can be disabled, when used inside a layout container that will handle resizing of the editor.


=====
Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.  The first thing you need to do is require into the page you're using the editor.  This is done in the same spot all your dojo.require calls are made, usually a head script tag.  For example:

.. code-block :: javascript
 
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.StatusBar");


Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.  Be sure to list it as the last plugin.  For example:

.. code-block :: html

  <div dojoType="dijit.Editor" id="editor" extraPlugins="['statusbar']"></div>

Or a status bar without resizer:

.. code-block :: html

  <div dojoType="dijit.Editor" id="editor" extraPlugins="[{name:'statusbar',resizer:false}]"></div>

You also need to include the CSS for it.  For example:

.. code-block :: html

  <style>
    @import "dojox/editor/plugins/resources/css/StatusBar.css";
  </style>


And that's it.  The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the StatusBar plugin.  You can now use the status bar to display status in the following ways:

.. code-block :: javascript

  dijit.byId("someEditor").statusBar.set("value", "new Value");

  // OR:

  dojo.publish("someEditor_statusBar", ["Some message"]);

========
Examples
========

Basic Usage
-----------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.5

  .. javascript::

    <script>
      dojo.require("dijit.Editor");
      dojo.require("dojox.editor.plugins.StatusBar");
    </script>

  .. css::

    <style>
      @import "{{baseUrl}}dojox/editor/plugins/resources/css/StatusBar.css";
    </style>
    
  .. html::

    <b>Move the cursor around and select blockquote to blockquote a section of the document.</b>
    <br>
    <div dojoType="dijit.Editor" height="250px"id="input" extraPlugins="['statusbar']">
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

========
See Also
========

* `dijit.Editor <dijit/Editor>`_
* `dijit._editor.plugins <dijit/_editor/plugins>`_
* `dojox.editor.plugins <dojox/editor/plugins>`_
