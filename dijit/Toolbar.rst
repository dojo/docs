#format dojo_rst

dijit.Toolbar
=============

.. contents::
    :depth: 2

:Project owner: Bill Keese
:Available: since V?

============
Introduction
============

Just as dijit.Menu is a container for dijit.MenuItem's, so dijit.Toolbar is a container for buttons. Any button-based Dijit component can be placed on the toolbar, including ComboButtons and DropdownButtons.


========
Examples
========

Programmatic example
--------------------

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


Note that iconClass is a CSS class that's been defined by the theme, see `Themes <dijit-themes>`_ for details.

Declarative example
-------------------

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


==========
Drop Downs
==========

By using `dijit.form.DropDownButton <dijit/form/DropDownButton>`_ and `dijit.form.ComboButton <dijit/form/ComboButton>`_ you can make a toolbar with drop downs.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.Toolbar");
      dojo.require("dijit.form.DropDownButton");
      dojo.require("dijit.ColorPalette");
      dojo.require("dijit.TooltipDialog");
      dojo.require("dijit.form.TextBox");
    </script>

  .. cv:: html

	<div id="fancy" dojoType="dijit.Toolbar">
		<div dojoType="dijit.form.DropDownButton" iconClass="dijitEditorIcon dijitEditorIconBold" showLabel="false">
			<span>Color</span>
			<div dojoType="dijit.ColorPalette"></div>
		</div>
		<div dojoType="dijit.form.DropDownButton" iconClass="dijitEditorIcon dijitEditorIconItalic" showLabel="false">
			<span>Dialog</span>
			<div dojoType="dijit.TooltipDialog">
				<label for="first">First name:</label> <input dojoType="dijit.form.TextBox" name="first" id="first"/>
                                <br/>
				<label for="last">Last name:</label> <input dojoType="dijit.form.TextBox" name="last" id="last"/>
			</div>
		</div>
        </div>

(The icons are no good but hopefully convey the idea.)


=============
Accessibility
=============

Note the use of showLabel="false" above.   We've specified a label but then hidden it.  This is important for accessibility reasons, so that users that can't see the icon still know what the button does.

Keyboard
--------

===========================================    ==========================
Action                                         Key
===========================================    ==========================
Move focus between widgets in the toolbar      Left and right arrow keys
===========================================    ==========================

Known Issues
------------
In hign contrast mode when a toggle button is checked an html entity charcter (✓) is displayed since the CSS background image icon for the checked state is no longer visible. When the toggle button is part of a toolbar the checkmark character does not display properly in IE6. In IE6 with high contrast mode turned on, a checked toggle button in a toolbar displays as two vertical bars rather than the checkmark character.


========
See also
========

* `dijit.MenuBar <dijit/MenuBar>`_
