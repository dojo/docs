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



=====
Usage
=====

.. codeviewer::
  
  <style type="text/css">
    @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/widget/DocTester/DocTester.css"; 
  </style>
  <script type="text/javascript">
    dojo.require("dojox.widget.DocTester");
    dojo.require("dojo.date.locale");
    
    dojo.addOnLoad(function(){
      var docTest = new dojox.widget.DocTester({}, "docTest");
    });
  </script>
  <div id="docTest">
    >>> var date1 = new Date(2000, 2, 1), date2 = dojo.date.add(date2, "month", -1); date.toUTCString();
    "Sat, 01 Apr 2000 05:00:00 GMT"
    >>> dojo.date.difference(date1, date2, "day")
    -29
  </div>


========
See Also
========

* `dojo.date.locale.* <dojo/date/locale>`_
* `dojo.date.stamp.* <dojo/date/stamp>`_
* `Dojo Cookie: Dates to Remember <http://dojocampus.org/content/2008/07/03/dates-to-remember/>`_
