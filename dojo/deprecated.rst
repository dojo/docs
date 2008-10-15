#format dojo_rst

dojo.deprecated
===============

:Status: Draft
:Version: 1.0
:Available: since V?

.. contents::
   :depth: 2

This function simply throws a warning message, alerting developers a method or package has been removed, replace, or otherwise has has been changed, and they are using a "older" version of the method.

.. code-block :: javascript

  dojo.deprecated("dijit.layout.SplitContainer","User dijit.layout.BorderContainer instead","2.0");

This means the "SplitContainer" widget still works, but has been replaced by the `BorderContainer <dijit/layout/BorderContainer>`_ widget, and will be removed in Dojo 2.0
