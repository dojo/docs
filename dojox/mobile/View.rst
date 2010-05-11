#format dojo_rst

dojox.mobile.View
=================

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz
:Developers: Yoshiroh Kamiyama, Jared Jurkiewicz
:Available: since V1.5

.. contents::
    :depth: 2

View is a container widget that represents entire mobile device screen. One html page can have multiple Views. In that case, only one View is visible and the others are invisible. The user can navigate through views with animated transition effects.

**Constructor Parameters**
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Required |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|selected      |Boolean   |No       |If true, the view is displayed at startup time. The default value is false.                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|keepScrollPos |Boolean   |No       |If true, the scroll position is kept when transition occurs between views. The default value is true.      |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
