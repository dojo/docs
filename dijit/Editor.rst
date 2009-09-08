## page was renamed from 1.2/dijit/Editor
## page was renamed from dijit/Editor
#format dojo_rst

dijit.Editor
============

:Status: Draft
:Version: 1.0
:Authors: Becky Gibson, Bill Keese, Nikolai Onken, Marcus Reimann
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2

Dijit's Rich Text editor, Dijit.Editor, is a text box on steroids. Designed to look and work like a word processor. The editor features a toolbar, HTML output, and a plugin architecture that supports new commands, new buttons and other new features.

========
Examples
========

Declarative example
-------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.Editor");
    </script>

  .. cv:: html

      <div dojoType="dijit.Editor" id="editor1" onChange="console.log('editor1 onChange handler: ' + arguments[0])">
        <p>This instance is created from a div directly with default toolbar and plugins</p>
      </div>

Programmatic example
--------------------

Of course, the editor can be created programmatically in addition to declaratively,
although even when created programatically you need to specify a source DOM node to replace:

.. cv:: html

	<div id="programmatic2">This div will become an auto-expanding editor.</div>
	<button
		id="create2"
		onclick="new dijit.Editor({height: '', extraPlugins: ['dijit._editor.plugins.AlwaysShowToolbar']}, dojo.byId('programmatic2')); dojo.query('#create2').orphan();">
	create expanding editor
	</button>


=======
Plugins
=======

A plugin (a.k.a. extension) is something that adds a function to the editor, or changes it's behavior.
Dojo includes a number of editor plugins, and developers can write additional plugins on their own.

Most plugins have an associated toolbar button(s), such as the FontChoice plugin (which has a drop down list for fonts),
but some plugins (like AlwaysShowToolbar) just affect the Editor's behavior without changing the toolbar.

The "plugins" parameter controls which plugins are available, and also controls which builtin editor commands
are available.

If you want to just add plugins above and beyond the standard configuration, then you should use the "extraPlugins" parameter.

Both the "plugins" parameter and the "extraPlugins" parameter are arrays, where each element in the array can be a
simple string or an object (if you need to set options on a plugin).

This example adds the text color, background color, and font selection plugins to the editor by setting extraPlugins.
(Technically, the FontChoice plugin provides two commands, foreground-color and highlight-color.)

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.Editor");
      dojo.require("dijit._editor.plugins.FontChoice");  // 'fontName','fontSize','formatBlock'
      dojo.require("dijit._editor.plugins.TextColor");
    </script>

  .. cv:: html

      <div dojoType="dijit.Editor" id="editor2"
	extraPlugins="['foreColor','hiliteColor',{name:'dijit._editor.plugins.FontChoice', command:'fontName', generic:true}]"
        onChange="console.log('editor2 onChange handler: ' + arguments[0])">
        <p>This instance is created with additional toolbar/ plugins</p>
      </div>

This example starts from scratch, thus removing some items from the toolbar (as compared to the default), like underline, and adding other features, namely the LinkDialog:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.Editor");
      dojo.require("dijit._editor.plugins.LinkDialog");
    </script>

  .. cv:: html

      <div dojoType="dijit.Editor" id="editor3"
	plugins="['bold','italic','|','createLink']"
        onChange="console.log('editor3 onChange handler: ' + arguments[0])">
        <p>This instance is created with customized toolbar/ plugins</p>
      </div>


================
Builtin Commands
================

This is a list of the default commands included in the editor, that can be specified in the plugins parameter (in addition to actual editor plugins in the editor/plugins directory or other places):

* "undo"
* "redo"
* "cut"
* "copy"
* "paste"
* "selectAll"
* "bold"
* "italic"
* "underline"
* "strikethrough"
* "subscript"
* "superscript"
* "removeFormat"
* "insertOrderedList"
* "insertUnorderedList"
* "insertHorizontalRule"
* "indent"
* "outdent"
* "justifyLeft"
* "justifyRight"
* "justifyCenter"
* "justifyFull"
* "createLink"
* "unlink"
* "delete" 

=========================
Additional Editor Plugins
=========================

There are several additional editor plugins contained in the `dojox.editor.plugins <dojox/editor/plugins>`_ project.  The following are listed below as their are considered generally stable and may be useful to you.

* `dojox.editor.plugins.PrettyPrint <dojox/editor/plugins/PrettyPrint>`_  -- **STABLE**  -- A headless plugin that improves the output format from dijit.Editor by structuring the tag indentions and text lines in a more easily human-readable way.  **This plugin is new to the Dojo Toolkit 1.4.**

|

* `dojox.editor.plugins.PageBreak <dojox/editor/plugins/PageBreak>`_ -- **STABLE**  -- A plugin + associated button icon and keybind for inserting page-break styled <hr> tags into the editor document so that upon printing, the document will page break at the desired points.  **This plugin is new to the Dojo Toolkit 1.4.**

|

* `dojox.editor.plugins.ShowBlockNodes <dojox/editor/plugins/ShowBlockNodes>`_  -- **STABLE** -- A plugin + associated button icon and keybind for helping see the current document 'structure' by applying styles to the block elements in the document to make the layout visible.  It does not affect the output contents from the editor in any way, as the styles are applied on the <body> node of the editor iframe document, which is not serialized.  Only the content underneath the body tag is serialized when dijit.Editor.attr("value")/dijit.Editor.getValue() are called.  **This plugin is new to the Dojo Toolkit 1.4.**



=====================
Auto-expanding editor
=====================

Typically an editor has a constant height, and if there's a lot of content it gets a scrollbar.
This is in addition to the main scrollbar for the page.

Editor also has a mode like dijit.form.Textarea where the more a user types, the more the text box expands.

However, that's a bit tricky because if implemented naively the toolbar would eventually scroll off the top
of the page.

The AlwaysShowToolbar plugin prevents that.  It's used along with setting height="" parameter setting.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.Editor");
      dojo.require("dijit._editor.plugins.AlwaysShowToolbar");
    </script>

  .. cv:: html

        <div dojoType="dijit.Editor" id="editor5"
	   extraPlugins="['dijit._editor.plugins.AlwaysShowToolbar']">
			<p>
				This editor is created from a div with AlwaysShowToolbar plugin (do not forget to set height="").
			</p>
	</div>


======================================
Accessibility (1.0 and later versions)
======================================

Keyboard for Editor
-------------------

====================================================================    ======================================================================
Action	                                                                Key
====================================================================    ======================================================================
Move focus to the next widget in the tab order.	                        Tab (must press tab twice in some situations - see Known Issues below)
Move focus to the prior widget in the tab order (the editor toolbar)	Shift+Tab (must press shift-tab twice in some situations - see Known Issues below)
====================================================================    ======================================================================


Keyboard for Editor Toolbar
---------------------------

====================================================================    ======================================================================
Action	                                                                Key
====================================================================    ======================================================================
Move focus to the next enabled button in the toolbar.	                arrow right in left to right locales, arrow left in right to left locales
Move focus to the previous widget in the toolbar	                arrow left in left to right locales; arrow right in right to left locales.
====================================================================    ======================================================================

The arrow keys will not work within any optional drop down lists such as ComboBox or FilteringSelect in the editor toolbar until the drop down list of choices has been activated. Use the backspace or escape key to clear the current selection in the textbox associated with the drop down. When the list of choices is not activated, the arrow keys will move between toolbar buttons rather than within the combobox or select.


Known Issues
------------

* On Firefox, the user must press the Tab key twice before keyboard focus moves to the next widget. This is a permanent restriction on Firefox 2. The reason for this is because Firefox implements usage of the tab key within the editor to indent text and shift-tab to outdent text. There is no keyboard mechanism in Firefox to move focus out of the editor. So, the dijit editor traps the tab key in the editor and sets focus to the editor iframe. From there pressing tab again will move to the next focusable item after the editor. When shift-tab is pressed within the editor, focus is set to the toolbar associated with the editor (currently there is always a toolbar defined for a dijit editor). Even though Firefox 3 now supports the use of the contentEditable attribute to create the editor using a div element, the dijit editor is still implemented using an iframe in Firefox 3 and this tabbing issue remains. Some people are unhappy with the loss of the tab key functionality within the editor. Version 1.2 includes a plug-in option to allow the use of tab and shift-tab within the editor to indent and outdent text.

* In IE6 or 7 when the editor has been created from a textarea the user must press tab twice to set focus into the editor to begin inserting or editing text. Likewise, with focus within editor text the user must press shift-tab twice to set focus back to the toolbar.
