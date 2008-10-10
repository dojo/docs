#format dojo_rst

dojo.version
============

:Status: Draft
:Version: 1.0
:Authors: ?--
:Developers: ?-
:Available: since V?

.. contents::
   :depth: 2

An object describing the current version of dojo.js

.. code-block :: javascript
  :linenos:

  >>> dojo.version;
  0.0.0dev (15278) major=0 minor=0 patch=0 flag=dev revision=15278
  >>> dojo.version.toString();
  "0.0.0dev (15278)"

0.0.0 indicated a "trunk" release. Typically you will see a real version, such as "1.2.0"
