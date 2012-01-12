.. _dojox/editor/plugins/InsertAnchor:

=================================
dojox.editor.plugins.InsertAnchor
=================================

:Authors: Jared Jurkiewicz
:Project owner: Jared Jurkiewicz
:since: V1.5

.. contents ::
    :depth: 2

Have you ever wanted to insert a named location in your document (anchor), that people can link to using urls and hashes?  If so, then this plugin is for you!

Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* Button with icon in toolbar for inserting and editing anchors in your page
* CSS styling in the edit view that indicates where anchors are  The styles do not appear outside of the editor.


Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.

First include the CSS for it:

.. css ::

    @import "dojox/editor/plugins/resources/css/InsertAnchor.css";

Then require it into the page where you're using the editor:

.. js ::
 
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.InsertAnchor");


Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.  For example:

.. html ::

  <div data-dojo-type="dijit/Editor" id="editor" data-dojo-props="extraPlugins:['insertanchor']"></div>


And that's it.  The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the InsertAnchor plugin!  You can use the button insert and edit anchors in your page.

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
      dojo.require("dojox.editor.plugins.InsertAnchor");

  .. css ::

      @import "{{baseUrl}}dojox/editor/plugins/resources/css/InsertAnchor.css";
    
  .. html ::

    <b>Move the cursor around and select blockquote to blockquote a section of the document.</b>
    <br>
    <div data-dojo-type="dijit/Editor" height="250px" id="input" data-dojo-props="extraPlugins:['insertanchor']">
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
