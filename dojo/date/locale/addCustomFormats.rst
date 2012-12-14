.. _dojo/date/locale/addCustomFormats:

====================================
dojo/date/locale::addCustomFormats()
====================================

:Project owner: Adam Peller
:Authors: Seth Lytle, Adam Peller, Marcus Reimann

.. contents ::
   :depth: 2

Adds a reference to a bundle containing localized custom formats to be used by date/time formatting and parsing
routines.

Introduction
============

The user may add custom localized formats where the bundle has properties following the same naming convention used by
:ref:`dojo/cldr <dojo/cldr>`: ``dateFormat-xxxx`` / ``timeFormat-xxxx`` and the pattern string should match that format.
See :ref:`dojo/date/locale::format() <dojo/date/locale/format>` for details. The resources must be loaded by via the
:ref:`dojo/i18n <dojo/i18n>` prior to use.

Usage
=====

.. js ::

  require(["dojo/_base/kernel", "dojo/date/locale", "dojo/i18n"], function(kernel, locale, i18n){
    var bundle = {
      timeFormat-custom: "HH:mm:ss.zzzz",
      dateFormat-custom: "d-MMMM-y"
    };
    i18n.cache["mypackage/nls/gregorian/" + kernel.locale] = bundle;
    locale.addCustomFormats("mypackage", "gregorian");
  });

See also
========

* :ref:`dojo/date/locale <dojo/date/locale>`


