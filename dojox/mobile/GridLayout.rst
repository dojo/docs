.. _dojox/mobile/GridLayout:

=======================
dojox/mobile/GridLayout
=======================

:Authors: Hikaru Tamura
:Developers: Hikaru Tamura
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

GridLayout is a container widget that places its child widgets in a grid layout. 
Each child must be a container widget such as dojox/mobile/Pane.
Use this widget when you want to keep the number of columns fixed. For example, 
if the parameter ``cols`` is set to 2 and the number of children div elements is 6, this 
widget places its children div elements into 2 rows and 3 columns. 
The width of the children changes appropriately to cater for the number of columns. 
If ``cols`` is 0, this widget places its children div elements by ordering them accordingly 
to the width of the children div elements. This widget does not change the width of the children. 
This widget is useful for adapting automatically the layout of widgets with fixed side 
when the orientation of mobile devices changes, or when the screen size changes.

This widget manages its immediate children div elements only. For example, if you 
want to lay out button elements, you need to wrap them with div elements.

.. image :: GridLayout.png

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|cols          |Number    |0        |The number of child items in a row.                                                                        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------
.. js ::

  require([
      "dojox/mobile/parser",
      "dojox/mobile",
      "dojox/mobile/compat",
      "dojox/mobile/View",
      "dojox/mobile/GridLayout",
      "dojox/mobile/Pane",
      "dojox/mobile/Button"
  ]);

.. html ::

  <div id="view1" data-dojo-type="dojox/mobile/View">
    <div data-dojo-type="dojox/mobile/GridLayout" data-dojo-props='cols:3' style="height: 200px;">
      <div data-dojo-type="dojox/mobile/Pane">
        <button class="mblBlueButton" data-dojo-type="dojox/mobile/Button">Button 1</button>
      </div>
      <div data-dojo-type="dojox/mobile/Pane">
        <button class="mblBlueButton" data-dojo-type="dojox/mobile/Button">Button 2</button>
      </div>
      <div data-dojo-type="dojox/mobile/Pane">
        <button class="mblBlueButton" data-dojo-type="dojox/mobile/Button">Button 3</button>
      </div>
      <div data-dojo-type="dojox/mobile/Pane">
        <button class="mblBlueButton" data-dojo-type="dojox/mobile/Button">Button 4</button>
      </div>
      <div data-dojo-type="dojox/mobile/Pane">
        <button class="mblBlueButton" data-dojo-type="dojox/mobile/Button">Button 5</button>
      </div>
      <div data-dojo-type="dojox/mobile/Pane">
        <button class="mblBlueButton" data-dojo-type="dojox/mobile/Button">Button 6</button>
      </div>
  </div>

.. image :: GridLayout.png

The following is an orientation change example. The code is the same, but the layout changes according to the orientation.

.. html ::

  <style>
    .mblButton {
        width: 150px;
        height: 100px;
    }
  </style>

.. js ::

  require([
      "dojox/mobile/parser",
      "dojox/mobile",
      "dojox/mobile/compat",
      "dojox/mobile/View",
      "dojox/mobile/GridLayout",
      "dojox/mobile/Pane",
      "dojox/mobile/Button"
  ]);

.. html ::

  <div id="view1" data-dojo-type="dojox/mobile/View">
    <div data-dojo-type="dojox/mobile/GridLayout">
      <div data-dojo-type="dojox/mobile/Pane">
        <button class="mblBlueButton" data-dojo-type="dojox/mobile/Button">Button 1</button>
      </div>
      <div data-dojo-type="dojox/mobile/Pane">
        <button class="mblBlueButton" data-dojo-type="dojox/mobile/Button">Button 2</button>
      </div>
      <div data-dojo-type="dojox/mobile/Pane">
        <button class="mblBlueButton" data-dojo-type="dojox/mobile/Button">Button 3</button>
      </div>
      <div data-dojo-type="dojox/mobile/Pane">
        <button class="mblBlueButton" data-dojo-type="dojox/mobile/Button">Button 4</button>
      </div>
      <div data-dojo-type="dojox/mobile/Pane">
        <button class="mblBlueButton" data-dojo-type="dojox/mobile/Button">Button 5</button>
      </div>
      <div data-dojo-type="dojox/mobile/Pane">
        <button class="mblBlueButton" data-dojo-type="dojox/mobile/Button">Button 6</button>
      </div>
    </div>
  </div>

Landscape

.. image :: GridLayout-example1.png

Portrait

.. image :: GridLayout-example2.png


Programmatic example
--------------------

.. js ::

  require([
      "dijit/registry",
      "dojo/ready",
      "dojox/mobile/GridLayout",
      "dojox/mobile/Pane",
      "dojox/mobile/Button",
      "dojox/mobile/View",
      "dojox/mobile",
      "dojox/mobile/parser"
  ], function(registry, ready, GridLayout, Pane, Button){
      ready(function(){
          var view = registry.byId("view1");
          var widget = new GridLayout({cols:3, style:{height:"200px"}});
          widget.placeAt(view.containerNode);
          widget.startup();

          var pane1 = new Pane();
          widget.addChild(pane1);
          var button1 = new Button({label:"Button 1", class:"mblBlueButton"});
          button1.placeAt(pane1.containerNode);
          button1.startup();

          var pane2 = new Pane();
          widget.addChild(pane2);
          var button2 = new Button({label:"Button 2", class:"mblBlueButton"});
          button2.placeAt(pane2.containerNode);
          button2.startup();

          var pane3 = new Pane();
          widget.addChild(pane3);
          var button3 = new Button({label:"Button 3", class:"mblBlueButton"});
          button3.placeAt(pane3.containerNode);
          button3.startup();

          var pane4 = new Pane();
          widget.addChild(pane4);
          var button4 = new Button({label:"Button 4", class:"mblBlueButton"});
          button4.placeAt(pane4.containerNode);
          button4.startup();

          var pane5 = new Pane();
          widget.addChild(pane5);
          var button5 = new Button({label:"Button 5", class:"mblBlueButton"});
          button5.placeAt(pane5.containerNode);
          button5.startup();

          var pane6 = new Pane();
          widget.addChild(pane6);
          var button6 = new Button({label:"Button 6", class:"mblBlueButton"});
          button6.placeAt(pane6.containerNode);
          button6.startup();
      });
  });
