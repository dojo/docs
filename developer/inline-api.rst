.. _developer/inline-api:

=============
Inlining API
=============

This document contains information on how to inline API documentation into the reference-guide.

Introduction
============

The Dojo API Documentation supports the ability to make remote procedure calls in order to retrieve a JSON
representation of the API.  rstWiki, the tool that generates the reference-guide supports the ability to inline this 
documentation into the page using special directives.

The format of the directives is as the following::

  .. api-doc :: package/module
    :level: 2
    :table:
    :topfunc:
    :methods: foo bar
    :properties: baz qux
    :events: onCorge onGrault
    :no-headers:
    :no-inherited:
    :extensions:
    :privates:
    :summary:
    :description:
    :returns:
    :sig:

Where the ``.. api-doc ::`` is followed by the MID to be inlined (e.g. ``dojo/query`` or ``dijit/form/Button``).  The 
following other options are available:

================== ====================================================================================================
Option             Description
================== ====================================================================================================
``:level:``        The header level that the at which the labels will be output at.  Defaults to ``2``.
``:table:``        Information should be presented in a table format, with summary information provided.  If this is 
                   specified, ``:level``, ``:description:`` and ``:sig:`` will be ignored.
``:topfunc:``      If specified, and the module returns a function, it will output the information for that root 
                   function.
``:methods:``      Output the methods for the specified module.  If this is followed by a space deliminated list, then 
                   only those methods will be output in the order supplied.  If there are none specified, all methods 
                   will be output, based on the ``:privates:`` argument.
``:properties:``   Output the properties for the specified module.  If this is followed by a space deliminated list, 
                   then only those properties will be output in the order supplied.  If there are none specified, all 
                   properties will be output, based on the ``:privates:`` argument.
``:events:``       Output the events for the specified module.  If this is followed by a space deliminated list, then 
                   only those events will be output in the order supplied.  If there are none specified, all events 
                   will be output, based on the ``:privates:`` argument.
``:no-headers:``   If not using tables, do not output a header for each method, property or event.
``:no-inherited:`` If outputting methods, properties or events, do not include those that are inherited.
``:no-base:``      If outputting methods, properties or events, do not include those that are declared within the 
                   class itself.
``:extensions:``   If outputting methods, properties or events, include those that
``:privates:``     If outputting methods, properties or events, include those that are marked as private.
``:summary:``      Output the summary for each method, property or event.
``:description:``  Output the description for each method, property or event.
``:returns:``      For methods, include information about the return value of the method.
``:sig:``          For methods, include a table of arguments that form the signature of the method.
================== ====================================================================================================

The above directive is designed to potentially be used, with a different configuration, in different places in the 
document, especially since the directive will not output any headers between methods, properties or events.

The following provides some "live" examples:

dojo/on Root Function
=====================

.. api-doc :: dojo/on
  :topfunc:
  :returns:
  :summary:
  :sig:

dojo/Stateful Methods
=====================

.. api-doc :: dojo/Stateful
  :methods: get set watch
  :table:
  :summary:

dijit/_WidgetBase Properties
============================

.. api-doc :: dijit/_WidgetBase
  :properties:
  :privates:
  :table:
  :summary:

dijit/form/Button Events
========================

.. api-doc :: dijit/form/Button
  :events:
  :summary:
