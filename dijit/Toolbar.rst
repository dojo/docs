.. _dijit/Toolbar:

=============
dijit/Toolbar
=============

:Project owner: Bill Keese
:since: V?

.. contents ::
    :depth: 2


Introduction
============

Just as dijit.DropDownMenu is a container for dijit.MenuItem's, so dijit.Toolbar is a container for buttons.
Any button-based Dijit component can be placed on the toolbar, including ComboButtons and DropdownButtons.


Examples
========

Programmatic example
--------------------

In this example, we borrow some of the toolbar buttons from the Editor.

.. code-example ::
  :djConfig: async: true

  .. js ::

    require([
        "dijit/Toolbar",
        "dijit/form/Button",
        "dojo/_base/array",
        "dojo/domReady!"
    ], function(Toolbar, Button, array){
        var toolbar = new Toolbar({}, "toolbar");
        array.forEach(["Cut", "Copy", "Paste"], function(label){
            var button = new Button({
                // note: should always specify a label, for accessibility reasons.
                // Just set showLabel=false if you don't want it to be displayed normally
                label: label,
                showLabel: false,
                iconClass: "dijitEditorIcon dijitEditorIcon"+label
            });
            toolbar.addChild(button);
        });
        toolbar.startup();
    });

  .. html ::

    <span id="toolbar"></span>


Note that iconClass is a CSS class that's been defined by the theme, see :ref:`Themes <dijit/themes>` for details.

Declarative example
-------------------

Creation from markup is even easier.

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/Toolbar", "dijit/form/Button", "dijit/form/ToggleButton", "dijit/ToolbarSeparator"]);

  .. html ::

    <!-- Tags end on line afterwards to eliminate any whitespace -->
    <div id="toolbar1" data-dojo-type="dijit/Toolbar"
        ><div data-dojo-type="dijit/form/Button" id="toolbar1.cut"
            data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconCut', showLabel:false">Cut</div
        ><div data-dojo-type="dijit/form/Button" id="toolbar1.copy"
            data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconCopy', showLabel:false">Copy</div
        ><div data-dojo-type="dijit/form/Button" id="toolbar1.paste"
            data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconPaste', showLabel:false">Paste</div
        ><!-- The following adds a line between toolbar sections
            --><span data-dojo-type="dijit/ToolbarSeparator"></span
         ><div data-dojo-type="dijit/form/ToggleButton" id="toolbar1.bold"
            data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconBold', showLabel:false">Bold</div>
    </div>


Drop Downs
==========

By using :ref:`dijit/form/DropDownButton <dijit/form/DropDownButton>` and :ref:`dijit/form/ComboButton <dijit/form/ComboButton>` you can make a toolbar with drop downs.

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/Toolbar", "dijit/form/DropDownButton", "dijit/ColorPalette", "dijit/TooltipDialog", "dijit/form/TextBox"]);

  .. html ::

    <div id="fancy" data-dojo-type="dijit/Toolbar">
        <div data-dojo-type="dijit/form/DropDownButton" data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconBold', showLabel:false">
            <span>Color</span>
            <div data-dojo-type="dijit/ColorPalette"></div>
        </div>
        <div data-dojo-type="dijit/form/DropDownButton" data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconItalic', showLabel:false">
            <span>Dialog</span>
            <div data-dojo-type="dijit/TooltipDialog">
                <label for="first">First name:</label> <input data-dojo-type="dijit/form/TextBox" name="first" id="first"/>
                <br/>
                <label for="last">Last name:</label> <input data-dojo-type="dijit/form/TextBox" name="last" id="last"/>
            </div>
        </div>
    </div>

(The icons are no good but hopefully convey the idea.)


Accessibility
=============

Note the use of showLabel="false" above.
We've specified a label but then hidden it.
This is important for accessibility reasons, so that users that can't see the icon still know what the button does.

Keyboard
--------

===========================================    ==========================
Action                                         Key
===========================================    ==========================
Move focus between widgets in the toolbar      Left and right arrow keys
===========================================    ==========================

Known Issues
------------
In high contrast mode when a toggle button is checked an html entity character (✓) is displayed
since the CSS background image icon for the checked state is no longer visible.
When the toggle button is part of a toolbar the checkmark character does not display properly in IE6.
In IE6 with high contrast mode turned on, a checked toggle button in a toolbar displays as two vertical bars rather than the checkmark character.


See also
========

* :ref:`dijit/MenuBar <dijit/MenuBar>`
