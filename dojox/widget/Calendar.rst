#format dojo_rst

dojox.widget.Calendar
=====================

:Status: Draft
:Version: 1.0
:Project owner: Shane O'Sullivan
:Available: since V1.2

.. contents::
   :depth: 2

============
Introduction
============

The dojox.widget.Calendar widget extends the base ''dijit._Calendar'' mixin to provide multiple views on the date object.  At time of writing (circa 1.3), there are four views available:
 * dojox.widget._CalendarDay - The primary view, showing all of the days in a single month.
 * dojox.widget._CalendarMonthYear - displays both the months and the years.
 * dojox.widget._CalendarMonth - displays just the months to choose. Available from dojox/widget/CalendarViews.js
 * dojox.widget._CalendarYear - displays just the years to choose. Available from dojox/widget/CalendarViews.js

The various views can be combined in any combination to create a complete widget.  However, the provided widgets are:
 * dojox.widget.Calendar - the default calendar contains the daily view combined with the Month/Year single view.
 * dojox.widget.DailyCalendar - just the daily view.
 * dojox.widget.MonthAndYearlyCalendar - just the Month/Year view.
 * dojox.widget.Calendar3Pane - the daily, monthly and yearly views.  Available from dojox/widget/CalendarViews.js.
 * dojox.widget.MonthlyCalendar - just the months. Available from dojox/widget/CalendarViews.js.
 * dojox.widget.YearlyCalendar - just the years. Available from dojox/widget/CalendarViews.js.

=====
Usage
=====

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   dojo.require("dojox.widget.Calendar");
 </script>
 <div dojoType="dojox.widget.Calendar"></div>


========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
