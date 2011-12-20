.. _dojox/widget/ColorPicker:

========================
dojox.widget.ColorPicker
========================

:Project owner: Nathan Toone
:since: V1.1

.. contents ::
   :depth: 2

A Photoshop-like HSV ColorPicker widget.

Introduction
============

This ColorPicker adds many options to the standard :ref:`ColorPalette <dijit/ColorPalette>` available in Dijit.

Usage
=====

To use the ColorPicker you need to first load the CSS:

.. html ::
    
    <link rel="stylesheet" href="dojox/widget/ColorPicker/ColorPicker.css" />

And Require the module:

.. js ::
  
  dojo.require("dojox.widget.ColorPicker");


Examples
========

Programmatic example
--------------------

.. code-example::

  .. css ::

    <link rel="stylesheet" href="{{baseUrl}}dojox/widget/ColorPicker/ColorPicker.css" />

  .. js ::

        dojo.require("dojox.widget.ColorPicker");
        dojo.ready(function(){
            var c = new dojox.widget.ColorPicker({}, "picker1");
        });

  .. html ::

    <div id="picker1"></div>


Declarative example
-------------------

.. code-example::

  .. css ::

    <link rel="stylesheet" href="{{baseUrl}}dojox/widget/ColorPicker/ColorPicker.css" />

  .. js ::

        dojo.require("dojox.widget.ColorPicker");

  .. html ::

    <div data-dojo-type="dojox.widget.ColorPicker" id="picker2"></div>


A ColorPicker within a DropDownButton
-------------------------------------

.. code-example::

  .. css ::

    <link rel="stylesheet" href="{{baseUrl}}dojox/widget/ColorPicker/ColorPicker.css" />

  .. js ::

        dojo.require("dojox.widget.ColorPicker");
        dojo.require("dijit.form.DropDownButton");

  .. html ::

    <div data-dojo-type="dijit.form.DropDownButton">
        <span>
            ColorPicker
        </span>
        <div data-dojo-type="dojox.widget.ColorPicker" id="picker3"></div>
    </div>


Notes
=====

``NOTE:`` as of Dojo 1.2, The ColorPicker is experimental, and doesn't implement the dijit.set() and get() methods for getting and setting values.
