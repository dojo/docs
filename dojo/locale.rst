.. _dojo/locale:

===========
dojo.locale
===========

:Project owner: ?--
:since: V?

.. contents ::
   :depth: 2

A string containing the current locale as defined by Dojo.


Introduction
============

dojo.locale contains the locale for loading localized resources, specified according to `RFC 3066 <http://www.ietf.org/rfc/rfc3066.txt>`_. This string can be specified with the help of dojoConfig.locale.


Usage
=====

A simple call of dojo.locale.

.. js ::

   // Dojo 1.7 (AMD)
   require(["dojo/_base/kernel"], function(dojo){
      var currentLocale = dojo.locale;
   });
   // Dojo < 1.7
   var currentLocale = dojo.locale;


See also
========

* :ref:`Language and Localization Settings in dojoConfig <dojo/config>`
