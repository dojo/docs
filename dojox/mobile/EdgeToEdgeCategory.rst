.. _dojox/mobile/EdgeToEdgeCategory:

===============================
dojox.mobile.EdgeToEdgeCategory
===============================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.5

.. contents ::
    :depth: 2

Introduction
============

EdgeToEdgeCategory is a category header for an :ref:`edge-to-edge list <dojox/mobile/EdgeToEdgeList>`.

.. image :: EdgeToEdgeCategory.png

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

  <h2 data-dojo-type="dojox.mobile.EdgeToEdgeCategory">J</h2>
