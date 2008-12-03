#format dojo_rst

dojo.number
===========

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 2


============
Introduction
============

dojo.number contains methods for user presentation of Javascript Number objects: formatting, parsing, and rounding.

Formatting and parsing are done in a locale-sensitive manner, using culturally appropriate patterns for representing group (thousands) and decimal separators, percent signs, etc.  This module forms the basis of dojo.currency, which uses similar methods but adds support for currency symbols and alters the pattern as appropriate.


================
format()/parse()
================

Similar to dojo.date.locale, dojo.number uses the Unicode.org Common Locale Data Repository in dojo.cldr to look up culturally-sensitive data to interact with users.  An American user would expect the number one-million to two decimal places to be represented as "1,000,000.00".  A German user would expect to see "1.000.000,00" and a French user would expect to see "1 000 000,00".  In India, there are thousands separators and hundreds place separators beyond that, so the appropriate formatted string would read "10,00,000.00".  Simply calling dojo.number.format(1000000, {places:2}) will give the correct results for the locale set by djConfig.  The inverse operation, dojo.number.parse("1,000,000.00", {places:2}) will yield the Javascript Number 1000000.

Custom formats may be specified to override the localized convention by passing in a 'pattern', for example dojo.number.format(123, {pattern:"00000"}) gives a result of "00123".  The pattern string is constructed according to the Unicode CLDR specification, which uses a convention similar to Java's NumberFormat.  See the API docs for details.


=======
round()
=======

The rounding method attempts to overcome some of the shortcomings of the intrinsic Javascript rounding methods, Math.round and Number.toFixed, allowing arbitrary increments in rounding to any number of places, and making adjustments for browser quirks and binary floating point representation.

Because JavaScript Number uses binary floating point, it is not always possible to achieve exact results for common calculations.  For example,

>>> 1.1+2.2
3.3000000000000003

This is commonly reported as a bug (https://bugzilla.mozilla.org/show_bug.cgi?id=5856) but in fact it is just an artifact of the way Numbers are stored in Javascript, rounded to the nearest IEEE double value, which can give unexpected results for even the most common calculations.  dojo.number.round does its rounding and accomodates numbers just a tiny bit below what would normally be the 'round up' point.  This is cheating, since mathematically, a full precision may have been expected.  A real solution to this problem would involve Decimal floating point arithmetic (see IEEE-754r)

dojo.number.round also works around a bug in Internet Explorer with Number.toFixed()

IE: (0.9).toFixed(1) yields "0.0"
All other browsers: (0.9).toFixed(1) yields "0.1"


========
See Also
========

 * dojo.currency
TODO: add references to CLDR, setting locale in Dojo, binary floating point issues
