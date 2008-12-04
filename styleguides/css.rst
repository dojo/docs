#format dojo_rst

CSS Styleguide
===============

:Status: Draft

.. contents::
   :depth: 2

This styleguide will give you in depth information on how Dojo and Dijits CSS Classes are used, and how you can create your own themes.

============
Introduction
============

Dijit comes with a very powerful themeing system.


=================
State inheritance
=================

In Dijit, nodes never inherit state from their child nodes. Lets look at an example:

When looking at a numberspinner you will see two buttons at the right of the numberspinner. When you set focus on the form element all childnodes will inherit from dijitFocus whereas when you click the up or down button the dijitActive class will only affect the button and not the entire numberspinner.

In the case that you need a parent node inherit state from a childnode - e.g. change the bordercolor of the forminput when the user clicks the up or down button = you need to do this when you instantiate the widget and add a custom event listener which adds or removes a class.


========
See also
========

* http://dojotoolkit.org/book/dijit-functional-spec/dijit-styling-theming
