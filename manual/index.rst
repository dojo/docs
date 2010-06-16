## page was renamed from manual
#format dojo_rst

Dojo Toolkit Reference Guide
============================

.. contents::
   :depth: 2

.. image:: logodojocdocssmall.png
   :alt: Dojo Documentation
   :class: logowelcome;


====
Dojo
====

* `dojo.js <dojo/index#dojo-js>`_

  The base functionality of the Dojo Toolkit, provided by just including ``dojo.js``. This includes tons of features like CSS-based queries, event handling, animations, Ajax, class-based programming, and a package system that makes getting access to the rest of Dojo a snap.

* `Dojo Core <dojo/index#dojo-core>`_

  Additional stable (but optional) components for advanced animations, I/O, data, Drag and Drop and much more.

=====
Dijit
=====

Dijit is Dojo's themeable, accessible, easy-to-customize UI Library. There are many widgets to choose from, so be sure to check out the `quickstart <quickstart/index>`_ guide which covers the basics. Dijit requires ``dojo.js`` and other Core modules. 

* `Dijit Reference <dijit/index>`_

=====
DojoX
=====

DojoX stands for Dojo eXtensions and contains many useful sub-projects and varying states of maturity -- from very stable and robust, to alpha and experimental. All DojoX projects contain README files that outline their maturity and authorship, so be sure to check those along with the documentation pages to get the full picture of where a module is headed.

* `DojoX Reference <dojox/index>`_


=====
DojoC
=====

DojoC is an external svn repository used by DojoCampus for a variety of widgets, tutorials, sandbox, and other demos. You are welcome to explore and contribute, though absolutely nothing is guaranteed to work. DojoC is meant as a community workshop, and code comes and goes frequently, often times 'promoted' to `DojoX projects <dojox>`_.

* `More about DojoC <dojoc/index>`_


================
Dojo Styleguides
================

* `Styleguides <styleguides/index>`_


===========================
Utilities and Miscellaneous
===========================

`Dojo Build System <build/index>`_
-----------------------------------

The Dojo build system is used to create efficient optimized packages of JavaScript and CSS, customized for a given application or website. You can take advantage of this powerful tool to help structure your development and speed up your applications.

`Multiple Versions of Dojo on a Page <multiversion/index>`_
------------------------------------------------------------

Dojo has special configuration and build options to allow you to use different versions of Dojo on the same page.



`The Dojo API Doc System <util/doctools>`_
-------------------------------------------

Dojo uses a custom inline comment syntax which produces well structured xml, and powers the official `API Docs <http://api.dojocampus.org/>`_ . 

`ShrinkSafe <shrinksafe/index>`_
---------------------------------

A standalone utility for compressing JavaScript, used by the Dojo Build System as an optional compression step, though can be used on individual files manually.


`Checkstyle <util/checkstyle>`_
---------------------------------

A standalone utility for checking JavaScript files for violations of the Dojo style guide. Also includes an online tool for automatically fixing the majority of style guide violations.
