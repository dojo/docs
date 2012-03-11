.. _quickstart/Animation:

================================
Animations and Effects with Dojo
================================

.. contents ::
   :depth: 2

Dojo provides several layers of Animation helpers, starting with Base Dojo (dojo.js), and adding in levels of incremental 
additions through the module system. All Animations in Dojo revolve around a single class: dojo.Animation, which acts as 
the underlying control mechanism for the flexible FX API Dojo provides.

Getting to know dojo.Animation
==============================

As mentioned, dojo.Animation is the foundation class for all Dojo animations. It provides several simple methods good for 
controlling your animation, such as `play`, `pause`, `stop`, and `gotoPercent`. The most simple method which is required 
of all animations is `play`:


.. js ::
  
 require(["dojo/_base/fx"], function(fx){
    var animation = fx.fadeOut({ // returns a dojo._Animation
        // this is an Object containing properties used to define the
        // animation
        node:"aStringId"
    });
    // call play() on the returned _Animation instance:
    animation.play();
 });


You can simplify the above code using chaining, if you don't need to keep the animation object around for later use as follows:

.. js ::
 
    require(["dojo/_base/fx"], function(fx){
        fx.fadeOut({ node:"someId" }).play();
    });

All animations in Dojo (with the exception of :ref:`dojo.anim <dojo/anim>`) use predefined animation properties on 
the Object parameter to specify the animation settings. The `node:` property is the most important, and points to a node 
in the DOM on which to apply the animation. `node` can be a String ID of a DOM node, or a direct reference to a DOM node 
you already have:

.. js ::

    require(["dojo/dom", "dojo/_base/fx"], function(dom, fx){
        var target = dom.byId("someId").parentNode;
        fx.fadeOut({ node: target }).play();
    });

Animation Properties
--------------------

The standard set of properties for specifying animation settings (via the Object parameter to the animation function) are:

:node:
  The domNode reference or string id of a node to apply the animation effects to. **required**

:delay:
  Delay, in milliseconds, before the animation starts.  The default is 0ms. **optional**

:duration:
  How long, in milliseconds, the animation will run.  The default is 350 milliseconds (.35 seconds) **optional**

:easing:
  An easing (timing) function to apply to the effect, such as exponential curve, bounce, etc.  Dojo provides a number of easing functions in the
  :ref:`dojo.fx.easing <dojo/fx/easing>` module. **optional**

:rate:
  By default dojo runs its animations with 50 frames/second. This can be too fast in certain scenarios when want the whole animation to run a lot
  slower. To change the framerate you use the rate property which defines the pause/delay between each frame. Ex. if you want 5 frames per second you
  should specify a rate of 200 (milliseconds between each frame **optional**

:repeat:
  How many times the animation will be played.  Default: 0. **optional**

:curve:
  An array two values, or an instance of a `dojo._Line`. Used as the start and end points for a given animation. Typically not used directly by
  end-users, though allows usage of the Animation class outside of Node effects

Animation Events
----------------

Performing custom behavior at specific points during an animation is done using callback functions (also set via the Object parameter to the animation function).  These functions will be executed at various stages during an animation's life-cycle.

The standard set of events that are fired during stages of an animation are:

+-------------------------------+--------------------------------------------------------------------------------------------+
+**Property**                   |**Description**                                                                             |
+-------------------------------+--------------------------------------------------------------------------------------------+
| beforeBegin                   |A callback function which will be executed synchronously before playing the animation.      |
|                               |                                                                                            |
|                               |**optional** **new in 1.4**: passed node reference for the animation                        |
+-------------------------------+--------------------------------------------------------------------------------------------+
| onBegin                       |A callback function which will be executed asynchronously immediately after starting the    |
|                               |animation.                                                                                  |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| onEnd                         |A callback function which will be executed synchronously when the animation ends.           |
|                               |                                                                                            |
|                               |**optional**  **new in 1.4**: passed node reference for the animation                       |
+-------------------------------+--------------------------------------------------------------------------------------------+
| onPlay                        |A callback function which will be executed synchronously when the animation is played.      |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| onAnimate                     |A callback function fired for every step of the animation, passing                          |
|                               |a value from a dojo._Line for this animation.                                               |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+

Consider this simple fade animation, and all the potential callbacks registered:

.. js ::
  
    require(["dojo/_base/fx"], function(fx){
        fx.fadeOut({

            // some node, by id to animate:
            node:"someId",
            beforeBegin: function(){
                // executed synchronously before playing
            },
            onBegin: function(){
                // executed asynchronously immediately after starting
            },
            onEnd: function(){
                // executed when the animation is done
            },
            onPlay: function(){
                // executed when the animation is played
            },        
            onAnimate: function(values){
                // fired for every step of the animation, passing
                // a value from a dojo._Line for this animation
            }

        }).play();
  });

You can define these callback functions as part of the Object parameter used to define the animation initially (as seen 
above) or use :ref:`dojo.connect <dojo/connect>` to connect directly to the instance and listen for the function calls.

.. js ::
  
    require(["dojo/_base/fx", "dojo/_base/connect"], function(fx, connect){
        var animation = fx.fadeOut({ node:"someNodebyId" });
        connect.connect(animation, "onEnd", function(){
            // connect externally to this animation instance's onEnd function
        });
        animation.play(); // start it up
    });

The onEnd and beforeBegin events are fired passing a reference to the node being animated so that you may more easily manipulate a node immediately before or after an animation (``1.4+``):

.. js ::
  
    require(["dojo/_base/fx"], function(fx){
        fx.fadeOut({
            node:"foo",
            onEnd: function(n){
                n.innerHTML = "";
            },
            beforeBegin: function(n){
                n.innerHTML = "Bye!";
            }
        }).play();
    });


Base Animations
===============

Base Dojo provides the animation framework as well as several simple helper animations for fading, and one incredibly useful function `dojo.animateProperty` (the workhorse of most CSS-based animations). All use the same Object parameter format for specifying properties of the animation, and several additional options are used in advanced cases.

Fading Example
--------------

To fade out a node, alter it's contents, and fade it back in:

.. js ::
  
 require(["dojo/_base/fx", "dojo/dom"], function(fx, dom){
    var node = dom.byId("someId");
    fx.fadeOut({
        node: node,
        onEnd: function(){
            node.innerHTML = "<p>Like magic!</p>"
            dojo.fadeIn({
                node: node
            }).play()
        }
    }).play();
 });

Here, we've created a fadeOut animation, and run it immediately. At the end of the animation (set here to use the default duration by omitting the `duration:` parameter), we set the node reference's `.innerHTML` property to something new, and fade it back in, again using the default duration.

Animating CSS Properties
------------------------

In addition to generic animations, Dojo provides shorthand helper functions for animating CSS properties via the :ref:`animateProperty <dojo/animateProperty>` API. An example where this specialized animation API simplifies specifying animation would be when you need to fade a background color property from red to green to indicate status changes.


Core Animations: Advanced helpers
=================================

Above the Base Animations (those contained entirely within dojo.js), there are several modules
available within the toolkit for advanced animation control.

To use these extended functions, you must require the `dojo.fx` module:

.. js ::
  
 require(["dojo/_base/fx", "dojo/fx"], function(fx, coreFx){
    // write your code here
 });
 
The animation methods used to declared in `dojo.fx` namespace should be called separately in dojo 1.7.

+-------------------------------+--------------------------------------------------------------------------------------------+
+**Method**                     |**Usage**                                                                                   |
+-------------------------------+--------------------------------------------------------------------------------------------+
| fadeIn                        |require(["**dojo/_base/fx**"], function(fx){                                                |
|                               |fx.fadeIn("SomeNode");});                                                                   |
+-------------------------------+--------------------------------------------------------------------------------------------+
| fadeOut                       |require(["**dojo/_base/fx**"], function(fx){                                                |
|                               |fx.fadeIn("SomeNode");});                                                                   |
+-------------------------------+--------------------------------------------------------------------------------------------+
| combine                       |require(["**dojo/fx**"], function(coreFx){                                                  |
|                               |coreFx.combine("anim1", "anim2").play();});                                                 |
+-------------------------------+--------------------------------------------------------------------------------------------+
| wipeIn                        |require(["**dojo/fx**"], function(coreFx){                                                  |
|                               |coreFx.wipeIn(node:"someId").play();});                                                     |
+-------------------------------+--------------------------------------------------------------------------------------------+
| wipeOut                       |require(["**dojo/fx**"], function(coreFx){                                                  |
|                               |coreFx.wipeOut(node:"someId").play();});                                                    |
+-------------------------------+--------------------------------------------------------------------------------------------+
| slideTo                       |require(["**dojo/fx**"], function(coreFx){                                                  |
|                               |coreFx.slideTo({node: node, left:"40", top:"50", units:"px"}).play();});                    |
+-------------------------------+--------------------------------------------------------------------------------------------+



The namespace `dojo.fx` has been reserved for all these animation, including `dojo.fx.chain` and `dojo.fx.combine`.


Chaining and Combining Animations
=================================

Two convenience functions provided in the `dojo.fx` module named `combine` and `chain` create an animation from a series of animations in an array.

`combine` merges the array of animations them into one animation instance to control them all in parallel, whereas `chain` merges the animations into a single animation, playing back each of the animations in series, or one right after the other.

To fade out two nodes simultaneously:

.. js ::
  
 require(["dojo/_base/fx", "dojo/fx", "dojo/ready"], function(fx, coreFx, ready){
    ready(function(){
        // create two animations
        var anim1 = fx.fadeOut({ node: "someId" });
        var anim2 = fx.fadeOut({ node: "someOtherId" });
        // and play them at the same moment
        coreFx.combine([anim1, anim2]).play();
    });
 });

(Notice we wrapped the animation call in and addOnLoad function this time. This is required always, as you cannot modify the DOM before the DOM is ready, which :ref:`addOnLoad <dojo/addOnLoad>` alerts us to. Also, we need to ensure the `dojo.fx` module has been loaded properly)

JavaScript is rather flexible about return values and where functions are called. The above example can alternatively be written in a shorthand like:

.. js ::
  
 require(["dojo/_base/fx", "dojo/fx", "dojo/ready"], function(fx, coreFx, ready){
    ready(function(){
        // create and play two fade animations at the same moment
        coreFx.combine([
            fx.fadeOut({ node: "someId" }),
            fx.fadeOut({ node: "someOtherId" })
        ]).play();
    });
 });

The same rules apply to a combined animation as do a normal animation, though with no direct way to mix event callbacks into the combine() call, you are left using the `dojo.connect` method to attach event handlers:

.. js ::
  
 require(["dojo/_base/fx", "dojo/_base/connect", "dojo/fx"], function(fx, connect, coreFx){
    var anim = coreFx.combine([
        fx.fadeOut({ node: "id", duration:1000 }),
        fx.fadeIn({ node: "otherId", duration:2000 })
    ]);
    connect.connect(anim, "onEnd", function(){
        // fired after the full 2000ms
    });
 });

Alternately, you can mix event handlers into your individual animations passed to dojo.fx.combine:

.. js ::
  
 require(["dojo/_base/fx", "dojo/fx"], function(fx, coreFx){
    var animA = fx.fadeOut({
        node:"someNode",
        duration: 500,
        onEnd: function(){
            // fired after 500ms
        }
    });
    var animB = fx.fadeIn({ node:"otherNode" });
    coreFx.combine([animA, animB]).play();
 });

Chain works in much the same way - though plays each animation one right after the other:

.. js ::
  
 require(["dojo/_base/fx", "dojo/fx"], function(fx, coreFx){
    coreFx.chain([
        fx.fadeIn({ node: "foo" }),
        fx.fadeIn({ node: "bar" })
    ]).play();
 });

All of the same patterns apply to chain as to other animation instances.

combine and chain accept an Array, and will work on a one-element array. This is interesting because you can manually create animations, pushing each into the array, and chain or combine the resulting set of animations. This is useful when you need to conditionally exclude some Animations from being created:

.. js ::
  
 require(["dojo/_base/array", "dojo/_base/fx", "dojo/fx"], function(array, fx, coreFx){
    // create the array
    var anims = [];
    // simulated condition, an array of id's:
    array.forEach(["one", "two", "three"], function(id){
        if(id !== "two"){
            // only animate id="one" and id="three"
            anims.push(fx.fadeOut({ node: id }));
        }
    });
    // combine and play any available animations waiting
    coreFx.combine(anims).play();
 });

Obviously, any logic for determining if a node should participate in an animation sequence is in the realm of the developer, but the syntax should be clear. Create an empty Array, push whichever style and types of animations you want into the Array, and call combine() on the list.

Example
-------

.. code-example ::

  .. js ::

    require(["dojo/query", "dojo/_base/fx", "dojo/fx", "dojo/domReady!"], function(query, fx, coreFx){
        var demoDoit = function(){
            var int = 175;
            var delay = 300;
            var anims = [];
            query(".entry p").reverse()
                .forEach(function(n){
                    anims.push(fx.fadeOut({ node:n, delay: parseInt(delay), duration:420 }));
                    delay += int;
                }).reverse().forEach(function(n){
                    delay += int;
                    anims.push(fx.animateProperty({
                        node:n,
                        delay: parseInt(delay),
                        duration:500, properties: { height:1 } 
                    }));
                });
            coreFx.combine(anims).play();
        };
        demoDoit();
    });

  .. html ::

    <div class="entry">
        <p>Lorem ipsum dolor sit amet</p><p>Lorem ipsum dolor sit amet</p>
        <p>Lorem ipsum dolor sit amet</p><p>Lorem ipsum dolor sit amet</p>
        <p>Lorem ipsum dolor sit amet</p><p>Lorem ipsum dolor sit amet</p>
        <p>Lorem ipsum dolor sit amet</p><p>Lorem ipsum dolor sit amet</p>
        <p>Lorem ipsum dolor sit amet</p><p>Lorem ipsum dolor sit amet</p>
        <p>Lorem ipsum dolor sit amet</p><p>Lorem ipsum dolor sit amet</p>
    </div>

Animation Easing
================

Have you ever wanted to perform an animated effect such as fade out, fade in, wipe in, but apply the effect in a non-linear way? For example, wouldn't it be cool to have a fade in accelerate the rate at which the node appears the further along in the animation duration it is, or provide a bit of bounce to your slide in animation? The functions which control the timing of the animation is handled through the 'easing' property of the arguments passed to the animation creation functions.

Instead of having to write the easing function yourself, dojo provides a collection of standard easing functions to use as this parameter to get a variety of effects.  See :ref:`Easing functions <dojo/fx/easing>` for more information on the easing function provided out of the box.


Text Effects
============

As mentioned above, the dojox/fx module provides additional effects over and beyond these basic animation capabilities.  On of the effects in the dojox package that is especially neat is effects that can operate on text directly, which can allow you to easily do animations such as exploding all the characters in a paragraph all over your page.  Make sure to check out these additional text effects once you understand the basics.


Animation in Dijit Widget 1.5+
==============================

Using the latest in CSS3 along with the Dojo APIs increases the performance of animation and makes it easier for designers to code the animation using CSS3.

See details on application of animation in specific Digits in :ref:`Themes and theming <dijit/themes>`.

See Also
========

* :ref:`dojo.fx <dojo/fx>`
* :ref:`dojox.fx <dojox/fx>`
* :ref:`dojo.NodeList-fx <dojo/NodeList-fx>`
