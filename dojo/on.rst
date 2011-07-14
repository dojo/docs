#format dojo_rst

dojo/on
=======

:Authors: Kris Zyp
:Project owner: Kris Zyp
:Available: 1.7.0

.. contents::
  :depth: 2

The dojo/on module is a general-purpose event handler, providing normalized event listening and event dispatching functionality. This module is designed to be lightweight and fast, based on modern browsers' event model.

===========
dojo/on API
===========

The module's value is an on function that can be directly called to add an event listener. The on function is the form:

.. code-block :: javascript

  on(target, eventType, listener);

The following parameters should be provided to the on function:

* target - This is the target object (typically a DOM node) that will be the source of the events. The target object may be a host object with it's own event capabilities (like DOM elements or the window), or it may be a plain JavaScript object. This argument is optional, and if omitted, on() will events on the window if that event is available there, or on the publish/subscribe hub.
* eventType - This is the name of the event to be listening for (like "click"). This may include a (CSS) selector to specify the target nodes to listen for.
* listener - This is the function that will be called when this event takes place. The listener function will be called with 'this' as the target object (or the element targeted by the selector in the case of event delegation) and the first and only argument will be the event. The event object is normalized to have the important standard properties and methods of a W3C event (target properties, preventDefault(), stopPropagation()).

The basic usage looks like:

.. code-block :: javascript

  define(["dojo/on"], function(on){
    on(document, "click", clickHandler);
  });

The return value from the on function is a signal handler that has a cancel() method that can be used to stop listening for the events. For example, to listen for a single click, one could do:

.. code-block :: javascript

  var signal = on(document, "click", function(){
    // cancel after first event
    signal.cancel();
    // now perform any other action
  });

The dojo/on module can also be loaded with dojo.require("dojo.on") to make available as dojo.on. For example:

.. code-block :: javascript

  dojo.require("dojo.on");
  dojo.on(document, "click", clickHandler);

The on function is also available on queried NodeList's with the NodeList on() method. For example, we could write:

.. code-block :: javascript
  
  dojo.query("button").on("click", buttonClickHandler);

Event Delegation
----------------
The on function also provides event delegation functionality. One can use a selector in the event type name to indicate the nodes that are targetted for event listening. The on function will then use respond to event bubbling (this only works for bubbling events) and trigger the listener when the appropriate child nodes trigger the event. The format for  selector-based event listening is to use "<selector>:<eventType>" as the eventType. For example, to listen for click events on elements with the myClass class name, we could do:

.. code-block :: javascript

  on(document, ".myClass:click", clickHandler);

The on function also supports comma delimited event types, so we can listen for multiple events (with delegation) with one call. For example, to listen for double clicks on the document and clicks on buttons with myClass class name, we could do:

.. code-block :: javascript

  on(document, "dblclick, button.myClass:click", clickHandler);

Extension Events
----------------

The eventType parameter may also be an extension event. An extension event is a custom event that may be based on extended functionality. Dojo includes several extension events, including touch gestures available in dojo/gestures and mouse tracking functionality with dojo/mouse's enter and leave extension events. For example, to listen for the mouse hovering over a DOM node, we could write:

.. code-block :: javascript

  define(["dojo/on", "dojo/mouse"], function(on, mouse){
    on(node, mouse.enter, hoverHandler);
  });

You can also create your own extension events. An extension event is simply a function (or any object with a call() method) that will be called with two parameters. The first parameter is the target and the second is the listener.

The module's on function also has several others properties/functions on it for additional functionality:

selector function
-----------------

The on.selector function can be used to apply event delegation when extension events are used (since you can't use the "<selector>:<type>" syntax with an extension event). The on.selector function is called with the CSS selector as the first argument and the event type as the second argument. For example, to listen for the mouse.enter extension event on elements with the myClass class name, we could write:

.. code-block :: javascript

  define(["dojo/on", "dojo/mouse"], function(on, mouse){
    on(node, on.selector(".myClass", mouse.enter), myClassHoverHandler);
  });

emit function
-----------------

The on.emit function provides a normalized mechanism for dispatching events. This method will dispatch an event using the native event facilities when available, and will emulate these facilities otherwise. The emit function takes three arguments (the first two closely mirror the on function):

* target - This is the target object (typically a DOM node) that will be the source of the event. The target object may be a host object with it's own event capabilities (like DOM elements or the window), or it may be a plain JavaScript object. This argument is optional, and if omitted the event is published on publish/subscribe hub.
* eventType - This is the name of the event type to be dispatched (like "select"). This event may be a standard event (like "click") or a custom event (like "finished").
* eventProperties - This is an object with the properties of the event to be dispatched. Generally you should align your properties with W3C standards. Two properties are of particular importance:

* eventProperties.bubbles - This indicates that the event should bubble up, first firing on the target object, next on the target object's parent (parentNode) and so on until it reaches the top of the DOM or bubbling is stopped. Bubbling is stopped when a listener calls event.stopPropagation().
* eventProperties.cancelable - This indicates that the event's default action can be cancelled. The default action is cancelled by a listener by calling event.preventDefault(). The emit method does not perform any default action, it returns a value allowing the calling code to perform any default action.

The emit function returns the event object unless the event is cancelable and is cancelled by one of the listeners, in which case it will return false. For example:

.. code-block :: javascript

  define(["dojo/on"], function(on){
    var event = on.emit(button, "click", {
      bubbles: true,
      cancelable: true,
      which: 1
    });
    // if event is not false, the event was not cancelled, we can do our default action
    if(event){
      submitForm();
    }
  });

pausable function
-----------------

The on.pausable function provides a means for pausing an event listener, while still preserving the listeners order and state. The on.pausable() function can be called just like on() (with the same arguments). The only difference is the returned signal handler will include pause() and resume() methods. The pause() method will cause the listener to not be called when the specified event takes place. The resume() method will cause the listener to be called again. For example, we could write:

.. code-block :: javascript

  var buttonHandler = on(button, "click", clickHandler);
  on(disablingButton, "click", function(){
    buttonHandler.pause();
  });

once function
-------------

The on.once function allows you to register a listener that will be called just once in response to an event. This works just like on(), but the listener will be called a single time and then it will be removed as a listener. For example:

.. code-block :: javascript

  on.once(finishedButton, "click", onFinished);

Publish/Subscribe
-----------------

Dojo provides a centralize hub for publishing and subscribing to global messages by topic. One can subscribe to these messages by using on() without the first target argument, and one can publish by using on.emit() with the first target argument. For example:

.. code-block :: javascript

  on("some/topic", listener); // listener will be called when a message is published for this topic
  ...
  on.emit("some/topic", "hi there", "additional arguments"); // publish a message


Evented Base Class
------------------

The on module also provides an Evented property that is a class that can be used as a base class or mixin for JavaScript classes that have their own events. The Evented class provides two methods, on(eventType, listener) and emit(eventType, eventObject) which correspond to on() and on.emit() with the target being the instance object. For example, we could create a class:

.. code-block :: javascript

  var MyComponent = dojo.declare([on.Evented], {
    startup: function(){
	  // once we are done with startup, fire the "ready" event
      this.emit("ready", {});
    }
  });

  component = new MyComponent();
  component.on("ready", function(){
    // this will be called when the "ready" event is emitted
    ...
  });
  component.startup();
