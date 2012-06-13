.. _dojox/mvc/StatefulArray:

=======================
dojox.mvc.StatefulArray
=======================

:Authors: Akira Sudoh, Ed Chatelain
:Developers: Akira Sudoh, Ed Chatelain
:since: V1.8

.. contents ::
  :depth: 2

**dojox/mvc/StatefulArray** is a class that inherits JavaScript native Array class, adding dojo.Stateful capability. The StatefulArray class can be created in below form:

.. js ::

  new StatefulArray([0, 1, 2]);

===============
Watch callbacks
===============

dojox/mvc/StatefulArray has watch function that works in the same way as the one in dojo/Stateful. The change in array length, as well as updates in array element, will be reflected to such watch callbacks.
dojox/mvc/StatefulArray also has watchElements function, that allows to watch for removals/adds of array elements. Like watch function, watchElements function returns a handle that allows disconnection of the watch at some point in future. For example:

.. js ::

  var a = new StatefulArray([0, 1, 2]);
  var handle = a.watchElements(function(index, removals, adds){
      alert("Removed: " + removals + " At: " + index);
  });
  a.shift();
  handle.unwatch();
