.. _dojo/date/locale/getNames:

============================
dojo/date/locale::getNames()
============================

.. contents ::
   :depth: 2

Used to get localized strings from ``dojo.cldr`` for day or month names.

Usage
=====

.. js ::

  require(["dojo/date/locale"], function(locale){
    // Get full months like "January"
    locale.getNames("months", "wide");
    
    // Get days like "M"
    locale.getNames("days", "narrow", "standAlone");
    
    // Get French names of months like "Janvier"
    locale.getNames("months", "wide", "format", "fr");
  });

Attributes
==========

======== ======= =======================================================================
Argument Type    Description
======== ======= =======================================================================
item     String  The item to retrieve ("months" or "days")
type     String  "wide" or "abbr" or "narrow" (e.g. "Monday", "Mon" or "M" respectively)
context  String? "standAlone" or "format" (default "format")
locale   String? Override the current locale to find the names
======== ======= =======================================================================

The function returns an Array.

Examples
========

The following code retrieves the "wide" versions of the months based on the current browser locale and prints out the
array of values.

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/date/locale", "dojo/dom", "dojo/json", "dojo/domReady!"],
    function(locale, dom, JSON){
      var output = locale.getNames("months", "wide");
      dom.byId("output").innerHTML = JSON.stringify(output);
    });

  .. html ::

    <strong>Output:</strong>
    <pre id="output"></pre>

See also
========

* :ref:`dojo/date/locale <dojo/date/locale>`

.. api-link :: dojo.date.locale.getNames
