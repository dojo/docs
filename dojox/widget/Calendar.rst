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

 <style type="text/css">
   @import "dojox/widget/Calendar/Calendar.css";
 </style>
 <script type="text/javascript">
   dojo.require("dojox.widget.Calendar");
 </script>
 <div dojoType="dojox.widget.Calendar"></div>

As shown in the example above, the ''dojox/widget/Calendar/Calendar.css'' CSS file must be included on the page, the JavaScript can be loaded using ''dojo.require("dojox.widget.Calendar")'', and a calendar can be placed on the page using the ''dojoType'' attribute.


========
Examples
========

Programmatic examples
---------------------

This example shows the standard calendar being created from code.  Include the Calendar.css file, define a HTML node where the calendar is to be placed, load the dojox/widget/Calendar.js file using ''dojo.require'', then instantiate the widget. 

.. cv-compound::

  A programmatically created Calendar. First lets write up some simple HTML code because you need to define the place where your Calendar should be created.
  
  .. cv:: html

    <style type="text/css">
      @import "{{baseUrl}}dojox/widget/Calendar/Calendar.css";
    </style>
    <div id="cal_1"></div>
    <div id="cal_1_report"></div>

  .. cv:: javascript
    :label: The javascript, put this wherever you want the dialog creation to happen

    <script type="text/javascript">
        dojo.require("dojox.widget.Calendar");

        dojo.addOnLoad(function(){	
            // create the dialog:
            var cal_1 = new dojox.widget.Calendar({}, dojo.byId("cal_1"));
            dojo.connect(cal_1, "onValueSelected", function(date){
              dojo.byId("cal_1_report").innerHTML = date;
            });
        });
    </script>

This example shows just the daily calendar being instantiated, with no month or year options.  

.. cv-compound::
  
  .. cv:: html

    <style type="text/css">
      @import "dojox/widget/Calendar/Calendar.css";
    </style>
    <div id="cal_2"></div>
    <div id="cal_2_report"></div>

  .. cv:: javascript
    :label: The javascript, put this wherever you want the dialog creation to happen

    <script type="text/javascript">
        dojo.require("dojox.widget.Calendar");

        dojo.addOnLoad(function(){	
            // create the dialog:
            var cal_2 = new dojox.widget.DailyCalendar({}, dojo.byId("cal_2"));
            dojo.connect(cal_2, "onValueSelected", function(date){
              dojo.byId("cal_2_report").innerHTML = date;
            });
        });
    </script>

Declarative example
-------------------

This example shows how to construct a standard Calendar declaratively.  Note the ''<script type="dojo/connect" '' used to listen for events.  This can be used instead of calls to ''dojo.connect'' for listening to function calls and events on widgets.

.. cv-compound::
  
  .. cv:: html

    <style type="text/css">
      @import "{{baseUrl}}dojox/widget/Calendar/Calendar.css";
    </style>
    <div id="cal_3" dojoType="dojox.widget.Calendar">
      <script type="dojo/connect" event="onValueSelected" args="date">
        dojo.byId("cal_3_report").innerHTML = date;
      </script>
    </div>
    <div id="cal_3_report"></div>

  .. cv:: javascript
    :label: The javascript, put this wherever you want the dialog creation to happen

    <script type="text/javascript">
        dojo.require("dojox.widget.Calendar");
    </script>
  
This example shows how to construct a Calendar declaratively, which only shows the Daily view.  Note the ''<script type="dojo/connect" '' used to listen for events.  This can be used instead of calls to ''dojo.connect'' for listening to function calls and events on widgets.

.. cv-compound::
  
  .. cv:: html

    <style type="text/css">
      @import "{{baseUrl}}dojox/widget/Calendar/Calendar.css";
    </style>
    <div id="cal_4" dojoType="dojox.widget.DailyCalendar">
      <script type="dojo/connect" event="onValueSelected" args="date">
        dojo.byId("cal_4_report").innerHTML = date;
      </script>
    </div>
    <div id="cal_4_report"></div>

  .. cv:: javascript
    :label: The javascript, put this wherever you want the dialog creation to happen

    <script type="text/javascript">
        dojo.require("dojox.widget.Calendar");
    </script>


==========================================
Creating A Custom Calendar By Mixing Views
==========================================

As the calendar consists of a combination of views, it is possible to mix these any way you like.  The example below shows how to create a calendar that contains a Daily and Yearly view.  You must always include ''dojox.widget._CalendarBase'' and one other view, otherwise you can include whatever views you like.

.. cv-compound::
  
  .. cv:: html

    <style type="text/css">
      @import "{{baseUrl}}dojox/widget/Calendar/Calendar.css";
    </style>
    <div id="cal_5" dojoType="dojox.widget.CustomDayAndYearCalendar">
      <script type="dojo/connect" event="onValueSelected" args="date">
        dojo.byId("cal_5_report").innerHTML = date;
      </script>
    </div>
    <div id="cal_5_report"></div>

  .. cv:: javascript
    :label: The javascript, put this wherever you want the dialog creation to happen

    <script type="text/javascript">
        dojo.require("dojox.widget.Calendar");

        dojo.declare("dojox.widget.CustomDayAndYearCalendar", 
	  [dojox.widget._CalendarBase,
	   dojox.widget._CalendarDay,
	   dojox.widget._CalendarYear], {});
    </script>


========
See also
========

* http://shaneosullivan.wordpress.com/2008/03/24/sexy-new-calendar-widget-for-dojo/
* http://archive.dojotoolkit.org/nightly/dojotoolkit/dojox/widget/tests/test_Calendar.html
