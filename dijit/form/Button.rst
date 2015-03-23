.. _dijit/form/Button:

=================
dijit/form/Button
=================

:Authors: Becky Gibson, Doug Hays, Bill Keese, Nikolai Onken, Marcus Reimann
:Project owner: Bill Keese
:since: V0.9

.. contents ::
    :depth: 2


Introduction
============

The dijit/form/Button widget is a representation of a normal <button> or <input type="submit/reset/button">.
The default value for the `type` attribute is `button`.

**When creating dijit Buttons declaratively from a <button> element, you *must* specify a type attribute or it will not work consistently across browsers (in IE8, the type will incorrectly default to "submit").**


Examples
========

Programmatic example
--------------------

The first example shows how to create a button programmatically.

.. code-example ::

  .. js ::

    require(["dijit/form/Button", "dojo/dom", "dojo/domReady!"], function(Button, dom){
        // Create a button programmatically:
        var myButton = new Button({
            label: "Click me!",
            onClick: function(){
                // Do something:
                dom.byId("result1").innerHTML += "Thank you! ";
            }
        }, "progButtonNode");
        myButton.startup();
    });

  .. html ::

    <button id="progButtonNode" type="button"></button>
    <div id="result1"></div>


Declarative example
-------------------

As usual, you can create the Button widget declaratively using the data-dojo-type attribute:

.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/form/Button"]);

  .. html ::

    <button data-dojo-type="dijit/form/Button" type="button">Click me too!
        <script type="dojo/on" data-dojo-event="click" data-dojo-args="evt">
            require(["dojo/dom"], function(dom){
                dom.byId("result2").innerHTML += "Thank you! ";
            });
        </script>
    </button>
    <div id="result2"></div>


Show only the icon
------------------

Buttons can have icons and labels, and sometimes they just display an icon, but even in that case you should specify a label for a11y reasons.
Use the showLabel parameter to suppress it from appearing under normal circumstances:

.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/form/Button"]);

  .. html ::

    <button data-dojo-type="dijit/form/Button" data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconCut', showLabel: false" type="button">cut</button>


Change the icon
---------------

You can change an icon of a Button using its iconClass attribute.
Following example toggles the icon if the button:

.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/form/Button"], function(parser){
        parser.parse();
    });
    
    var toggled = false;
    function toggle(){
        myToggleButton.set("iconClass", toggled ? "dijitEditorIcon dijitEditorIconCut" : "dijitEditorIcon dijitEditorIconPaste");
        toggled = !toggled;
    }

  .. html ::

    <button data-dojo-type="dijit/form/Button" data-dojo-id="myToggleButton" onClick="toggle();" data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconCut'" type="button">
        Click me!
    </button>

Event Handlers outside the widget instance 
------------------------------------------

To bind an event handler to a non-global JavaScript object, it is simplest to use dojo/connect to connect to the onClick method of the widget instance.

  .. js ::

    require(["dojo/parser", "dojo/_base/connect", "dijit/registry", "dijit/form/Button"],
    function(parser, connect, registry){
        parser.parse();
        var toggled = false;
        registry.byId("toggleButton").connect("onClick", function toggle(){
           this.set("iconClass", toggled ? "dijitEditorIcon dijitEditorIconCut" : "dijitEditorIcon dijitEditorIconPaste");
            toggled = !toggled;
        });

    });    

  .. html ::

    <button data-dojo-type="dijit/form/Button" id="toggleButton" data-dojo-id="myToggleButton" data-dojo-props="iconClass:'dijitEditorIcon dijitEditorIconCut'" type="button">
        Click me!
    </button>


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

All buttons should include a label parameter with text for the button even if the showLabel parameter is set to false.
The label parameter is used to identify the button in high contrast mode when the icon for the button will no longer be displayed and is also used to identify the button to a screen reader.

Screen Reader
~~~~~~~~~~~~~

In order to identify the button description to the screen reader, all buttons should include a label parameter even if the showLabel parameter is set to false.

See also
========

* :ref:`dijit.form.ComboButton <dijit/form/ComboButton>` - regular button with an arrow on the right to show a drop down (often a menu)
* :ref:`dijit.form.DropDownButton <dijit/form/DropDownButton>` - displays some kind of drop down, often a menu, when pressed
* :ref:`dijit.form.ToggleButton <dijit/form/ToggleButton>` - combination of Button and Checkbox widget
* :ref:`dojox.form.BusyButton <dojox/form/BusyButton>` - implements more user friendly form submission
* :ref:`dojox.mobile.Button <dojox/mobile/Button>` - simple button widget for mobiles
* :ref:`dojox.mobile.ToolBarButton <dojox/mobile/ToolBarButton>` - button placed in the Heading widget for mobiles
