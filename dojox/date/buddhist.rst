.. _dojox/date/buddhist:

===================
dojox.date.buddhist
===================

:Project owner: 
:Contributors: Aphichit Hanbanchong and Nattapong Sirilappanich
:since: V1.4

.. contents ::
  :depth: 2

Implements the Thai Solar Calendar, the legal calendar of Thailand.  Years are written in the Buddhist era, 543 years greater than the Gregorian calendar, otherwise the calendar is generally the same.

=====
Usage
=====

Code snippet below illustrates a common usage of Buddhist Date code with the Dijit Calendar widget.

.. html ::
 
  <head>
  <script type="text/javascript">
    dojo.require("dojox.date.buddhist");
    dojo.require("dojox.date.buddhist.Date");
    dojo.require("dojox.date.buddhist.locale");
  </script>
  <title>Thai Solar calendar</title>
  </head>
  <body>
    <input name="thaical"
       value="2009-03-10"
       data-dojo-type="dijit.form.DateTextBox"
       datePackage = "dojox.date.buddhist">
  </body>
