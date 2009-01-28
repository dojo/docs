#format dojo_rst

ShrinkSafe 
==========

:Status: Draft
:Version: 2.0
:Project owner: Alex Russell
:Available: since V0.4

.. contents::
   :depth: 2

ShrinkSafe is a standalone Java-based JavaScript compressor which utilizes Rhino to introspect code and safely obfuscate the results. 

================
Getting the Code
================

While ShrinkSafe is available as an `online service <http://shrinksafe.dojotoolkit.org/>`_ and a default step in the `Dojo Build system <build/index>`_, one may wish to use this application outside of Dojo, and on their own servers.

ShrinkSafe comes bundled with the ``-src`` releases of the Dojo Toolkit in the folder ``util/shrinksafe/``. Alternately, you can download ShrinkSafe standalone from `http://download.dojotoolkit.org <http://download.dojotoolkit.org/current-stable/>`_ by selecting the ``-shrinksafe`` archive. 

In versions prior to Dojo 1.3, ShrinkSafe was bundled into Rhino by way of patch, and shipped as ``custom_rhino.jar``. In newer versions, ShrinkSafe has been extracted into it's own .jar which utilizes a vanilla Rhino jar: ``js.jar`` 

=====
Usage
=====



========
See also
========

* `Dojo Builds <build/index>`_
