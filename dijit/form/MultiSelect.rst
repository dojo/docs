.. _dijit/form/MultiSelect:

======================
dijit.form.MultiSelect
======================

:Authors: Doug Hays, Steve Peart
:Developers: Doug Hays, Peter Higgins, Bill Keese, Nathan Toone
:since: V?

.. contents ::
   :depth: 2

The MultiSelect widget allows the selection of multiple items.


Introduction
============

The MultiSelect widget is an exact replacement for the native SELECT element and was created to provide a thin widget
wrapper that was necessary to interact with the Form widget, and to provide the ability to select multiple items
which is not available in the FilteringSelect widget.
Like SELECT, you provide a list of acceptable value pairs consisting of text to be displayed and the hidden text value
to be submitted with a FORM.
Unlike FilteringSelect, the user cannot freely type text.

On FORM submit, the selected item's hidden text values of a non-disabled MultiSelect widget are submitted
using a native SELECT element if the *name* attribute was specified at widget creation time.

MultiSelect widgets are not dojo.data-enabled.
This means that the data must be embedded as OPTION tags, children of the parent SELECT element.
However, it is possible to create the OPTION tags dynamically at runtime.


Examples
========

Declarative example
-------------------

MultiSelect widgets always use a native SELECT tag and have child OPTION tags to describe selection choices, e.g.
the OPTION's *value* attribute is used as the submit value and the OPTION's child text node is used as the displayed value.
The OPTION's child text node is used as the displayed value and the OPTION's *value* attribute is used as the hidden submit value.
To set the default value when using OPTION tags, specify the *selected* attribute on 1 of the child OPTION tags.

**Note:** If you are using the declarative example and want to manually specify 'selected' or 'selected="selected"'
on multiple <options> to have multiple selected on the initial load, you'll need to add the multiple="true" attribute
to your native <select> element.
Eg. <select data-dojo-type="dijit/form/MultiSelect" multiple="true"...

.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/form/MultiSelect"]);

  .. html ::

    <select data-dojo-type="dijit/form/MultiSelect" id="fruit" name="fruit" size="4">
        <option value="AP">Apples</option>
        <option value="OR">Oranges</option>
        <option value="PE" selected="selected">Pears</option>
    </select>


Programmatic example
--------------------

.. code-example ::

  .. js ::

    require([
        "dijit/form/MultiSelect", "dijit/form/Button",
        "dojo/dom", "dojo/_base/window", "dojo/domReady!"
    ], function(MultiSelect, Button, dom, win){

        var sel = dom.byId('dynamic');
        var n = 0;
        for(var i in dijit){
            var c = win.doc.createElement('option');
            c.innerHTML = i;
            c.value = n++;
            sel.appendChild(c);
        }
        var myMultiSelect = new MultiSelect({ name: 'dynamic' }, sel);
        myMultiSelect.startup();

        var myButton = new Button({
            onClick: function(){
                alert(myMultiSelect.get('value'));
            }
        }, "progbutton");
        myButton.startup();
    });

  .. html ::

    <select id="dynamic"></select>
    <p><button id="progbutton" type="button">Get value</button></p>


Accessibility
=============

The MultiSelect widget uses native HTML controls.
