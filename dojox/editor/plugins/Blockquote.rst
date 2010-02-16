#format dojo_rst

dojox.editor.plugins.Blockquote
===============================

:Authors: Jared Jurkiewicz
:Project owner: Jared Jurkiewicz
:Available: since V1.4

.. contents::
    :depth: 2

Have you ever wanted to set apart a section of text in your document as a 'quotation' of something someone else has said?  Have you ever wanted to remove quotation indication from a section of text in your document?  If so, then this plugin is for you!

========
Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* Button with icon in toolbar for toggling selections and sections of text as <blockquote> wrapped or not.
* Handles blockquoting a section from current cursor position as well as blockquoting the selected section of the document as best it can determine.
* Updates its blockquote status based on whether or not the cursor is positioned inside a blockquoted section of the document.

=====
Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.  The first thing you need to do is require into the page you're using the editor.  This is done in the same spot all your dojo.require calls are made, usually a head script tag.  For example:

.. code-block :: javascript
 
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.Blockquote");


Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.  For example:

.. code-block :: html

  <div dojoType="dijit.Editor" id="editor" extraPlugins="['blockquote']"></div>


You also need to include the CSS for it.  For example:

.. code-block :: html

  <style>
    @import "dojox/editor/plugins/resources/css/Blockquote.css";
  </style>


And that's it.  The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the Blockqupte plugin!  You can use the button to toggle the quotation mode of the text underneath the cursor in the document, or across a selection of text in the document.

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
      dojo.require("dijit.form.Button");
      dojo.require("dijit.Editor");
      dojo.require("dojox.editor.plugins.Blockquote");
    </script>

  .. css::

    <style>
      @import "{{baseUrl}}dojox/editor/plugins/resources/css/Blockquote.css";
    </style>
    
  .. html::

    <b>Move the cursor around and select blockquote to blockquote a section of the document.</b>
    <br>
    <div dojoType="dijit.Editor" height="250px"id="input" extraPlugins="['blockquote']">
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
