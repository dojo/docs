#format dojo_rst

dojox.form.ListInput
======================

:Status: Draft
:Version: 1.0
:Authors: Benjamin Santalucia
:Developers: Benjamin Santalucia
:Available: 1.4

.. contents::
   :depth: 2

The ListInput widget allow you to create a list of element. It's like the "to" field on hotmail.


============
Introduction
============

The ListInput widget is a new way for letting user to create a list.

The list is populated by an input. The datas written in the field are added to the list when : onblur, enter key pressed, or by adding a separator in the input(like comma).

Datas can be validated by a regular expression before the adding.
When page is submitted, you can choose to post all datas or just the valid one.

The left and right arrows are used to re-edit an entry.

========
Examples
========

Declarative example
-------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojox.form.ListInput");
    </script>

  .. cv:: html

    <div dojoType="dojox.form.ListInput" id="fruit" name="fruit" value="Apples,Oranges,Pears"></div>


Programmatic example
--------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojox.form.ListInput");
        dojo.addOnLoad(function(){
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
    </script>

  .. cv:: html

    <div id="dynamic"></div>
    <p><button onClick="alert(dijit.byId('dynamic').attr('value'))">Get value</button></p>


=============
Accessibility
=============
