## page was renamed from manual
#format dojo_rst

Dojo Toolkit Reference Guide
============================

:Status: Draft
:Version: 1.0

.. contents::
   :depth: 2

.. image:: http://media.dojocampus.org/images/docs/logodojocdocssmall.png
   :alt: Dojo Documentation
   :class: logowelcome;


====
Dojo
====

Dojo is divided into two parts: Dojo Base, and Dojo Core. Dojo Base is the functionality provided for by just including ``dojo.js``, and Dojo Core is comprised of stable additional (optional) components. Typically, if a function or Class exists within the dojo namespace directly (eg: dojo.require(), dojo.addOnLoad()) it is part of Base Dojo. If the function or Class exists beneath the dojo namespace (eg: dojo.dnd.Mover), you will need to require the appropriate module (eg: dojo.require("dojo.dnd.Mover");)

* `dojo <dojo/index>`_


=====
Dijit
=====

Dijit is Dojo's UI Library, and lives as a separate namespace ``dijit``. Dijit requires Dojo Core. Each of the widgets and functionality provided by Dijit is describe in the following sections, though the aforementioned `quickstart <quickstart/index>`_ guides cover some basics.

* `dijit <dijit/index>`_


=====
DojoX
=====

DojoX serves many purposes, and by design is difficult to document. Here, we have an ongoing effort to document the most used, stable, reliable and powerful aspects of DojoX. DojoX contains code in alpha and experimental states, so your assistance in testing and documenting are especially helpful.

* `dojox <dojox/index>`_



----

=====
DojoC
=====

DojoC is an svn repository used by DojoCampus for a variety of widgets, tutorials, sandbox, and other demos. You are welcome to explore and contribute, though absolutely nothing is guaranteed to work. DojoC is meant as a community workshop, and code comes and goes frequently, often times 'promoted' to `DojoX projects <dojox>`_.

* `More about DojoC <dojoc/index>`_


================
Dojo Styleguides
================

* `Styleguides <styleguides/index>`_
