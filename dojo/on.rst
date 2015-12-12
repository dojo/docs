.. _dojo/on:

=======
dojo/on
=======

:Authors: Kris Zyp
:Project owner: Kris Zyp
:since: 1.7.0

.. contents ::
  :depth: 2

**dojo/on** is a general-purpose event handler module for DOM nodes and other event emitting objects, providing 
normalized event listening and event dispatching functionality.

This module is designed to be lightweight and fast, based on modern browsers' event model.  This module also 
deprecates the event handling features of :ref:`dojo/connect <dojo/connect>`.

Usage
=====

The module's return value is an on function that can be directly called to add an event listener:

.. js ::

  require(["dojo/on"], function(on){
    on(target, "event", function(e){
      // handle the event
    });
  });


Removing an Event Handler
-------------------------

The return value of ``on()`` provides a method that can be used to remove the event listener from the event:

.. js ::

  require(["dojo/on", "dojo/_base/window"], function(on, win){
    var signal = on(win.doc, "click", function(){
      // remove listener after first event
      signal.remove();
      // do something else...
    });
  });

emit()
------

The ``emit()`` method provides a normalized mechanism for dispatching events. This method will dispatch an event using 
the native event facilities when available, and will emulate these facilities otherwise:

.. js ::

  require(["dojo/on"], function(on){
    on(target, "event", function(e){
      // handle event
    });

    on.emit(target, "event", {
      bubbles: true,
      cancelable: true
    });
  });

The signature of the method is:

======== ====== =======================================================================================================
Argument Type   Description
======== ====== =======================================================================================================
target   Object This is the target object (a DOM node or other event emitting object) that will be the source of the 
                event. The target object may be a host object with its own event capabilities (like DOM elements or 
                the window), or it may be a JavaScript object with an ``on()`` method.
type     String This is the name of the event type to be dispatched (like ``select``). This event may be a standard 
                event (like ``click``) or a custom event (like ``finished``).
event    Object This is an object with the properties of the event to be dispatched. Generally you should align your 
                properties with W3C standards. Two properties are of particular importance:

                * bubbles - This indicates that the event should bubble up, first firing on the target object, next on 
                  the target object's parent (``parentNode``) and so on until it reaches the top of the DOM or 
                  bubbling is stopped. Bubbling is stopped when a listener calls ``event.stopPropagation()``.

                * cancelable - This indicates that the event's default action can be cancelled. The default action is 
                  cancelled by a listener by calling ``event.preventDefault()``. The emit method does not perform any 
                  default action, it returns a value allowing the calling code to perform any default action.
                * detail - When an event is emitted using ``widget.emit()``, this object is added and contains useful
                  information such as a reference to the widget instance that emitted the event.
======== ====== =======================================================================================================

``emit()`` returns the event object unless the event is cancelable and is cancelled by one of the listeners, in which 
case it will return ``false``.

.. _dojo/on#selector-function:

selector()
----------

The ``selector()`` method can be used to apply event delegation when extension events are used (since you can't use 
the ``<selector>:<type>`` syntax with an extension event).  The method is called with the CSS selector as the first 
argument and the event type as the second argument.  For example, to listen for the ``mouse.enter`` extension event on 
elements with the ``myClass`` class name, we could write:

.. js ::

  require(["dojo/on", "dojo/mouse", "dojo/query!css2"], function(on, mouse){
    on(node, on.selector(".myClass", mouse.enter), myClassHoverHandler);
  });

The ``selector()`` method can also be used with custom selector functions, by providing a function instead of a 
selector string as the first argument. The function will be called each time the indicated event takes place, and 
provide the event's target as the single argument. If the selector function has a corresponding node that matches for 
the event target, it can return that node. If the selector does not match, it should return a falsy value.

Also note that :ref:`dojo/query <dojo/query>` must be loaded for ``selector()`` to work, even if it is not used 
directly in your code block.

pausable()
----------

The ``pausable()`` method provides a means for pausing an event listener, while still preserving the listeners order 
and state.  The ``pausable()`` method can be called just like ``on()``.  The only difference is the returned signal 
handler will include ``pause()`` and ``resume()`` methods.

The ``pause()`` method will cause the listener to not be called when the specified event takes place. The ``resume()`` 
method will cause the listener to be called again.

For example, we could write:

.. js ::

  require(["dojo/on"], function(on){
    var buttonHandler = on.pausable(button, "click", clickHandler);
    
    on(disablingButton, "click", function(){
      buttonHandler.pause();
    });

    on(enablingButton, "click", function(){
      buttonHandler.resume();
    });
  });

once()
------

The ``once()`` function allows you to register a listener that will be called just once in response to an event. This 
works just like ``on()``, but the listener will be called a single time and then it will be removed as a listener. For 
example:

.. js ::

  require(["dojo/on"], function(on){
    on.once(finishedButton, "click", function(){
      // will only fire once...
    });
  });

Notes
=====

Integration with dojo/query
---------------------------

:ref:`dojo/query <dojo/query>` defines an ``on()`` method as part of the NodeList objects it returns.  So the 
following can be done:

.. js ::
  
  require(["dojo/query"], function(query){
    query("button").on("click", clickHandler);
  });

Normalization
-------------

One of the key benefits of using ``dojo/on`` is that it provides event normalization, event listeners will receive an 
event object with the properties defined by the W3C event model, even in Internet Explorer.  Generally, ``dojo/on`` 
does not normalize non-standard properties.

There are some non-standard geometry properties that are often desirable, that are not normalized by ``dojo/on``.
The :ref:`dojo/dom-geometry <dojo/dom-geometry>` module provides a ``normalizeEvent()`` function that can be used to 
normalize the ``pageX``, ``pageY``, ``layerX``, and ``layerY`` properties on events.

Multiple Events
---------------

You can listen to multiple event types with a single call by comma-delimiting the event names. Then we can listen for 
multiple events (with delegation) with one call. For example, we can listen for ``touchend`` and ``dblclick``:

.. js ::

  require("dojo/on", function(on){
    on(element, "dblclick, touchend", function(e){
      // handle either event
    });
  });

Event Delegation
----------------

The ``on()`` function also provides event delegation functionality.  One can use a selector in the event type name to 
indicate the nodes that are targeted for event listening.  The ``on()`` function will then use respond to event 
bubbling and trigger the listener when the appropriate child nodes trigger the event.

The format for selector-based event listening is to use ``<selector>:<eventType>`` as the ``eventType``.

For example, to listen for click events on elements with the ``myClass`` class name, we could do:

.. js ::

  require(["dojo/on", "dojo/_base/window", "dojo/query"], function(on, win){
    on(win.doc, ".myClass:click", clickHandler);
  });

To listen for double clicks on the document and clicks on buttons with ``myClass`` class name, we could do:

.. js ::

  on(document, "dblclick, button.myClass:click", clickHandler);

Note that event delegation will only work on events that bubble.  Most DOM events do bubble, but there are a few 
exceptions.  The ``mouseenter`` and ``mouseleave`` events do not bubble, but ``mouseover`` and ``mouseout`` are the 
bubbling counterparts.  The ``focus`` and ``blur`` events do not bubble, but dojo/on normalizes ``focusin`` and 
``focusout`` as bubbling equivalents.  Also, ``scroll`` events don't bubble.

Note that ``dojo/query`` must be loaded for event delegation to work.

Sometimes an event may occur on a sub-node beneath the node matching the selector.  For example, you may have a table 
where you want to monitor which ``<tr>`` row was clicked, but the actual click events occur on the ``<td>`` nodes, or 
nodes within the ``<td>``.

In this case you can get the node that matched the selector via ``this``:

.. js ::

  require(["dojo/on", "dojo/query"], function(on){
    on(myTable, "tr:click", function(evt){
      console.log("Clicked on node ", evt.target, " in table row ", this);
    });
  });

Extension Events
----------------

The ``eventType`` parameter may also be an extension event.  An extension event is a custom event that may be based on 
extended functionality.  Dojo includes several extension events, such as mouse tracking functionality with 
:ref:`dojo/mouse <dojo/mouse>`\'s enter and leave extension events.  For example, to listen for the mouse hovering 
over a DOM node, we could write:

.. js ::

  require(["dojo/on", "dojo/mouse"], function(on, mouse){
    on(node, mouse.enter, hoverHandler);
  });

You can also create your own extension events.  An extension event is simply a function (or any object with a 
``call()`` method) that will be called with two parameters.  The first parameter is the target and the second is the 
listener.

Migration
=========

Converting from dojo.connect
----------------------------

``dojo/on`` can replace :ref:`dojo.connect <dojo/connect>` when connect is used for connecting to DOM nodes and event 
emitting objects (see the :ref:`dojo/Evented <dojo/Evented>` page for more information). If you are connecting to a 
plain method, use :ref:`dojo/aspect <dojo/aspect>` instead.  Also, note that some event emitting objects, like Dijits, 
have their own event naming conventions and may need to be changed to remove "on" from the names and lower-case the 
remaining event names used with ``dojo.connect`` for some event emitting objects like Dijits.

Transitioning to Dojo 2.0
-------------------------

The ``dojo/on`` module is expected to be a core module in Dojo 2.0 with the API introduced in 1.7.  The dojo/on module 
can be used for listening to events on DOM and host objects, as well Evented objects such that your code should 
transition to 2.0.

However, the event emitting objects in Dojo (including Dijits, DnD, and Animation) are likely to change their events (
both names and emitted event objects) in 2.0, so one should not assume that code using ``dojo/on`` to listen to Dojo 
objects will work unchanged in 2.0.

Using the dojo/on Module with pre-AMD-style Dojo APIs
-----------------------------------------------------

The ``dojo/on`` module can also be loaded with ``dojo.require("dojo.on")`` to make available as ``dojo.on``. For 
example:

.. js ::

  dojo.require("dojo.on");
  dojo.on(document, "click", clickHandler);

Examples
========

Event Delegation
----------------

.. code-example ::
  :djConfig: async: true

  Using event delegation on an HTML table to highlight rows and columns.

  .. js ::

    require([
      'dojo/on',
      'dojo/dom-class',
      'dojo/dom-attr',
      'dojo/query',  // note that dojo/query must be loaded for event delegation to work
      'dojo/domReady!'
    ], function(on, domClass, domAttr, query) {
  
      var highlighter = {
  
        setCol: function(cellIdx, classStr, tbl) {
          var i = 0, len = tbl.rows.length;
          for (i; i < len; i++) {
            var cell = tbl.rows[i].cells[cellIdx];
            if (cell && !domAttr.has(cell, 'colspan')) {  // provided index might not be available and skip header 
                                                          //cells with colspan
              domClass.toggle(cell, classStr)
            }
          }
        },
  
        highlightCol: function(cssQuery, classStr) {
          var self = this;
          query(cssQuery).on('td:mouseover, td:mouseout', function(evt) {
            self.setCol(this.cellIndex, classStr, evt.currentTarget);
          });
        },
  
        highlightRow: function(cssQuery, classStr) {
          // note: this could also just be set through css with pseudoclass hover
          query(cssQuery).on('tr:mouseover, tr:mouseout', function() {
            domClass.toggle(this, classStr);
          });
        },
  
        highlightBoth: function(cssQuery, classStrRow, classStrCol){
          var self = this;
          query(cssQuery).on('td:mouseover, td:mouseout', function(evt) {
            var tbl = evt.currentTarget;
            var tr = evt.target.parentNode;
            var td = evt.target;
            self.setCol(td.cellIndex, classStrCol, tbl);
            domClass.toggle(tr, classStrRow);
          });
        }
      };
  
      highlighter.highlightBoth('#tbl', 'tdHover', 'trHover');
  
    });

  .. css ::

    #tbl { border-collapse: collapse; }
    #tbl td, #tbl th { border-color: #AAAAAA; border-style: solid; border-width: 0 1px; padding: 3px 9px; }

    #tbl th { text-align: center; }
    #tbl td, .tbl th { text-align: right; }
    #tbl td:first-child { text-align: left; }

    .tdHover { background-color: #005197; color: #ffffff; }
    .trHover { background-color: #E98900; color: #ffffff; }

  .. html ::

    <table id="tbl">
    <tbody>
      <tr><th></th><th colspan="12">Main</th></tr>
      <tr><th></th><th colspan="2">Sub 1</th><th colspan="2">Sub 2</th><th colspan="2">Sub 3</th>
        <th colspan="2">Sub 4</th><th colspan="2">Sub 5</th><th colspan="2">Sub 6</th></tr>
      <tr><th>Categories</th><th>Unit</th><th>± %</th><th>Unit</th><th>± %</th><th>Unit</th><th>± %</th><th>Unit</th>
        <th>± %</th><th>Unit</th><th>± %</th><th>Unit</th><th>± %</th></tr>
      <tr><td>Category 1</td><td>473</td><td>15</td><td>686</td><td>540</td><td>141</td><td>101</td><td>1935</td>
        <td>745</td><td>43</td><td>161</td><td>515</td><td>52</td></tr>
      <tr><td>Category 2</td><td>20</td><td>161</td><td>127</td><td>13</td><td>201</td><td>14</td><td>278</td>
        <td>31</td><td>921</td><td>519</td><td>103</td><td>608</td></tr>
      <tr><td>Category 3</td><td>18</td><td>80</td><td>10</td><td>99</td><td>5</td><td>71</td><td>3</td>
        <td>70</td><td>1</td><td>105</td><td>10</td><td>45</td></tr>
      <tr><td>Catogory 4</td><td>378</td><td>9</td><td>943</td><td>11</td><td>1747</td><td>94</td>
        <td>236</td><td>19</td><td>3265</td><td>95</td><td>6788</td><td>4</td></tr>
    </tbody>
    </table>

See Also
========

* :ref:`dojo/Evented <dojo/Evented>` base class for objects that emit their own events.
