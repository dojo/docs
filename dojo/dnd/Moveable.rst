.. _dojo/dnd/Moveable:

=================
dojo/dnd/Moveable
=================


.. contents ::
  :depth: 2

Introduction
============

This is a specific sub-module of the Dojo DnD system that makes a DOM node moveable using the mouse.

Usage
=====

Constructor
-----------

Constructor takes the node to make moveable and an optional object of options which can have the following fields:

+------------------+--------------------------------------------------------------------------------------------+
|**handle**        | DOMNode or ID of a node that will be used as a handle for this Moveable                    +
+------------------+--------------------------------------------------------------------------------------------+
|**delay**         | If > 0, the move won't be initiated unless mouse drags more than **delay** pixels          +
+------------------+--------------------------------------------------------------------------------------------+
|**skip**          | If true, dragging on form elements won't trigger the move.                                 +
+------------------+--------------------------------------------------------------------------------------------+
|**mover**         | Constructor for a custom dojo.dnd.Mover. Default mover directly moves the node but you     +
|                  | might want to clone it instead of moving the original                                      +
+------------------+--------------------------------------------------------------------------------------------+

Events
------

You can connect to the following events of a Moveable:

``onMoveStart``
  called when the node starts to be moved;

``onMoveStop``
  called when the node has been moved (the mouse button has been released) ;

``onFirstMove``
  called when the user first moves the node :

``onMove``
  called at every step of the move (every ``onmousemove`` event);

``onMoving``
  called at the beginning of any move step (before the moveable position has been updated);

``onMoved``
  called at the end of any move step (after the moveable position has been updated).

Example
=======

.. code-example ::

  .. js ::

    require(["dojo/dnd/Moveable", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(Moveable, dom, on){
      on(dom.byId("doIt"), "click", function(){
        var dnd = new Moveable(dom.byId("dndOne"));
      });
    });

  .. html ::

    <div id="dndArea">
      <div id="dndOne">Hi, I am moveable when you want to.</div>
    </div>
    <p><button id="doIt" type="button">Make moveable</button></p>

  .. css ::

    #dndOne {
      width: 100px;
      height: 100px;
      padding: 10px;
      border: 1px solid #000;
      background: red;
    }

    #dndArea {
      height: 200px;
      padding: 10px;
      border: 1px solid #000;
    }

Custom Mover Example
====================

Here is an example of a custom mover allowing to move an object with 5 pixels steps when ``Ctrl`` key is pressed while
dragging:

.. js ::
 
  require(["dojo/_base/declare", "dojo/_base/event", "dojo/dnd/Mover", "dojo/dnd/autoScroll"], 
  function(declare, event, Mover, autoScroll, dom))
    var StepMover = declare([Mover], {
      onMouseMove: function(e){
        autoScroll(e);
        var m = this.marginBox;
        if(e.ctrlKey){
          this.host.onMove(this, {l: parseInt((m.l + e.pageX) / 5) * 5, t: parseInt((m.t + e.pageY) / 5) * 5});
        }else{
          this.host.onMove(this, {l: m.l + e.pageX, t: m.t + e.pageY});
        }
        event.stop(e);
      }
    });
    
    //Create your "Moveable" as
    var myMoveable = new Moveable("aNode", {
      mover: StepMover
    });
  });

See also
========

* :ref:`dojo/dnd <dojo/dnd>` - The Dojo Drag and Drop Package/System
