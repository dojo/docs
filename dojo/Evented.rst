.. _dojo/Evented:

============
dojo/Evented
============

:Authors: Kris Zyp
:Project owner: Kris Zyp
:since: 1.7.0

.. contents ::
  :depth: 2

**dojo/Evented** is a module that provides a class that can be used as a base class or mixin for JavaScript classes that
emit their own events.

Introduction
============

``dojo/Evented`` is designed to provide a class that allows a developer to emit events and provide an easy way to allow
those events to be connected to by downstream users. It leverages the API concepts of :ref:`dojo/on <dojo/on>`. It
should be noted though that this is for what is commonly referred to as "synthetic" events, which are different than DOM
events, which ``dojo/on`` normalises.

Common convention is that events emitted are all lower case and usually a single word that has semantic meaning. For
example ``change`` or ``start`` or ``end``. The structure of the event that is passed on the emit is up to the
developer, but it should be consistent and easy to understand.

Usage
=====

The ``dojo/Evented`` class provides two methods, ``on(eventType, listener)`` and ``emit(eventType, eventObject)`` which
correspond to ``dojo/on()`` and ``dojo/on::emit()`` with the target being the instance object. For example, we could
create a class:

.. js ::
  
  define(["dojo/Evented", "dojo/_base/declare"], function(Evented, declare){
    var MyComponent = declare([Evented], {
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

While ``dojo/Evented`` can be extended and used directly, it is better to subclass into a new class.

If a ``dojo/Evented`` instance is passed to ``dojo/on`` as a target, ``dojo/on`` will detect this and delegate the
setting of the event handler to ``dojo/Evented``.

Event Handle Properties
-----------------------

The ``dojo/Evented`` class supports auto-magic property/methods for events which are named after the event with an "on"
prefix, following the DOM0 convention. For example, listening to the "foo" event will put the listeners in the ``onfoo``
method. If a class has an ``onMouseDown`` method, this corresponds to a "MouseDown" event that you can listen to with:

.. js ::
  
  component.on("MouseDown");

While it is possible to trigger the event by directly calling the ``onfoo()`` or ``onMouseDown()`` method, it is
recommend that you use emit("foo") or emit("MouseDown") for consistency. One can upgrade most classes with ``onEvent``
methods to be usable with dojo/on by simply adding the Evented class as a base class. Note that some event emitting
objects, like Dijit widgets, have their own event emitting implementation, and define their own event names.

Transitioning to Dojo 2.0
-------------------------

There are a number of objects in Dojo (like :ref:`dojo/dnd <dojo/dnd>`) that inherit from ``dojo/Evented``. However,
these event emitting objects are likely to change their events (both names and emitted event objects) in 2.0, so one
should not assume that code using ``dojo/Evented`` to listen to Dojo objects will work unchanged in 2.0.

Examples
========

.. code-example ::

  This example creates a new ``Timer`` class that will emit ``start``, ``stop`` and ``tick`` events and demonstrates how
  you can then assign handlers to those events.

  .. js ::

    require(["dojo/Evented", "dojo/_base/declare", "dojo/on", "dojo/dom", "dojo/dom-construct", "dojo/domReady!"],
    function(Evented, declare, on, dom, domConst){
      // Declare the new Timer class
      var Timer = declare([Evented], {
        timeout: 1000,
        start: function(){
          this.stop();
          this.emit("start", {});
          var self = this;
          this._handle = setInterval(function(){
            self.emit("tick", {});
          }, this.timeout);
        },
        stop: function(){
          if(this._handle){
            clearInterval(this._handle);
            delete this._handle;
            this.emit("stop", {});
          }
        }
      });
    
      // Create an instance
      var timer = new Timer();
    
      // Set event handlers
      timer.on("start", function(){
        domConst.place("<p>start</p>", "output");
      })
      timer.on("tick", function(){
        domConst.place("<p>tick</p>", "output");
      });
      timer.on("stop", function(){
        domConst.place("<p>stop</p>", "output");
      });
    
      // Setup button click handlers
      on(dom.byId("startButton"), "click", function(){
        timer.start();
      });
      on(dom.byId("stopButton"), "click", function(){
        timer.stop();
      });
    
    });

  .. html ::

    <button type="button" id="startButton">Start</button>
    <button type="button" id="stopButton">Stop</button>
    <h1>Output</h1>
    <div id="output"></div>

See also
========

* :ref:`dojo/on <dojo/on>` - The Dojo event normalization API

