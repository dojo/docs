.. _dojox/editor/plugins/PageBreak:

==============================
dojox.editor.plugins.PageBreak
==============================

:Authors: Jared Jurkiewicz
:Project owner: Jared Jurkiewicz
:since: V1.4

.. contents ::
    :depth: 2

Have you ever wanted to pull your hair out when printing an HTML document because it would page break at bad locations?  There is actually a little-known CSS style that allows **you** to set a point at which printing should page break the document, the 'page-break-after: always' style.  This feature can be important when editing documents on the web, so it's very useful in some cases to be able to insert a page break on demand.  This plugin provides such a function to the dijit.Editor.

Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* Button with icon in toolbar for inserting a page break at the current location in the document.
* Keyboard hotkey: CTRL-SHIFT-ENTER for inserting a page break at the current location in the editor.  (Note that this is a similar keybind to those used by commercial word processors, so it will hopefully be familiar and easy to pick up.).
* Dynamic styling in the page to make the document appear broken into two pages at that point.  Also provides @media CSS so that the styling is not printed (via a print plugin), only that the document page breaks when encountered.

Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.


First include the CSS for it:

.. css ::

    @import "dojox/editor/plugins/resources/css/PageBreak.css";


Then require it into the page where you're using the editor:

.. js ::
 
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.PageBreak");


Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.  For example:

.. html ::

  <div data-dojo-type="dijit/Editor" id="editor" data-dojo-props="extraPlugins:['pageBreak']"></div>


And that's it.  The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the PageBreak plugin!  You can use the button or hotkey to insert page breaks as you desire.

Limitations
===========

The page break plugin only has one limitation coded into it, it will not allow page breaks to be inserted in block elements like <ul> and <ol>, because it tends to make the page view look a bit odd.

Examples
========

Basic Usage
-----------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. js ::

      dojo.require("dijit.form.Button");
      dojo.require("dijit.Editor");
      dojo.require("dojox.editor.plugins.PageBreak");

  .. css ::

      @import "{{baseUrl}}dojox/editor/plugins/resources/css/PageBreak.css";
    
  .. html ::

    <b>Enter some text or select a position, then push the PageBreak button or use CTRL-SHIFT-ENTER, to insert a page break at the desired point.</b>
    <br>
    <div data-dojo-type="dijit/Editor" height="250px" id="input" data-dojo-props="extraPlugins:['pagebreak']">
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

See Also
========

* :ref:`dijit.Editor <dijit/Editor>`
* :ref:`dijit._editor.plugins <dijit/_editor/plugins>`
* :ref:`dojox.editor.plugins <dojox/editor/plugins>`
