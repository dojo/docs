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

If you would like to define maximum constraints, use the ``maxWidth`` and ``maxHeight`` properties, though you must explicitly set ``constrainMax`` to "true" to enable this feature.

  new dojox.layout.ResizeHandle({
     targetId:"foo",
     constrainMax:true, 
     maxHeight:500, maxWidth:300
  }).placeAt("foo");

Experimental, and available in Dojo 1.3 is a ``fixedAspect`` boolean property, which will attempt to retain a resizeable node's aspect ratio while resizing. It currently only works with 1:1 aspect ratios. 

Resize Notification
-------------------

event: onResize, property: intermediateChanges:true causes firing frequently.
