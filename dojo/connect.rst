.. _dojo/connect:

=================================
dojo.connect (dojo/_base/connect)
=================================

:Project owner: ?--
:since: V?

.. contents ::
   :depth: 2

dojo.connect connects events to methods, so that after the event occurs, the new connected method is called too.

Preferred event handling mechanism is now dojo/on
=================================================

Dojo versions prior to 1.7 used the connect module for event handling.  As of Dojo 1.7, the preferred way of handling events is to use the new lightweight dojo/on module.  For compatibility reasons, the dojo.connect api's will remain fully supported through remaining 1.x releases, but will likely be removed in Dojo 2.0.  Migration from connect() to on() should be straightforward as the api signature is very similar.

Introduction
============

`dojo.connect` is the core event handling and delegation method in Dojo. It allows one function to "listen in" on the execution of any other, triggering the second whenever the first is called. Many listeners may be attached to a function, and source functions may be either regular function calls or DOM events.

`dojo.connect` connects listeners to actions, so that after event fires, a listener is called with the same arguments passed to the original function.

Since `dojo.connect` allows the source of events to be either a "regular" JavaScript function or a DOM event, it provides a uniform interface for listening to all the types of events that an application is likely to deal with though a single, unified interface. DOM programmers may want to think of it as "addEventListener for everything and anything".

When setting up a connection, the `event` parameter must be a string that is the name of the method/event to be listened for. If `obj` is null, `dojo.global` is assumed, meaning that connections to global methods are supported but also that you may inadvertently connect to a global by passing an incorrect object name or invalid reference.

`dojo.connect` generally is forgiving. If you pass the name of a function or method that does not yet exist on `obj`, connect will not fail, but will instead set up a stub method. Similarly, null arguments may simply be omitted such that fewer than 4 arguments may be required to set up a connection See the examples for details.

The return value is a handle that is needed to remove this connection with `dojo.disconnect`.


Usage
=====

.. js ::
  
  // Dojo 1.7 (AMD)
  require(["dojo/_base/connect"], function(connect){
    connect.connect(obj, event, context, method, dontFix);
  });
  // Dojo < 1.7
  dojo.connect(obj, event, context, method, dontFix);


Examples
========

Dojo 1.7 (AMD)
--------------

.. js ::

  require(["dojo/_base/connect"], function(connect){
    // When obj.onchange(), do ui.update():
    connect.connect(obj, "onchange", ui, "update");
    connect.connect(obj, "onchange", ui, ui.update); // same

    // Using return value for disconnect:
    var link = connect.connect(obj, "onchange", ui, "update");
    ...
    connect.disconnect(link);

    // When onglobalevent executes, watcher.handler is invoked:
    connect.connect(null, "onglobalevent", watcher, "handler");

    // When ob.onCustomEvent executes, customEventHandler is invoked:
    connect.connect(ob, "onCustomEvent", null, "customEventHandler");
    connect.connect(ob, "onCustomEvent", "customEventHandler"); // same

    // When ob.onCustomEvent executes, customEventHandler is invoked
    // with the same scope (this):
    connect.connect(ob, "onCustomEvent", null, customEventHandler);
    connect.connect(ob, "onCustomEvent", customEventHandler); // same

    // When globalEvent executes, globalHandler is invoked
    // with the same scope (this):
    connect.connect(null, "globalEvent", null, globalHandler);
    connect.connect("globalEvent", globalHandler); // same
  });


Dojo < 1.7
----------

.. js ::

    // When obj.onchange(), do ui.update():
    dojo.connect(obj, "onchange", ui, "update");
    dojo.connect(obj, "onchange", ui, ui.update); // same

    // Using return value for disconnect:
    var link = dojo.connect(obj, "onchange", ui, "update");
    ...
    dojo.disconnect(link);

    // When onglobalevent executes, watcher.handler is invoked:
    dojo.connect(null, "onglobalevent", watcher, "handler");

    // When ob.onCustomEvent executes, customEventHandler is invoked:
    dojo.connect(ob, "onCustomEvent", null, "customEventHandler");
    dojo.connect(ob, "onCustomEvent", "customEventHandler"); // same

    // When ob.onCustomEvent executes, customEventHandler is invoked
    // with the same scope (this):
    dojo.connect(ob, "onCustomEvent", null, customEventHandler);
    dojo.connect(ob, "onCustomEvent", customEventHandler); // same

    // When globalEvent executes, globalHandler is invoked
    // with the same scope (this):
    dojo.connect(null, "globalEvent", null, globalHandler);
    dojo.connect("globalEvent", globalHandler); // same

.. api-inline :: dojo.connect

See also
========

* :ref:`Event QuickStart <quickstart/events>` for a good introduction
* :ref:`dojo.connectPublisher <dojo/connectPublisher>`
