#format dojo_rst

dojox.editor.plugins
====================

:Status: Draft
:Version: 1.0
:Project owner: Mike Wilcox, Jared Jurkiewicz
:Available: since V1.1

.. contents::
   :depth: 2

The dojox.editor.plugins is a component is a holding place for additional features for the dijit.Editor that load via the dijit.Editor plugin infrastructure.  Some of the plugins are very stable while others may be considered less so.  Please refer to the dojox/editor/README for project status

============
Introduction
============

There are currently a small set of nice features that can be plugged into the dijit.Editor that are contained within this package.  Please refer to the following list for additional details:

* `dojox.editor.plugins.TablePlugins <dojox/editor/plugins/TablePlugins>`_  -- **EXPERIMENTAL** -- A set of plugins for manipulating tables within the editor.  They do not work on all dojo supported browsers.

| 

* `dojox.editor.plugins.PrettyPrint <dojox/editor/plugins/PrettyPrint>`_  -- **STABLE**  -- A headless plugin that improves the output format from dijit.Editor by structuring the tag indentions and text lines in a more easily human-readable way.  **This plugin is new to the Dojo Toolkit 1.4.**

|

* `dojox.editor.plugins.PageBreak <dojox/editor/plugins/PageBreak>`_ -- **STABLE**  -- A plugin + associated button icon and keybind for inserting page-break styled <hr> tags into the editor document so that upon printing, the document will page break at the desired points.  **This plugin is new to the Dojo Toolkit 1.4.**

|

* `dojox.editor.plugins.ShowBlockNodes <dojox/editor/plugins/ShowBlockNodes>`_  -- **STABLE** -- A plugin + associated button icon and keybind for helping see the current document 'structure' by applying styles to the block elements in the document to make the layout visible.  It does not affect the output contents from the editor in any way, as the styles are applied on the <body> node of the editor iframe document, which is not serialized.  Only the content underneath the body tag is serialized when dijit.Editor.attr("value")/dijit.Editor.getValue() are called.  **This plugin is new to the Dojo Toolkit 1.4.**

|

* `dojox.editor.plugins.Preview <dojox/editor/plugins/Preview>`_ -- **STABLE**  -- A plugin + associated button icon that allows you to 'preview' the editor content in a window outside of the editor with CSS styles and stylesheets applied to it.  **This plugin is new to the Dojo Toolkit 1.4.**

|


========
See Also
========

* `dijit.Editor <dijit/Editor>`_
