.. _index:

============================
Dojo Toolkit Reference Guide
============================

.. contents ::
   :depth: 2

Welcome
=======

The Dojo Toolkit Reference Guide is designed to be an in-depth resource regarding the Dojo Toolkit. The Reference Guide
is a community effort and can be contributed to by anyone who has a `CLA <http://dojofoundation.org/about/cla>`_ in
place with the Dojo Foundation.

If you are looking for an introduction to the Dojo Toolkit, it is better to utilize the tutorials, and then use this
reference guide.

The Dojo Toolkit
================

The Dojo Toolkit is divided into several main packages that would constitute a full distribution of Dojo Toolkit. Those
main packages are:

* :ref:`dojo <dojo/index>` - Sometimes referred to as the "core", this is the main part of Dojo and the most generally
  applicable packages and modules are contained in here. The core covers a wide range of functionality like AJAX, DOM
  manipulation, class-type programming, events, promises, data stores, drag-and-drop and internationalization libraries.

* :ref:`dijit <dijit/index>` - An extensive set of widgets (user interface components) and the underlying system to 
  support them. It is built fully on-top of the Dojo core.

* :ref:`dojox <dojox/index>` - A collection of packages and modules that provide a vast array of functionality that are
  built upon both the Dojo core and Dijit. Packages and modules contained in DojoX will have varying degrees of
  maturity, denoted within the README files of each package. Some of the modules are extremely mature and some are
  highly experimental.

* :ref:`util <util/index>` - Various tools that support the rest of the toolkit, like being able to build, test and 
  document code.

One of the long term objectives of the Dojo Toolkit is to continue to make packages more vibrant and not necessarily
require packages to exist within DojoX. Some of the packages that are currently part of this community are:

* `dgrid <http://dgrid.io/>`_ - A full featured, lightweight data grid.

Reference Guide Structure
=========================

This guide not only covers of the main packages of the toolkit, it also provides a few other areas of reference
information:

* :ref:`Release Notes <releasenotes/index>` - The release notes for the Dojo Toolkit and a couple of other release related
  transition notes.

* :ref:`Developer Notes <developer/index>` - Several documents that are used to document Dojo contributor and committer
  guidelines.
