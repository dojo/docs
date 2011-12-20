.. _dojox/widget/FisheyeLite:

========================
dojox.widget.FisheyeLite
========================

:Project owner: Peter Higgins
:since: 1.1

.. contents ::
   :depth: 2

A lightweight Fisheye effect component which animates during mouse movement over the widget.


Introduction
============

This is a very small class component which adds behavior to some node. This is a "behavioral widget" in that is does little more than register events on a node, and controls the existing markup.

This widget currently works by passing key/value pairs of css properties and ratios to a properties: object declared for the instance. The default is ``fontSize:1.25``, which will cause the calculated ``font-size`` CSS property to scale to 1.25 times the original size on mouseover, and restore the font to the original place onmouseout.

In Dojo 1.3, passing an object as a named property allows better definition of the end values. The default behavior is still to multiply by ratio, but now one is able to specify a fixed end:, start: or unit: value to be passed directly to the animation.

Usage
=====

To load this widget code:

.. js ::
  
  dojo.require("dojox.widget.FisheyeLite");

``note:`` NO CSS is required for this widget to operate. You must style your own nodes. This effect is behavioral.

Any CSS properties can be modified, by default in multipliers. Some CSS "setup" is required in order to properly utilize this widget. For instance, if a series of list-items in an unordered-list have position:absolute, left:2px in their 'natural' state, a ``properties:{ left:10 }`` parameter passed would cause the left value to be 20px when moused over.

New in Dojo 1.3, you can optionally specify an object (instead of a multiplier) of values to pass directly to the animation. You are still required to style the nodes accordingly for the 'natural' state, but can specify direct end: values for a property. eg 'left':

.. js ::
  
  new dojox.widget.FisheyeLite({ properties: { left: { end:100, unit:"px" } } }, "someNode");


Examples
========

Programmatic example
--------------------

The nature of this widget is typically to repeat patterns throughout a Node. Going back to the original unordered-list mentioned initially, an easy way to set the FisheyeLite on all list-items in a list:

.. js ::
  
  dojo.ready(function(){
      dojo.query("#myList li").instantiate(dojox.widget.FisheyeLite, { properties:{ left:10 } });
  });

You can also instantiate a FisheyeLite as you would any standard Dijit:

.. js ::
  
  var fish = new dojox.widget.FisheyeLite({ properties:{ top:5 } }, "someNode");

The previous examples used a multiplier value (10 and 5, respectively). Passing an object for each property allows you to simply "animate to some point":

.. js ::
  
   var fish = new dojox.widget.FisheyeLite({
       properties:{
           height:{
              end:200, unit:"px"
           }
       }
   }, "someId");

This will animate a node from it's natural height to 200px (on hover), then back to natural on leave.

Declarative example
-------------------

Simply add a ``data-dojo-type``:

.. html ::
  
    <ul>
       <li data-dojo-type="dojox.widget.FisheyeLite" data-dojo-props="properties:{left:10}">hi</li>
    </ul>

When instantiating, either programmatically or declaratively, the source DOM Node (with the data-dojo-type, or the widget.domNode member) becomes the target node for the animations. Alternately, you can supply a target somewhere within the sourceNode by adding a class ``fisheyeTarget`` to some node.

.. html ::
    
    <ul>
       <li data-dojo-type="dojox.widget.FisheyeLite" data-dojo-props="properties:{height:10}">
           <p>Content</p><div class="fisheyeTarget">target for animations</div>
       </li>
    </ul>

This will cause the inner DIV to be the target of the animations when the LI is hovered.

Behavioral Widget
-----------------

This widget is one of the few official widgets which utilize the optional parameter to pass to .destroy(). Typically, calling .destroy() on a Widget will remove the original DOM Node from the document. By passing ``true`` (preserveDom), we are able to cleanly remove the Fisheye effect from a node, optionally restoring it later in a different form.

.. html ::
  
   var fish = dijit.byId("someId");
   // leave the node id="someId" alone, just remove FX
   fish.destroy(true);

   // make a new, different fisheye effect on someId:
   fish = new dojox.widget.FisheyeLite({}, "someId");

See also
========

* :ref:`FisheyeList <dojox/widget/FisheyeList>` is a heavier, more-Dock-like variation on this widget.
