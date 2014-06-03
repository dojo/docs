.. _quickstart/events:

==========================
JavaScript events and Dojo
==========================

:Authors: Matt Bowen, Peter Higgins, Bill Keese, Nikolai Onken
:since: V0.9

.. contents ::
    :depth: 2

Dojo's event system offers a refreshing alternative to the normal JavaScript events. With Dojo, you connect functions to one another, creating a link that calls one function when another fires.

This means that you can connect a function of your own to:

* a DOM event, such as when a link is clicked
* an event of an object, such as an animation starting or stopping
* a function call of your own, such as bar()
* a topic, which acts as a queue that other objects can publish objects to.

Your connected function is called when the event occurs. With simple events, when it calls your function, dojo passes your function a normalized event object, so that it can respond correctly, responding to keystrokes or stopping default behavior. With topics, Dojo passes any subscribed functions the object that was published. Dojo happily abstracts away all of the difficulty of cross-browser event systems, offering programmers a coherent event system that acts consistently across browsers.

Dojo's event system is flexible and gives you a few options for connecting your functions. In the core package, you have both simple events (which use a signal and slot system, similar to Qt's) and topics. In this section, you'll learn the following:

* how to connect functions to one another with :ref:`dojo/on <dojo/on>` and :ref:`dojo/aspect <dojo/aspect>`
* what comes with an event object
* how to connect functions with topics and even publish your own objects to the topic
* how to enjoy event-based programming


DOM Events
==================

Dojo provides two modules to handle many of your event-handling needs.

With :ref:`dojo.on <dojo/on>`, you can link functions to fire when a DOM event occurs.

How does it work?
-----------------

Imagine that you're hungry and have decided to cook a pizza in your oven. The pizza will take 17 minutes, so you set a timer. You have better things to do than sit around your kitchen hanging out by the timer though, so you get your brother and tell him, "When you hear the oven timer, take the pizza out of the oven and bring me a slice." Your brother can only keep track of one thing at a time, and you don't want your house to burn down, so you tell your sister, "When you hear the over timer, turn off the oven." Because you're a little worried that your dirty oven might start to smoke, you tell them both, "If you hear the smoke alarm, come get me and then go outside." After you get your pizza, you tell your brother and sister that they don't have to worry about the oven alarm now and that they can go play until you call for them again. You then set the oven alarm to wake you up from a nap.

In this example, your siblings are functions. Your telling them to respond to certain events, such as "onPizzaDone" and "onHouseOnFire" performs the same function as :ref:`dojo/on <dojo/on>` (for DOMNodes) or :ref:`dojo/aspect <dojo/aspect>` for plain objects - it sets up your siblings (functions) to listen for an event and perform their tasks when they receive notice. The various alarms are similar to event objects; they inform your siblings of important details about the situation (such as what is beeping). Telling your siblings that they don't need to worry about the oven alarm anymore is similar to handle.remove(); the next time the oven alarm goes off, it means that you need to wake up, and you don't want your brother hunting for a pizza needlessly, so you've told him to stop listening to that event.


Connecting to a DOM Event
-------------------------

To connect a function to a DOM event with Dojo, you first need to get the node that you want to connect to. Here, I'll use the venerable
:ref:`dojo/dom byId <dojo/dom#byId>`.

.. js ::

  firstLinkNode = dom.byId("firstLink");


Now, to fire foo when a user clicks ``#firstLink``, and I have the node, so I just need to use dojo/on for the heavy lifting:

.. js ::

  firstLinkConnections = [];
  firstLinkConnections.push(on(firstLinkNode, 'click', foo));


In this example, I passed ``on`` the DOMNode I want my function to listen to,
the name of the event that should trigger my function's call,
and my function.
Note that I keep a reference to the connection (called a handle) by setting firstLinkConnections[0] to the return value
of ``on``.
This will allow me to disconnect the listener later, if I desire.
Now, when a user clicks "Dojo", a message appears in the log.


Now, if I also want to connect someObject.bar() to #firstLink, we can do that too:

.. js ::

  firstLinkConnections.push(on(firstLinkNode, 'click', lang.hitch(someObject, "bar")));

In this case I am using lang.hitch() (from :ref:`dojo/_base/lang <dojo/_base/lang#hitch>`) to call someObject.bar.

To stop listening to all the registered event handlers stored in ``firstLinkConnections``, call handle.remove() for each handle:

.. js ::

   require(["dojo/_base/array"], function(array){
       array.forEach(firstLinkConnections, function(handle){ handle.remove(); });
   });


Events available for Connection
-------------------------------

As a convenience, here is a quick list of normalized Dom Events:

* "click" - the user clicked a node
* "focus" - a node received focus
* "blur" - a node was 'blurred', or otherwise lost focus
* "change" - an input value was changed
* "keypress" - fired when the user presses a key that displays
* "keydown" - fired for non-printable keys
* "keyup" - fired when the user releases a key
* "mouseover" - a node was hovered (*warning:* may fire more than you'd like because of bubbling)
* "mouseout" - a node was un-hovered
* :ref:`dojo/mouse#enter <dojo/mouse#enter>` - a normalized version of onmouseover that *wont* fire more than you'd like (only on first enter)
* :ref:`dojo/mouse#leave <dojo/mouse#leave>` - a normalized version of onmouseout that *wont* fire more than you'd like (only once when leaving)
* submit - a form has been submitted

All of these events are also mapped into :ref:`dojo.NodeList <dojo/NodeList>` as direct methods. To register an click event for many nodes at once:

.. js ::
  
  dojo.query(".foo").onclick(function(e){ /* handle the event */ }).onmouseenter(function(e){ /* handle event */ });

*A note about the event names:* Event names now are lower case, except in special cases (e.g., some Mozilla DOM events). Your event name should not have "on". This differs from **Widget Events** in the sense Dijit uses mixedCase event names, to avoid potential conflicts.   However, widget's on() method functions similarly to `dojo/on`:

.. js ::

  // connect to domEvent "onclick"
  var node = dom.byId("foo");
  on(node, "click", function(){

  });
  // connect to dijit event "onClick"
  var widget = dijit.byId("foo");
  widget.on("click", function(){

  });

**A note about return values:** Any value returned by a function called by ``on()`` will be lost.

Connecting to MouseWheel events
-------------------------------

One event not mentioned above, though entirely useful: mousewheel (okay, it's two events, which is the reason for pointing this out ... )
All Mozilla based browsers use ``DOMMouseScroll``, and the rest ``mousewheel`` ... You can quickly connect to whichever is needed using Dojo's :ref:`dojo/sniff <dojo/sniff>` module:

.. js ::

  var node = dom.byId("foobar");
  on(node, (!has("mozilla") ? "mousewheel" : "DOMMouseScroll"), function(e){
     // except the direction is REVERSED, and the event isn't normalized! one more line to normalize that:
     var scroll = e[(!has("mozilla") ? "wheelDelta" : "detail")] * (!has("mozilla") ? 1 : -1);
     console.log(scroll);
  });

Here we've fixed the event based on the Event Object provided, and are returning a number greater than 1 for scrolling up, and a negative value for scrolling down.

Keyboard Events
---------------
Although different browsers report keyboard events differently, you can write portable keyboard event handling code using dojo, by following these rules:

  - Setup a keypress (not keydown) handler to monitor printable keys

  - Setup a keydown (not keypress) handler to monitor non-printable keys

  - For non-printable keys (arrows, function keys, etc) compare evt.keyCode against the :ref:`Key code constants <dojo/keys>`, rather than hardcoding a number.  For example, if the user presses the left arrow then event.keyCode == dojo.keys.LEFT_ARROW

  - Ignore keypress events where keyCode == keys.CTRL, keys.SHIFT, etc. as these may occur as part of a user pressing (for example) Ctrl-C.

  - call event.stop(e) (:ref:`dojo/_base/event <dojo/_base/event#stop>`) for CTRL combinations (like Ctrl-B) or function keys (like F5) that have special meaning to the browser (like refreshing the page).


As mentioned above, non-printable character events define a keyCode.  Printable character events define a keyChar.  For example, if the user presses the 'a' key than evt.keyChar == 'a'.  If the user presses SHIFT-A then evt.keyChar == 'A'.

Disconnecting
-------------

To disconnect listeners from events, you simply call handle.remove():

.. js ::

  objectConnections[3].remove();

Or, by using :ref:`array.forEach <dojo/_base/array#foreach>`:

.. js ::

   require(["dojo/_base/array"], function(array){
       array.forEach(objectConnections, function(handle){ handle.remove(); });
   });


The Event Object
----------------

When you connect a function to a DOM event with :ref:`dojo/on <dojo/on>`, Dojo passes your function a **normalized** event object. This means that, regardless of the client's browser, you can count on a set of standard attributes about the event and a set of methods to manipulate the event.

Assume that your function has been called by dojo/on and takes an argument named ``event``, like:

.. js ::

  on(dom.byId("node"), "click", function(event){
     // the var 'event' is available, and is the normalized object
  });

Dojo provides the following attributes with an event object:

* event.target - the element that generated the event
* event.currentTarget - the current target
* event.layerX - the x coordinate, relative to the ``event.currentTarget``
* event.layerY - the y coordinate, relative to the ``event.currentTarget``
* event.pageX - the x coordinate, relative to the view port
* event.pageY - the y coordinate, relative to the view port
* event.relatedTarget - For ``mouseover`` and ``mouseout``, the object that the mouse pointer is moving to or out of
* event.charCode - For keypress events, the character code of the key pressed
* event.keyCode - for keypress events, handles special keys like ENTER and spacebar.

Dojo normalizes the following methods with an event object:

* event.preventDefault - prevent an event's default behavior (e.g., a link from loading a new page)
* event.stopPropagation - prevent an event from triggering a parent node's event
* event.stopImmediatePropagation - prevent an event from triggering a parent node's event and from firing any more event handlers on this node

Additionally, :ref:`event.stop(event) <dojo/_base/event#stop>` will prevent both default behavior any any propagation (bubbling) of an event.


Page Load and Unload
--------------------

Dojo has three functions recommended for registering code to run on page load and unload:

* :ref:`ready(func) <dojo/ready>` - Runs the specified function after the page has finished loading, require() calls have completed, and the parser (if enabled) has instantiated widgets.

* :ref:`dojo/_base/unload#addOnWindowUnload(func) <dojo/_base/unload#addOnWindowUnload>` - Runs on page unload.   Useful for tear-down releasing resources (destroying widgets, etc.), but some browsers limit what operations can be done at this stage, especially DOM access / manipulation.

* :ref:`dojo/_base/unload#addOnUnload(func) <dojo/_base/unload#addOnUnload>` - This also runs on page unload, but earlier than :ref:`dojo/_base/unload#addOnWindowUnload(func) <dojo/_base/unload#addOnWindowUnload>`, avoiding the restrictions mentioned above.   However, the function specified to `addOnUnload(func)` may be called even when the page isn't unloading, just because a user (for example) clicked a hyperlink to download a file.    Useful for idempotent operations like saving state.

Like on(), these methods are useful because multiple pieces of code calling `ready()` etc. won't overwrite each other.

Connecting Functions to One Another
===================================

With :ref:`dojo.aspect <dojo/aspect>`, you can link one function to fire when another does.
This is for setting up advice on a regular (non DOMNode) object.

Connecting functions to one another is even simpler than connecting them to DOM events; because you already have a reference to the function, you don't need to do any byId or query work. To have anotherObject.afterBaz fire after someObject.baz fires, use the following:

.. js ::

  objectConnections = [];
  objectConnections[0] = aspect.after(someObject, "baz", lang.hitch(anotherObject, "afterBaz"), true);

In the above code, the first argument is the context of "baz", the second argument is the event (in this case, when baz fires),anotherObject is the context of your listener function, and "afterBaz" is the name of the listener function itself. Connecting two global functions is even easier:

.. js ::

  objectConnections[1] = aspect.after(null, "foo", globalGuy, true);




Gotchas with direct references to functions
-------------------------------------------
Note that the first connection to a function actually modifies the function, by wrapping it another function.   So that

.. js ::

  aspect.after(null, "foo", bar);

is like saying:

.. js ::

  var originalFoo = foo;
  foo = function(){ originalFoo(); bar(); }


This means that you need to be careful with code that directly references (the original) function foo(), including other aspect.after() calls.



Publish and Subscribe
=====================

In addition to the simple event system created by :ref:`dojo/aspect <dojo/aspect>`, dojo offers support for anonymous publication and subscription of objects, via :ref:`dojo/topic#publish <dojo/topic#publish>` and :ref:`dojo/topic#subscribe <dojo/topic#subscribe>`. These methods allow a function to broadcast objects to any other function that has subscribed. This is dojo's topic system, and it makes it very easy to allow separate components to communicate without explicit knowledge of one another's internals.  :ref:`dojo/topic#publish <dojo/topic#publish>` calls any functions that are connected to the topic via :ref:`dojo/topic#subscribe <dojo/topic#subscribe>`, passing to those subscribed functions arguments that are published (see syntax for details). As one might expect, `handle.remove()` will cause a previously subscribed function to no longer be called when :ref:`dojo/topic#publish <dojo/topic#publish>` is called in the future

How does it work?
-----------------

Imagine that you run a running a conference, and there will be updates throughout the day. You could collect contact information for everyone at the beginning of the day, along with each person's interests. However, this would be a lot of logistical work. Instead, you decide to use your facility's Public Address System. When there is an update to the schedule, you announce "This is an update to the schedule: the Dojo training is full and we have added yet a third time slot for it tomorrow." When there is meal information, you announce "This is an update about food: we will be serving free ice cream in the main hall in five minutes." This way, anyone interested in your information can pay attention to any updates that could change their behavior. You don't need to know who is subscribing, and they don't need to fill out a bunch of paper work - it's a win-win.

Example Code for Reference
--------------------------

.. js ::

  function globalGuy(arg){ console.debug("Global Guy fired with arg " + arg); }
    var someObject = {
      bar: function(first, second){ console.debug("Bar fired with first of "+first+" and second of "+second); return 7; },
    }
  }

To connect globalGuy to the topic "globalEvents" and someObject.bar to "fullNames", you simply use ``topic.subscribe``, as follows:

.. js ::

  topics = [];
  topics[0] = topic.subscribe("globalEvents",globalGuy);
  topics[1] = topic.subscribe("fullNames", lang.hitch(someObject, bar));


To publish information to both of these topics, you pass ``topic.publish`` the topic names and arguments that you want to pass to subscribed functions, as follows

.. js ::

  topic.publish("globalEvents", "data from an interesting source");
  topic.publish("fullNames", "Alex", "Russell");

To disconnect someObject.bar from its topic, you use the handle's ``remove()`` method:

.. js ::

  topics[1].remove();


Events with Dijit
=================

The Dijit widgets have many "events", similar to events on DOM nodes.
For example, the dijit.form.Button widget has an click
event synonymous with a <button> node's click event.


You can connect to widget events similarly to connecting to DOM events, using the ``on()`` method of the widget:

.. js ::

  var myWidget = new dijit.form.Button({label: ...});
  myWidget.on("click", myFunc);

or in markup as:

.. html ::

  <div data-dojo-type="dijit/form/Button">
     <script type="dojo/on" data-dojo-event="click">
        ...
     </script>
     Click me!
  </div>



Dijit events similar to DOM events
----------------------------------
As stated above, the widgets tend to support all events similar to DOM events, like:

 * "click": especially useful for button widgets
 * "change": note that the first argument to onChange is the new value, not the event object itself
 * "dblclick"
 * "keydown"
 * "keypress"
 * "keyup"
 * "mousemove"
 * "mousedown"
 * "mouseout": probably not useful since it will report mouse out events within the widget's internal DOM nodes; consider using "mouseleave" instead
 * "mouseover": probably not useful since it will report mouse in events within the widget's internal DOM nodes; consider using "mouseenter" instead
 * "mouseleave": when the mouse is moved away from the widget's outermost DOM node
 * "mouseenter": when the mouse is moved over the widget's outermost DOM node
 * "mouseup"

See the documentation for each widget for details.
Note that the events in widget documentation may be listed in camel case and starting with "on",
reflecting the internal functions in the widgets corresponding to those events.

Notable differences between the widget's event and the similar event on a DOM node:

  * event's corresponding function name is camel case (ex: onClick) for widgets
  * in the handler for a widget's event, "this" points to the widget

Overriding vs. Connecting
-------------------------
Rather than connecting (as above), you can specify a handler as a parameter to the widget on initialization:

.. js ::

  var myWidget = new dijit.form.Button({
      label: "click me!",
      onClick: myFunc
   });

or in markup:

.. html ::

   <button data-dojo-type="dijit/form/Button" onClick="myFunc">Click me!</button>


There's a subtle difference between the third and fourth example (using onClick="myFunc") and
the others:
the third and fourth examples are *overriding* (i.e., replacing) the widget's onClick method
whereas the other examples are connecting to the widget's click event, which internally means they
are setting up advice on the existing onClick method.
Note that you can also override by using <script type="dojo/method"> instead of type="dojo/connect".

Also note that when overriding, you specify the function name rather than the event name,
so it is prepended with "on" and in camel case: "onClick".

In practice the distinction between connecting and overriding is irrelevant
because the widgets default onClick method is an empty function.
However, occasionally you will need to override the default function to return a value.

watch()
-------
You can also watch attribute value changes on widgets.   For example:

.. js ::

   myTitlePane.watch("open", callback);

focused
--------
There's a "focused" attribute on all widgets.

Despite the names of this readonly attribute, it don't correspond exactly to the DOM focus and blur events.
One might say that it indicates when a widget is "active", although "active" is also an overloaded word,
having a separate meaning in CSS.

By way of example, consider a Spinner widget inside of a ContentPane inside of a TabContainer:

.. html ::

  <div data-dojo-type="dijit/layout/TabContainer">
     <div data-dojo-type="dijit/layout/ContentPane" ...>
        <input data-dojo-type="dijit/form/NumberSpinner" ...>
     </div>
  </div>

Clicking the spinner widget predictably causes it's focused attribute to become true (as the widget is actually getting keyboard focus).
However, clicking the arrows of the spinner also causes it's focused attribute to become true, even though technically that removes
keyboard focus (at least on some browsers).

In addition, clicking or tabbing to the spinner widget also cause the focused attribute on the ContentPane and TabContainer to become true, since they
are ancestors of the Spinner widget.
At any point in time there's a stack of active widgets, and dijit keeps track of that stack and sets each widget's focused attribute to true or false as each widget joins or leaves the stack.


High level events
-----------------
Widgets also support some events that don't correspond to DOM events.
Typically these are "higher level" conceptual events on the widget.
For example, InlineEditBox has an "onCancel" event that occurs when the user cancels the edit.

See the documentation for each widget to find out the exact list of events it supports.
Most of the events start with "on" in their name.

Finally, note that you can connect to/override any method in a widget, not just the ones that are considered
"events".   However, note the caveats listed above about connecting vs. overriding.

.. _quickstart/events#widget-events-published-to-the-dom:

Widget events published to the DOM
----------------------------------
Starting in version 1.8, widget events are published to the DOM tree and can be monitored by setting up listeners
on the DOM tree.
This allows event delegation: setting up an event handler on a high level DOMNode to handle events on multiple widgets.

There are two main types of events that widgets publish:
   - native events, ex: "click"
   - attribute changes, ex: attrmodified-open


Here's a simple example of monitoring click events coming from any widget.
Note that since dijit widgets leverage :ref:`dijit/_OnDijitClickMixin <dijit/_OnDijitClickMixin>`,
keyboard "click" events (i.e using the space or enter key) are also emitted as DOMNode click events.

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

    .. js ::

        require(["dojo/dom", "dojo/on", "dijit/registry", "dojo/domReady!"], function(dom, on, registry){
            on(dom.byId("buttonContainer"), "click", function(evt){
                var widget = registry.getEnclosingWidget(evt.target);
                if(widget){
                    console.log("click on widget " + widget.id);
                }
            });
        });
             
    .. html ::
     
        <div id="buttonContainer">
            <button type="button" data-dojo-type="dijit/form/Button" id="button1">1</button>
            <button type="button" data-dojo-type="dijit/form/Button" id="button2">2</button>
            <button type="button" data-dojo-type="dijit/form/Button" id="button3">3</button>
        </div>


Here's an example using the attrmodified-* events to detect when TitlePanes are opened or closed.
Note that there's a separate event type for each attribute; in this example a change to the open
attribute generates an event of type "attrmodified-open".

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

    .. js ::

        require(["dojo/dom", "dojo/on", "dijit/registry", "dojo/domReady!"], function(dom, on, registry){
            on(dom.byId("tpContainer"), "attrmodified-open", function(evt){
                var widget = registry.getEnclosingWidget(evt.target);
                console.log(widget.id + ".open changed from " +
                    evt.detail.prevValue + " to " + evt.detail.newValue);
            });
        });

    .. html ::

        <div id="tpContainer">
            <div data-dojo-type="dijit/TitlePane" title="pane #1" id="pane1">
                Contents of TitlePane #1
            </div>
            <div data-dojo-type="dijit/TitlePane" title="pane #2" id="pane2">
                Contents of TitlePane #2
            </div>
            <div data-dojo-type="dijit/TitlePane" title="pane #3" id="pane3">
                Contents of TitlePane #3
            </div>
        </div>


You can also use on.selector() to limit the notifications to certain widgets (technically, limiting the events
to the root DOMNodes of certain widgets).  For example:

.. code-example ::

    .. js ::

        require(["dojo/dom", "dojo/on", "dijit/registry", "dojo/query!css2", "dojo/domReady!"],
                function(dom, on, registry){
            on(dom.byId("buttonContainer"), on.selector(".watchme", "click"), function(evt){
                // "this" is the node that matched the selector, the root DOMNode of a Button widget
                // with class="watchme"
                var widget = registry.byNode(this);
                if(widget){
                    console.log("click on widget " + widget.id);
                }
            });
        });

    .. html ::

        <div id="buttonContainer">
            <button type="button" data-dojo-type="dijit/form/Button" id="watched" class="watchme">watched</button>
            <button type="button" data-dojo-type="dijit/form/Button" id="unwatched">not watched</button>
        </div>

Note that as shown above, when on.selector() is used, the app must also require() dojo/query.