#format dojo_rst

dojox.editor.plugins.ResizeTableColumn (Under Construction)
===========================================================

:Authors: He Gu Yi
:Project owner: Jared Jurkiewicz
:Available: since V1.6

.. contents::
    :depth: 2

Have you ever wanted to resize the width of the table column by dragging the edge of the table columnin the editor's document? This plug-in is for you.

========
Features
========

Once required in and enabled, this plugin provides the users with the ability to resize the width of the table column by dragging the edge of the column in the editor.

=====
Usage
=====

Basic Usage
-----------
Usage of this plugin is simple and painless. The first thing you need to do is require the editor into the page. This is done in the same spot all your dojo.require called are made, usually a head script tag. For example:

.. code-block :: html

  <script type="text/javascript">
    dojo.require("dijit.Editor");
    ...
  </script>
  ...
  <div dojoType="dijit.Editor" id="editor1">
  ...
  </div>

Then just declare the plugin and configure it as follows. 

.. code-block :: html

  <script type="text/javascript">
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.ResizeTableColumn");
    ...
  </script>
  <div dojoType="dijit.Editor" id="editor1" extraPlugins="[{name: 'dojox.editor.plugins.TablePlugins', command: 'ResizeTableColumn'}]">
  ...
  </div>

And that's it. The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the ResizeTableColumn plugin!

==============
User Interface
==============

ResizeTableColumn plugin is a plugin for dijit.Editor, which provides the users with the ability to resize the width of the table columns. The width of column can be changed by dragging and dropping the edge of the column. The result of the drag&drop is as follows:

* The width of the table column can be changed by dragging the edge of the column.
* The delta width is either taken from or added to the adjacent column on the trailing edge (for G11N)
* Sizing the rightmost or leftmost columns affects only those columns.
* The leading and trailing columns can only be sized to the extent of the containing div.

.. image :: ResizeTableColumn.png

===========
Limitations
===========

None.

========
Examples
========

Basic Usage
-----------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.6

  .. javascript::

    <script>
      dojo.require("dijit.Editor");
      dojo.require("dojox.editor.plugins.AutoSave");
    </script>

  .. css::

    <style>
      @import "{{baseUrl}}dojox/editor/plugins/resources/css/AutoSave.css";
    </style>
    
  .. html::

    <b>Click the down arrow and select Set Auto-Save Interval... to save at intervals</b>
    <br>
    <div dojoType="dijit.Editor" height="250px"id="input" extraPlugins="['autosave']">
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
