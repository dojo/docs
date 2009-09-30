#format dojo_rst

dijit.form.Button
=================

:Status: Draft
:Version: 1.0
:Authors: Becky Gibson, Doug Hays, Bill Keese, Nikolai Onken, Marcus Reimann
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2

The dijit.form.Button widget is a representation of a normal <button> or <input type="submit/reset/button"/>. The default value for the `type` attribute is `button`. However, if creating Button widgets via markup using IE8 in strict mode, the default value is changed by the browser to `submit`. Because of this, users are encouraged to always specify an explicit `type` attribute.


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
            onClick: function(/*Event*/ e){
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

As usual you can create the button widget declaratively using the dojoType attribute

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <button dojoType="dijit.form.Button" type="button">Click me too!
        <script type="dojo/method" event="onClick" args="evt">
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

    <button dojoType="dijit.form.Button" iconClass="dijitEditorIcon dijitEditorIconCut" showLabel="false" type="button">cut</button>


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

    <button dojoType="dijit.form.Button" id="toggleButton" iconClass="dijitEditorIcon dijitEditorIconCut" type="button">Click me!</button>


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
