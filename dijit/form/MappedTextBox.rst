.. _dijit/form/MappedTextBox:

========================
dijit.form.MappedTextBox
========================

.. contents ::
    :depth: 2

Introduction
============

MappedTextBox is a dijit.form.ValidationTextBox subclass that provides a base class for widgets that have
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

Using MappedTextBox in your code
================================

Users will find that the existing dijit subclasses of MappedTextBox, such as FilteringSelect, DateTextBox, and NumberSpinner, can fit most of their data conversion use cases with minimal modification. Users who require unusual mappings beyond what dijit provides can implement their own MappedTextBox. To do this, users must implement at least the following functions:

 - **format**: converts the passed serialized value to its corresponding displayed value
 - **parse**: converts the passed displayed value to its corresponding serialized value

Simple programmatic example
===========================

In this example, the user enters a query to a service that expects the query to be in all upper case. The following MappedTextBox silently performs the conversion on the client side. When the user submits a form containing the textbox, the browser will send the MappedTextBox's serialized value, the upper case version of their input, to the server.

.. code-example ::

  .. js ::

    require(["dijit/form/MappedTextBox", "dojo/domReady!"], function(MappedTextBox){
        var textbox = new MappedTextBox({
            format: function(value){
                // format set value to display to user.
                var displayed = this.get("displayedValue");
                if(value.toUpperCase() == displayed.toUpperCase()){
                    // leave user input alone
                    return displayed;
                }else{
                    // update to new value
                    return value;
                }
            },
            parse: function(displayedValue){
                // parse user input to send canonical value to server
                return displayedValue.toUpperCase();
            }
        }, "textBox");
        textbox.startup();
        textbox.set("value", "HI");
    });

  .. html ::

    <div id="textBox"></div>
