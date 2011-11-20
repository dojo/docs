.. _dojox/data/RailsStore:

dojox.data.RailsStore
=====================

:Status: Draft
:Version: 1.0
:Project owner: Kris Zyp, Travis Tilley
:Available: since 1.3

.. contents::
   :depth: 2

RailsStore extends the JsonRestStore to interact properly with Ruby on Rail's REST interface.


============
Introduction
============

RailsStore provides the same functionality as the JsonRestStore except that it formats the request URLs to Rail's specifications, post-pending URLs with .json extension to indicate that JSON format is being requested. It will also translate Dojo Data sort attributes to query parameters for Rail's will_paginate module.

=====
Usage
=====

See dojox/data/JsonRestStore for usage from Dojo. For setting up the REST interaction from Ruby on Rail's see Ruby code that is available here: http://github.com/ttilley/railsstore/tree/master.

========
Examples
========

See dojox/data/JsonRestStore for examples of Dojo usage. The attached Ruby code should contain examples on how to setup Rails.

========
See also
========

http://www.sitepen.com/blog/2008/06/13/restful-json-dojo-data/
http://www.sitepen.com/blog/?p=565
http://docs.dojocampus.org/dojox/data/JsonRestStore
