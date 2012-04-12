.. _dojox/mobile/RoundRect:

======================
dojox.mobile.RoundRect
======================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.5

.. contents ::
    :depth: 2

Introduction
============

dojox.mobile.RoundRect is a simple round rectangle container for any HTML and/or widgets. You can achieve the same appearance by just applying the -webkit-border-radius style to a div tag. However, if you use RoundRect, you can get a round rectangle even on non-CSS3 browsers such as (older) IE.

Constructor Parameters
======================

+--------------+----------+---------+--------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                             |
+--------------+----------+---------+--------------------------------------------------------+
|shadow        |Boolean   |false    |If true, adds a shadow effect to the container element. |
+--------------+----------+---------+--------------------------------------------------------+

Examples
========

Declarative example
-------------------

.. js ::

  require([
    "dojox/mobile",
    "dojox/mobile/parser"
  ]);
.. html ::

  <div data-dojo-type="dojox.mobile.RoundRect" data-dojo-props='shadow:true'>
    This module provides some widgets that can be used to build web-based
    applications for mobile devices such as iPhone or Android.
  </div>

.. image :: RoundRect.png
