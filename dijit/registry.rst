#format dojo_rst

dijit.registry
===============

:Status: Draft
:Version: 1.0
:Available: since V1.0

.. contents::
   :depth: 2

The dijit.regsitry is a collection of all Dijit widgets within a page. It can be used for bulk operation and control of groups of widgets. The registry is an instance of a `dijit.WidgetSet <http://api.dojotoolkit.org/jsdoc/1.3/dijit.WidgetSet>`_ and is present on all pages using Dijits.

============
Introduction
============

The dijit.registry in an instance of a dijit.WidgetSet, which contains several convenience methods for manipulating Widgets in bulk. Similar to a dojo.NodeList in functionality, treating the list of widgets as a pseudo-array and allowing common Array-like functions to iterate over and through. 

=====
Usage
=====

The most common usage of the dijit.registry is to iterate over all existing widgets in a page with .forEach:

.. code-block :: javascript
 :linenos:

  dijit.registry.forEach(function(widget, index, hash){
     // function is run for each widget available
  });

New in **1.4**, the .forEach method returns the instance of the WidgetSet, allowing chaining:

.. code-block :: javascript
  :linenos:

  dijit.registry.forEach(function(w){
       w.containerNode.appendChild(dojo.create("div"));
  }).byClass("dijit.Dialog").forEach(function(w){ /* only dijit.Dialog instances */ });

Additionally, also new in **1.4**, the functions: filter, forEach, map, every and some all accept a `thisObject` in the last position. This is in line with all other Dojo Array functions, and allows for transparent scope manipulation:

.. code-block :: javascript
  :linenos:

  // we are in some object, like a Widget
  dijit.registry.forEach(function(w){
       this.addChild(w); // add all children to the instance we are in
  }, this);

Common methods on WidgetSet/registry are: byClass, forEach, byId, and filter. New in Dijit **1.4** are: map, every, some, and toArray. 

* byClass - returns a new WidgetSet of only matching class names. eg: "dijit.Dialog", "my.Thinger". Anything using `dojo.declare <dojo/declare>`_ and inheriting from dijit._Widget.
* forEach - iterate over the WidgetSet, calling a function for each widget available. Much like `dojo.forEach <dojo/forEach>`_, the function is passed the widget instance, the index of the widget instance and the internal collection of widgets. The internal collection is NOT an array, so will seldom be useful. New in **1.4**, forEach returns the WidgetSet instance and allows further chaining.
* byId - each dijit._Widget either is assigned an id by the user or a generic id based on the class name is generated. dijit.registy.byId returns a widget instance with a matching id, or a falsey value if not found.
* filter - returns a reduced list of Widgets based on the return value of the callback function. Similar to `dojo.filter <dojo/filter>`_, will run a callback function over every widget in the set. If the return value is true the widget is added to the new set. If false the widget is ommitted from the new list. 

.. code-block :: javascript
  :linenos:

  // filter out even widgets, and iterate over the remainder
  dijit.registry.filter(function(w, i){
     return i % 2 == 0;
  }).forEach(function(w){
     console.log(w.id, "was an odd number in the list");
  }); 

* map - similar to filter, and identical to `dojo.map <dojo/map>`_ - will return a new array of the same length, mapping the return values into the new array. This does **not** return a WidgetSet, but rather a true array of whatever values.

.. code-block :: javascript
  :linenos:

  // get the actual domNode which represents the widgets in this list:
  var nodes = dijit.registy.map(function(w){
       return w.domNode;
  });

* every, some - identical to `dojo.every <dojo/every>`_ and `dojo.some <dojo/some>`_. Both can be used to 'continue' or otherwise short circuit looping. .every will break upon finding the first false value and will return false. .some will break upon finding the first true value, and will return true. The return values are reversed if the functions satisfy all elements.

.. code-block :: javascript
  :linenos:

  // loop over all the widgets, looking for something specifc
  var whatIwant;
  dijit.registy.some(function(w){
       // find the first id with "foo" somewhere in it:
       var condition = w.id.indexOf("foo") >= 0; 
       if(condition){
         whatIwant = w;
       }
       return condition;
  });

  var hasvalues = dijit.registry.every(function(w){ 
       // all widgets must have a value > 0 to pass
       return w.attr("value") > 0;
  });
  if(hasvalues){
       // all widgets have a value > 0, proceed:
  }else{
       // something failed before we got through all widgets, something
       // didn't pass the test
  }

It is important to note a WidgetSet and accompanying functions are **NOT** true arrays, only behave as such. That said, each WidgetSet (and the default dijit.registy) maintain a *length* property, indicating the number of widgets contained within. This can be useful to determine basic conditionals very easily:

.. code-block :: javascript
  :linenos:

  if(dijit.registry.byClass("dijit.Dialog").length){
     // there is at least one dijit.Dialog alive on this page
  }else{
     // none found
  }

The same is true for the subsequent WidgetSet's returned from chained functions, like filter:

.. code-block :: javascript
  :linenos:

  if(dijit.registy.filter(function(w){ return w.id.indexOf("baz") >= 0 }).length){
     // there aren't any widgets in this list with "baz" in the id
  }

========
See also
========

* `dijit.WidgetSet <dijit/WidgetSet>`_
* `dojo.NodeList <dojo/NodeList>`_
