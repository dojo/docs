#format dojo_rst

dojo/on
=======

:Authors: Kris Zyp
:Project owner: Kris Zyp
:Available: 1.7.0

.. contents::
  :depth: 2

The dojo/Evented module is a class that can be used as a base class or mixin for JavaScript classes that have their own events.

================
dojo/Evented API
================

The Evented class provides two methods, on(eventType, listener) and emit(eventType, eventObject) which correspond to on() and on.emit() with the target being the instance object. For example, we could create a class:

.. code-block :: javascript
  
  define(["dojo/Evented"], function(Evented){
    var MyComponent = dojo.declare([Evented], {
      startup: function(){
  	  // once we are done with startup, fire the "ready" event
        this.emit("ready", {});
      }
    });

    component = new MyComponent();
    component.on("ready", function(){
      // this will be called when the "ready" event is emitted
      // ...
    });
    component.startup();
  });

========================
Event Handler Properties
========================

The Evented class stores events in a property/method slot named after the event with an "on" prefix, following the DOM0 convention. For example, listening to the "foo" event will put the listeners in the "onfoo" method. If a class has an "onMouseDown" method, this corresponds to a "MouseDown" event that you can listen to with:

.. code-block :: javascript
  
  component.on("MouseDown");

While it is possible to trigger the event by directly calling the onfoo() or onMouseDown() method, it is recommend that you use emit("foo") or emit("MouseDown") for consistency.

One can upgrade most classes with onEvent methods to be usable with dojo/on by simply adding the Evented class as a base class.

Note that some event emitting objects, like Dijit widgets, have their own event emitting implementation, and define their own event names.