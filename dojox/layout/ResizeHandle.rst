#format dojo_rst

dojox.layout.ResizeHandle
=========================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2


============
Introduction
============

dojox.layout.ResizeHandle is a small widget to provide resizing of some attached node. It is experimental, and subject to API changes. 

=====
Usage
=====

To use the resize handle, you must include the code:

.. code-block :: javascript
  :linenos:

  dojo.require("dojox.layout.ResizeHandle");

You will likely want to use the default styles as well:

.. code-block :: html
  :linenos:

    <link rel="stylesheet" href="path/to/dojo/dojox/layout/resources/ResizeHandle.css" />

This provides simple styling for your ResizeHandle, and a default handle icon. 

========
Examples
========

Programmatic example
--------------------

This example assumes a node with id="someNodeId" exists, is position:relative, and uses the defaults of ResizeHandle. 

.. code-block :: javascript
  :linenos:

  var handle = new dojox.layout.ResizeHandle({
      targetId:"someNodeId"
  }).placeAt("someNodeId");

Declarative example
-------------------

This example assumes all defaults, and attaches to a parent node. 

.. code-block :: html
  :linenos:

    <div id="someNode">
        <p class="content">Node Content</p>
        <div id="someNodeHandle" dojoType="dojox.layout.ResizeHandle" targetId="someNode"></div>
    </div>

The following CSS must be applied for the above example to work:

.. code-block :: css
  :linenos:

  <style type="text/css">
  #someNode { position:relative; }
  #someNodeHandle { bottom:4px; right:4px; }
  </style>

position:absolute is part of the ResizeHandle.css

============
API Overview
============

ResizeHandle has a lot of options available. Some are entirely experimental, and setting some overrides others in rare cases. This is an attempt to document a potentially changing API scheme.

Targeting a Node
----------------

This widget accepts a number of different options for choosing which node to resize. The first, ``targetId`` is an ID of a node to use. This is first passed through `dijit.byId <dijit>`_, and checked for a widget instance of that id. If nothing is found, a DomNode with that id is searched for. Specifying a ``targetContainer`` will override both, and allow you to pass a DomNode in by direct reference.

Resize Direction
----------------

This widget can [currenty] resize in 3 directions. This is defined by the ``resizeAxis`` parameter. Defaulting to "xy", though you are able to limit movement to X and Y axis changes only by setting "x" and "y" respectively.

.. code-block :: javascript
  :linenos:

  new dojox.layout.ResizeHandle({ resizeAxis:"y", targetId: "foo" }).placeAt("foo");

Constraints
-----------

By default, the resiable will be constrained to a minimum size of 100px x 100px, defined by the ``minWidth`` and ``minHeight`` properties. These are always used, though this will undoubtably change as this widget is extended into considering top/left changes as well.

.. code-block :: javascript
  :linenos:

  new dojox.layout.ResizeHandle({
     targetId: "foo",
     minWidth:125, 
     minHeight:200
  }).placeAt("foo");

In Dojo 1.3 or higher, if you would like to define maximum constraints, use the ``maxWidth`` and ``maxHeight`` properties, though you must explicitly set ``constrainMax`` to "true" to enable this feature. 

.. code-block :: javascript
  :linenos:

  new dojox.layout.ResizeHandle({
     targetId:"foo",
     constrainMax:true, 
     maxHeight:500, maxWidth:300
  }).placeAt("foo");

By specifying a maxHeight/maxWidth at startup, a special instance object is created: ``maxSize``, with "w" and "h" properties. If you wish to dynamically adjust the constraints of the target. Some pseudo-code, illustrating a draggable object within some imaginary constraint:

.. code-block :: javascript
  :linenos:

  var handle = dijit.byId("thatHandle");
  dojo.subscribe("/dojo/dnd/stop", function(n){
      var xy = dojo.coords(handle.targetDomNode);
      handle.maxSize = {
          // calculate new max based on where we are
          w: xy.w - offset, h: xy.w - offset
      }
  }); 

This will adjust the constraints when a node is finished moving, and has had it's position changed.

Experimental, and available in Dojo 1.3 is a ``fixedAspect`` boolean property, which will attempt to retain a resizeable node's aspect ratio while resizing. The ratio is determined when resizing begins, so if the target was resized by another means, the handle will retain whichever current aspect ratio is used. 

Resize Notification
-------------------

event: onResize, property: intermediateChanges:true causes firing frequently.

**New in 1.4** - User-definable topics are published before and after the resize UI is taking placing. The topics default to /dojo/resize/start and /dojo/resize/stop respectively. They can be overridden by defining *startTopci* and *endTopic* members in the constructor on a per-instance basis. The ResizeHandle instance is passed as the only argument to subscribed functions, allowing you to lookup which widget/node/whatever has been resized.

.. code-block :: javascript
  :linenos:

  dojo.subscribe("/dojo/resize/stop", function(inst){
     // inst.targetDomNode is the node resized. sometimes there will be a inst.targetWidget. inst is the ResizeHandle instance.
  });
