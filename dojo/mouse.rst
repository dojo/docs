.. _dojo/mouse:

===========
dojo/mouse
===========

:Authors: Kris Zyp
:Project owner: Kris Zyp
:since: 1.7.0

.. contents ::
  :depth: 2

**dojo/mouse** is a module that provides extension events for hovering and mouse button utility functions. The module has three properties: ``enter``, ``leave``, and ``mouseButtons``.

Usage
=====

Basic usage requires requirement of the module:

.. js ::

  require(["dojo/mouse"], function(mouse){
    // Mouse extension events available
  });

To gain utility out of the module, you must utilize one of three extension events:

.. js ::

  require(["dojo/mouse", "dojo/on", "dojo/dom"], function(mouse, on, dom){
    on(dom.byId("someid"), mouse.enter, function(evt){
      // handle mouse enter event
    });
  });

enter
-----

The ``dojo/mouse::enter`` event is an extension event for being notified of when the mouse cursor hovers over an element. This is based on Internet Explorer's ``mouseenter`` event and differs ``mouseover`` because it does not bubble (``mouseover`` and ``mouseout`` are widely considered to be broken because they do bubble and generate many meaningless events for every time the mouse enters a different element within the target element). To use ``enter``, we can listen for an event like:

.. js ::

  require(["dojo/mouse", "dojo/on", "dojo/dom"], function(mouse, on, dom){
    on(dom.byId("someid"), mouse.enter, function(evt){
      // handle mouse enter event
    });
  });

leave
-----

The ``dojo/mouse::leave`` event is an extension event for being notified of when the mouse cursor stops hovering over an element. This is based on Internet Explorer's ``mouseleave`` event and again differs ``mouseout`` because it does not bubble. To use ``leave``, we can listen for an event like:

.. js ::

  require(["dojo/mouse", "dojo/on", "dojo/dom"], function(mouse, on, dom){
    on(dom.byId("someid"), mouse.leave, function(evt){
      // handle mouse leave event
    });
  });

mouseButtons
------------

The ``mouseButtons`` object has the following properties and methods:

* LEFT - The number corresponding to the "button" property value on the event when the left mouse button is clicked.

* MIDDLE - The number corresponding to the "button" property value on the event when the middle mouse button is clicked.

* RIGHT - The number corresponding to the "button" property value on the event when the right mouse button is clicked.

* isLeft(event) - Indicates if the left mouse button was used in the provided event.

* isMiddle(event) - Indicates if the middle mouse button was used in the provided event.

* isRight(event) - Indicates if the right mouse button was used in the provided event.

It is designed to make interpretation of mouse events easier.  For example:

.. js ::

  require(["dojo/mouse", "dojo/on", "dojo/dom"], function(mouse, on, dom){
    on(dom.byId("someid"), "click", function(evt){
      if (mouse.isLeft(event)){
        // handle mouse left click
      }else if (mouse.isRight(event)){
        // handle mouse right click
      }
    });
  });

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example applies a CSS class to a node when the mouse hovers over it.

  .. js ::

    require(["dojo/mouse", "dojo/dom", "dojo/dom-class", "dojo/on", "dojo/domReady!"],
    function(mouse, dom, domClass, on){
      on(dom.byId("hoverNode"), mouse.enter, function(){
        domClass.add("hoverNode", "hoverClass");
      });
      
      on(dom.byId("hoverNode"), mouse.leave, function(){
        domClass.remove("hoverNode", "hoverClass");
      });
    });

  .. html ::

    <div id="hoverNode">Hover Over Me!</div>

  .. css ::

    #hoverNode { width: 200px; height: 100px; border: 1px solid black; }
    .hoverClass { background-color: red; }

See Also
========

* :ref:`dojo/keys <dojo/keys>` - Key Input Management Module

* :ref:`dojo/touch <dojo/touch>` - Touch Input Management Module
