.. _dojox/editor/plugins/BidiSupport:

================================
dojox.editor.plugins.BidiSupport
================================

:Author: Semion Chichelnitsky, Ed Chatelain
:since: V1.10

.. contents ::
    :depth: 2

This plugin provides advanced bidirectional (bidi) support for the rich text editing widget. It adds several bidi-specific commands,
which are not released in native RTE's ('set text direction to left-to-right', 'set text direction to right-to-left', 
'change text direction to opposite'). Commands are executed for selected block-level elements by changing their styles. 


User Interface
==============

User activates commands,provided by this plugin, using additional left-to-right (LTR) and right-to-left (RTL) toolbar's buttons 

.. image :: BidiButtons.png

or/and using the following shortcuts:
 
- Ctrl + 0    Set RTL text direction
- Ctrl + 8    Set LTR text direction
- Ctrl + 9    Change text direction to opposite. 

Usage
=====


Basic Usage
-----------
First include the CSS for it.

.. css ::

    @import "dojox/editor/plugins/resources/css/BidiSupport.css";

Then require the editor and plugin into the page. For example:

.. js ::


     require([
              "dijit/Editor",
              "dojox/editor/plugins/BidiSupport"
            ]);

Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.  For example:

.. html ::

    <div data-dojo-type="dijit/Editor" id="editor" data-dojo-props="extraPlugins:['bidisupport']">
        <p>
            This editor is created from a div with the bidisupport plugin.
        </p>
    </div>

And that's it. The editor instance is now enabled with the BidiSupport plugin!


Configuring BidiSupport
-------------------------

The BidiSupport plugin supports two options, "shortcutonly" and "blockMode".
Note that "bidisupport" and "bidiSupport" can be used instead of the plugin's name to add plugin to the Editor.

+-----------------------------------+---------------------------------------------------------------------+------------------------+
| **option**                        | **Description**                                                     | **Required**           |
+-----------------------------------+---------------------------------------------------------------------+------------------------+
| shortcutonly                      |Possible values: "false" (which is the default) and "true". If it is | No                     |
|                                   |set to "true", LTR and RTL buttons don't appear.                     |                        |
+-----------------------------------+---------------------------------------------------------------------+------------------------+
| blockMode                         |Possible values: "DIV" (which is the default) and "P". Decides       | No                     |
|                                   |behavior of the ENTER key (by other words, decides, what the new     |                        |
|                                   |HTML element should be created after user clicked the ENTER key).    |                        |
|                                   |This property overrides blockNodeForEnter property of the            |                        |
|                                   |EnterKeyHandling plugin, if it is loaded.                            |                        |
+-----------------------------------+---------------------------------------------------------------------+------------------------+


Examples
========

Basic Example
---------------------------------

.. code-example ::
  :djConfig: parseOnLoad: true
  :version: 1.10

  .. js ::

      require([
              "dijit/Editor",
              "dojox/editor/plugins/BidiSupport"
              ]);

  .. css ::

       @import "dojox/editor/plugins/resources/css/BidiSupport.css";

  .. html ::

    <!--Adding BidiSupport plugin.-->
    <div data-dojo-type="dijit/Editor"
      data-dojo-props='plugins: ["bold","italic","|","justifyLeft","justifyCenter","justifyRight","|","formatBlock"], 
      extraPlugins: ["|","insertOrderedList","insertUnorderedList","|","indent","outdent","|","bidiSupport","|",
      "dijit/_editor/plugins/ViewSource"], height: "230px", disableSpellCheck:true'>		
        <p>
            This editor is created from a div with the BidiSupport plugin.
        </p>
    </div>

Example adding BidiSupport plugin without buttons
-------------------------------------------------

.. code-example ::
  :djConfig: parseOnLoad: true
  :version: 1.10

  .. js ::

      require([
              "dijit/Editor",
              "dojox/editor/plugins/BidiSupport"
              ]);

  .. css ::

       @import "dojox/editor/plugins/resources/css/BidiSupport.css";


  .. html ::

    <!--Adding BidiSupport plugin without buttons.-->
    <div data-dojo-type="dijit/Editor"
      data-dojo-props='plugins: ["bold","italic","|","justifyLeft","justifyCenter","justifyRight","|","formatBlock"], 
      extraPlugins: ["|","insertOrderedList","insertUnorderedList","|","indent","outdent","|",
      {name: "dojox/editor/plugins/BidiSupport", shortcutonly: true}, 
      "dijit/_editor/plugins/ViewSource", "collapsibletoolbar"], height: "230px", disableSpellCheck:true'>
        <p>
            This editor is created from a div with the BidiSupport plugin.
        </p>
    </div>

Example adding BidiSupport plugin with specified blockMode
----------------------------------------------------------

.. code-example ::
  :djConfig: parseOnLoad: true
  :version: 1.10

  .. js ::

      require([
              "dijit/Editor",
              "dojox/editor/plugins/BidiSupport"
              ]);

  .. css ::

       @import "dojox/editor/plugins/resources/css/BidiSupport.css";

  .. html ::

    <!--Adding BidiSupport plugin with specified blockMode.-->
    <div data-dojo-type="dijit/Editor"
      data-dojo-props='plugins: ["bold","italic","|","justifyRight","justifyCenter","justifyLeft","|","formatBlock",
      "dijit/_editor/plugins/EnterKeyHandling"], 
      extraPlugins: ["|","insertOrderedList","insertUnorderedList","|","indent","outdent","|",
      {name: "dojox/editor/plugins/BidiSupport", blockMode: "P"}, "|",
      "dijit/_editor/plugins/ViewSource"], height: "230px", disableSpellCheck:true'>
        <p>
            This editor is created from a div with the BidiSupport plugin.
        </p>
    </div>
	
See Also
========

* :ref:`dijit.Editor <dijit/Editor>`
* :ref:`dijit._editor.plugins <dijit/_editor/plugins>`
* :ref:`dojox.editor.plugins <dojox/editor/plugins>`
