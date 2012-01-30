.. _dojo/date/stamp:

===============
dojo/date/stamp
===============


.. contents ::
  :depth: 2


Introduction
============

Methods of dojo/date/stamp module use a profile of the ISO-8601 standard to handle dates in a way that is unambiguous, culturally and location independent, fast, and easily machine readable.  The format is yyyy-MM-ddTHH:mm:ss.SSS where the fields do not all need to be specified, and either local time, GMT offset or "Zulu" may be used.  See the API documentation for details.



Usage
=====

.. code-example ::

  .. js ::

    require(["dojo/date/stamp"], function(stamp){
        var date1 = new Date(2008, 9, 17);
        date1.setUTCHours(0);
        console.log(stamp.toISOString(date1, {zulu: true}));
        // 2008-10-17T00:00:00Z
        
        console.log(stamp.toISOString(date1, {selector: 'date'}));
        // 2008-10-16
        
        console.log(stamp.fromISOString("2008-10-17T00:00:00Z").toGMTString()); // note toGMTString output is implementation-dependent
        // Fri, 17 Oct 2008 00:00:00 GMT
        
        console.log(stamp.fromISOString("T23:59:59.999-04:00", new Date(2008,9,17)).toGMTString());
        // Sat, 18 Oct 2008 03:59:59 GMT
    });


See Also
========

* :ref:`dojo.date.* <dojo/date>`
* :ref:`dojo.date.locale.* <dojo/date/locale>`
* `Dojo Cookie: Dates to Remember <http://dojocampus.org/content/2008/07/03/dates-to-remember/>`_
