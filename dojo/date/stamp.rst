.. _dojo/date/stamp:

===============
dojo/date/stamp
===============

.. contents ::
  :depth: 2

**dojo/date/stamp** is a module that provides date handling functions for ISO-8601 standard formatting of date/time
stamps. The standard return variable for this module is ``stamp``.

Introduction
============

Methods of ``dojo/date/stamp`` module use a profile of the ISO8601 as defined by `[RFC3339] <http://www.ietf.org/rfc/rfc3339.txt>`_ to handle dates in a way that is unambiguous, culturally and location
independent, fast, and easily machine readable. The format is ``yyyy-MM-ddTHH:mm:ss.SSS`` where the fields do
not all need to be specified, and either local time, GMT offset or "Zulu" may be used.

.. api-link :: dojo.date.stamp

Usage
=====

.. js ::

  require(["dojo/date/stamp"], function(stamp){
    var date1 = new Date();
    var options = {
      selector: "date",
      zulu: true
    };
    
    stamp.toISOString(date1);
    stamp.toISOString(date1, options);
    
    stamp.fromISOString("2008-10-17T00:00:00Z");
    stamp.fromISOString("T23:59:59.999-04:00", date1);
  });

Features
========

fromISOString()
---------------

Returns a Date object given a string formatted according to a subset of the ISO-8601 standard.

Attributes
~~~~~~~~~~

=============== ======= ================================================================================================
Argument        Type    Description
=============== ======= ================================================================================================
formattedString String  A string such as ``2005-06-30T08:05:00-07:00`` or ``2005-06-30`` or ``T08:05:00``
defaultTime     Number? Used for defaults for fields omitted in the formattedString. Uses ``1970-01-01T00:00:00.0Z`` by
                        default.
=============== ======= ================================================================================================

The function returns a Date.

toISOString()
-------------

Format a Date object as a string according a subset of the ISO-8601 standard.

Attributes
~~~~~~~~~~

========== ======= ====================================================================================================
Argument   Type    Description
========== ======= ====================================================================================================
dateObject Date    The Date to be converted
options    Object? *Optional argument* Options on how the date should be formatted.  Refer to the API documentation for
                   full details
========== ======= ====================================================================================================

The function returns a String.

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/date/stamp", "dojo/dom", "dojo/domReady!"], 
    function(stamp, dom){
        var date1 = new Date(2008, 9, 17);
        date1.setUTCHours(0);

        var output = stamp.toISOString(date1, {zulu: true}) + "</br>";

        output += stamp.toISOString(date1, {selector: 'date'}) + "<br/>";

        output += stamp.fromISOString("2008-10-17T00:00:00Z").toGMTString() + "<br/>";
        // note toGMTString output is implementation-dependent

        output += stamp.fromISOString("T23:59:59.999-04:00", new Date(2008,9,17)).toGMTString();

        dom.byId("output").innerHTML = output;
    });

  .. html ::

    <strong>Output:</strong>
    <div id="output"></div>

See Also
========

* :ref:`dojo/date <dojo/date>`

* :ref:`dojo/date/locale <dojo/date/locale>`

* `ISO-8601 <http://wikipedia.org/wiki/ISO_8601>`_
