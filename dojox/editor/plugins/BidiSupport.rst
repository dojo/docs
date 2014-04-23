.. _dojox/editor/plugins/BidiSupport:

================================
dojox.editor.plugins.BidiSupport
================================

:Author: Semion Chichelnitsky
:since: V1.10

.. contents ::
    :depth: 2

This plugin provides advanced bidirectional (bidi) support for rich text editing widget. It adds several bidi-specific commands, 
which are not released in native RTE's ('set text direction to left-to-right', 'set text direction to right-to-left', 
'change text direction to opposite'). Commands are executed for selected block-level elements by changing their styles. 

Important properties
====================
command     
			Possible values: "bidisupport" and "bidiSupport". Can be used instead of the plugin's name to add plugin to the Editor;
blockMode   
			Possible values: "DIV" (which is the default) and "P". Decides behavior of the ENTER key (by other words, decides, 
			what the new HTML element should be created after user clicked the ENTER key). 
			This property overrides blockNodeForEnter property of the EnterKeyHandling plugin, if it is loaded.
sortcutonly   
			Posiible values: "false" (which is the default) and "true". If it is set to "true", LTR and RTL buttons don't appear.

User Interface
==============

User activates commands,provided by this plugin, using additional left-to-right (LTR) and right-to-left (RTL) toolbar's buttons 

.. image :: BidiButtons.png

or/and using the following shotcuts:
 
- Ctrl + 0    Set RTL text direction
- Ctrl + 8    Set LTR text direction
- Ctrl + 9    Change text direction to opposite. 

Usage
=====

.. code-example ::

First include the CSS for it.

    .. css ::

    @import "dojox/editor/plugins/resources/css/BidiSupport.css";

Then require it into the page where you're using the editor.

    .. js ::
 
    require([
        "dijit/Editor",
        "dojox/editor/plugins/BidiSupport"
    ]);

Now include it in the list of extraPlugins (or in the list of plugins if you're reorganizing the toolbar) for you want to load into the editor, for 
example:

    .. html ::

    <div data-dojo-type="dijit/Editor" id="editor" data-dojo-props="extraPlugins:['bidisupport']"></div>

Examples
========

.. code-example ::

Adding Bidi plugin using command.
    
    .. html ::

    <div data-dojo-type="dijit/Editor" 
      data-dojo-props='plugins: ["bold","italic","|","justifyLeft","justifyCenter","justifyRight","|","formatBlock"], 
      extraPlugins: ["|","insertOrderedList","insertUnorderedList","|","indent","outdent","|","bidiSupport","|",
      "dijit/_editor/plugins/ViewSource"], height: "230px", disableSpellCheck:true'>		
    </div>

Adding Bidi plugin without buttons.

    .. html ::

    <div data-dojo-type="dijit/Editor" 
      data-dojo-props='plugins: ["bold","italic","|","justifyLeft","justifyCenter","justifyRight","|","formatBlock"], 
      extraPlugins: ["|","insertOrderedList","insertUnorderedList","|","indent","outdent","|",
      {name: "dojox/editor/plugins/BidiSupport", shortcutonly: true}, 
      "dijit/_editor/plugins/ViewSource", "collapsibletoolbar"], height: "230px", disableSpellCheck:true'>
    </div>

Adding Bidi plugin with specified blockMode.

    .. html ::

    <div data-dojo-type="dijit/Editor"
      data-dojo-props='plugins: ["bold","italic","|","justifyRight","justifyCenter","justifyLeft","|","formatBlock",
      "dijit/_editor/plugins/EnterKeyHandling"], 
      extraPlugins: ["|","insertOrderedList","insertUnorderedList","|","indent","outdent","|",
      {name: "dojox/editor/plugins/BidiSupport", blockMode: "P"}, "|",
      "dijit/_editor/plugins/ViewSource"], height: "230px", disableSpellCheck:true'>
    </div>
	
See Also
========

* :ref:`dijit.Editor <dijit/Editor>`
* :ref:`dijit._editor.plugins <dijit/_editor/plugins>`
* :ref:`dojox.editor.plugins <dojox/editor/plugins>`
