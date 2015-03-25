.. _dojo/date/locale/parse:

=========================
dojo/date/locale::parse()
=========================

.. contents ::
   :depth: 2

Converts a properly formatted String to a primitive Date object, using locale-specific settings.

Introduction
============

By default, this method parses looking for both date and time in the string. Formatting patterns are chosen appropriate
to the locale. Different formatting lengths may be chosen, with "full" used by default. Custom patterns may be used or
registered with translations using the :ref:`dojo/date/locale::addCustomFormats() <dojo/date/locale/addCustomFormats>`
method.

Formatting patterns are implemented using the `syntax described at unicode.org <http://www.unicode.org/reports/tr35/tr35-4.html#Date_Format_Patterns>`_. When two digit years are used, a century is
chosen according to a sliding window of 80 years before and 20 years after present year, for both ``yy`` and ``yyyy``
patterns. Dates prior to year 100CE requires strict mode.

Usage
=====

.. js ::

  require(["dojo/date/locale"], function(locale){
    // Parse a full date time in the current locale
    locale.parse("Tuesday, 13 January 2010 12:43:06 GMT-0:00");
    
    // Parse a short date in a specific locale
    locale.parse("13/01/2010", {
      locale: "en-gb",
      formatLength: "short",
      selector: "date"
    });
  });

Attributes
==========

========= ================================== ====================================================
Arguments Type                               Description
========= ================================== ====================================================
value     String                             The string to be parsed into a date
options   dojo/date/locale::__FormatOptions? *Optional* This follows the format options of 
                                             :ref:`format() <dojo/date/locale/format#attributes>`
========= ================================== ====================================================

The function returns a Date object.

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/date/locale", "dojo/dom", "dojo/domReady!"],
    function(locale, dom){
      var output = locale.parse("13/01/2010", {
        locale: "en-gb",
        formatLength: "short",
        selector: "date"
      });
      dom.byId("output").innerHTML = output.toUTCString();
    });

  .. html ::

    <strong>Output:</strong>
    <div id="output"></div>

See also
========

* :ref:`dojo.date.locale <dojo/date/locale>`
