.. _dojo/date/locale/format:

==========================
dojo/date/locale::format()
==========================

:Project owner: Adam Peller
:Authors: Seth Lytle, Adam Peller, Marcus Reimann

.. contents ::
   :depth: 2

Creates a string from a Date object using a known localized pattern.

Introduction
============

By default, this method formats both date and time from dateObject. Formatting patterns are chosen appropriate to the
locale. Different formatting lengths may be chosen, with "full" used by default. Custom patterns may be used or
registered with translations using the :ref:`dojo/date/locale::addCustomFormats() <dojo/date/locale/addCustomFormats>`
method. Formatting patterns are implemented using the syntax described at unicode.org.

Usage
=====

By simply passing a JavaScript Date object to ``format()``, Dojo will use the locale passed as ``dojoConfig.locale`` or
the browser's default to handle the formats, and you may choose from a variety of formats: "short", "medium", "full", or
"long".

Various other options are available to format the date. You may choose to process only the date, only the time, or both,
and you may decide to use your own custom datePattern or timePattern.

.. js ::

  require(["dojo/date/locale"], function(locale){
    locale.format(new Date(),{
      selector: "date",
      formatLength: "short"
    });
  })

Attributes
==========

+------------+-----------------------------------+-------------+-----------+-----------------------------------+
| Parameter  | Type                              | Description                                                 |
+============+===================================+=============+===========+===================================+
| dateObject | Date                              | The date and/or time to be formatted. If a time only is     |
|            |                                   | formatted, the values in the year, month, and day fields are|
|            |                                   | irrelevant. The opposite is true when formatting only dates.|
+------------+-----------------------------------+-------------+-----------+-----------------------------------+
| options    | dojo/date/locale::__FormatOptions | Optional. An object with the following properties:          |
+------------+-----------------------------------+-------------+-----------+-----------------------------------+
|                                                |  **Field**  |  **Type** |          **Description**          |
|                                                +-------------+-----------+-----------------------------------+
|                                                | am          | String    | override strings for am in times  |
|                                                +-------------+-----------+-----------------------------------+
|                                                | datePattern | String    | override pattern with this string |
|                                                +-------------+-----------+-----------------------------------+
|                                                | formatLength| String    | choice of long, short, medium or  |
|                                                |             |           | full (plus any custom additions). |
|                                                |             |           | Defaults to 'short'               |
|                                                +-------------+-----------+-----------------------------------+
|                                                | fullYear    | Boolean   | (format only) use 4 digit years   |
|                                                |             |           | whenever 2 digit years are called |
|                                                |             |           | for                               |
|                                                +-------------+-----------+-----------------------------------+
|                                                | locale      | String    | override the locale used to       |
|                                                |             |           | determine formatting rules        |
|                                                +-------------+-----------+-----------------------------------+
|                                                | pm          | String    | override strings for pm in times  |
|                                                +-------------+-----------+-----------------------------------+
|                                                | selector    | String    | choice of 'time','date'           |
|                                                |             |           | (default: date and time)          |
|                                                +-------------+-----------+-----------------------------------+
|                                                | strict      | Boolean   | (parse only) strict parsing,      |
|                                                |             |           | off by default                    |
|                                                +-------------+-----------+-----------------------------------+
|                                                | timePattern | String    | override pattern with this string |
+------------------------------------------------+-------------+-----------+-----------------------------------+

The ``datePattern`` is composed of tokens and string literals:

* String literals may be enclosed in single quotes (e.g. ``'which is'``).

* Characters that are not a format token are rendered as is.

* Tokens consist of a character repeated one or more times.

* The letter indicates the field type.

* The number of repeats indicates the field width.

* Often, widths of 1 mean numeric, 2 or 3 mean abbreviated, and 4 means full (tokens ``yMEZG``)

* Other times, field widths are meant to be interpreted literally, (e.g. ``qwdDh`` ...)

* In some cases widths are ignored, (e.g. ``a``)

======================  ====================  ======================================  ======
Pattern                 Meaning               Thu Mar 26 2009 13:37:43.777 (EST)      Notes
======================  ====================  ======================================  ======
G                       era                   AD
"                       "                     Anno Domini                             GGGG
y                       year                  2009                                    yyy
qQ                      quarter               1
M                       month                 March                                   MMMM
w                       week of the year      12
d                       date                  26
D                       day of the year       85
E                       day of the week       Thursday                                EEEE
"                       "                     Thu                                     EEE
a                       am/pm                 PM
h                       hours by 0-11         1
H                       hours by 0-23         13
K                       hours by 1-12
k                       hours by 1-24
m                       minutes               37
s                       seconds               43
S                       milliseconds          777                                     SSS
vz                      timezone              EST
Z                       timezone offset       GMT-04:00                               ZZZZ
"                       "                     -0400                                   Z
======================  ====================  ======================================  ======

Notes:

* Everything in this module assumes Gregorian calendars. For other calendars, see dojox/date

* The representation of timezone names vary by browser and operating system.  The string is simply parsed and passed through from the representation in Date.toString().  For more precise handling of timezones, see dojox/date

* A single quote can be incorporated in a quoted string by supplying 2 of them, for example 'o''clock'

Examples
========

A simple example formatting a date in a number of ways

.. code-example ::

  .. js ::

    require(["dojo/ready", "dojo/date/locale", "dojo/query"], function(ready, locale, query){
        function format(date, fmt){ return locale.format( date, {selector:"date", datePattern:fmt } ); };
        
        var initDates = function(){
            var date = new Date(2009,9,26,13,37,43,777);
            var fmto = "EEEE, MMMM d yyyy GGG, h:m:s.SSS a z (ZZZZ)";
            var fmt2 = "EEEE, MMMM d yyyy GGG, 'day' D, 'week' w, 'quarter' q, h:m:s.SSS a z 'ie hour' H -- ZZZZ";
            var txt = dojo.query( ".date" )[0];
            txt.innerHTML = format( date, fmto );
            var fmts = {
                explicit: fmto,
                simple: "MMM d, yyyy",
                abbreviated: "EEE, MMM d, yyyy G",
                full: "MMMM d, 'in the year' yyyy GGGG",
                time: "h:m:s.SSS a z",
                ordinal: "'day' D, 'week' w, 'quarter' q 'of the year' yyyy",
                literal: "'this is not really a date'",
                "extra stuff": "MMM d, yyyy -- 39:45, ____+1"
            };
            var out = query( ".output" )[0];
            for(var ii in fmts){
                var fmt = fmts[ii];
                var res = format( date, fmt );
                out.innerHTML += "<tr><td>" + ii + "</td><td>" + fmt + "</td><td>" + res + "</td></tr>";
            }
        }
        ready(initDates);
    });

  .. css ::

    th,td  { border:1px solid black; padding: .2em 1em; }
    table { border-collapse:collapse }

  .. html ::

    <h3>dojo/date/locale test</h3>
    The following table shows the date: <div class="date"></div> formatted using dojo/date/locale.format
    <table class="output" style="border:1px solid black; width: auto;">
        <tr><th>style</th><th>format</th><th>result</th></tr>
    </table>


Formatting dates and times using custom patterns. Render the current Date in several ways using format(). The inverse
operation to take the String and return a Date object is ``parse()``.

.. code-example ::

    .. css ::
  
        @import "{{dataUrl}}dojox/widget/DocTester/DocTester.css";
  
    .. js ::
  
            var dojoConfig = {
                locale: 'en',
                extraLocale: ['es', 'zh']
            };
            dojo.require("dojox.widget.DocTester");
            dojo.require("dojo.date.locale");
    
            dojo.ready(function(){
                var docTest = new dojox.widget.DocTester({}, "docTest");
            });

    .. html ::

        <div id="docTest">
            >>> dojo.date.locale.format(new Date(2007,2,23,6,6,6), {formatLength: "short", locale: "es"}); // locale must match an identifier included in dojoConfig bootstrap, and is normally not specified here (used here for demonstration purposes)
            "23/03/07 06:06"
            >>> dojo.date.locale.format(new Date(2007,2,23,6,6,6), {selector: "date", formatLength: "short", locale: "es"});
            "23/03/07"
            >>> dojo.date.locale.format(new Date(2007,2,23,6,6,6), {selector: "date", formatLength: "long", locale: "es"});
            "23 de marzo de 2007"
            >>> dojo.date.locale.format(new Date(2007,2,23,6,6,6), {selector: "date", formatLength: "long", locale: "zh"});
            "2007年3月23日"
            >>> dojo.date.locale.format(new Date(2007,2,23,6,6,6), {datePattern: "MMMM yyyy", locale: "es"});
            "marzo 2007"
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


See also
========

* :ref:`dojo.date.locale <dojo/date/locale>`
