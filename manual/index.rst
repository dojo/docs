## page was renamed from manual
#format dojo_rst

Dojo Toolkit Reference Guide
============================

.. contents::
   :depth: 2

.. image:: http://media.dojocampus.org/images/docs/logodojocdocssmall.png
   :alt: Dojo Documentation
   :class: logowelcome;


====
Dojo
====

Dojo is divided into two parts: Dojo Base, and Dojo Core.

* `Dojo Base <dojo/index#dojo-base>`_

  The base functionality of the Dojo Toolkit, provided for by just including ``dojo.js``.

* `Dojo Core <dojo/index#dojo-core>`_

  Additional stable (but optional) components.


=====
Dijit
=====

Dijit is Dojo's UI Library, and lives as a separate namespace ``dijit``. Dijit requires Dojo Core. Each of the widgets and functionality provided by Dijit is described in the following sections, though the aforementioned `quickstart <quickstart/index>`_ guides cover some basics.

* `Dijit Reference <dijit/index>`_

=====
DojoX
=====

DojoX serves many purposes, and by design is difficult to document. Here, we have an ongoing effort to document the most used, stable, reliable and powerful aspects of DojoX. DojoX stands for Dojo eXtensions and contains code in a variety of states, from very stable and robust, to alpha and experimental, so your assistance in testing and documenting are especially helpful.

* `DojoX Reference <dojox/index>`_


=====
DojoC
=====

DojoC is an svn repository used by DojoCampus for a variety of widgets, tutorials, sandbox, and other demos. You are welcome to explore and contribute, though absolutely nothing is guaranteed to work. DojoC is meant as a community workshop, and code comes and goes frequently, often times 'promoted' to `DojoX projects <dojox>`_.

* `More about DojoC <dojoc/index>`_


================
Dojo Styleguides
================

* `Styleguides <styleguides/index>`_


===========================
Utilities and Miscellaneous
===========================

There are several Dojo-related sub-projects, utilities, and helpers shipped with Dojo:

* `Dojo Build System <build/index>`_

  The Dojo build system is used to create efficient optimized packages of JavaScript and CSS, customized for a given application or website.

* `The Dojo API Doc System <util/doctools>`_

  Dojo uses a custom inline comment syntax which produces well structured xml, and powers the official `API Docs <http://api.dojotoolkit.org>`_ . 

* `ShrinkSafe <shrinksafe/index>`_

  A standalone utility for compressing JavaScript, used by the Dojo Build System as an optional compression step, though can be used on individual files manually.
