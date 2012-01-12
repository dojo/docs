.. _dojox/editor/plugins/Breadcrumb:

===============================
dojox.editor.plugins.Breadcrumb
===============================

:Authors: Jared Jurkiewicz
:Project owner: Jared Jurkiewicz
:since: V1.4

.. contents ::
    :depth: 2

Have you ever wanted to know how node you were in while editing some rich text?  Have you ever wanted to be sure the entire element was deleted, not just its content?  If so, then this plugin is for you.

Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* A footer toolbar that will show the HTML node nesting.
* Clicking the node name in the footer selects the contents of that node.
* Each node button provides a dropdown for other operations, such as deleting the entire element, or moving the cursor to the start or end of the contents of that element.

Limitations
===========

* This plugin does not work well with the :ref:`full screen <dijit/_editor/plugins/FullScreen>` plugin.  In Full screen mode the footer toolbar is out of view.  This will be fixed in a later version of dojo.  It requires minor updated to Editor as well as the full screen and view source plugins.


Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.

First include the CSS for it:

.. css ::

  @import "dojox/editor/plugins/resources/css/Breadcrumb.css";

Then require it into the page where you're using the editor:

.. js ::
 
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.Breadcrumb");


Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.  For example:

.. html ::

  <div data-dojo-type="dijit/Editor" id="editor" data-dojo-props="extraPlugins:['breadcrumb']"></div>



And that's it.  The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the Breadcrumb plugin!  You can click around in the editor and see the breadcrumb update.  You can also click the buttons in the breadcrumb bar to select contents or activate the dropdown action menu.

Examples
========

Basic Usage
-----------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. js ::

      dojo.require("dijit.Editor");
      dojo.require("dojox.editor.plugins.Breadcrumb");

  .. css ::

      @import "{{baseUrl}}dojox/editor/plugins/resources/css/Breadcrumb.css";
    
  .. html ::

    <br>
    <div data-dojo-type="dijit/Editor" height="250px" id="input" data-dojo-props="extraPlugins:['breadcrumb']">
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
