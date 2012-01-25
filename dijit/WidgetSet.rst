.. _dijit/WidgetSet:

===============
dijit.WidgetSet
===============

:since: V1.7

.. contents ::
   :depth: 2

A dijit.WidgetSet is a collection of Dijit widgets.
It can be used for bulk operation and control of groups of widgets.
In Dojo 1.7, including dijit.WidgetSet will add Array-like functions to the main :ref:`dijit/registry` object as well
for backwards-compatibility; this behavior will be removed in Dojo 2.0.

Introduction
============

dijit.WidgetSet works similarly to a dojo.NodeList, treating the list of widgets as a pseudo-array and allowing common Array-like functions to iterate through the list.

Usage
=====

Adding a widget to a WidgetSet
------------------------------

.. js ::
 
  var ws = new WidgetSet();
  ws.add(new dijit.Dialog());

Removing a widget from a WidgetSet
----------------------------------

.. js ::
 
  ws.remove("MyWidgetId");

Iterating over a list of widgets
--------------------------------

.. js ::
 
  ws.forEach(function(widget, index, hash){
    // function is run for each widget available
  });

Converting a WidgetSet to an array
----------------------------------

.. js ::
 
  var widgetArray = ws.toArray();

Chaining forEach and byClass calls
----------------------------------

.. js ::
  
  ws.forEach(function(widget){
    widget.containerNode.appendChild(dojo.create("div"));
  }).byClass("dijit.Dialog").forEach(function(widget){ /* only dijit.Dialog instances */ });

The functions ``filter()``, ``forEach()``, ``map()``, ``every()`` and ``some()``
all accept a `thisObject` in the last position.
This is in line with all other Dojo array functions and allows for transparent scope manipulation:

.. js ::
  
  // we are in some object, like a widget
  ws.forEach(function(widget){
    this.addChild(widget); // add all children to the instance we are in
  }, this);

Filtering a list of widgets
---------------------------

This example filters all even widgets from the list, then iterates over the remainder:

.. js ::
  
  // filter out even widgets, and iterate over the remainder
  ws.filter(function(widget, i){
    return i % 2 == 0;
  }).forEach(function(widget){
    console.log(widget.id, "was an odd number in the list");
  });

Inspecting how many widgets are in a WidgetSet
----------------------------------------------

.. js ::
  
  if(ws.length){
    // there is at least one widget in this WidgetSet
  }

.. js ::
  
  if(ws.byClass("dijit.Dialog").length){
    // there are Dialog widgets in this set
  }

Other examples
==============

Retrieving all DOM nodes for a set of widgets
---------------------------------------------

.. js ::
  
  // get the actual domNode which represents the widgets in this list:
  var nodes = dijit.registry.map(function(widget){
    return widget.domNode;
  });

Validating all widgets in a WidgetSet
-------------------------------------

.. js ::
  
  var isValid = ws.every(function(widget){
    // all widgets must have a value > 0 to pass
    return widget.isValid();
  });
  
  if(isValid){
    // all widgets are valid
  }else{
    // something failed before we got through all widgets, something
    // didn't pass the test
  }

See also
========

* :ref:`dijit/registry <dijit/registry>`
* :ref:`dojo.NodeList <dojo/NodeList>`
