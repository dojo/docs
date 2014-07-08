.. _dojox/mobile/ContentPane:

========================
dojox/mobile/ContentPane
========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

Introduction
============

ContentPane is a very simple and lightweight content pane to embed an HTML fragment.
It can be regarded as a <div> element, but has ability to embed an HTML fragment and run the parser.
The onLoad() handler is called when parsing is done and the content is ready.
Compared with dijit/layout/ContentPane, this widget provides only basic functionality,
but it is much smaller than dijit/layout/ContentPane.

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|href          |String    |""       |A URL of an HTML fragment to load.                                                                         |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|lazy          |Boolean   |false    |If true, external content specified with the href property is not loaded at startup time. It can be loaded |
|              |          |         |by calling load().                                                                                         |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|content       |String    |""       |An HTML fragment content to load.                                                                          |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|parseOnLoad   |Boolean   |true     |If true, runs the parser to parse the content.                                                             |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|prog          |Boolean   |true     |If true, shows a progress indicator while loading an HTML fragment specified by href.                      |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|executeScripts|Boolean   |true     |If true, executes scripts that is found in the content.                                                    |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

.. js ::

  require([
    "dojox/mobile",
    "dojox/mobile/parser",
    "dojox/mobile/ContentPane"
  ]);

.. html ::

  <h2 data-dojo-type="dojox/mobile/RoundRectCategory">Pane1</h2>
  <div data-dojo-type="dojox/mobile/ContentPane"
       data-dojo-props="content:'&lt;div data-dojo-type=&quot;dojox/mobile/RoundRect&quot; data-dojo-props=&quot;shadow:true&quot;&gt;Thank you!&lt;/div&gt;'"></div>

  <h2 data-dojo-type="dojox/mobile/RoundRectCategory">Pane2</h2>
  <div data-dojo-type="dojox/mobile/ContentPane"
       data-dojo-props='href:"fragment1.html"'></div>

The content of fragment1.html is as follows:

.. html ::

  <div data-dojo-type="dojox/mobile/RoundRect" data-dojo-props='shadow:true'>
    HTML fragment example
  </div>

.. image :: ContentPane.png


See examples of :ref:`dojox/mobile/FixedSplitter <dojox/mobile/FixedSplitter>` also.
