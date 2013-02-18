.. _dojox/date/umalqura:

===================
dojox.date.umalqura
===================

:Contributor: Hossam Katory
:since: V1.9

.. contents ::
   :depth: 2

Implements the traditional Um AlQura (Hijri) calendar. This is the Official calendar system in Saudi Arabia

Introduction
============

The Um AlQura calendar (Hijri calendar) does not rely on a visual sighting of the crescent moon to fix the start of a new month as in the case of the civil Islamic calendar. Saudi Arabia used a lunar calendar in which each month started on the day of the astronomical Conjunction based on the meridian of Greenwich. The rule was:

If the Moon’s age at sunset is 12 hours or more after the astronomical New Moon then the Um AlQura month starts from the previous sunset date since the Um AlQura day starts at sunset, and the night comes before the daylight.

This rule implied that every lunar month started in the evening when the Moon at sunset was either less than 12 hours old or less than 12 hours away from the time of New Moon. The consequence was that in about 50% of all cases the lunar Um AlQura month began before the astronomical New Moon and in about as many cases moonset occurred before sunset. In all cases, the lunar crescent would have been absolutely invisible to the naked eye on the first evening of the lunar Um AlQura month.


Usage
=====

Code snippet below illustrates most common usage of Um AlQura calendar.

.. html ::
 
  <head>
      <script type="text/javascript">
        dojo.require("dojox.date.umalqura");
        dojo.require("dojox.date.umalqura.Date");
        dojo.require("dojox.date umalqura.locale");
      </script>
      <title> Um AlQura calendar </title>
  </head>
  <body>
    <input id="UAQcal"
       name="noDOMvalue"
       value="2009-03-10"
       type="text"
       data-dojo-type="dijit.form.DateTextBox"
       datePackage = "dojox.date.umalqura"
       constraints="{min:'2008-03-01',max:'2009-04-01',datePattern:'dd MMMM yyyy'}">
  </body>

Um AlQura calendar package
--------------------------

Um AlQura calendar package comprises of following two files:

    * dojox.date.umalqura.Date implements logic of Um AlQura calendar and provides support for date conversion between Gregorian and Um AlQura calendars
    * dojox.date.umalqura.locale includes implementation of functions responsible for conversion between two possible representations of Um AlQura date: String representation and Date object. It also provides date formatting capabilities.

Um AlQura calendar and DateTextBox
----------------------------------

Um AlQura calendar implemented in this package can be used in conjunction with DateTextBox in order to provide graphical date picker for Um AlQura calendar. For example, image below illustrates DateTextBox using Um AlQura calendar with default language set to Arabic.

.. image :: dijit.jpg

Examples
========

Programmatic example
--------------------

The code snippet below illustrates conversion between two possible representations of Um AlQura date: String and Date object.

.. js ::

   var options = {datePattern:'EEEE dd MMMM yyyy HH:mm:ss', selector:'date'};

   // converts string representation of Um AlQura date to Date object
   var dateHij = dojox.date.umalqura.locale.parse("الأربعاء 04 صفر 1431 12:30:25", options);

   // formats Um AlQura date object and serialize it into a string
   var dateHijString = dojox.date.umalqura.locale.format(dateHij, options);


Declarative example
-------------------

Code snippet below illustrates usage of Um AlQura calendar in the context of graphical date picker - DateTextBox


.. html ::
 
  <head>
      <script type="text/javascript">
        dojo.require("dojox.date.umalqura");
        dojo.require("dojox.date.umalqura.Date");
        dojo.require("dojox.date.umalqura.locale");
      </script>
      <title> Um AlQura calendar </title>
  </head>
  <body>
    <input id="hijcal"
       name="noDOMvalue"
       value="2009-03-10"
       type="text"
       data-dojo-type="dijit.form.DateTextBox"
       datePackage = "dojox.date.umalqura"
       constraints="{min:'2008-03-01',max:'2009-04-01',datePattern:'dd MMMM yyyy'}">
  </body>


See also
========

Islamic Calendar: http://en.wikipedia.org/wiki/Islamic_calendar
Um AlQura Calendar: http://www.islamicmoon.com/Moonsighting%20Ummal-Qura%20Calendar.htm
