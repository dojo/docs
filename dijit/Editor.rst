#format sphinx_rst

dijit.Editor
============

Examples
--------

.. codeviewer::

  <script type="text/javascript">
    dojo.require("dijit.Editor");
    dojo.require("dijit._editor.plugins.AlwaysShowToolbar");
    dojo.require("dijit._editor.plugins.EnterKeyHandling");
    dojo.require("dijit._editor.plugins.FontChoice");  // 'fontName','fontSize','formatBlock'
    dojo.require("dijit._editor.plugins.TextColor");
    dojo.require("dijit._editor.plugins.LinkDialog");
  </script>

  <div style="border: 1px solid black;">
    <div dojoType="dijit.Editor" id="editor1"
      onChange="console.log('editor1 onChange handler: ' + arguments[0])">
      <p>This instance is created from a div directly with default toolbar and plugins</p>
      The following HTML should appear as source: &lt;INPUT TYPE="IMAGE" SRC="javascript:alert('no scripting attacks')"&gt;
    </div>
  </div>
