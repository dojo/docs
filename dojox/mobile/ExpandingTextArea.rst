.. _dojox/mobile/ExpandingTextArea:

==============================
dojox/mobile/ExpandingTextArea
==============================

:Authors: Doug Hays
:Developers: Doug Hays
:since: V1.7

.. contents ::
    :depth: 2

TextArea is a very simple TEXTAREA widget, but it dynamically resizes to fit the content of the text inside. It takes nearly all the parameters (name, value, etc.) that a vanilla TEXTAREA takes. The attribute rows is not supported since this widget adjusts the height.


Constructor Parameters
======================

+------------+---------+--------------------+--------------------------------------------------------------------------------------------------------+
|Parameter   |Type     |Default             |Description                                                                                             |
+------------+---------+--------------------+--------------------------------------------------------------------------------------------------------+
|baseClass   |String   |mblTextArea         |Default CSS class names used to render the TEXTAREA.                                                    |
|            |         |mblExpandingTextArea|                                                                                                        |
+------------+---------+--------------------+--------------------------------------------------------------------------------------------------------+
|class       |String   |                    |Additional CSS class names to add to baseClass.                                                         |
+------------+---------+--------------------+--------------------------------------------------------------------------------------------------------+
|value       |String   |                    |Initial value of the editable text.  If omitted, then the TEXTAREA's innerHTML is used.                 |
+------------+---------+--------------------+--------------------------------------------------------------------------------------------------------+
|maxLength   |Number   |                    |Maximum number of characters that can be entered in the TEXTAREA (requires browser support).            |
+------------+---------+--------------------+--------------------------------------------------------------------------------------------------------+
|placeHolder |String   |                    |Prompt text to display inside the TEXTAREA when it would otherwise be empty (requires browser support). |
+------------+---------+--------------------+--------------------------------------------------------------------------------------------------------+
|onChange    |Function |                    |An event handler used for TEXTAREA value change notifications.                                          |
+------------+---------+--------------------+--------------------------------------------------------------------------------------------------------+

Examples
========

Simple ExpandingTextArea
------------------------

.. html ::

  <textarea data-dojo-type="dojox/mobile/ExpandingTextArea">line 1
  line 2</textarea>

.. image :: SimpleMobileExpandingTextArea.png


onChange handler in HTML5 format
--------------------------------

.. html ::

  <textarea data-dojo-type="dojox/mobile/ExpandingTextArea" cols="40"
    data-dojo-props='value:"line 1\nline 2\nline 3", onChange:function(newValue){ alert("value changed to " + newValue); }'></textarea>

.. image :: HTML5MobileExpandingTextArea.png
