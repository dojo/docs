.. _dojox/mobile/CheckBox:

=====================
dojox/mobile/CheckBox
=====================

:Authors: Doug Hays
:Developers: Doug Hays
:since: V1.7

.. contents ::
    :depth: 2

CheckBox is a very simple INPUT type="checkbox" widget. CheckBox widgets maintain a *checked* boolean attribute (settable/gettable) that toggles on each click action.  While checked, each of the widget's CSS class names are appended with "Checked" and injected into the CSS class list. If embedded within a FORM element, CheckBox widgets will submit a value if in the checked state.


Constructor Parameters
======================

+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default       |Description                                                                                                |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|baseClass     |String    |mblCheckBox   |Default CSS class name used to render the INPUT checkbox.                                                  |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|class         |String    |              |Additional CSS class names to add to baseClass.                                                            |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|checked       |Boolean   |false         |Read-only boolean that returns the current state of the INPUT checkbox.                                    |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|value         |String    |on            |The value submitted on FORM submit if checked==true and the name attribute was specified.                  |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|onChange      |Function  |              |An event handler used for checked state change notifications.                                              |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Simple CheckBox
---------------

.. html ::

  <input data-dojo-type="dojox/mobile/CheckBox" type="checkbox" />

.. image :: SimpleMobileCheckBox.png


onChange handler in HTML5 format
--------------------------------

.. html ::

  <input data-dojo-type="dojox/mobile/CheckBox" type="checkbox" data-dojo-props='
        onChange:function(checked){ alert("checked state changed to " + checked); },
        checked:true' />

.. image :: HTML5MobileCheckBox.png
