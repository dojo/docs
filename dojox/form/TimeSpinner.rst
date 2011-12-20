.. _dojox/form/TimeSpinner:

======================
dojox.form.TimeSpinner
======================

:Project owner: ?--
:since: V1.2

.. contents ::
   :depth: 2

This widget is the same as dijit.form.NumberSpinner, but for the time component of a date object instead.


Introduction
============

 * The down and up arrow buttons "spin" the time up and down.
 * Furthermore, when you hold down the buttons, the spinning accelerates to make coarser adjustments easier.


Examples
========

Programmatic example
--------------------

.. js ::
 
   dojo.require("dojox.form.TimeSpinner");
   dojo.ready(function(){
     var s = new dojox.form.TimeSpinner({
       required: true,
       smallDelta: 1,
       largeDelta: 30
     }, "timespinner");
   });

.. html ::

   <input type="text" id="spinner" />

Declarative example
-------------------

.. js ::
 
   dojo.require("dojox.form.TimeSpinner");

.. html ::

   <input type="text" data-dojo-type="dojox.form.TimeSpinner" value="12:45" />

See also
========

* :ref:`dijit.form.NumberSpinner <dijit/form/NumberSpinner>` An input widget which restricts input to numeric input and offers down and up arrow buttons to "spin" the number up and down
* :ref:`dijit.form.TimeTextBox <dijit/form/TimeTextBox>` A time input control which allows either typing or choosing a time from any time-picker widget
