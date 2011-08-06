#format dojo_rst

dojox.mobile.CheckBox
=====================

:Status: Draft
:Version: 1.0
:Authors: Doug Hays
:Developers: Doug Hays
:Available: since V1.7

.. contents::
    :depth: 2

CheckBox is a very simple INPUT type="checkbox" widget. While checked, each of the widget's CSS class names are appended with "Checked" and 
injected into the CSS class list. 


======================
Constructor Parameters
======================

+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default       |Description                                                                                                |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|baseClass     |String 	  | mblCheckBox  |Default CSS class name used to render the INPUT checkbox.                                                  |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|class         |String 	  |              |Additional CSS class names to add to baseClass.                                                            |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|checked       |Boolean   | false        |Read-only boolean that returns the current state of the INPUT checkbox.                                    |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|onChange      |Function  |              |An event handler used for checked state change notifications.                                              |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+

========
Examples
========

Simple CheckBox
---------------

.. code-block :: html

  <input dojoType="dojox.mobile.CheckBox" type="checkbox" />

.. image:: SimpleMobileCheckBox.png


onChange handler in HTML5 format
--------------------------------

.. code-block :: html

  <input data-dojo-type="dojox.mobile.CheckBox" type="checkbox" data-dojo-props='
        onChange:function(checked){ alert("checked state changed to " + checked); },
        checked:true' />

.. image:: HTML5MobileCheckBox.png