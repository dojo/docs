.. _dojox/mobile/TextBox:

====================
dojox/mobile/TextBox
====================

:Authors: Doug Hays
:Developers: Doug Hays
:since: V1.7

.. contents ::
    :depth: 2

TextBox is a very simple INPUT widget.


Constructor Parameters
======================

+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default       |Description                                                                                                |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|baseClass     |String    | mblTextBox   |Default CSS class name used to render the textbox.                                                         |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|class         |String    |              |Additional CSS class names to add to baseClass.                                                            |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|maxLength     |Number    | (no limit)   |Maximum number of characters that can be entered in the INPUT box.                                         |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|placeHolder   |String    |              |Prompt text to display inside the INPUT when it would otherwise be empty (requires browser support).       |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|onChange      |Function  |              |An event handler used for INPUT change notifications.                                                      |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|trim          |Boolean   | false        |Remove leading and trailing spaces.                                                                        |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|uppercase     |Boolean   | false        |Convert text to uppercase.                                                                                 |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|lowercase     |Boolean   | false        |Convert text to lowercase.                                                                                 |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|propercase    |Boolean   | false        |Convert text to propercase (Leading Uppercase).                                                            |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Simple TextBox
--------------

.. html ::

  <input data-dojo-type="dojox/mobile/TextBox" placeHolder="Enter LAST name" />

.. image :: SimpleMobileTextBox.png


onChange handler in HTML5 format
--------------------------------

.. html ::

  <input data-dojo-type="dojox/mobile/TextBox" style="background-color:lightgray;"
        data-dojo-props='maxLength:10, value:"some data", onChange:function(newValue){ alert("value changed to " + newValue); }' />

.. image :: HTML5MobileTextBox.png
