#format dojo_rst

dojox.widget.ColorPicker
========================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since 1.1

.. contents::
   :depth: 2

A Photoshop-like HSV ColorPicker widget. 

============
Introduction
============

This ColorPicker adds many options to the standard `ColorPallete <dijit/ColorPalette>`_ available in Dijit. 

=====
Usage
=====

To use the ColorPicker you need to first load the CSS:

.. code-block :: html
  :linenos:
  
    <link rel="stylesheet" href="dojotoolkit/dojox/widget/ColorPicker/ColorPicker.css" />

And Require the module:

.. code-block :: javascript
  :linenos:

  dojo.require("dojox.widget.ColorPicker");


========
Examples
========

Programmatic example
--------------------

.. code-block :: javascript
  :linenos:

  var c = new dojox.widget.ColorPicker();

Declarative example
-------------------

.. code-block :: html
  :linenos:

    <div dojoType="dojox.widget.ColorPicker" id="picker"></div>

=====
Notes
=====

``NOTE:`` as of Dojo 1.2, The ColorPicker is experimental, and doesn't implement the Dijit .attr() method for getting and setting values. 
