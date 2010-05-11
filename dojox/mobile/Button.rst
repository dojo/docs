#format dojo_rst

dojox.mobile.Button
===================

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz
:Developers: Yoshiroh Kamiyama, Jared Jurkiewicz
:Available: since V1.5

.. contents::
    :depth: 2

Button is a very simple button with a very basic capbility.  It changes the button color when pressed and then returns the color to normal after a given period of time.

**Constructor Parameters**

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Required |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|btnClass      |String 	  |No       |A button class name. The default value is "mblBlueButton". Note that there is no relationship between this |
|              |          |         |Button widget and the button classes that are defined in dojox/mobile/themes/buttons.css.                  |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|duration      |Number    |No       |Duration of the selected color status in milliseconds.                                                     |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
