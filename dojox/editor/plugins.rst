.. _dojox/editor/plugins:

====================
dojox.editor.plugins
====================

:Project owner: Mike Wilcox, Jared Jurkiewicz
:since: V1.1

.. contents ::
   :depth: 2

The dojox.editor.plugins is a component is a holding place for additional features for the dijit.Editor that load via the dijit.Editor plugin infrastructure.  Some of the plugins are very stable while others may be considered less so.  Please refer to the dojox/editor/README for project status

Introduction
============

There are currently a small set of nice features that can be plugged into the dijit.Editor that are contained within this package.  Please refer to the following list for additional details:

* :ref:`dojox.editor.plugins.TablePlugins <dojox/editor/plugins/TablePlugins>`  -- **EXPERIMENTAL**

  A set of plugins for manipulating tables within the editor.  They do not work on all dojo supported browsers.

* :ref:`dojox.editor.plugins.PrettyPrint <dojox/editor/plugins/PrettyPrint>`  -- **STABLE**

  A headless plugin that improves the output format from dijit.Editor by structuring the tag indentations and text lines in a more easily human-readable way.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* :ref:`dojox.editor.plugins.PageBreak <dojox/editor/plugins/PageBreak>` -- **STABLE**

  A plugin + associated button icon and keybind for inserting page-break styled <hr> tags into the editor document so that upon printing, the document will page break at the desired points.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* :ref:`dojox.editor.plugins.ShowBlockNodes <dojox/editor/plugins/ShowBlockNodes>`  -- **STABLE**

  A plugin + associated button icon and keybind for helping see the current document 'structure' by applying styles to the block elements in the document to make the layout visible.  It does not affect the output contents from the editor in any way, as the styles are applied on the <body> node of the editor iframe document, which is not serialized.  Only the content underneath the body tag is serialized when dijit.Editor.get("value") is called.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* :ref:`dojox.editor.plugins.Preview <dojox/editor/plugins/Preview>` -- **STABLE**

  A plugin + associated button icon that allows you to 'preview' the editor content in a window outside of the editor with CSS styles and stylesheets applied to it.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* :ref:`dojox.editor.plugins.Save <dojox/editor/plugins/Save>` -- **STABLE**

  A simple plugin + associated button icon that allows you have a toolbar button for saving (POSTing) the content to a URL on your server.  More extensive save logic should extend this plugin and customize it to their needs.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* :ref:`dojox.editor.plugins.ToolbarLineBreak <dojox/editor/plugins/ToolbarLineBreak>` -- **STABLE**

  A simple plugin that lets you break the editor toolbar to multiple lines.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* :ref:`dojox.editor.plugins.InsertEntity <dojox/editor/plugins/InsertEntity>` -- **EXPERIMENTAL**

  A plugin that enables inserting 'entity' characters into the editor, such as latin and greek symbols/characters  This plugin is keybound to CTRL-SHIFT-S as well as button driven.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* :ref:`dojox.editor.plugins.NormalizeIndentOutdent <dojox/editor/plugins/NormalizeIndentOutdent>` -- **EXPERIMENTAL**

  A plugin that tries to normalize indent and outdent behavior across browsers.  It uses margin-left styling to indent/outdent block nodes and the like, and properly handles indenting and outdenting list structures.  It will even attempt to correct malformed lists to make them HTML compliant.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* :ref:`dojox.editor.plugins.Breadcrumb <dojox/editor/plugins/Breadcrumb>` -- **EXPERIMENTAL**

  A plugin that adds a toolbar footer to the dijit.Editor that shows you the location in the DOM where the cursor is.  If clicked, it selects the node contents.  It also provides dropdown menus that allow you to perform operations on the node in question, such as select, delete, move cursor to start, and move cursor to end.
  
  **This plugin is new to the Dojo Toolkit 1.4.**

* :ref:`dojox.editor.plugins.FindReplace <dojox/editor/plugins/FindReplace>` -- **STABLE**

  A plugin that adds a find/replace toolbar that can be toggled to appear underneath the main toolbar.  It provides the capability to find text, replace text, and replace all occurrences of some text.  It also allows searching backwards from current cursor position as well as matching case.  This plugin does NOT work on Opera, as it is making use of browser specific API's, and Opera doesn't provide a mechanism to do native find.
  
  **This plugin is updated in Dojo Toolkit 1.6.**

* :ref:`dojox.editor.plugins.CollapsibleToolbar <dojox/editor/plugins/CollapsibleToolbar>` -- **STABLE**

  A plugin that modifies the header of the grid and converts it to a collapsible toolbar.  This plugin has been well tested and is known to work well in all browsers supported by dojo.
  
  **This plugin is new to the Dojo Toolkit 1.5.**

* :ref:`dojox.editor.plugins.Blockquote <dojox/editor/plugins/Blockquote>` -- **STABLE**

  A plugin that adds a blockquoting button to the toolbar.  All text that is part of a block of text will be wrapped in a blockquote tag when applied, or removed from a blockquote tag when untoggled.  It will also work across large selections, blockquoting each chunk of text and inline elements as a blockquote block.  This plugin has been well tested and is known to work well in all browsers supported by dojo.
  
  **This plugin is new to the Dojo Toolkit 1.5.**

* :ref:`dojox.editor.plugins.PasteFromWord <dojox/editor/plugins/PasteFromWord>` -- **BETA**

  A plugin that adds a 'paste from word' icon to the toolbar.  It opens a dialog where content from Word or similar programs can be pasted in, then filters are run against the input to remove extraneous HTML that causes the editor difficulty, leaving the injected content cleaner HTML.
  
  **This plugin is new to the Dojo Toolkit 1.5.**

* :ref:`dojox.editor.plugins.InsertAnchor <dojox/editor/plugins/InsertAnchor>` -- **STABLE**

  A plugin that adds an 'insert anchor' icon to the toolbar.  An anchor is a specialized <a> tag used for linking to specific sections of a document.  The plugin highlights (makes visible), via css what is an anchor in the page.  It also allows for double-click editing of anchors.
  
  **This plugin is new to the Dojo Toolkit 1.5.**

* :ref:`dojox.editor.plugins.TextColor <dojox/editor/plugins/TextColor>` -- **STABLE**

  A plugin that implements color selectors for text color and background color of test using the dojox.widget.ColorPicker instead of dijit.ColorPalette.
  
  **This plugin is new to the Dojo Toolkit 1.5.**

* :ref:`dojox.editor.plugins.NormalizeStyle <dojox/editor/plugins/NormalizeStyle>` -- **EXPERIMENTAL**

  A headless plugin that adds pre and post filters to convert incoming and outgoing editor content into CSS styling (use of span with style attributes), or semantic (use of <b>, </i>, type tags), for common formatting options.  The mode it uses for output is configurable.  The mode it uses for input is determined by browser to try and use the right input mode so that the native browser commands operate reasonably well on the input.
  
  **This plugin is new to the Dojo Toolkit 1.5.**

* :ref:`dojox.editor.plugins.StatusBar <dojox/editor/plugins/StatusBar>` -- **EXPERIMENTAL**

  A plugin that adds a new footer bar to the editor that allows users to post status to the editor.  The posting can be done through direct setting of the value attribute of editor.statusBar, or via a topic.  It also has an optional 'resizer' handle for use when the editor is outside of a sizing content pane.
  
  **This plugin is new to the Dojo Toolkit 1.5.**
  
* :ref:`dojox.editor.plugins.AutoSave  <dojox/editor/plugins/AutoSave>` -- **STABLE**

  A plugin that allows the user to set a time interval after which the editor contents will be automatically saved.
  
  **This plugin is new to the Dojo Toolkit 1.6.**

* :ref:`dojox.editor.plugins.LocalImage <dojox/editor/plugins/LocalImage>` -- **STABLE**

  A plugin that allows the user to insert a local or hosted image into the textstream.
  
  **This plugin is new to the Dojo Toolkit 1.6.**

* :ref:`dojox.editor.plugins.SpellCheck  <dojox/editor/plugins/SpellCheck>` -- **STABLE**

  A plugin that allows the user to spell check editor content either interactively (where unrecognized words are highlighted as they are typed) or as a batch process via a dialog that steps the user through all the content, moving from one unrecognized word to the next. The focus here is on the client-side feature. While a server-side demo is provided, it is expected that a more comprehensive server piece will be deployed.
  
  **This plugin is new to the Dojo Toolkit 1.6.**

* :ref:`dojox.editor.plugins.AutoUrlLink  <dojox/editor/plugins/AutoUrlLink>` -- **STABLE**

  A plugin that allows results in properly documented URLs are recognized and presented as links.
  
  **This plugin is new to the Dojo Toolkit 1.6.**

* :ref:`dojox.editor.plugins.SafePaste <dojox/editor/plugins/SafePaste>` -- **BETA**

  A plugin that extends the PasteFromWord plugin and adds basic content filtering and script tag removal to the dijit.Editor.  It opens a dialog where content from Word or similar programs can be pasted in, then filters are run against the input to remove extraneous HTML that causes the editor difficulty or may be security threats, leaving the injected content cleaner HTML.   It also supports a user specified list of tags that can should be stripped from the content before injecting it into the editor body.

* :ref:`dojox.editor.plugins.BidiSupport <dojox/editor/plugins/BidiSupport>` -- **EXPERIMENTAL**

  A plugin + associated buttons icon and keybinds for advanced bidirectional (bidi) support. It adds several bidi-specific commands, which are not released in native RTE's ('set text direction to left-to-right', 'set text direction to right-to-left', 'change text direction to opposite'). 
  
  **This plugin is new to the Dojo Toolkit 1.10.**

See Also
========

* :ref:`dijit.Editor <dijit/Editor>`
* :ref:`dijit._editor.plugins <dijit/_editor/plugins>`
