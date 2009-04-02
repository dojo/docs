#format dojo_rst

Animations with Dojo
====================

:Status: Draft
:Version: 1.0

.. contents::
   :depth: 2

Dojo provides several layers of Animation helpers, starting with Base Dojo (dojo.js), and adding in levels of incremental additions through the module system. All Animations in Dojo revolve around a single class: dojo._Animation. The underscore denotes a private constructor, and is not meant to be created directly, but rather used as the underlying control mechanism for the flexible FX API Dojo provides.


===============================
Getting to know dojo._Animation
===============================

As mentioned, dojo._Animation is the foundation for all Dojo Animations. It provides several simple methods good for controlling your animation, such as `play`, `pause`, `stop`, and `gotoPercent`. The most simple method which is required of all animations is `play`:

.. code-block :: javascript
	:linenos:
	
	var animation = dojo.fadeOut({ // returns a dojo._Animation 
		// this is an Object containing properties used to define the animation
		node:"aStringId"
	});
	// call play() on the returned _Animation instance:
	animation.play();
	
You can simplify the above code using chaining, if you don't need to keep the animation object around for later use as follows:

.. code-block :: javascript
	:linenos:
	
	dojo.fadeOut({ node:"someId" }).play();
	
All animations in Dojo (with the exception of dojo.anim, introduced in Dojo 1.2) use predefined animation properties on the Object parameter to specify the animation settings. The `node:` property is the most important, and points to a node in the DOM on which to apply the animation. `node` can be a String ID of a DOM node, or a direct reference to a DOM node you already have:

.. code-block :: javascript
	:linenos:
		
	var target = dojo.byId("someId").parentNode;
	dojo.fadeOut({ node: target }).play();

Animation Properties
--------------------

The standard set of properties for specifying animation settings (via the Object parameter to the animation function) are:
+-------------------------------+--------------------------------------------------------------------------------------------+
+**Property**                   |**Description**                                                                             |
+-------------------------------+--------------------------------------------------------------------------------------------+
| node                          |The domNode or node id to apply the animation effects to.                                   |
|                               |                                                                                            |
|                               |**required**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| delay                         |Delay, in milliseconds, before the animation starts.  The default is 0ms.                   |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| duration                      |How long, in milliseconds, the animation will run.  The default is 2000 milliseconds        |
|                               |(2 seconds).                                                                                |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| easing                        |An easing (timing) function to apply to the effect, such as exponential curve, bounce,      |
|                               |etc.  Dojo provides a number of easing functions in module                                  |
|                               |`dojo.fx.easing <dojo/fx/easing>`_                                                          |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| rate                          |`TODOC:`                                                                                    |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| repeat                        |How many times the animation will be played.  Default: 0.                                   |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| curve                         |`TODOC:`                                                                                    |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+

The standard set of events that are fired during stages of an animation are:
+-------------------------------+--------------------------------------------------------------------------------------------+
+**Property**                   |**Description**                                                                             |
+-------------------------------+--------------------------------------------------------------------------------------------+
| beforeBegin                   |A callback function which will be executed synchronously before playing the animation.      |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| onBegin                       |A callback function which will be executed asynchronously immediately after starting the    |
|                               |animation.                                                                                  |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| onEnd                         |A callback function which will be executed synchronously when the animation ends.           |
|                               |                                                                                            |
|                               |**optional**                                                                                |
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

`API reference for _Animation <http://api.dojotoolkit.org/jsdoc/dojo/1.2/dojo._Animation>`_

Animation Events
----------------

Performing custom behavior at specific points during an animation is done using callback functions.  These functions will be executed at various stages during an animation's life-cycle. 

Consider this simple fade animation, and all the potential callbacks registered:

.. code-block :: javascript
  :linenos:

  dojo.fadeOut({ 

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

You can define these callback functions as part of the Object parameter used to define the animation initially (as seen above) or use `dojo.connect <dojo/connect>`_ to connect directly to the instance and listen for the function calls.

.. code-block :: javascript
	:linenos:
	
	var animation = dojo.fadeOut({ node:"someNodebyId" });
	dojo.connect(animation, "onEnd", function(){
	 	// connect externally to this animation instance's onEnd function
	});
	animation.play(); // start it up


===============	
Base Animations
===============

Base Dojo provides the animation framework as well as several simple helper animations for fading, and one incredibly useful function `dojo.animateProperty` (the workhorse of most CSS-based animations). All use the same Object parameter format for specifying properties of the animation, and several additional options are used in advanced cases. 

Fading Example
--------------

To fade out a node, alter it's contents, and fade it back in:

.. code-block :: javascript
	:linenos:
	
	var node = dojo.byId("someId");
	dojo.fadeOut({
		node: node,
		onEnd: function(){
			node.innerHTML = "<p>Like magic!</p>"
			dojo.fadeIn({
				node: node
			}).play()
		}
	}).play();

Here, we've created a fadeOut animation, and run it immediately. At the end of the animation (set here to use the default duration by omitting the `duration:` parameter), we set the node reference's `.innerHTML` property to something new, and fade it back in, again using the default duration. 

animateProperty Intro
---------------------

`TODOC`


=================================
Core Animations: Advanced helpers
=================================

Above the Base Animations (those contained entirely within dojo.js), there are several modules 
available within the toolkit for advanced animation control. 

To use these extended functions, you must include the `dojo.fx` module:

.. code-block :: javascript
	:linenos:
	
	dojo.require("dojo.fx");

The namespace `dojo.fx` has been reserved for all these animation, including `dojo.fx.chain` and `dojo.fx.combine`. 


=================================
Chaining and Combining Animations
=================================

Two convenience functions provided in the `dojo.fx` module named `combine` and `chain` create an animation from a series of Animations in an array. 

`combine` merges the array of animations them into one `dojo._Animation` instance to control them all in parallel, whereas `chain` merges the animations into a single `dojo._Animation`, playing back each of the animations in series, or one right after the other.

To fade out two nodes simultaneously:

.. code-block :: javascript
	:linenos:
	
	dojo.require("dojo.fx");
	dojo.addOnLoad(function(){
		// create two animations
		var anim1 = dojo.fadeOut({ node: "someId" });
		var anim2 = dojo.fadeOut({ node: "someOtherId" });
		// and play them at the same moment
		dojo.fx.combine([anim1, anim2]).play();
	});

(Notice we wrapped the animation call in and addOnLoad function this time. This is required always, as you cannot modify the DOM before the DOM is ready, which `addOnLoad <dojo/addOnLoad>`_ alerts us to. Also, we need to ensure the `dojo.fx` module has been loaded properly)

Javascript is rather flexible about return values and where functions are called. The above example can alternatively be written in a shorthand like:

.. code-block :: javascript
	:linenos:

	dojo.require("dojo.fx");
	dojo.addOnLoad(function(){
		// create and play two fade animations at the same moment
		dojo.fx.combine([
			dojo.fadeOut({ node: "someId" }),
			dojo.fadeOut({ node: "someOtherId" })
		]).play();
	});

The same rules apply to a combined animation as do a normal _Animation, though with no direct way to mix event callbacks into the combine() call, you are left using the `dojo.connect` method to attach event handlers:

.. code-block :: javascript
	:linenos:
	
	var anim = dojo.fx.combine([
		dojo.fadeOut({ node: "id", duration:1000 }),
		dojo.fadeIn({ node: "otherId", duration:2000 })
	]);
	dojo.connect(anim, "onEnd", function(){
		// fired after the full 2000ms
	});

Alternately, you can mix event handlers into your individual animations passed to dojo.fx.combine:

.. code-block :: javascript
	:linenos:
	
	var animA = dojo.fadeOut({
		node:"someNode",
		duration: 500,
		onEnd: function(){
			// fired after 500ms
		}
	});
	var animB = dojo.fadeIn({ node:"otherNode" });
	dojo.fx.combine([animA, animB]).play();

Chain works in much the same way - though plays each animation one right after the other:

.. code-block :: javascript
	:linenos:
	
	dojo.fx.chain([
		dojo.fadeIn({ node: "foo" }), 
		dojo.fadeIn({ node: "bar" })
	]).play();

All of the same patterns apply to chain as to other dojo._Animation instances. A good article covering `advanced usage of combine and chain <http://dojocampus.org/content/2008/04/11/staggering-animations/>`_ is available at DojoCampus. 

combine and chain accept an Array, and will work on a one-element array. This is interesting because you can manually create animations, pushing each into the array, and chain or combine the resulting set of animations. This is useful when you need to conditionally exclude some Animations from being created:

.. code-block :: javascript
	:linenos:
	
	// create the array
	var anims = [];
	// simulated condition, an array of id's:
	dojo.forEach(["one", "two", "three"], function(id){
		if(id !== "two"){
			// only animate id="one" and id="three"
			anims.push(dojo.fadeOut({ node: id }));
		}
	});
	// combine and play any available animations waiting
	dojo.fx.combine(anims).play();

Obviously, any logic for determining if a node should participate in an Animation sequence is in the realm of the developer, but the syntax should be clear. Create an empty Array, push whichever style and types of animations you want into the Array, and call combine() on the list. 


================
Animation Easing
================

`TODOC`
