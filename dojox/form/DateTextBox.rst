.. _dojox/form/DateTextBox:

dojox.form.DateTextBox
======================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

TODO: short summary of the component/class/method


============
Introduction
============

TODO: introduce the component/class/method


=====
Usage
=====

TODO: how to use the component/class/method

.. js ::
 
 <script type="text/javascript">
   // your code
 </script>



========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example

======================
Problems and Solutions
======================

The dojox.form.MonthTextBox only returns an integer value representing the selected month.  This doesn't take into account the year in which the month was selected.  You can use dojox.form.DateTextBox in conjunction with a custom popup class to enhance this situation, so that the returned value is a more useful Date object.

.. html ::
 
 dojo.require("dojox.form.DateTextBox");
 dojo.require("dojox.widget.Calendar");

 <span id="dtb2" dojoType="dojox.form.DateTextBox"
   popupClass="dojox.widget.MonthAndYearlyCalendar"
   constraints="{datePattern: 'MMMM yyyy'}"></span>

The above DateTextBox will print e.g. "November 2011" in the text box (localised according to the current locale) and return as its 'value' attribute (dijit.byId('dtb2').get('value')) a Date object for the first day in the selected month.

========
See also
========

* TODO: links to other related articles
