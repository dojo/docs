.. _quickstart/internationalization/number-and-currency-formatting:

===============================================
Cultural conventions: Date, Number and Currency
===============================================

:Authors: Adam Peller
:since: V?

.. contents ::
   :depth: 2

Dates and Times
===============

Unlike standard JavaScript, Dojo is capable of formatting and parsing date formats for many locales, using the CLDR repository at unicode.org. Both the date and time portion of a JavaScript Date object may be converted to or from a String representation using the routines of :ref:`dojo.date.locale <dojo/date/locale>`.

For example, look at the following date formatted using the default locale for the user (in this case, English - United States) and also with a specific locale override of Chinese - PRC China:

.. js ::

   require(["dojo/date/locale"], function(localeDate){

     var d = new Date(2006, 9, 29, 12, 30);
     // To format a date, simply pass the date to the format function.  A default format appropriate for
     // your locale will be chosen.
     localeDate.format(d);
     // => "10/29/06 12:30 PM"

     // The second argument may contain a list of options in Object syntax,
     // such as overriding the default locale
     // Note: the page must specify dojoConfig.extraLocale: 'zh-cn'
     // to bootstrap the environment with support for a locale which is not the user's default
     localeDate.format(d, {locale:'zh-cn'})
     // => "06-10-29 下午12:30"
   });

Note that the positioning of month, day, and year are all different, as well as the "PM" symbol and its placement. Use of a locale override in this API is limited to examples like this one; usually the correct thing to do is to assume the user's default, or override the locale for the entire page (see "Setting a locale") Dojo.date offers a variety of formatting choices, such as the option to a different format "length" -- a choice of "short", "medium", "long", or "full" -- or to print only the date or time portion of the Date object:

.. js ::

   localeDate.format(d, {selector:'date', formatLength:'full'});
   // => "Sunday, October 29, 2006"

   localeDate.format(d, {selector:'time', formatLength:'long', locale:'zh-cn'});
   // => "下午12时30分00秒"

Also, it is possible to reverse the process and parse String objects into Dates. For a user running in a Dutch locale like "nl-nl", the following would produce a valid Date object:

.. js ::

   localeDate.parse("maandag 30 oktober 2006", {formatLength: "full"});

Special patterns may be specified to provide custom formats, however using such a pattern overrides the locale-specific behavior and may result in an application that is not properly localized. The patterns used follow the specification and are similar to those used by the Java dateformat class (e.g. MMddyyyy).

Also available under :ref:`dojo.cldr.supplemental <dojo/cldr>` are routines to provide the first day of the week and the start and end of the weekend, according to local custom.


Numbers and currencies
======================

The formatting and parsing of numbers is handled in much the same way. Conventions vary around the world for the decimal and thousands separator, placement of the sign, and symbols used to indicate exponential numbers or percentages. There are other exceptions, such as in India, where the thousands separator is used at the thousands place, then again after every two digits instead of three.

dojo.number
-----------

Dojo provides the facilities to properly format and parse numbers on a localized basis using the methods in :ref:`dojo.number <dojo/number>`:

.. js ::

   require(["dojo/number"], function(localeNumber){

     // in the United States
     localeNumber.format(1234567.89);
     // => "1,234,567.89"

     // in France
     localeNumber.format(1234567.89);
     // => "1 234 567,89"

Other options may be specified to limit output to a certain number of decimal places or use rounding. And again, custom formats may be specified, overriding the local customs.

dojo.currency
-------------

:ref:`dojo.currency <dojo/currency>` combines the functionality of dojo.number to use the appropriate syntax with knowledge of the conventions associated with a particular currency -- this includes the number of decimal places typically used with a currency, rounding conventions, and the currency symbol which itself may be rendered differently according to locale, any of these may be overridden. When calling dojo.currency APIs, be sure to specify a currency according to its 3-letter ISO-4217 symbol.

.. js ::

   require(["dojo/currency"], function(localeCurrency){

     // in the United States
     localeCurrency.format(1234.567, {currency: "USD"});
     // => "$1,234.57"
     localeCurrency.format(1234.567, {currency: "EUR"});
     // => "€1,234.57"

     // a French-speaking Swiss user would see
     localeCurrency.format(-1234.567, {currency: "EUR"});
     // => "-1 234,57 €"

     // while a German-speaking Swiss user would see
     localeCurrency.format(-1234.567, {currency: "EUR"});
     // => "-€ 1,234.57"

Note: handling of Hindi and Arabic style numerals is not yet implemented.


Locale support
==============

It is not necessary to craft translated files to support these conventions in your locale. Dojo supports the above cultural conventions and currency types in pretty much every locale available through the CLDR, which is included with the Dojo build tools. However, by default, only a subset of these locales and currencies are built as JavaScript objects in the Dojo repository under :ref:`dojo.cldr <dojo/cldr>`. A script is available to build a custom or more complete set -- look for instructions at util/buildscripts/cldr/README.
