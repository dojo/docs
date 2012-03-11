.. _util/index:

====
Util
====

The util/ directory is different than dojo/dijit/dojox in that it doesn't contain JavaScript code that accessed directly from web pages.   Rather, it contains utility scripts as listed below.

:ref:`Dojo Build System <build/index>`
--------------------------------------

The Dojo build system is used to create efficient optimized packages of JavaScript and CSS, customized for a given application or website. You can take advantage of this powerful tool to help structure your development and speed up your applications.

See also the documentation on :ref:`custom builds <quickstart/custom-builds>`, about how to make optimized builds based on which dojo modules you are using.


:ref:`ShrinkSafe <util/shrinksafe/index>`
-----------------------------------------

A standalone utility for compressing JavaScript, used by the Dojo Build System as an optional compression step, though can be used on individual files manually.

DOH
---
:ref:`DOH <util/doh>` is the test harness used by dojo, similar to JUnit.

The util/doh/ directory also contains :ref:`DOH Robot <util/dohrobot>`, an API used in conjunction with DOH for automated keyboard/mouse testing.

:ref:`The Dojo API Doc System <util/doctools>`
----------------------------------------------

Dojo uses a custom inline comment syntax which produces well structured xml, and powers the official `API Docs <http://dojotoolkit.org/api/>`_ .

The doc system is powered by the docscripts/ directory, where generate.php extracts the inline documentation into an api.xml file, and the jsdoc/ directory, which generates web pages to display the doc.

:ref:`Checkstyle <util/checkstyle>`
-----------------------------------

A standalone utility for checking JavaScript files for violations of the Dojo style guide. Also includes an online tool for automatically fixing the majority of style guide violations.


Migration
-----------
The migration directory contains scripts for helping to migrate from older versions of dojo to newer ones.
