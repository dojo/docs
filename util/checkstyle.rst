#format dojo_rst

util.checkstyle
===============

:Status: Draft
:Version: 1.0
:Project owner: Shane O'Sullivan
:Available: since 1.4

.. contents::
   :depth: 2

============
Introduction
============

Checkstyle is a command line tool that generates a report of all JavaScript files that violate the Dojo code style guidelines - http://www.dojotoolkit.org/developer/StyleGuide. It also includes an interactive online tool to automatically fix most style guide issues.

=====
Usage
=====

Open a command window in the util/checkstyle folder.  The commands listed below all use '''checkstyle.bat''', which is for MS Windows, but users of Linux and Macs can use '''checkstyle.sh'''.

Run Checkstyle on all Dojo folders
==================================
checkstyle.bat


Run Checkstyle on a specific folder
===================================
checkstyle.bat dir=dijit/form


Run Checkstyle on a custom namespace
====================================
checkstyle.bat dir=myCustomNs


Show Checkstyle help
====================
checkstyle help



========
See also
========

* TODO: links to other related articles
