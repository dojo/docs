## page was renamed from util
#format dojo_rst

Util
====

The util/ directory is different than dojo/dijit/dojox in that it doesn't contain javascript code that accessed directly from web pages.   Rather, it contains utility scripts as listed below.


`Dojo Build System <build/index>`_
--------------------------------------

The Dojo build system is used to create efficient optimized packages of JavaScript and CSS, customized for a given application or website. You can take advantage of this powerful tool to help structure your development and speed up your applications.

See also the documentation on `custom builds <quickstart/custom-builds>`_, about how to make optimized builds based on which dojo modules you are using.


`ShrinkSafe <shrinksafe/index>`_
------------------------------------

A standalone utility for compressing JavaScript, used by the Dojo Build System as an optional compression step, though can be used on individual files manually.


DOH
---
`DOH <util/doh>`_ is the test harness used by dojo, similar to JUnit.

The util/doh/ directory also contains `DOH Robot <util/dohrobot>`_, an API used in conjunction with DOH for automated keyboard/mouse testing.


`The Dojo API Doc System <util/doctools>`_
----------------------------------------------

Dojo uses a custom inline comment syntax which produces well structured xml, and powers the official `API Docs <http://api.dojocampus.org/>`_ .

The doc system is powered by the docscripts/ directory, where generate.php extracts the inline documentation into an api.xml file, and the jsdoc/ directory, which generates web pages to display the doc.



`Checkstyle <util/checkstyle>`_
-----------------------------------

A standalone utility for checking JavaScript files for violations of the Dojo style guide. Also includes an online tool for automatically fixing the majority of style guide violations.


Migration
-----------
The migration directory contains scripts for helping to migrate from older versions of dojo to newer ones.
