.. _dojo/_base/fx:

=============
dojo/_base/fx
=============

.. contents ::
    :depth: 2

**dojo/_base/fx** contains basic animation functions.

.. _dojo/_base/fx#anim:

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

.. _dojo/_base/fx#animateproperty:

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

How can I change the frame rate of an animation?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default dojo runs its animations with 50 frames/second. This can be too fast in certain use scenarios and you want the whole animation to run lots slower.
To change the frame rate you use the rate attribute which defines the pause between each frame. So if you want 5 frames per second you need a rate of 200 (milliseconds between each frame)

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

.. _dojo/_base/fx#animation:

Animation
=========

``dojo/_base/fx::Animation`` is a class that has features that allow control of an animation. An instance of the class
is returned from most animation functions.

Features
--------

There are several key properties to the class:

======== =========== ======== ==========================================================================================
Property Type        Default  Description
======== =========== ======== ==========================================================================================
duration Integer     350      How long in milliseconds the animation should take to play.
curve    _Line|Array ``null`` A two element array of start and end values, or a 
                              :ref:`dojo/_base/fx::_Line <dojo/_base/fx#_Line>` instance to be used in the Animation.
easing   Function    ``null`` A Function to adjust the acceleration (or deceleration) of the progress across a 
                              :ref:`dojo/_base/fx::_Line <dojo/_base/fx#_Line>`
repeat   Integer     0        The number of times the animation should repeat (loop).
rate     Integer     20       The rate in milliseconds the Animation should attempt to update.  20ms = 50fps.
delay    Integer     ``null`` The time in milliseconds to wait before starting animation after it has been 
                              ``.play()``\'ed
======== =========== ======== ==========================================================================================

play()
~~~~~~

This method starts the animation and takes two optional arguments:

========= ======== =====================================================================================================
Argument  Type     Description
========= ======== =====================================================================================================
delay     Integer? *Optional* The number of milliseconds to delay before starting the animation.  Defaults to ``0``.
gotoStart Boolean? *Optional* If true, starts the animation from the beginning; otherwise, starts it from its current
                   position.
========= ======== =====================================================================================================

The method returns the instance of ``dojo/_base/fx::Animation``.

pause()
~~~~~~~

This method pauses the running animation and returns the instance of ``dojo/_base/fx::Animation``.

gotoPercent()
~~~~~~~~~~~~~

This method goes to a particular point in the animation and takes up to two arguments:

======== ======== =================================================================================
Argument Type     Description
======== ======== =================================================================================
percent  Decimal  The percentage in decimal notation (between 0.0 and 1.0)
andPlay  Boolean? *Optional* Set to ``true`` to start playing the animation, defaults to ``false``.
======== ======== =================================================================================

The method returns the instance of ``dojo/_base/fx::Animation``.

stop()
~~~~~~

This method stops the playing of an animation and takes one optional argument:

======== ======== =======================================================================
Argument Type     Description
======== ======== =======================================================================
goToEnd  Boolean? *Optional* If ``true``, the animation will end.  Defaults to ``false``.
======== ======== =======================================================================

The method returns the instance of ``dojo/_base/fx::Animation``.

status()
~~~~~~~~

This method returns a string token representation of the status of the animation, one of: ``paused``, ``playing``,
``stopped``.

.. _dojo/_base/fx#_Line:

_Line
=====

A private class object that is used to generate values from a start value to an end value

.. _dojo/_base/fx#fadein:

fadeIn()
========

This function is a helper function that wraps the ``animateProperty()`` function to provide an easy interface to fading a node into view on the page.  While this can be done with the ``animateProperty()`` function, this function is simpler to use and will handle 99% of the cases a fade-in is desired.

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
  :djConfig: async: true, parseOnLoad: false

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
  :djConfig: async: true, parseOnLoad: false

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
  :djConfig: async: true, parseOnLoad: false

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

.. _dojo/_base/fx#fadeout:

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
  :djConfig: async: true, parseOnLoad: false

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
  :djConfig: async: true, parseOnLoad: false

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
  :djConfig: async: true, parseOnLoad: false

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

* :ref:`dojo/fx <dojo/fx>` - Some advanced animation functions

* :ref:`dojox/fx <dojox/fx>` - More advanced animation functions

* `Animation Tutorial <http://dojotoolkit.org/documentation/tutorials/1.7/animation/>`_ - The tutorial to find out about
  Dojo's FX API
