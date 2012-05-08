.. _dojox/mobile/RoundRectCategory:

==============================
dojox.mobile.RoundRectCategory
==============================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.5

.. contents ::
    :depth: 2

Introduction
============

RoundRectCategory is a category header for a rounded rectangle list.

.. image :: RoundRectCategory.png

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|label         |String    |""       |A label of the category. If the label is not specified, innerHTML is used as a label.                      |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

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

  <h2 data-dojo-type="dojox.mobile.RoundRectCategory">Transition Effects</h2>
