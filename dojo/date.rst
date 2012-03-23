.. _dojo/date:

=========
dojo/date
=========

.. contents ::
  :depth: 2

**dojo/date** is a module that provides date handling functions. The standard return variable for this module is
``date``.

Introduction
============

Dealing with dates in software can be trickier than it seems. The web and JavaScript add to the challenge. Because your
code is on the web, users are likely to execute it in a variety of platforms in different locales and time zones, and
JavaScript isn't always helpful abstracting these issues in development. JavaScript has got a bunch of quirks of its own
related to dates, perhaps worthy of their own cookies, but it's got a reasonably straightforward API. When you're in
JavaScript, you use the Date object. ``dojo/date`` contains methods for manipulating JavaScript Date objects. The
``dojo/date/*`` methods are generally independent of String representations and are culturally neutral. There are two
modules beneath ``dojo/date``: 

* :ref:`dojo/date/stamp <dojo/date/stamp>`, for culturally neutral representations using a subset of the ISO-8601
  standard, typically for unambiguous, machine-readable formatting and parsing of dates (e.g. 2008-10-16T23:59:59),

* :ref:`dojo/date/locale <dojo/date/locale>`, for culturally-sensitive formatting and parsing of dates for human
  interaction (e.g. in English: Thursday, October 8, 2008 11:59:59PM)

*Note* that in JavaScript, counting of months starts at "0" so if you want to create following date: August 23rd 2034
you will have to do:

.. js ::

  var myDate = new Date(2034, 7, 23);

So don't get confused by the new Date() statements in the tests, the second parameter is the month and is always one
number lower than the month you actually want.

Usage
=====

.. js ::

  require(["dojo/date"], function(date){
     var date1 = new Date(2000, 2, 1);
     date1.toUTCString(); // note that even toUTCString output is implementation-dependent
     // output: "Wed, 01 Mar 2000 05:00:00 GMT"

     var date2 = date.add(date1, "month", -1);
     date2.toUTCString();
     // output: "Tue, 01 Feb 2000 05:00:00 GMT"

     date.difference(date1, date2, "day");
     // output: -29
  });

Features
========

getDaysInMonth()
----------------

Returns the number of days in the month used by dateObject.

Usage
~~~~~

.. js ::

  require(["dojo/date"], function(date){
    var myDate = new Date(2000, 1, 1);
    date.getDaysInMonth(myDate);
  });

Attributes
~~~~~~~~~~

========== ==== =================================================
Argument   Type Description
========== ==== =================================================
dateObject Date The Date object you want the number of months for
========== ==== =================================================

The function returns a Number.

Examples
~~~~~~~~

.. code-example::

  .. js ::

    require(["dojo/date", "dojo/dom", "dojo/domReady!"],
    function(date, dom){
      var date1 = new Date(2000, 1, 1);
      var date2 = new Date(1973, 5, 16);
      var rainman = "February 2000 had " + date.getDaysInMonth(date1) + " days.<br/>";
      rainman += "June 1973 had " + date.getDaysInMonth(date2) + " days.";
      dom.byId("rainman").innerHTML = rainman;
    });

  .. html ::

    <strong>Output:</strong>
    <div id="rainman"></div>

isLeapYear()
------------

Determines if the year of the dateObject is a leap year. Leap years are years with an additional day YYYY-02-29, where
the year number is a multiple of four with the following exception: If a year is a multiple of 100, then it is only a
leap year if it is also a multiple of 400. For example, 1900 was not a leap year, but 2000 is one. (Right Apple and
Microsoft?)

Usage
~~~~~

.. js ::

  require(["dojo/date"], function(date){
    var myDate = new Date(1900, 1, 1);
    date.isLeapYear(myDate);
  });

Attributes
~~~~~~~~~~

========== ==== ===========================================================
Argument   Type Description
========== ==== ===========================================================
dateObject Date The Date object you want to determine is a leap year or not
========== ==== ===========================================================

The function returns a ``true`` if it is a leap year or ``false`` if it is not.

Examples
~~~~~~~~

.. code-example::

  .. js ::

    require(["dojo/date", "dojo/dom", "dojo/domReady!"],
    function(date, dom){
      var date1 = new Date(1900, 1, 1);
      var date2 = new Date(2000, 5, 16);
      if (date.isLeapYear(date1)){
        var rainman = "1900 was a leap year.<br/>";
      }else{
        var rainman = "1900 was <strong>not</strong> a leap year.<br/>";
      }
      if (date.isLeapYear(date2)){
        rainman += "2000 was a leap year.";
      }else{
        rainman += "2000 was <strong>not</strong> a leap year.";
      }
      dom.byId("rainman").innerHTML = rainman;
    });

  .. html ::

    <strong>Output:</strong>
    <div id="rainman"></div>

getTimezoneName()
-----------------

Get the user's time zone as provided by the browser. Try to get time zone info from toString or toLocaleString method of
the Date object -- UTC offset is not a time zone. See `http://www.twinsun.com/tz/tz-link.htm <http://www.twinsun.com/tz/tz-link.htm>`_.

*Note:* Results may be inconsistent across browsers.


Usage
~~~~~

.. js ::

  require(["dojo/date"], function(date){
    var myDate = (2000, 5, 16);
    date.getTimezoneName(myDate);
  });

Attributes
~~~~~~~~~~

========== ==== =================================================================
Argument   Type Description
========== ==== =================================================================
dateObject Date Needed because the timezone may vary with time (daylight savings)
========== ==== =================================================================

The function returns a string.

Examples
~~~~~~~~

.. code-example::

  .. js ::

    require(["dojo/date", "dojo/dom", "dojo/domReady!"],
    function(date, dom){
      var tz = date.getTimezoneName(new Date());
      var rainman = "You are supposedly in: " + tz + " timezone.";
      dom.byId("rainman").innerHTML = rainman;
    });

  .. html ::

    <strong>Output:</strong>
    <div id="rainman"></div>

compare()
---------

Compare two date objects by date, time, or both and returns 0 if both dates are equal, positive if a > b, or else
negative.

Usage
~~~~~

.. js ::

  require(["dojo/date"], function(date){
    var date1 = new Date();
    var date2 = new Date(2000, 0, 1);
    
    // Compares both the date and time portions
    date.compare(date1, date2);
    
    // Compares just the date portion
    date.compare(date1, date2, "date");
    
    // Compares just the time portion
    date.compare(date1, date2, "time");
    
    // Same as omitting the third argument
    date.compare(date1, date2, "datetime");
  });

Attributes
~~~~~~~~~~

======== ======= ==============================================================================================
Argument Type    Description
======== ======= ==============================================================================================
date1    Date    The first date to be compared
date2    Date    The second date to be compared
portion  String? *Optional argument* A String indicating the "date" or "time" portion of a Date object.
                 Compares both "date" and "time" by default.  One of the following: "date", "time", "datetime".
======== ======= ==============================================================================================

The function returns a Number where 0 means the dates are equal, 1 if date1 > date2 and -1 if date1 < date2.

Examples
~~~~~~~~

.. code-example::

  .. js ::

    require(["dojo/date", "dojo/dom", "dojo/domReady!"],
    function(date, dom){
      var date1 = new Date(2013, 5, 16, 0, 12, 27);
      var date2 = new Date(1973, 5, 16, 0, 12, 27);
      switch(date.compare(date1, date2)){
      case 0:
        var rainman = date1.toUTCString() + " is the same as " + date2.toUTCString() + "</br>";
        break;
      case 1:
        var rainman = date1.toUTCString() + " is after " + date2.toUTCString() + "</br>";
        break;
      case -1:
        var rainman = date1.toUTCString() + " is before " + date2.toUTCString() + "</br>";
        break;
      }
      switch(date.compare(date1, date2, "time")){
      case 0:
        rainman += date1.toUTCString() + " is the same time as " + date2.toUTCString() + "</br>";
        break;
      case 1:
        rainman += date1.toUTCString() + " time is after " + date2.toUTCString() + "</br>";
        break;
      case -1:
        rainman += date1.toUTCString() + " time is before " + date2.toUTCString() + "</br>";
        break;
      }
      dom.byId("rainman").innerHTML = rainman;
    });

  .. html ::

    <strong>Output:</strong>
    <div id="rainman"></div>

add()
-----

Add to a Date in intervals of different size, from milliseconds to years.

Usage
~~~~~

.. js ::

  require(["dojo/date"], function(date){
    var myDate = new Date();
    date.add(myDate, "day", 1);
  });

Attributes
~~~~~~~~~~

======== ======= ====================================================================================================
Argument Type    Description
======== ======= ====================================================================================================
date     Date    Date object to change
interval String  A string representing the interval.  One of the following: "year", "month", "day", "hour", "minute",
                 "second", "millisecond", "quarter", "week", "weekday".
amount   int     How much to add to the date.
======== ======= ====================================================================================================

The function returns a Date.

Examples
~~~~~~~~

.. code-example::

  .. js ::

    require(["dojo/date", "dojo/dom", "dojo/domReady!"],
    function(date, dom){
      var today = new Date();
      var rainman = "Tomorrow will be: " + date.add(today, "day", 1).toUTCString() + "<br/>";
      rainman += "Last week was: " + date.add(today, "week", -1).toUTCString();
      dom.byId("rainman").innerHTML = rainman;
    });

  .. html ::

    <strong>Output:</strong>
    <div id="rainman"></div>

difference()
------------

Get the difference in a specific unit of time (e.g., number of months, weeks, days, etc.) between two dates, rounded to
the nearest integer.

Usage
~~~~~

.. js ::

  require(["dojo/date"], function(date){
    var date1 = new Date(2000, 0 , 1);
    var date2 = new Date(2006, 11, 12);
    
    // Returns the difference from now in whole days
    date.difference(date1);
    
    // Returns the difference between two dates in whole days
    date.difference(date1, date2);
    
    // Returns the difference in the specified interval
    date.difference(date1, date2, "week");
  });

Attributes
~~~~~~~~~~

======== ======= ====================================================================================================
Argument Type    Description
======== ======= ====================================================================================================
date1    Date    The first date for the difference.
date2    Date?   *Optional argument* The second date for the difference.  Defaults to current Date.
interval String? *Optional argument* A string representing the interval.  One of the following:

                   "year", "month", "day", "hour", "minute", "second", "millisecond", "quarter", "week", "weekday"

                 Defaults to "day".
======== ======= ====================================================================================================

The function returns an integer.

Examples
~~~~~~~~

.. code-example::

  .. js ::

    require(["dojo/date", "dojo/dom", "dojo/domReady!"],
    function(date, dom){
      var date1 = new Date(1973, 5, 16);
      var date2 = new Date(2013, 5, 16);
      var rainman = date1.toUTCString() + " was " + date.difference(date1) + " days ago.<br/>";
      rainman += "The difference between " + date1.toUTCString() + " and " + date2.toUTCString() + " is " +
        date.difference(date1, date2, "year") + " years.";
      dom.byId("rainman").innerHTML = rainman;
    });

  .. html ::

    <strong>Output:</strong>
    <div id="rainman"></div>

See Also
========

* :ref:`dojo/date/locale <dojo/date/locale>`
* :ref:`dojo/date/stamp <dojo/date/stamp>`
