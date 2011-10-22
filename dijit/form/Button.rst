#format dojo_rst

dijit.form.Button
=================

:Authors: Becky Gibson, Doug Hays, Bill Keese, Nikolai Onken, Marcus Reimann
:Project owner: Bill Keese
:Available: since V0.9

.. contents::
    :depth: 2


============
Introduction
============

The dijit.form.Button widget is a representation of a normal <button> or <input type="submit/reset/button"/>. The default value for the `type` attribute is `button`.

**When creating dijit Buttons declaratively from a <button> element, you *must* specify a type attribute or it will not work consistently across browsers (in IE8, the type will incorrectly default to "submit").**


========
Examples
========

Programmatic example
--------------------

The first example shows how to create a button programmatically.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button");

    dojo.addOnLoad(function(){
        // Create a button programmatically:
        var button = new dijit.form.Button({
            label: "Click me!",
            onClick: function(){
                // Do something:
                dojo.byId("result1").innerHTML += "Thank you! ";
            }
        }, "progButtonNode");

    });
    </script>

  .. cv:: html

    <button id="progButtonNode" type="button"></button>
    <div id="result1"></div>


Declarative example
-------------------

As usual you can create the button widget declaratively using the data-dojo-type attribute

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <button data-dojo-type="dijit.form.Button" type="button">Click me too!
        <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
            // Do something:
            dojo.byId("result2").innerHTML += "Thank you! ";
        </script>
    </button>
    <div id="result2"></div>


Show only the icon
------------------

Buttons can have icons and labels, and sometimes they just display an icon, but even in that case you should specify a label for a11y reasons. Use the showLabel parameter to supress it from appearing under normal circumstances:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <button data-dojo-type="dijit.form.Button" data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconCut', showLabel: false" type="button">cut</button>


Change the icon
---------------

You can change an icon of a Button using its iconClass attribute. Following example toggles the icon if the button:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button");

    dojo.addOnLoad(function(){
      var toggled = false;
      dojo.connect(dijit.byId("toggleButton"), "onClick", function(){
        dijit.byId("toggleButton").attr("iconClass", toggled ? "dijitEditorIcon dijitEditorIconCut" : "dijitEditorIcon dijitEditorIconPaste");
        toggled = !toggled;
      });
    });
    </script>

  .. cv:: html

    <button data-dojo-type="dijit.form.Button" id="toggleButton" data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconCut'" type="button">Click me!</button>


=============
Accessibility
=============

Keyboard
--------

==========================================    =================================================
Action                                        Key
==========================================    =================================================
Navigate to a button                          tab - all buttons are in the tab order
Activate the button                           enter or space key
==========================================    =================================================

Known Issues
------------

High Contrast Mode
~~~~~~~~~~~~~~~~~~

All buttons should include a label parameter with text for the button even if the showLabel parameter is set to false. The label parameter is used to identify the button in high contrast mode when the icon for the button will no longer be displayed and is also used to identify the button to a screen reader.

Screen Reader
~~~~~~~~~~~~~

In order to identify the button description to the screen reader, all buttons should include a label parameter even if the showLabel parameter is set to false.

========
See also
========

* `dijit.form.ComboButton <dijit/form/ComboButton>`_ - regular button with an arrow on the right to show a drop down (often a menu)
* `dijit.form.DropDownButton <dijit/form/DropDownButton>`_ - displays some kind of drop down, often a menu, when pressed
* `dijit.form.ToggleButton <dijit/form/ToggleButton>`_ - combination of Button and Checkbox widget
* `dojox.form.BusyButton <dojox/form/BusyButton>`_ - implements more user friendly form submission
* `dojox.mobile.Button <dojox/mobile/Button>`_ - simple button widget for mobiles
* `dojox.mobile.ToolBarButton <dojox/mobile/ToolBarButton>`_ - button placed in the Heading widget for mobiles
