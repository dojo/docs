.. _dojox/mobile/FixedSplitter:

==========================
dojox.mobile.FixedSplitter
==========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

Introduction
============

FixedSplitter is a very simple container widget that layouts its child dom nodes side by side either horizontally or vertically. An example usage of this widget would be to realize the split view on iPad. There is no visual splitter between the children, and there is no function to resize the child panes with drag-and-drop. If you need a visual splitter, you can specify a border of a child dom node with CSS.

FixedSplitter has no knowledge of its child widgets. :ref:`dojox.mobile.Container <dojox/mobile/Container>` (=formerly known as FixedSplitterPane), :ref:`dojox.mobile.Pane <dojox/mobile/Pane>`, or :ref:`dojox.mobile.ContentPane <dojox/mobile/ContentPane>` can be used as a child widget of FixedSplitter.

- Use dojox.mobile.Container if your content consists of ONLY dojo widgets.
- Use dojox.mobile.Pane if your content is an inline html fragment (may or may not include dojo widgets).
- Use dojox.mobile.ContentPane if your content is an external html fragment (may or may not include dojo widgets).

Note that, FixedSplitter.css was under the themes/common folder until V1.7, but in V1.8, it was moved to each device folder such as themes/iphone.

.. image :: FixedSplitter.png

Usage
=====

FixedSplitter typically needs the following page settings.

.. css ::

  html, body{
      height: 100%;
      overflow: hidden;
      position: relative;
  }

Constructor Parameters
======================

+--------------------+----------+------------------------------+--------------------------------------------------------------------------------------+
|Parameter           |Type      |Default                       |Description                                                                           |
+--------------------+----------+------------------------------+--------------------------------------------------------------------------------------+
|orientation         |String    |"H"                           |The direction of split. If "H" is specified, panes are split horizontally. If "V" is  |
|                    |          |                              |specified, panes are split vertically.                                                |
+--------------------+----------+------------------------------+--------------------------------------------------------------------------------------+
|variablePane        |Number    |-1                            |The index of a pane that fills the remainig space. If -1, the last child pane fills   |
|                    |          |                              |the remaining space.                                                                  |
+--------------------+----------+------------------------------+--------------------------------------------------------------------------------------+
|screenSizeAware     |Boolean   |false                         |If true, dynamically load a screen-size-aware module.                                 |
+--------------------+----------+------------------------------+--------------------------------------------------------------------------------------+
|screenSizeAwareClass|String    |"dojox/mobile/ScreenSizeAware"|A screen-size-aware module to load.                                                   |
+--------------------+----------+------------------------------+--------------------------------------------------------------------------------------+

Examples
========

Declarative example #1
----------------------

In this example, :ref:`dojox.mobile.Pane <dojox/mobile/Pane>` is used as a child widget of FixedSplitter.

.. js ::

  require([
    "dojox/mobile/parser",
    "dojox/mobile/FixedSplitter",
    "dojox/mobile/Pane"
  ]);

.. html ::

  <div data-dojo-type="dojox.mobile.FixedSplitter" data-dojo-props='orientation:"H"'>
    <div data-dojo-type="dojox.mobile.Pane" style="background-color:yellow;width:200px;">
      pane #1 (width=200px)
    </div>
    <div data-dojo-type="dojox.mobile.Pane" style="background-color:pink;">
      pane #2
    </div>
  </div>

.. image :: FixedSplitter-example1.png

Declarative example #2
----------------------

In this example, :ref:`dojox.mobile.ContentPane <dojox/mobile/ContentPane>` is used as a child widget of FixedSplitter.

.. js ::

  require([
    "dojox/mobile/parser",
    "dojox/mobile/ContentPane",
    "dojox/mobile/FixedSplitter"
  ]);

.. html ::

  <div data-dojo-type="dojox.mobile.FixedSplitter"
       data-dojo-props='orientation:"V"' style="width:100%;height:100%;">
    <div data-dojo-type="dojox.mobile.ContentPane"
         data-dojo-props='href:"data/FixedSplitterfragment1.html"'
         style="background-color:yellow;height:20%"></div>

    <div data-dojo-type="dojox.mobile.FixedSplitter"
         data-dojo-props='orientation:"H"' style="width:100%;height:100%;">
      <div data-dojo-type="dojox.mobile.ContentPane"
           data-dojo-props='href:"data/FixedSplitterfragment2.html"'
           style="background-color:pink;width:20%;"></div>
      <div data-dojo-type="dojox.mobile.ContentPane"
           data-dojo-props='href:"data/FixedSplitterfragment3.html"'
           style="background-color:cyan;"></div>
    </div>
  </div>

.. html ::

  <!-- data/FixedSplitterfragment1.html -->
  <div>
    <h3>FixedSplitter fragment example</h3>
    pane #1
  </div>

.. html ::

  <!-- data/FixedSplitterfragment2.html -->
  <div>
    <h3>FixedSplitter fragment example</h3>
    pane #2
  </div>

.. html ::

  <!-- data/FixedSplitterfragment3.html -->
  <div>
    <h3>FixedSplitter fragment example</h3>
    pane #3
  </div>

.. image :: FixedSplitter-example2.png

Declarative example #3
----------------------

In this example, :ref:`dojox.mobile.Container <dojox/mobile/Container>` is used as a child widget of FixedSplitter.

.. js ::

  require([
    "dojox/mobile",
    "dojox/mobile/parser",
    "dojox/mobile/FixedSplitter",
    "dojox/mobile/Container",
    "dojox/mobile/IconContainer"
  ]);

.. html ::

  <div data-dojo-type="dojox.mobile.FixedSplitter" data-dojo-props='orientation:"H"'>
    <div data-dojo-type="dojox.mobile.Container" style="background-color:yellow;width:100px;">
      <ul data-dojo-type="dojox.mobile.IconContainer">
        <li data-dojo-type="dojox.mobile.IconItem"
            data-dojo-props='label:"View #1", icon:"images/icon1.png",
                             moveTo:"view1", transition:"slide"'></li>
        <li data-dojo-type="dojox.mobile.IconItem"
            data-dojo-props='label:"View #2", icon:"images/icon2.png",
                             moveTo:"view2", transition:"slide"'></li>
        <li data-dojo-type="dojox.mobile.IconItem"
            data-dojo-props='label:"View #3", icon:"images/icon3.png",
                             moveTo:"view3", transition:"slide"'></li>
      </ul>
    </div>
    <div data-dojo-type="dojox.mobile.Container" style="background-color:pink;">
      <div id="view1" data-dojo-type="dojox.mobile.View" style="height:100%;">
        View #1
      </div>
      <div id="view2" data-dojo-type="dojox.mobile.View" style="height:100%;">
        View #2
      </div>
      <div id="view3" data-dojo-type="dojox.mobile.View" style="height:100%;">
        View #3
      </div>
    </div>
  </div>

.. image :: FixedSplitter-example3.png

Programmatic example
--------------------

.. js ::

  require([
    "dojo/dom",
    "dojo/ready",
    "dojox/mobile/FixedSplitter",
    "dojox/mobile/Pane"
  ], function(dom, ready, FixedSplitter, Pane){
    ready(function(){
      var w = new FixedSplitter({
        orientation: "H"
      }, dom.byId("container"));
      w.startup();

      var p0 = new Pane({
        innerHTML: "pane #1 (width=200px)"
      });
      p0.domNode.style.backgroundColor = "yellow";
      p0.domNode.style.width = "200px";
      w.addChild(p0);

      var p1 = new Pane({
        innerHTML: "pane #2"
      });
      p1.domNode.style.backgroundColor = "pink";
      w.addChild(p1);
    });
  });

.. image :: FixedSplitter-example4.png

Screen size aware example
-------------------------

See the :ref:`dojox.mobile.ScreenSizeAware <dojox/mobile/ScreenSizeAware>` widget for various examples.
