.. _dojo/_base/fx:

=============
dojo/_base/fx
=============

.. contents ::
    :depth: 2

**dojo/_base/fx** contains basic animation functions.

anim()
======
A simpler interface to `animateProperty()`.

`anim()` returns an instance of :ref:`dojo/Animation <dojo/Animation>` but begins the animation immediately, unlike nearly every other Dojo animation API.

`anim()` is a simpler (but somewhat less powerful) version of `animateProperty()`. It uses defaults for many basic properties and allows for positional parameters to be used in place of the packed "property bag" which is used for other Dojo animation methods.

The :ref:`dojo/Animation <dojo/Animation>` object returned from `anim()` will be already playing when it is returned from this function, so calling play() on it again is (usually) a no-op.


.. js ::

   require(['dojo/_base/fx'], function(fx){
     fx.anim(node, properties, duration, easing, onEnd, delay);
   });

animateProperty()
=================
`animateProperty()` is a very useful method for animating CSS properties. An example use case is fading a background color from red to green to indicate status changes.

Usage
-----

`animateProperty()`, like all other :ref:`dojo/Animation <dojo/Animation>`'s, uses a "magic object" (or "property bag") to define the base functionality, though introduces a new identifier named ``properties:`` to define which CSS properties to animate.

The syntax follows a simple pattern. The ``properties:`` key is an object hash of css properties to manipulate. The values of those keys have a number of ways of definition.

.. js ::

   require(["dojo/_base/fx"], function(fx){
     fx.animateProperty({
      node:"someId",
      properties: {
        width: 300
      }
    }).play();
   });


The above example will animate a node with id="someId" to width:300px from it's current size. Multiple CSS properties can be animated within the object hash:

.. js ::

  require(["dojo/_base/fx"], function(fx){
    fx.animateProperty({
    node:"someId",
    properties: {
        width: 300,
        height: { end: 400, start:100 },
        fontSize: { end:14, units:"pt" } // beware of stray comma's
    }
   }).play();
  });


As seen, we simply add new keys to the ``properties:`` hash. The above example introduces each of the available syntax options for the value of each property. The ``width`` property have an integer value, which is assumed to be the ``end:`` value, with a ``unit:`` of "px". The ``height`` key is another object hash, defining ``end`` and ``start`` values as integers. Passing a start value will cause the property to go immediately to that value, and animate to the end value, again assuming "px". The ``fontSize`` object hash omits a ``start:`` value, defaulting to the current calculated value, and introduces the ``unit:`` identifier, used to set the measurement to something other than the default "px".

It is also worth noting: when animating multi-word CSS properties such as ``font-size``, JavaScript requires they be converted to the mixed-case: ``fontSize``.

Advanced Properties
-------------------

In addition to being able to use the above syntax to define the properties:{} object, you are able to define functions for the start: and end: members for a given property. The return value from these functions is substituted in for the value.

A simple, though redundant, example:

.. js ::

  require(["dojo/dom-geometry", "dojo/_base/fx"], function(domGeometry, fx){
    fx.animateProperty({
        node:"someNode",
        properties:{
            width:{
                start:function(){
                    // calculate the width before being play'd
                    return domGeometry.marginBox("someNode").w / 2;
                },
                end:function(){
                    return 600;
                }
            }
        }
    }).play();
  });

**new in Dojo 1.4**: `animateProperty()` allows a function to be directly passed to the property:

.. js ::

  require(["dojo/dom-geometry", "dojo/_base/fx"], function(domGeometry, fx){
    fx.animateProperty({
       node:"someNode",
       properties:{
         height: function(node){
           // notice 'node' being passed. Also new in Dojo 1.4
           // can return any animateProperty syntax:
           // return { start:5, end:2 };
           // return 100;
           // return { end:50, units:"pt" }

           // make this node 3x it's current height
           return domGeometry.marginBox(node).h * 3

         }
      }
    }).play();
  });


As pointed out above, the height: function is passed a reference to the domNode being animated. This functionality is new in Dojo 1.4, as well as the addition of the node being passed to the start: and end: functions.

Examples
--------

A simple animation
~~~~~~~~~~~~~~~~~~

A simple animation changing both background color and text color.

.. code-example ::

  .. js ::

      require(["dojo/dom", "dojo/_base/fx"], function(dom, fx){
        statusOk = function(){
          fx.animateProperty({
            node: dom.byId("statusCode"), duration: 500,
            properties: {
              backgroundColor: { start: "red", end: "green" },
              color: { start: "black", end: "white" },
            },
            onEnd: function(){
              dom.byId("statusCode").innerHTML = "Granted";
            }
          }).play();
        };
      });

  .. html ::

      <p><button onclick="statusOk();">Grant access</button></p>
      <div id="statusCode">Denied</div>

  .. css ::

      #statusCode {
          padding: 5px;
          border: 1px solid #000;
          background: red;
          text-align: center;
          width: 100px;
      }

How can I change the framerate of an animation?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default dojo runs its animations with 50 frames/second. This can be too fast in certain use scenarios and you want the whole animation to run lots slower.
To change the framerate you use the rate attribute which defines the pause between each frame. So if you want 5 frames per second you need a rate of 200 (milliseconds between each frame)

.. code-example ::

  .. js ::

      require(["dojo/dom", "dojo/_base/fx"], function(dom, fx){
        animateSlow = function(){
          fx.animateProperty({
            node: dom.byId("animateProperty"), duration: 10000,
            properties: {
              fontSize: { start: "12", end: "30" }
            },
            rate: 1000
          }).play();
        };

        animateDefault = function(){
          fx.animateProperty({
            node: dom.byId("animateProperty"), duration: 10000,
            properties: {
              fontSize: { start: "12", end: "30" }
            }
          }).play();
        };
      });

  .. html ::

     <p>
         <button onclick="animateDefault();">Animate (default fps)</button>
         <button onclick="animateSlow();">Animate (1 fps)</button>
     </p>
     <div id="animateProperty">This will be animated</div>

For more on Animations overall, see the :ref:`FX User Guide <quickstart/Animation>`

fadeIn()
========
This function is a helper function that wraps the `animateProperty()` function to provide an easy interface to fading a node into view on the page.  While this can be done with the `animateProperty()` function, this function is simpler to use and will handle 99% of the cases a fade-in is desired.

Parameters
----------

The `fadeIn()` takes an object as its parameter.  This object defines what dom node to act on, how long the fade in should take (in milliseconds), and an optional easing function.


Return value
------------

The `fadeIn()` function returns an instance of :ref:`dojo/Animation <dojo/Animation>`.  To execute the fadeIn, call the *play()* function on the animation.  This object can be used with other dojo animation functions, such as :ref:`dojo/fx/chain <dojo/fx/chain>` and :ref:`dojo/fx/combine <dojo/fx/combine>` to link it with other effects to perform complex animations.

Examples
--------

Example 1:  Fade in a dom node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-example ::

  .. js ::

      require(["dojo/dom", "dojo/_base/fx", "dojo/on", "dojo/dom-style", "dojo/domReady!"],
      function(dom, fx, on, style){
         // Style the dom node to opacity 0;
         style.set("basicFadeNode", "opacity", "0");

         // Function linked to the button to trigger the fade.
         function fadeIt(){
            style.set("basicFadeNode", "opacity", "0");
            var fadeArgs = {
              node: "basicFadeNode"
            };
            fx.fadeIn(fadeArgs).play();
         }
         on(dom.byId("basicFadeButton"), "click", fadeIt);
      });

  .. html ::

    <button id="basicFadeButton">Fade It In!</button>
    <div id="basicFadeNode" style="width: 100px; height: 100px; background-color: red;"></div>


Example 2:  Fade in a dom node with a custom duration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-example ::

  .. js ::

      require(["dojo/dom", "dojo/_base/fx", "dojo/on", "dojo/dom-style", "dojo/domReady!"],
      function(dom, fx, on, style){
         // Style the dom node to opacity 0;
         style.set("basicFadeNode2", "opacity", "0");

         // Function linked to the button to trigger the fade.
         function fadeIt(){
            style.set("basicFadeNode2", "opacity", "0");
            var fadeArgs = {
              node: "basicFadeNode2",
              duration: 5000,
            };
            fx.fadeIn(fadeArgs).play();
         }
         on(dom.byId("basicFadeButton2"), "click", fadeIt);
      });

  .. html ::

    <button id="basicFadeButton2">Fade It In Slow!</button>
    <div id="basicFadeNode2" style="width: 100px; height: 100px; background-color: red;"></div>



Example 3:  Fade in a dom node with an easing function
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-example ::

  .. js ::

      require(["dojo/dom", "dojo/fx/easing", "dojo/_base/fx", "dojo/on", "dojo/dom-style", "dojo/domReady!"],
      function(dom, easing, fx, on, style){
         // Style the dom node to opacity 0;
         style.set("basicFadeNode3", "opacity", "0");

         // Function linked to the button to trigger the fade.
         function fadeIt(){
            style.set("basicFadeNode3", "opacity", "0");
            var fadeArgs = {
              node: "basicFadeNode3",
              duration: 8000,
              easing: easing.expoOut
            };
            fx.fadeIn(fadeArgs).play();
         }
         on(dom.byId("basicFadeButton3"), "click", fadeIt);
      });

  .. html ::

    <button id="basicFadeButton3">Fade It In Slow with Expo Easing!</button>
    <div id="basicFadeNode3" style="width: 100px; height: 100px; background-color: red;"></div>


fadeOut()
=========
This function is a helper function that wraps the `animateProperty()` function to provide an easy interface to fading a node out of view on the page.  While this can be done with the `animateProperty()` function, this function is simpler to use and will handle 99% of the cases a fade-out is desired.

Parameters
----------

The `fadeOut()` method takes an object as its parameter.  This object defines what dom node to act on, how long the fade out should take (in milliseconds), and an optional easing function.

All standard :ref:`dojo/Animation <dojo/Animation>` events and parameters apply, though *properties:{}* is explicitly set to control opacity, so should be omitted.

Return value
------------

The `fadeOut()` function returns an instance of :ref:`dojo/Animation <dojo/Animation>`.  To execute the fadeOut, call the *play()* function on the animation.  This object can be used with other dojo animation functions, such as :ref:`dojo/fx/chain <dojo/fx/chain>` and :ref:`dojo/fx/combine <dojo/fx/combine>` to link it with other effects to perform complex animations.

Examples
--------

Example 1:  Fade out a dom node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-example ::

  .. js ::

      require(["dojo/dom", "dojo/_base/fx", "dojo/on", "dojo/dom-style", "dojo/domReady!"],
      function(dom, fx, on, style){
         // Function linked to the button to trigger the fade.
         function fadeIt(){
            style.set("basicFadeNode", "opacity", "1");
            var fadeArgs = {
              node: "basicFadeNode"
            };
            fx.fadeOut(fadeArgs).play();
         }
         on(dom.byId("basicFadeButton"), "click", fadeIt);
      });

  .. html ::

    <button id="basicFadeButton">Fade It Out!</button>
    <div id="basicFadeNode" style="width: 100px; height: 100px; background-color: red;"></div>


Example 2:  Fade out a dom node with a custom duration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-example ::

  .. js ::

      require(["dojo/dom", "dojo/_base/fx", "dojo/on", "dojo/dom-style", "dojo/domReady!"],
      function(dom, fx, on, style){
         // Function linked to the button to trigger the fade.
         function fadeIt(){
            style.set("basicFadeNode2", "opacity", "1");
            var fadeArgs = {
              node: "basicFadeNode2",
              duration: 5000,
            };
            fx.fadeOut(fadeArgs).play();
         }
         on(dom.byId("basicFadeButton2"), "click", fadeIt);
      });

  .. html ::

    <button id="basicFadeButton2">Fade It Out Slow!</button>
    <div id="basicFadeNode2" style="width: 100px; height: 100px; background-color: red;"></div>



Example 3:  Fade out a dom node with an easing function
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-example ::

  .. js ::

      require(["dojo/dom", "dojo/fx/easing", "dojo/_base/fx", "dojo/on", "dojo/dom-style", "dojo/domReady!"],
      function(dom, easing, fx, on, style){
         // Function linked to the button to trigger the fade.
         function fadeIt(){
            style.set("basicFadeNode3", "opacity", "1");
            var fadeArgs = {
              node: "basicFadeNode3",
              duration: 10000,
              easing: easing.expoOut
            };
            fx.fadeOut(fadeArgs).play();
         }
         on(dom.byId("basicFadeButton3"), "click", fadeIt);
      });


  .. html ::

    <button id="basicFadeButton3">Fade It Out Slow with Expo Easing!</button>
    <div id="basicFadeNode3" style="width: 100px; height: 100px; background-color: red;"></div>


See also
========

* :ref:`dojo/fx <dojo/fx>`

  Advanced animation functions in dojo/fx

* :ref:`dojox/fx <dojox/fx>`

  More advanced animation functions in dojox/fx

* :ref:`Animation Quickstart <quickstart/Animation>`

  Animation introduction