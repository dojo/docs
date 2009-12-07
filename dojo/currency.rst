#format dojo_rst

dojo.currency
=============

:Status: Draft
:Version: 1.0

.. contents::
  :depth: 2


============
Introduction
============

dojo.currency extends dojo.number to handle formatting and printing.  Data provided by dojo.cldr enables handling of virtually every type currency according to local customs.  This data provides the formatting conventions, the representation and placement of the currency symbol, and the number of decimal places used.

By default, the Dojo Toolkit is prepared to support for a short list of major world currencies.  That list can be extended by running the scripts in util/buildscripts/cldr.  Please see the README in that directory for details.

================
format()/parse()
================


========
See Also
========

 * dojo.number

TODO: add references to CLDR, setting locale in Dojo, binary floating point issues
