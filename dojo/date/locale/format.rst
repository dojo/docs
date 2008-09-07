#format dojo_rst

dojo.date.locale.format
=======================

:Status: Draft
:Version: 1.2


.. contents::
  :depth: 3

Dojo comes with a powerful library to format your dates and times specifically to a given locale or as you would like using date/time patterns.

Examples
--------

Formatting dates and times using custom patterns
------------------------------------------------

When you want to do custom formatting of dates or times you still use the dojo.date.locale.format method, but instead of passing a locale you pass a datePattern or timePattern. Lets dive right in and format the current Date in several ways.

Following examples lists doc tests, to see the results of them click on the "Run tests" button just below the example.

Also note that in JavaScript, counting of months starts at "0" so if you want to create following date: August 23rd 2034 you will have to do::

  var myDate = new Date(2034,7,23);

So don't get confused by the new Date() statements in the tests, the second parameter is the month and is always one number lower than the month you actually want.

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
    >>> dojo.date.locale.format(new Date(2007,2,23,6,6,6), {datePattern: "yyyyMMdd", selector: "date"});
    "20070323"
    >>> dojo.date.locale.format(new Date(2007,2,23,6,6,6), {datePattern: "yyyy-MM-dd", selector: "date"});
    "2007-03-23"
    >>> dojo.date.locale.format(new Date(2007,2,23,6,6,6), {datePattern: "yyMMdd", selector: "date"});
    "070323"
    >>> dojo.date.locale.format(new Date(2007,2,23,6,6,6), {datePattern: "dd.MM.yy", selector: "date"});
    "23.03.07"
    >>> dojo.date.locale.format(new Date(2007,2,23,15,23,6), {timePattern: "HHmmss", selector: "time"});
    "152306"
    >>> dojo.date.locale.format(new Date(2007,2,23,15,23,6), {timePattern: "hmms", selector: "time"});
    "3236"
    >>> dojo.date.locale.format(new Date(2007,2,23,15,23,6), {timePattern: "HH:mm", selector: "time"});
    "15:23"
    >>> dojo.date.locale.format(new Date(2007,2,23,15,23,6), {timePattern: "HH.mm", selector: "time"});
    "15.23"
    >>> dojo.date.locale.format(new Date(2007,2,23,15,23,6), {datePattern: "yyyyMMdd", timePattern: "HHmmss"});
    "20070323 152306"
  </div>
