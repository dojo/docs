#format dojo_rst

dojo.date.locale
================

:Status: Draft
:Version: 1.2


.. contents::
  :depth: 3

dojo.date.locale offers a library of localization methods to format and parse dates and times.


============
Introduction
============

When you want to present dates or times to the user, Javascript only knows how to handle a single locale and language, and the actual format is implementation-dependent, and your web application has no control over these choices. 

Dojo comes with a powerful library to format and parse dates and times using local language and conventions, from your choice of hundreds of locales, or as you would like using custom date/time patterns.

=================
Available Methods
=================

dojo.date.locale offers the following methods:

* `dojo.date.locale.addCustomFormats <dojo/date/locale/addCustomFormats>`_

  Add a reference to a bundle containing localized custom formats to be used by date/time formatting and parsing routines.

* `dojo.date.locale.format <dojo/date/locale/format>`_

  Format a Date object as a String, using locale-specific settings or custom patterns.

* `dojo.date.locale.getNames <dojo/date/locale/getNames>`_

  Used to get localized strings from dojo.cldr for day or month names.

* `dojo.date.locale.isWeekend <dojo/date/locale/isWeekend>`_

  Determines if the date falls on a weekend, according to local custom.

* `dojo.date.locale.parse <dojo/date/locale/parse>`_

  Convert a properly formatted string to a primitive Date object, using locale-specific settings.

* `dojo.date.locale.regexp <dojo/date/locale/regexp>`_

  Builds the regular needed to parse a localized date


========
See also
========

* `Cultural conventions: Date, Number and Currency <quickstart/internationalization/number-and-currency-formatting>`_
