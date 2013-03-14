.. _dojox/mobile/ToggleButton:

=========================
dojox/mobile/ToggleButton
=========================

:Authors: Doug Hays
:Developers: Doug Hays
:since: V1.7

.. contents ::
    :depth: 2

ToggleButton widgets are a cross between :ref:`Button <dojox/mobile/Button>` and :ref:`Checkbox <dojox/mobile/CheckBox>` widgets. They are created like Button widgets, but like CheckBox widgets, they maintain a *checked* boolean attribute (settable/gettable) that toggles on each click action. Unlike CheckBox widgets however, ToggleButton widgets do not submit any value on FORM submit. They are used solely for client-side processing where the user can toggle between 2 states before performing some additional action. While checked, each of the widget's CSS class names are appended with "Checked" and injected into the CSS class list.


Constructor Parameters
======================

+--------------+----------+---------------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default        |Description                                                                                                |
+--------------+----------+---------------+-----------------------------------------------------------------------------------------------------------+
|baseClass     |String    |mblToggleButton|Default CSS class name used to render the widget.                                                          |
+--------------+----------+---------------+-----------------------------------------------------------------------------------------------------------+
|class         |String    |               |Additional CSS class names to add to baseClass.                                                            |
+--------------+----------+---------------+-----------------------------------------------------------------------------------------------------------+
|checked       |Boolean   |false          |Read-only boolean that returns the current state of the widget.                                            |
+--------------+----------+---------------+-----------------------------------------------------------------------------------------------------------+
|onChange      |Function  |               |An event handler used for checked state change notifications.                                              |
+--------------+----------+---------------+-----------------------------------------------------------------------------------------------------------+
|duration      |Number    |1000           |Duration of the selected CSS change in milliseconds.                                                       |
+--------------+----------+---------------+-----------------------------------------------------------------------------------------------------------+
|label         |String    |               |The label of the button. If the label is not specified, innerHTML is used as a label.                      |
+--------------+----------+---------------+-----------------------------------------------------------------------------------------------------------+
|onClick       |Function  |               |An event handler used for press notifications.                                                             |
+--------------+----------+---------------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Simple ToggleButton
-------------------

.. html ::

  <button data-dojo-type="dojox/mobile/ToggleButton" checked="true">Toggle me</button>

.. image :: SimpleMobileToggleButton.png


onChange handler in HTML5 format
--------------------------------

.. html ::

  <button data-dojo-type="dojox/mobile/ToggleButton" data-dojo-props='
        label:"Toggle me too",
        onChange:function(checked){ alert("checked state changed to " + checked); }'></button>

.. image :: HTML5MobileToggleButton.png
