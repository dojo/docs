#format dojo_rst

dojo.locale
===========

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

A string containing the current locale as defined by Dojo.


============
Introduction
============

dojo.locale contains the locale for loading localized resources, specified according to `RFC 3066 <http://www.ietf.org/rfc/rfc3066.txt>`_. This string can be specified with the help of djConfig.locale.


=====
Usage
=====

A simple call of dojo.locale.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var currentLocale = dojo.locale;
 </script>


========
See also
========

* `Language and Localization Settings in djConfig <djConfig#language-and-localization-settings-in-djconfig>`_
