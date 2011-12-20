.. _dijit/_Templated:

================
dijit._Templated
================

:Authors: Peter Higgins, Bill Keese, Nikolai Onken
:Project owner: Bill Keese
:since: V0.9

.. contents ::
   :depth: 2


Introduction
============

dijit._Templated has been superseded by :ref:`dijit._TemplatedMixin <dijit/_TemplatedMixin>`
and :ref:`dijit._WidgetsInTemplateMixin <dijit/_WidgetsInTemplateMixin>`.
Please see those pages for details.
dijit._Templated will be removed in the 2.0 release.


waiRole and waiState
--------------------

These attributes were support for accessibility, to define the role of DOM nodes such as "tree".
See :ref:`Creating Accessible Widgets <quickstart/writingWidgets/a11y>` for more information.

However, due to browser advancements widgets can now just specify roles (ex: role="grid") and aria states (ex: aria-pressed="true") directly.


widgetsInTemplate
-----------------

Setting the widgetsInTemplate flag to true turns on the widgets-in-template feature described by  :ref:`dijit._WidgetsInTemplateMixin <dijit/_WidgetsInTemplateMixin>`.


See also
========

* :ref:`Writing Widgets <quickstart/writingWidgets>`
