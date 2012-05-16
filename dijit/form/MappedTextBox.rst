.. _dijit/form/MappedTextBox:

========================
dijit.form.MappedTextBox
========================

.. contents ::
    :depth: 2

Introduction
============

MappedTextBox is a dijit.form.ValidationTextBox subclass which provides a base class for widgets that have
a visible formatted display value, and a serializable
value in a hidden input field which is actually sent to the server.

Many of the form controls have a concept of "displayed value" vs. "serialized value" (a.k.a. the "real value"),
which is the value passed to the server on form submit.

For example, a NumberSpinner may be declared like

.. html ::

  <div data-dojo-type="dijit/form/NumberSpinner" data-dojo-props="value:1000">

(note the "value" keyword). But when it's displayed in America it looks like "1,000" (with the comma).
And if the user types in "1,234,567", it gets sent back to the server as "123456789".

This is handled internally by having two <input> fields in the widget:

.. image :: ../MappedTextBox.gif

The upshot of this is that Dijit handles localization issues on the client,
so the server doesn't have to worry about it
(except of course for translating the boilerplate text on the page, like the label for the above control).

Extending MappedTextBox
=======================

MappedTextBox is an abstract class. Subclasses of MappedTextBox **MUST** implement the serialize function. MappedTextBox automatically calls the serialize function after the user enters a value. The serialize function takes two arguments: the displayed value to convert, and an object of arbitrary constraints. The syntax and semantics of the constraints depends entirely on what the subclass's serialize function expects. An instance of MappedTextBox **MAY** state per-instance constraints through the constraints property. The serialize function **MUST** return the canonical value corresponding to the passed displayed value.

Examples
========

The following simple example demonstrates how MappedTextBox translates the displayed value (that the user enters) against a trivial lookup table:

.. code-example ::

  .. js ::

    require("dojo","dijit/form/MappedTextBox",function(dojo,MappedTextBox){
        var textbox=new MappedTextBox({
            serialize: function(value){
                switch(value){
                    case "displayedValue1":
                        return "canonicalValue1";
                    case "displayedValue2":
                        return "canonicalValue2";
                    case "displayedValue3":
                        return "canonicalValue3";
                    default:
                        return "canonicalInvalidValue";
                }
            }
        });
        dojo.body().appendChild(textbox.domNode);
    });