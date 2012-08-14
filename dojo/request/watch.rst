.. _dojo/request/watch:

==================
dojo/request/watch
==================

:authors: Bryan Forbes
:since: V1.8

.. contents ::
    :depth: 2

**dojo/request/watch** is an internal module that is used within the ``dojo/request`` package to manage in-flight
requests. It prevents memory leaks on older browsers and handles and tracks if a request has timed out if a
``timeout`` option has been specified.

See also
========

* :ref:`dojo/request <dojo/request>` - The Request API package

* :ref:`dojo/request/xhr <dojo/request/xhr>` - The default provider for browser platforms

* :ref:`dojo/request/node <dojo/request/node>` - The default provider for the node.js platform

* :ref:`dojo/request/iframe <dojo/request/iframe>` - A provider that uses IFrame for transport

* :ref:`dojo/request/script <dojo/request/script>` - A provider that expects the response to be embedded in a
  ``<script>`` tag.
