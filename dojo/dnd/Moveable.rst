#format dojo_rst

dojo.dnd.Moveable
=================

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 3

============
Introduction
============

Makes a DOM node moveable using the mouse.

=====
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
 * onMoveStart : called when the node starts to be moved;
 * onMoveStop : called when the node has been moved (the mouse button has been released) ;
 * onFirstMove : called when the user first moves the node :
 * onMove : called at every step of the move (every onmousemove event);
 * onMoving : called at the begining of any move step (before the moveable position has been updated);
 * onMoved : called at the end of any move step (after the moveable position has been updated).

=======
Example
=======

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // this we only require to make the demo look fancy
    dojo.require("dojo.dnd.Moveable");

    function makeMoveable(node){
      var dnd = new dojo.dnd.Moveable(dojo.byId(node));
    }
    </script>

  .. cv:: html

    <div id="dndArea">
      <div id="dndOne">Hi, I am moveable when you want to.</div>
    </div>
    <p><button dojoType="dijit.form.Button" onClick="makeMoveable('dndOne')">Make moveable</button>

  .. cv:: css

    <style type="text/css">
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
    </style>
