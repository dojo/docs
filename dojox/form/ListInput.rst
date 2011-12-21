.. _dojox/form/ListInput:

======================
dojox.form.ListInput
======================

:Authors: Benjamin Santalucia
:Developers: Benjamin Santalucia
:since: 1.4

.. contents ::
   :depth: 2

The ListInput widget allow you to create a list of element. It's like the "to" field on hotmail.


Introduction
============

The ListInput widget is a new way for letting user to create a list.

The list is populated by an input. The data written in the field is added to the list when : onblur, enter key pressed, or by adding a separator in the input(like comma).

Data can be validated by a regular expression before the adding.
When page is submitted, you can choose to post all the data or just the valid items.

The left and right arrows are used to re-edit an entry.

Examples
========

Declarative example
-------------------

.. code-example ::

  .. js ::

      dojo.require("dojox.form.ListInput");

  .. html ::

    <div data-dojo-type="dojox.form.ListInput" id="fruit" data-dojo-props="name:'fruit', value:['Apples','Oranges','Pears']"></div>

  .. css ::

      @import "{{baseUrl}}dojox/form/resources/ListInput.css";

Programmatic example
--------------------

.. code-example ::

  .. js ::

        dojo.require("dojox.form.ListInput");
        dojo.ready(function(){
            var sel = dojo.byId('dynamic');
            var n = 0;
            var value = "";
            for(var i in dijit){
                    value += i + ",";
            }
            new dojox.form.ListInput({
                name: 'dynamic',
                value: "Apples,Oranges,Pears"
            }, sel);
        });

  .. html ::

    <div id="dynamic"></div>
    <p><button onClick="alert(dijit.byId('dynamic').get('value'))">Get value</button></p>

  .. css ::

      @import "{{baseUrl}}dojox/form/resources/ListInput.css";

Accessibility
=============
