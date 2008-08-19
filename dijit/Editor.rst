## page was renamed from 1.2/dijit/Editor
## page was renamed from dijit/Editor
#format dojo_rst

dijit.Editor
============

:Status: Draft
:Version: 1.2

Dijit's Rich Text editor, Dijit.Editor, is a text box on steroids. Designed to look and work like a word processor. The editor features a toolbar, HTML output, and a plugin architecture that supports new commands, new buttons and other new features.

Examples
--------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.Editor");
      dojo.require("dijit._editor.plugins.AlwaysShowToolbar");
      dojo.require("dijit._editor.plugins.EnterKeyHandling");
      dojo.require("dijit._editor.plugins.FontChoice");  // 'fontName','fontSize','formatBlock'
      dojo.require("dijit._editor.plugins.TextColor");
      dojo.require("dijit._editor.plugins.LinkDialog");
    </script>

  .. cv:: html

    <div style="margin-top: 5px; border: 1px solid #ccc;">
      <div dojoType="dijit.Editor" id="editor1"
        onChange="console.log('editor1 onChange handler: ' + arguments[0])">
        <p>This instance is created from a div directly with default toolbar and plugins</p>
        The following HTML should appear as source: &lt;INPUT TYPE="IMAGE" SRC="javascript:alert('no scripting attacks')"&gt;
      </div>
    </div>

Available Plugins
-----------------

This is a list of built-in verbs of dijit.Editor:

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
