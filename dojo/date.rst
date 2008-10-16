#format dojo_rst

dojo.date
=========

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 2


============
Introduction
============

dojo.date contains methods for manipulating Javascript Date objects.  The dojo.date.* methods are generally independent of String representations and are culturally neutral.  There are two modules beneath dojo.date: dojo.date.stamp.*, for culturally neutral representations using a subset of the ISO-8601 standard, typically for machine-readable formatting and parsing of dates (e.g. 2008-10-16T23:59:59), and dojo.date.locale.*, for culturally-sensitive formatting and parsing of dates for human interaction (e.g. in English: Thursday, October 8, 2008 11:59:59PM)



=====
Usage
=====



========
See Also
========

* `dojo.date.locale.* <dojo/date/locale>`_
* `dojo.date.stamp.* <dojo/date/stamp>`_
