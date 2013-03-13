.. _dojox/mobile/Slider:

===================
dojox/mobile/Slider
===================

:Authors: Doug Hays
:Developers: Doug Hays
:since: V1.7

.. contents ::
    :depth: 2

Slider is a simple INPUT type="range" widget (either horizontal or vertical) allowing numeric values to be selected by dragging a handle.


Constructor Parameters
======================

+--------------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|Parameter           |Type      |Default       |Description                                                                                                |
+--------------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|value               |Number    | 0            |Current value of the widget.                                                                               |
+--------------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|min                 |Number    | 0            |Minimum value of the widget.                                                                               |
+--------------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|max                 |Number    | 100          |Maximum value of the widget.                                                                               |
+--------------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|step                |Number    | 1            |Delta from 1 value to the next.  0 means smallest possible given the pixel size.                           |
+--------------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|onChange            |Function  |              |An event handler used for widget value change notifications.                                               |
+--------------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|flip                |Boolean   | false        |Reverse the direction of the Slider values.                                                                |
+--------------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|orientation         |String    | auto         |One of H (horizontal), V (vertical), or auto (selects best fit) for Slider handle to move.                 |
+--------------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|halo                |String    | 8pt          |Size of padding around the Slider widget that can receive touch events in order to interact with Slider.   |
+--------------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|intermediateChanges |Boolean   | false        |Whether onChange fires on each value change or only once at the end while slider's handle is moved.        |
+--------------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Simple Slider
-------------

.. html ::

  <input type="range" style="width:200px;" data-dojo-type="dojox/mobile/Slider" value="10" max="20" />

.. image :: SimpleMobileSlider.png


onChange handler in HTML5 format
--------------------------------

.. html ::

  <input type="range" style="height:200px;width:20px;" data-dojo-type="dojox/mobile/Slider" data-dojo-props='
        step:0,
        orientation:"V",
        onChange:function(newValue){ alert("value changed to " + newValue); }' />

.. image :: HTML5MobileSlider.png
