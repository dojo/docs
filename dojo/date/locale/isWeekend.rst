.. _dojo/date/locale/isWeekend:

=============================
dojo/date/locale::isWeekend()
=============================

.. contents ::
   :depth: 2

Determines if the date falls on a weekend, according to local custom.

Usage
=====

.. js ::

  require(["dojo/date/locale"], function(locale){
    // Returns if current date is the weekend in the current locale
    locale.isWeekend();
    
    // Returns if 10 Nov 2010 was a weekend in the current locale
    var date1 = new Date(2010, 10, 10);
    locale.isWeekend(date1);
    
    // Returns if 10 Nov 2010 was a weekend in the French locale
    locale.isWeekend(date1, "fr");
  })

Attributes
==========

========== ======= =============================================
Argument   Type    Description
========== ======= =============================================
dateObject Date?   *Optional* The date to check (default: today)
locale     String? *Optional* Overrides the current locale
========== ======= =============================================

The function returns ``true`` if the date is on the weekend in the locale, otherwise ``false``.

Example
=======

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/date/locale", "dojo/dom", "dojo/domReady!"],
    function(locale, dom){
      if (locale.isWeekend()){
        var output = "It is the weekend!";
      }else{
        var output = "It is a weekday, get back to work!";
      }
      dom.byId("output").innerHTML = output;
    });

  .. html ::

    <strong>Output:</strong>
    <div id="output"></div>

See also
========

* :ref:`dojo.date.locale <dojo/date/locale>`

.. api-link :: dojo.date.locale.isWeekend
