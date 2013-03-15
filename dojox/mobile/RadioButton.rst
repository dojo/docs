.. _dojox/mobile/RadioButton:

========================
dojox/mobile/RadioButton
========================

:Authors: Doug Hays
:Developers: Doug Hays
:since: V1.7

.. contents ::
    :depth: 2

RadioButton is a very simple INPUT type="radio" widget. RadioButton widgets maintain a *checked* boolean attribute (settable/gettable) that is true when clicked, but unlike CheckBox, is false only when a different RadioButton with the same name attribute is clicked.  While checked, each of the widget's CSS class names are appended with "Checked" and injected into the CSS class list.  Normally, there are multiple RadioButton widgets assigned to a single group defined by widgets sharing the same *name* attribute. Upon FORM submission, the 1 checked RadioButton *value* is submitted using this shared *name*.


Constructor Parameters
======================

+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default       |Description                                                                                                |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|baseClass     |String    |mblRadioButton|Default CSS class name used to render the INPUT checkbox.                                                  |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|class         |String    |              |Additional CSS class names to add to baseClass.                                                            |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|checked       |Boolean   |false         |Read-only boolean that returns the current state of the widget.                                            |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|value         |String    |              |The value submitted on FORM submit if checked==true and the name attribute was specified.                  |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|onChange      |Function  |              |An event handler used for checked state change notifications.                                              |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Simple RadioButton
------------------

.. html ::

  <input type="radio" data-dojo-type="dojox/mobile/RadioButton" checked="true"  name="radioGroup" value="yes" />
  <input type="radio" data-dojo-type="dojox/mobile/RadioButton" checked="false" name="radioGroup" value="no" />

.. image :: SimpleMobileRadioButton.png


onChange handler in HTML5 format
--------------------------------

.. html ::

  <input type="radio" name="group" data-dojo-type="dojox/mobile/RadioButton" data-dojo-props='
      value:"on",
      onChange:function(checked){ if(checked)alert("on selected"); }' />
  <input type="radio" name="group" data-dojo-type="dojox/mobile/RadioButton" data-dojo-props='
      checked:true,
      value:"off",
      onChange:function(checked){ if(checked)alert("off selected"); }' />

.. image :: HTML5MobileRadioButton.png
