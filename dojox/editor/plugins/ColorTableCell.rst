#format dojo_rst

dojox.editor.plugins.ColorTableCell (Under Construction)
========================================================

:Authors: He Gu Yi
:Project owner: Jared Jurkiewicz
:Available: since V1.6

.. contents::
    :depth: 2

Have you ever wanted to pick a color for the background of the table cells in the document? This plug-in is for you.

========
Features
========

Once required in and enabled, this plugin provides the user with the ability to set the background color of the table cells.

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

  <style type="text/css">
    @import "../../form/resources/ColorPicker.css";
    @import "../plugins/resources/css/editorPlugins.css";
    ...
  </style>
  <script type="text/javascript">
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.TablePlugins");
    ...
  </script>
  <div dojoType="dijit.Editor" id="editor1" extraPlugins="[{name: 'dojox.editor.plugins.TablePlugins', command: 'colorTableCell'}]">
  ...
  </div>

And that's it. The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the ColorTableCell plugin!

==============
User Interface
==============

TablePlugin is a plugin for dijit.Editor, which provides the users with the ability to change the background color of table cells.
Select one or more cells and click the toolbar icon to open the setting dialog. The default color is the current background color of the last cell in the selection.

.. image :: OpenDialog.png

There are four ways to set the background color.

* Set the color by pick a color on the palette.
* Set RGB value.
* Set HSV value.
* Set the value in hex directly.

Click **Set** button to set the color or click **Cancel** button to cancel the setting.

.. image :: SettingDialog.png

.. image :: Result.png

===================
A11Y Considerations
===================

All fields within the setting dialog can be accessed with the keyboard.

===========
Limitations
===========

In IE, we have to press and drag the mouse to select the cell (just like what we do to select a piece of text), which is quite different from that of the other browsers.

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
