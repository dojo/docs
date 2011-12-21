.. _dojox/mobile/FixedSplitter:

==========================
dojox.mobile.FixedSplitter
==========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

FixedSplitter is a very simple container widget that layouts its child dom nodes side by side either horizontally or vertically. An example usage of this widget would be to realize the split view on iPad. There is no visual splitter between the children, and there is no function to resize the child panes with drag-and-drop. If you need a visual splitter, you can specify a border of a child dom node with CSS. A child of the widget should be FixedSplitterPane.

.. image :: FixedSplitter.png

Usage
=====

FixedSplitter is in a separate module file from _base.js. You need to dojo.require FixedSplitter as below. If you load FixedSplitter, FixedSplitterPane will be automatically loaded as well.

.. css ::

  @import "../themes/common/FixedSplitter.css";
  html, body{
      height: 100%;
      overflow: hidden;
      position: relative;
  }

.. js ::

  dojo.require("dojox.mobile.FixedSplitter");

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|orientation   | String   |"H"      |The direction of split. If "H" is specified, panes are split horizontally. If "V" is specified, panes are  |
|              |          |         |split vertically.                                                                                          |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example1
--------------------

.. html ::

  <div data-dojo-type="dojox.mobile.FixedSplitter" orientation="H">
      <div data-dojo-type="dojox.mobile.FixedSplitterPane" style="width:200px;border-right:1px solid black;background-color:yellow;">
          pane #1 (width=200px)
      </div>
      <div data-dojo-type="dojox.mobile.FixedSplitterPane" style="background-color:pink;">
          pane #2
      </div>
  </div>

.. image :: FixedSplitter-example1.png

Declarative example2
--------------------

.. html ::

  <div data-dojo-type="dojox.mobile.FixedSplitter" orientation="V">
      <div data-dojo-type="dojox.mobile.FixedSplitterPane" style="background-color:cyan;height:200px;">
          pane #1 (height=200px)
      </div>
      <div data-dojo-type="dojox.mobile.FixedSplitterPane" style="background-color:yellow;height:100px;border-bottom:1px solid black">
          pane #2 (height=100px)
      </div>
      <div data-dojo-type="dojox.mobile.FixedSplitterPane" style="background-color:pink;">
          pane #3
      </div>
  </div>

.. image :: FixedSplitter-example2.png

Programmatic example3
---------------------

.. js ::

  var w = new dojox.mobile.FixedSplitter({
      orientation: "H"
  }, dojo.byId("container"));
  w.startup();

  var p0 = new dojox.mobile.FixedSplitterPane({
      innerHTML: "pane #1 (width=200px)"
  });
  p0.domNode.style.backgroundColor = "yellow";
  p0.domNode.style.width = "200px";
  w.addChild(p0);

  var p1 = new dojox.mobile.FixedSplitterPane({
      innerHTML: "pane #2"
  });
  p1.domNode.style.backgroundColor = "pink";
  w.addChild(p1);

.. image :: FixedSplitter-example3.png
