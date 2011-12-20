.. _dojox/mobile/ContentPane:

========================
dojox.mobile.ContentPane
========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

ContentPane is a very simple and lightweight content pane to embed an HTML fragment. It can basically be regarded as a <div> element, but has ability to embed an HTML fragment and run the parser. The onLoad() handler is called when parsing is done and the content is ready.

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|href          |String    |""       |A URL of an HTML fragment to load.                                                                         |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|content       |String    |""       |HTML fragment content to load.                                                                             |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|parseOnLoad   |Boolean   |true     |If true, run the parser to parse the content.                                                              |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|prog          |Boolean   |true     |If true, show a progress indicator while loading an HTML fragment specified by href.                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

.. html ::

  <h2 data-dojo-type="dojox.mobile.RoundRectCategory">Pane1</h2>
  <div id="pane1" data-dojo-type="dojox.mobile.ContentPane"
       content="&lt;div data-dojo-type='dojox.mobile.RoundRect' shadow='true'&gt;Thank you!&lt;/div&gt;"></div>

  <h2 data-dojo-type="dojox.mobile.RoundRectCategory">Pane2</h2>
  <div id="pane2" data-dojo-type="dojox.mobile.ContentPane"
       href="fragment1.html"></div>

The content of fragment1.html is as follows:

.. html ::

  <div data-dojo-type="dojox.mobile.RoundRect" shadow="true">
    HTML fragment example
  </div>

.. image :: ContentPane.png
