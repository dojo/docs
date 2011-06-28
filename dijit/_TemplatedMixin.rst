#format dojo_rst

dijit._TemplatedMixin
=====================

:Authors: ?-
:Available: since v1.7

.. contents::
    :depth: 2

**dijit._TemplatedMixin** is a Mixin for widgets that are instantiated from a template.  This is lighter than the deprecated `dijit._Templated <dijit/Templated>`_ and requires the inclusion of `dijit._WidgetsInTemplateMixin <dijit/_WidgetsInTemplateMixin>`_ if there are other widgets in the template.

=====
Usage
=====

This should be the main mixin used by widgets that are instantiated from a template.  It provides some enhancements to **dijit._Templated**, but is lighter in weight.  If the template includes subwidgets that need to be handled, the **dijit._WidgetsInTemplateMixin** should also be required by the widget.

======================  ====================  =============================================================================
Parameter               Type                       Description
======================  ====================  =============================================================================
templateString          string                A string that represents the widget template.
templatePath            string                A path to the template file for this widget relative to dojo.baseUrl
_skipNodeCache          boolean               Some widgets have problems if the widget template nodes are cached.  If true, it ensures the template is always re-built from a string
_earlyTemplatedStartup  boolean               A fallback to preserve the 1.0 - 1.3 behaviour of children in templates.
======================  ====================  =============================================================================

========
Examples
========

To Be Completed

=============
Accessibility
=============

To Be Completed
