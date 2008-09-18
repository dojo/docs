#format dojo_rst

dijit.Toolbar
=============

.. contents::
    :depth: 2

:Status: Draft
:Version: 1.2
:Authors: Bill Keese

Just as dijit.Menu is a container for dijit.MenuItem's, so dijit.Toolbar is a container for buttons. Any button-based Dijit component can be placed on the toolbar, including ComboButtons and DropdownButtons.

Programatic Toolbar
-------------------
In this example, we borrow some of the toolbar buttons from the Editor.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.Toolbar");
      dojo.require("dijit.form.Button");

      var toolbar;
      dojo.addOnLoad(function(){
	  toolbar = new dijit.Toolbar({}, "toolbar");
	  dojo.forEach(["Cut", "Copy", "Paste"], function(label){
		var button = new dijit.form.Button({
                        // note: should always specify a label, for accessibility reasons.
                        // Just set showLabel=false if you don't want it to be displayed normally
                        label: label,
                        showLabel: false,
                        iconClass: "dijitEditorIcon dijitEditorIcon"+label
                });
                toolbar.addChild(button);
          });
      });
    </script>

  .. cv:: html

    <span id="toolbar"></span>



Markup
------
Creation from markup is even easier.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.Toolbar");
      dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <!-- Tags end on line afterwards to eliminate any whitespace -->
    <div id="toolbar1" dojoType="dijit.Toolbar"
        ><div dojoType="dijit.form.Button" id="toolbar1.cut" iconClass="dijitEditorIcon dijitEditorIconCut"   
            showLabel="false">Cut</div
        ><div dojoType="dijit.form.Button" id="toolbar1.copy" iconClass="dijitEditorIcon dijitEditorIconCopy" 
            showLabel="false">Copy</div
        ><div dojoType="dijit.form.Button" id="toolbar1.paste" iconClass="dijitEditorIcon dijitEditorIconPaste" 
            showLabel="false">Paste</div
        ><!-- The following adds a line between toolbar sections
            --><span dojoType="dijit.ToolbarSeparator"></span
         ><div dojoType="dijit.form.ToggleButton" id="toolbar1.bold" 
            iconClass="dijitEditorIcon dijitEditorIconBold" showLabel="false">Bold</div>
   </div>


Poor Man's MenuBar
------------------
Here's a Toolbar that looks like a MenuBar.
We haven't implemented a MenuBar for dijit yet so some people use the Toolbar as a poor-man's substitute.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.Toolbar");
      dojo.require("dijit.form.Button");
      dojo.require("dijit.Menu");
    </script>

  .. cv:: html

	<div id="menubar" dojoType="dijit.Toolbar" class="menuBar">
		<div dojoType="dijit.form.DropDownButton">
			<span>File</span>
			<div dojoType="dijit.Menu">
				<div dojoType="dijit.MenuItem">New</div>
				<div dojoType="dijit.MenuItem">Open</div>
				<div dojoType="dijit.MenuSeparator"></div>
				<div dojoType="dijit.MenuItem" iconClass="dijitEditorIcon dijitEditorIconSave">Save</div>
				<div dojoType="dijit.MenuItem">Save As...</div>
			</div>
		</div>
		<div dojoType="dijit.form.DropDownButton">
			<span>Edit</span>
			<div dojoType="dijit.Menu">
				<div dojoType="dijit.MenuItem" iconClass="dijitEditorIcon dijitEditorIconCut">Cut</div>
				<div dojoType="dijit.MenuItem" iconClass="dijitEditorIcon dijitEditorIconCopy">Copy</div>
				<div dojoType="dijit.MenuItem" iconClass="dijitEditorIcon dijitEditorIconPaste">Paste</div>
			</div>
		</div>
        </div>
