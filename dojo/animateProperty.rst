#format dojo_rst

dojo.animateProperty
====================

:Status: Draft
:Version: 1.2
:Available: since V?

.. contents::
    :depth: 2

dojo.animateProperty is a very useful method for animating CSS properties. An example use case is fading a background color from red to green to indicate status changes.


=====
Usage
=====

animateProperty, like all other dojo._Animations, use a "magic object" (or "property bag") to define the base functionality, though introduces a new identifier named ``properties:`` to define which CSS properties to animate.

The syntax follows a simple pattern. The ``properties:`` key is an object hash of css properties to manipulate. The values of those keys have a number of ways of definition. 

.. code-block :: javascript
  :linenos:

  dojo.animateProperty({ 
    node:"someId",
    properties: {
        width: 300
    }
  }).play();

The above example will animate a node with id="someId" to width:300px from it's current size. Multiple CSS properties can be animated within the object hash:

.. code-block :: javascript
  :linenos:

  dojo.animateProperty({ 
    node:"someId",
    properties: {
        width: 300,
        height: { end: 400, start:100 },
        fontSize: { end:14, unit:"pt" } // beware of stray comma's
    }
  }).play();

As seen, we simply add new keys to the ``properties:`` hash. The above example introduces each of the available syntax options for the value of each property. The ``width`` property have an integer value, which is assumed to be the ``end:`` value, with a ``unit:`` of "px". The ``height`` key is another object hash, defining ``end`` and ``start`` values as integers. Passing a start value will cause the property to go immediately to the value, and animate to to end value, again assuming "px". The ``fontSize`` object hash omits a ``start:`` value, defaulting to the current calculated value, and introduces the ``unit:`` identifier, used to set the measurement to something other than the default "px". 

It is also worth noting: when animating multi-word CSS properties such as ``font-size``, Javascript requires they be converted to the mixed-case: ``fontSize``. 

========
Examples
========

A simple animation
------------------

A simple animation changing both background color and text color.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // we require the button to make our demo look fancy
    
    function statusOk(){
      dojo.animateProperty({
        node: dojo.byId("statusCode"), duration: 500,
        properties: {
          backgroundColor: { start: "red", end: "green" },
          color: { start: "black", end: "white" },
        },
        onEnd: function(){
          dojo.byId("statusCode").innerHTML = "Granted";
        }
      }).play();
    }
    </script>

  .. cv:: html

    <p><button dojoType="dijit.form.Button" onClick="statusOk()">Grant access</button></p>
    <div id="statusCode">Denied</div>

  .. cv:: css

    <style type="text/css">
    #statusCode {
      padding: 5px;
      border: 1px solid #000;
      background: red;
      text-align: center;
      width: 100px;
    }
    </style>

How can I change the framerate of an animation?
-----------------------------------------------

By default dojo runs its animations with 100 frames/second. This can be too fast in certain use scenarios and you want the whole animation to run lots slower. 
To change the framerate you use the rate attribute which defines the pause between each frame. So if you want 5 frames per second you need a rate of 200 (miliseconds between each frame)

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // we require the button to make our demo look fancy
    
    function animateSlow(){
      dojo.animateProperty({
        node: dojo.byId("animateProperty"), duration: 10000,
        properties: {
          fontSize: { start: "12", end: "30" }
        },
        rate: 1000
      }).play();
    }

    function animateDefault(){
      dojo.animateProperty({
        node: dojo.byId("animateProperty"), duration: 10000,
        properties: {
          fontSize: { start: "12", end: "30" }
        }
      }).play();
    }
    </script>

  .. cv:: html

    <p><button dojoType="dijit.form.Button" onClick="animateDefault()">Animate (default fps)</button> <button dojoType="dijit.form.Button" onClick="animateSlow()">Animate (1 fps)</button></p>
    <div id="animateProperty">This will be animated</div>

For more on Animations overall, see the `FX User Guide <quickstart/Animation>`_
