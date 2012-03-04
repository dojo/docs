.. _dojo/date/stamp:

===============
dojo.date.stamp
===============


.. contents ::
  :depth: 2


Introduction
============

Methods of dojo.date.stamp module use a profile of the ISO-8601 standard to handle dates in a way that is unambiguous, culturally and location independent, fast, and easily machine readable.  The format is yyyy-MM-ddTHH:mm:ss.SSS where the fields do not all need to be specified, and either local time, GMT offset or "Zulu" may be used.  See the API documentation for details.



Usage
=====

.. html ::
  
  <style type="text/css">
    @import "dojox/widget/DocTester/DocTester.css";
  </style>
  <script type="text/javascript">
    dojo.require("dojox.widget.DocTester");
    dojo.require("dojo.date.stamp");
    
    dojo.ready(function(){
      var docTest = new dojox.widget.DocTester({}, "docTest");
    });
  </script>
  <div id="docTest">
    >>> var date1 = new Date(2008, 9, 17); date1.setUTCHours(0); dojo.date.stamp.toISOString(date1, {zulu: true});
    "2008-10-17T00:00:00Z"
    >>> dojo.date.stamp.toISOString(date1, {selector: 'date'});
    "2008-10-17"
    >>> dojo.date.stamp.fromISOString("2008-10-17T00:00:00Z").toGMTString(); // note toGMTString output is implementation-dependent
    "Fri, 17 Oct 2008 00:00:00 GMT"
    >>> dojo.date.stamp.fromISOString("T23:59:59.999-04:00", new Date(2008,9,17)).toGMTString();
    "Sat, 18 Oct 2008 03:59:59 GMT"
  </div>


See Also
========

* :ref:`dojo.date.* <dojo/date>`
* :ref:`dojo.date.locale.* <dojo/date/locale>`
