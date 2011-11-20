.. _dijit/_editor/plugins:

dijit.editor.plugins
====================

:Project owner: Bill Keese
:Available: since V1.0

.. contents::
   :depth: 2

The dijit.editor.plugins is a component is a holding place for additional features for the dijit.Editor that load via the dijit.Editor plugin infrastructure. These plugins are generally well tested and are known to work well across browsers. Plugins with specific limitations are addressed in their own documentation

============
Introduction
============

There are currently a small set of nice features that can be plugged into the dijit.Editor that are contained within this package. Please refer to the following list for additional details:

* :ref:`dijit._editor.plugins.ToggleDir <dijit/_editor/plugins/ToggleDir>`  -- **EXPERIMENTAL**

  A plugin that lets you toggle Right-To-Left and Left-To-Right views of the editor content.

* :ref:`dijit._editor.plugins.LinkDialog <dijit/_editor/plugins/LinkDialog>`  -- **STABLE**

  A plugin that enables a hyperlinks and image insert support for dijit.Editor. This provides the two commands 'createlink' and 'insertImage' as registrable toolbar plugins in the editor.

* :ref:`dijit._editor.plugins.FontChoice <dijit/_editor/plugins/FontChoice>`  -- **STABLE**

  A plugin that enables a a 'Font choice' editor for the dijit.Editor. This provides the commands 'fontName', 'fontSize', and 'formatBlock' editor commands to alter font, size, and other formatting options of selected text.

* :ref:`dijit._editor.plugins.TextColor <dijit/_editor/plugins/TextColor>`  -- **STABLE**

  A plugin that enables a a 'Font color' editor for the dijit.Editor. This provides the commands 'foreColor' and 'hiliteColor', editor commands to alter font color and font background color of selected text.

* :ref:`dijit._editor.plugins.FullScreen <dijit/_editor/plugins/FullScreen>`  -- **STABLE**

  A plugin that enables a 'FullScreen' option for the dijit.Editor. This provides a button plus hotkey command for putting the editor in 'Full Screen' mode, where it will fill the entire viewport of the window containing it.

  **This plugin is new to the Dojo Toolkit 1.4.**

* :ref:`dijit._editor.plugins.ViewSource <dijit/_editor/plugins/ViewSource>`  -- **STABLE**

  A plugin that enables a 'ViewSource' mode for the dijit.Editor. This provides a button plus hotkey command for putting the editor in 'Source' mode, where the content HTML can be directly edited.

  **This plugin is new to the Dojo Toolkit 1.4.**

* :ref:`dijit._editor.plugins.Print <dijit/_editor/plugins/Print>`  -- **STABLE**

  A simple plugin that enables a 'Print' command for the dijit.Editor. This provides a button for printing the contents of the editor.

  **This plugin is new to the Dojo Toolkit 1.4.**

* :ref:`dijit._editor.plugins.NewPage <dijit/_editor/plugins/NewPage>`  -- **STABLE**

  A simple plugin that enables a 'New Page' command for the dijit.Editor. This provides a button for resetting the contents of the editor to some default value.

  **This plugin is new to the Dojo Toolkit 1.4.**


========
See Also
========

* :ref:`dijit.Editor <dijit/Editor>`
* :ref:`dojox.editor.plugins <dojox/editor/plugins>`
