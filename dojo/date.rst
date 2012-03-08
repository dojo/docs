.. _dojo/date:

=========
dojo.date
=========


.. contents ::
  :depth: 2


Introduction
============

Dealing with dates in software can be trickier than it seems.  The web and JavaScript add to the challenge.  Because your 
code is on the web, users are likely to execute it in a variety of platforms in different locales and time zones, and 
JavaScript isn't always helpful abstracting these issues in development.  JavaScript has got a bunch of quirks of its
own related to dates, perhaps worthy of their own cookies, but it's got a reasonably straightforward API.  When you're 
in JavaScript, you use the Date object.  ``dojo.date`` contains methods for manipulating JavaScript Date objects.  The 
dojo.date.* methods are generally independent of String representations and are culturally neutral.  There are two 
modules beneath dojo.date: dojo.date.stamp.*, for culturally neutral representations using a subset of the ISO-8601 
standard, typically for unambiguous, machine-readable formatting and parsing of dates (e.g. 2008-10-16T23:59:59), and 
dojo.date.locale.*, for culturally-sensitive formatting and parsing of dates for human interaction (e.g. in 
English: Thursday, October 8, 2008 11:59:59PM)


Note that in JavaScript, counting of months starts at "0" so if you want to create following date: August 23rd 2034 you will have to do:

.. js ::

  var myDate = new Date(2034, 7, 23);

So don't get confused by the new Date() statements in the tests, the second parameter is the month and is always one number lower than the month you actually want.


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

See Also
========

* :ref:`dojo.date.locale.* <dojo/date/locale>`
* :ref:`dojo.date.stamp.* <dojo/date/stamp>`
