#format dojo_rst

dojox.mobile.Heading
====================

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz
:Developers: Yoshiroh Kamiyama, Jared Jurkiewicz
:Available: since V1.5

.. contents::
    :depth: 2

Heading is a widget that represents a navigation bar in typical mobile applicatons.  It usually appears at the top of a View and displays the title of the current view.  It may also inlcude navigational controls for moving back to the previous View and to a new View.

**Constructor Parameters**

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Required |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|back          |String 	  |No       |A label for the navigational control to return to the previous View                                        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|href 	       |String    |No       |A URL to open when the navigational control is pr                                                          |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|moveTo        |String    |No       |An id of a View to which the current view moves when the 'next' navigational control is pressed.           |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|transition    |String    |No       |A type of animated transition effect. "slide", "fade", "flip", or "none". The default value is "slide".    |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|label 	       |String    |No       |A title text of the heading. If the label is not specified, the innerHTML of the node is used as a label   |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
