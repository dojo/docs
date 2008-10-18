#format dojo_rst

dojo.date.locale
================

:Status: Draft
:Version: 1.2


.. contents::
  :depth: 3

Dojo comes with a powerful library to format and parse dates and times using local language and conventions, from your choice of hundreds of locales, or as you would like using custom date/time patterns.

Examples
--------

Formatting dates and times using custom patterns
------------------------------------------------

When you want to present dates or times to the user, Javascript only knows how to handle a single locale and language, and the actual format is implementation-dependent, and your web application has no control over these choices.  By simply passing a Javascript Date object to dojo.date.locale.format, Dojo will use the locale passed as djConfig.locale or the browser's default to handle the formats, and you may choose from a variety of formats: short, medium, full, or long.  Various other optins are available.  You may choose to process the only the date, only the time, or both, and you may decide to use your own custom datePattern or timePattern. Lets dive right in and format the current Date in several ways.

.. codeviewer::
  
  <style type="text/css">
    @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/widget/DocTester/DocTester.css"; 
  </style>
  <script type="text/javascript">
    djConfig.locale = 'en'; djConfig.extraLocale = 'zh';
  </script>
  <script type="text/javascript">
    dojo.require("dojox.widget.DocTester");
    dojo.require("dojo.date.locale");
    
    dojo.addOnLoad(function(){
      var docTest = new dojox.widget.DocTester({}, "docTest");
    });
  </script>
  <div id="docTest">
    >>> dojo.date.locale.format(new Date(2007,2,23,6,6,6), {selector: "date", locale: "en"});
    "March 23, 2007"
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
