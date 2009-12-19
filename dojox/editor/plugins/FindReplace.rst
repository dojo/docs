#format dojo_rst

dojox.editor.plugins.FindReplace
================================

:Authors: Jared Jurkiewicz
:Project owner: Jared Jurkiewicz
:Available: since V1.4

.. contents::
    :depth: 2

Have you ever wanted to know how node you were in while editing some rich text?  Have you ever wanted to be sure the entire element was deleted, not just its content?  If so, then this plugin is for you.

========
Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* The ability to find text with modifiers of matching case and searching backwards from current position.
* The ability to replace text, with a modifier to replace all occurances in the document past the current position.

===========
Limitations
===========

* This plugin does not work in Opera.
* Searching backwards does not work well in Internet Explorer.

=====
Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.  The first thing you need to do is require into the page you're using the editor.  This is done in the same spot all your dojo.require calls are made, usually a head script tag.  For example:

.. code-block :: javascript
 
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.FindReplace");


Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.  For example:

.. code-block :: html

  <div dojoType="dijit.Editor" id="editor" extraPlugins="['findreplace']"></div>


You also need to include the CSS for it.  For example:

.. code-block :: html

  <style>
    @import "dojox/editor/plugins/resources/css/FindReplace.css";
  </style>


And that's it.  The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the FindReplace plugin!  To display the find/replace toolbar, click the find/replace toggle button in the main toolbar.  The find/replace toolbar will then appear beneath the main toolbar.  

========
Behavior
========

* The find button will not enable until text has been entered into the find field.
* The replace button will not enable until text is in both the find and replace fields.

To replace a single instance of a word, enter the word in the find box, then enter its replacement in the replacement box.  Click find and it will highlight the first occurance.  Then click replace to replace it.  To find the next one, click find again.

To replace all occurances, simply enter the text to find, the text to replace it with, click the 'All Occurances' checkbox, then click replace.  It will interatively search the document from the current cursor position and replace all instances it finds.


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
      dojo.require("dojox.editor.plugins.FindReplace");
    </script>

  .. css::

    <style>
      @import "{{baseUrl}}dojox/editor/plugins/resources/css/FindReplace.css";
    </style>
    
  .. html::

    <b>Toggle the find/replace toolbar by clicking its menu bar button.</b>
    <br>
    <div dojoType="dijit.Editor" height="250px"id="input" extraPlugins="['findreplace']">
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
