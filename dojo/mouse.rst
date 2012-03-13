.. _dojo/mouse:

===========
dojo/mouse
===========

:Authors: Kris Zyp
:Project owner: Kris Zyp
:since: 1.7.0

.. contents ::
  :depth: 2

The dojo/mouse module provides extension events for hovering and mouse button utility functions. The module has three properties: enter, leave, and mouseButtons.

mouse.enter
===========

The mouse.enter event is an extension event for being notified of when the mouse cursor hovers over an element. This is based on Internet Explorer's "mouseenter" event and differs "mouseover" because it does not bubble ("mouseover" and "mouseout" are widely considered to be broken because they do bubble and generate many meaningless events for every time the mouse enters a different element within the target element). To use mouse.enter, we can listen for an event like:

.. js ::

    define(["dojo/dom-class", "dojo/on", "dojo/mouse"], function(domClass, on, mouse){
        on(node, mouse.enter, function(event){
            domClass.add(node, "hoverClass");
        });
    });

mouse.leave
===========

The mouse.leave event is an extension event for being notified of when the mouse cursor stops hovering over an element. This is based on Internet Explorer's "mouseleave" event and again differs "mouseout" because it does not bubble. To use mouse.leave, we can listen for an event like:

.. js ::

    define(["dojo/dom-class", "dojo/on", "dojo/mouse"], function(domClass, on, mouse){
        on(node, mouse.leave, function(event){
            domClass.remove(node, "hoverClass");
        });
    });

mouseButtons
============

The mouseButtons object has the following properties and methods:

* LEFT - The number corresponding to the "button" property value on the event when the left mouse button is clicked.
* MIDDLE - The number corresponding to the "button" property value on the event when the middle mouse button is clicked.
* RIGHT - The number corresponding to the "button" property value on the event when the right mouse button is clicked.
* isLeft(event) - Indicates if the left mouse button was used in the provided event.
* isMiddle(event) - Indicates if the middle mouse button was used in the provided event.
* isRight(event) - Indicates if the right mouse button was used in the provided event.
