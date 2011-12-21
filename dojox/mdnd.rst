.. _dojox/mdnd:

==========
dojox.mdnd
==========

:Project owner: Erwan Morvillez, Jean-Jacques Patard, Jeff Cunat
:since: V1.1

.. contents ::
   :depth: 2

Experimental coordinates based moveable drag and drop. Use stable dojo.dnd for production.


Introduction
============

Alternative Drag and Drop solution based on coordinates of drag element and targets instead of mouseover. It allows dragging directly the nodes (like dojo.dnd.Moveable) instead of an avatar (as in dojo.dnd). dojo.dnd and dojox.mdnd are compatible by using adapters.

PureSource is just a rewrite of dojo.dnd.Source to only allow drag start and no drop without testing acceptance.


Usage
=====

How to use the component:

.. js ::
  
    dojo.require("dojox.mdnd.AreaManager");
    dojo.require("dojox.mdnd.DropIndicator");
    dojo.require("dojox.mdnd.dropMode.DefaultDropMode");

    dojo.ready(function(){
      var m = dojox.mdnd.areaManager();
      m.areaClass = "dndArea";
      m.dragHandleClass = "dragHandle";
      m.registerByClass();
    });

.. html ::

  <div style="position:absolute; top:80px; left:50px;">
    <h2>Accepts Type1 items</h2>
    <div class="dndArea container" accept="type1">
      <div class="dndItem" dndType="type1">
        <div class="dragHandle">Item Type 1</div>
        <div>
          <p>Proin aliquet accumsan nunc. Duis nec tortor.</p>
        </div>
      </div>
      <div class="dndItem simpleBlock" dndType="type2">
        <div class="dragHandle">Item Type2</div>
        <div>
          <p>Proin aliquet accumsan nunc. Duis nec tortor.</p>
        </div>
      </div>
    </div>

    <div style="position:absolute; top:80px; left:350px;">
      <h2>Accepts Type2 items</h2>
      <div class="dndArea container" accept="type2">
      </div>
    </div>
  </div>

See also
========

* :ref:`dojo.dnd <dojo/dnd>` Drag and Drop
