#format dojo_rst

dojo.date
=========

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 2


============
Introduction
============

dojo.date contains methods for manipulating Javascript Date objects.  The dojo.date.* methods are generally independent of String representations and are culturally neutral.  There are two modules beneath dojo.date: dojo.date.stamp.*, for culturally neutral representations using a subset of the ISO-8601 standard, typically for unambiguous, machine-readable formatting and parsing of dates (e.g. 2008-10-16T23:59:59), and dojo.date.locale.*, for culturally-sensitive formatting and parsing of dates for human interaction (e.g. in English: Thursday, October 8, 2008 11:59:59PM)


Note that in JavaScript, counting of months starts at "0" so if you want to create following date: August 23rd 2034 you will have to do::

  var myDate = new Date(2034,7,23);

So don't get confused by the new Date() statements in the tests, the second parameter is the month and is always one number lower than the month you actually want.


=====
Usage
=====

.. codeviewer::
  
  <style type="text/css">
    @import "{{baseUrl}}dojox/widget/DocTester/DocTester.css"; 
  </style>
  <script type="text/javascript">
    dojo.require("dojox.widget.DocTester");
    dojo.require("dojo.date");
    
    dojo.addOnLoad(function(){
      var docTest = new dojox.widget.DocTester({}, "docTest");
    });
  </script>
  <div id="docTest">
    >>> var date1 = new Date(2000, 2, 1); date1.toUTCString(); // note that even toUTCString output is implementation-dependent
    "Wed, 01 Mar 2000 05:00:00 GMT"
    >>> var date2 = dojo.date.add(date1, "month", -1); date2.toUTCString();
    "Tue, 01 Feb 2000 05:00:00 GMT"
    >>> dojo.date.difference(date1, date2, "day")
    -29
  </div>


========
See Also
========

* `dojo.date.locale.* <dojo/date/locale>`_
* `dojo.date.stamp.* <dojo/date/stamp>`_
* `Dojo Cookie: Dates to Remember <http://dojocampus.org/content/2008/07/03/dates-to-remember/>`_
