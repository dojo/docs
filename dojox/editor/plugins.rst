#format dojo_rst

dojox.editor.plugins
====================

:Project owner: Mike Wilcox, Jared Jurkiewicz
:Available: since V1.1

.. contents::
   :depth: 2

The dojox.editor.plugins is a component is a holding place for additional features for the dijit.Editor that load via the dijit.Editor plugin infrastructure.  Some of the plugins are very stable while others may be considered less so.  Please refer to the dojox/editor/README for project status

============
Introduction
============

There are currently a small set of nice features that can be plugged into the dijit.Editor that are contained within this package.  Please refer to the following list for additional details:

* `dojox.editor.plugins.TablePlugins <dojox/editor/plugins/TablePlugins>`_  -- **EXPERIMENTAL**

  A set of plugins for manipulating tables within the editor.  They do not work on all dojo supported browsers.

* `dojox.editor.plugins.PrettyPrint <dojox/editor/plugins/PrettyPrint>`_  -- **STABLE**

  A headless plugin that improves the output format from dijit.Editor by structuring the tag indentions and text lines in a more easily human-readable way.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* `dojox.editor.plugins.PageBreak <dojox/editor/plugins/PageBreak>`_ -- **STABLE**

  A plugin + associated button icon and keybind for inserting page-break styled <hr> tags into the editor document so that upon printing, the document will page break at the desired points.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* `dojox.editor.plugins.ShowBlockNodes <dojox/editor/plugins/ShowBlockNodes>`_  -- **STABLE**

  A plugin + associated button icon and keybind for helping see the current document 'structure' by applying styles to the block elements in the document to make the layout visible.  It does not affect the output contents from the editor in any way, as the styles are applied on the <body> node of the editor iframe document, which is not serialized.  Only the content underneath the body tag is serialized when dijit.Editor.attr("value")/dijit.Editor.getValue() are called.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* `dojox.editor.plugins.Preview <dojox/editor/plugins/Preview>`_ -- **STABLE**

  A plugin + associated button icon that allows you to 'preview' the editor content in a window outside of the editor with CSS styles and stylesheets applied to it.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* `dojox.editor.plugins.Save <dojox/editor/plugins/Save>`_ -- **STABLE**

  A simple plugin + associated button icon that allows you have a toolbar button for saving (POSTing) the content to a URL on your server.  More extensive save logic should extend this plugin and customize it to their needs.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* `dojox.editor.plugins.ToolbarLineBreak <dojox/editor/plugins/ToolbarLineBreak>`_ -- **STABLE**

  A simple plugin that lets you break the editor toolbar to multiple lines.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* `dojox.editor.plugins.InsertEntity <dojox/editor/plugins/InsertEntity>`_ -- **EXPERIMENTAL**

  A plugin that enables inserting 'entity' characters into the editor, such as latin and greek symbols/characters  This plugin is keybound to CTRL-SHIFT-S as well as button driven.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* `dojox.editor.plugins.NormalizeIndentOutdent <dojox/editor/plugins/NormalizeIndentOutdent>`_ -- **EXPERIMENTAL**

  A plugin that tries to normalize indent and outdent behavior across browsers.  It uses margin-left styling to indent/outdent block nodes and the like, and properly handles indenting and outdenting list structures.  It will even attempt to correct malformed lists to make them HTML compliant.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* `dojox.editor.plugins.Breadcrumb <dojox/editor/plugins/Breadcrumb>`_ -- **EXPERIMENTAL**

  A plugin that adds a toolbar footer to the dijit.Editor that shows you the location in the DOM where the cursor is.  If clicked, it selects the node contents.  It also provides dropdown menus that allow you to perform operations on the node in question, such as select, delete, move cursor to start, and move cursor to end.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* `dojox.editor.plugins.FindReplace <dojox/editor/plugins/FindReplace>`_ -- **EXPERIMENTAL**

  A plugin that adds a find/replace toolbar that can be toggled to appear underneath the main toolbar.  It provides the capability to find textm replace text, and replace all occurances of some text.  It also allows searching backwards from current cursor position as well as matching case.  This plugin does NOT work on Opera, as it is making use of Browser specific apis, and Opera doesn't provide a mechanism to do native find.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* `dojox.editor.plugins.CollapsibleToolbar <dojox/editor/plugins/CollapsibleToolbar>`_ -- **STABLE**

  A plugin that modifies the header of the grid and converts it to a collapsible toolbar.  This plugin has been well tested and is known to work well in all browsers supported by dojo.
  
  **This plugin is new to the Dojo Toolkit 1.5.**

========
See Also
========

* `dijit.Editor <dijit/Editor>`_
* `dijit._editor.plugins <dijit/_editor/plugins>`_
