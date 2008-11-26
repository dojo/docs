#format dojo_rst

dojox.widget.FisheyeLite
========================

:Status: Draft
:Version: 1.0
:Project owner: Peter Higgins
:Available: since 1.1

.. contents::
   :depth: 2

A lightweight Fisheye effect component which animates during mouse movement over the widget. 


============
Introduction
============

This is a very small class component which adds behavior to some node. This is a "behavioral widget" in that is does little more than register events on a node, and controls the existing markup. 

This widget currently works by passing key/value pairs of css properties and ratios to a properties: object declared for the instance. The default is ``fontSize:1.25``, which will cause the calculated ``font-size`` CSS property to scale to 1.25 times the original size on mouseover, and restore the font to the original place onmouseout. 

=====
Usage
=====

To load this widget code:

.. code-block :: javascript
  :linenos:

  dojo.require("dojox.widget.FisheyeLite");

``note:`` NO CSS is required for this widget to operate. You must style your own nodes. This effect is behavioral.

Any CSS properties can be modified, but only in multipliers. Some CSS "setup" is required in order to properly utilize this widget. For instance, if a series of list-items in an unorder-list have position:absolute, left:2px in their 'natural' state, a ``properties:{ left:10 }`` parameter passed would cause the left value to be 20px when moused over. 

``note:`` the 'multipliers-only`` issue is limiting, and planned to be addressed, while still retaining the original functionality of the widget. 

========
Examples
========

Programmatic example
--------------------

The nature of this widget is typically to repeat patterns throughout a Node. Going back to the original unordered-list mentioned initially, an easy way to set the FisheyeLite on all list-items in a list:

.. code-block :: javascript
  :linenos:

  dojo.addOnLoad(function(){
      dojo.query("#myList li").instantiate(dojox.widget.FisheyeLite, { properties:{ left:10 } });
  });

You can also instantiate a FisheyeLite as you would any standard Dijit:

.. code-block :: javascript
  :linenos:

  var fish = new dojox.widget.FisheyeLite({ properties:{ top:5 } }, "someNode");

Declarative example
-------------------

Simply add a ``dojoType``:

.. code-block :: html
  :linenos:

    <ul>
       <li dojoType="dojox.widget.FisheyeLite" properties="left:10">hi</li>
    </ul>

When instantiating, either programatically or declaratively, the source DOM Node (with the dojoType, or the widget.domNode member) becomes the target node for the animations. Alternately, you can supply a target somewhere within the sourceNode by adding a class ``dojoxFisheyeTarget`` to some node. 

Behavioral Widget
-----------------

This widget is one of the few official widgets which utilize the optional parameter to pass to .destroy(). Typically, calling .destroy() on a Widget will remove the original DOM Node from the document. By passing ``true`` (preserveDom), we are able to cleanly remove the Fisheye effect from a node, optionally restoring it later in a different form. 

.. code-block :: html
  :linenos:

   var fish = dijit.byId("someId");
   // leave the node id="someId" alone, just remove FX
   fish.destroy(true);

   // make a new, different fisheye effect on someId:
   fish = new dojox.widget.FisheyeLite({}, "someId");

========
See also
========

* `FisheyeList <dojox/widget/FisheyeList>`_ is a heaver, more-Dock-like variation on this widget.
