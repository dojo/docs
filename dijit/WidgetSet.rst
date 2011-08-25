#format dojo_rst

dijit.WidgetSet
===============

:Status: Draft
:Version: 1.7
:Available: since V1.7

.. contents::
   :depth: 2

A dijit.WidgetSet is a collection of Dijit widgets. It can be used for bulk operation and control of groups of widgets. In Dojo 1.7, including dijit.WidgetSet will add Array-like functions to the main dijit.registry object as well for backwards-compatibility; this behaviour will be removed in Dojo 2.0.

============
Introduction
============

dijit.WidgetSet works similarly to a dojo.NodeList, treating the list of widgets as a pseudo-array and allowing common Array-like functions to iterate through the list.

=====
Usage
=====

Adding widgets to a WidgetSet:

.. code-block :: javascript
 :linenos:

  var ws = new WidgetSet();
  ws.add(new dijit.Dialog());

Removing a widget from a WidgetSet:

.. code-block :: javascript
 :linenos:

  ws.remove("MyWidgetId");

Iterating over all a list of widgets with forEach:

.. code-block :: javascript
 :linenos:

  ws.forEach(function(widget, index, hash){
     // function is run for each widget available
  });

Chaining forEach and byClass calls:

.. code-block :: javascript
  :linenos:

  ws.forEach(function(widget){
	  widget.containerNode.appendChild(dojo.create("div"));
  }).byClass("dijit.Dialog").forEach(function(widget){ /* only dijit.Dialog instances */ });

The functions filter, forEach, map, every and some all accept a `thisObject` in the last position. This is in line with all other Dojo array functions and allows for transparent scope manipulation:

.. code-block :: javascript
  :linenos:

  // we are in some object, like a Widget
  ws.forEach(function(widget){
       this.addChild(widget); // add all children to the instance we are in
  }, this);

Filtering all even widgets from the list, then iterating over the remainder:

.. code-block :: javascript
  :linenos:

  // filter out even widgets, and iterate over the remainder
  ws.filter(function(widget, i){
     return i % 2 == 0;
  }).forEach(function(widget){
     console.log(widget.id, "was an odd number in the list");
  }); 

Retrieving all DOM nodes for the set of widgets:

.. code-block :: javascript
  :linenos:

  // get the actual domNode which represents the widgets in this list:
  var nodes = dijit.registy.map(function(widget){
       return widget.domNode;
  });

Ensuring all widgets in the list have a specific value:

.. code-block :: javascript
  :linenos:

  var isValid = ws.every(function(widget){ 
       // all widgets must have a value > 0 to pass
       return widget.attr("value") > 0;
  });
  
  if(isValid){
       // all widgets have a value > 0, proceed:
  }else{
       // something failed before we got through all widgets, something
       // didn't pass the test
  }

Looking at how many widgets are in a WidgetSet:

.. code-block :: javascript
  :linenos:

  if(ws.byClass("dijit.Dialog").length){
     // there is at least one dijit.Dialog in this WidgetSet
  }else{
     // none found
  }

Looking at how many widgets are in a filtered WidgetSet:

.. code-block :: javascript
  :linenos:

  if(ws.filter(function(widget){ return widget.id.indexOf("baz") >= 0 }).length){
     // there aren't any widgets in this list with "baz" in the id
  }

========
See also
========

* `dijit.registry <dijit/registry>`_
* `dojo.NodeList <dojo/NodeList>`_
