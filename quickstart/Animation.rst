#format dojo_rst

====================
Animations with Dojo
====================

Dojo provides several layers of Animation helpers, starting with Base Dojo (dojo.js), and adding in levels of incremental additions through the module system. All Animations in Dojo revolve around a single class: dojo._Animation. The underscore denotes a private constructor, and is not meant to be created directly, but rather used as the underlying control mechanism for the flexible FX API Dojo provides.

Getting to know dojo._Animation
-------------------------------

As mentioned, dojo._Animation is the foundation for all Dojo Animations. It provides several simple methods good for controlling your animation, such as `play`, `pause`, `stop`, and `gotoPercent`. The most simple, and required of all animations is `play`:

.. code-block :: javascript
	:linenos:
	
	var animation = dojo.fadeOut({ // returns a dojo._Animation 
		// this is the "magic object" used to define the animation
		node:"aStringId"
	});
	// call play() on the returned _Animation instance:
	animation.play();
	
If you are into chaining, and don't need the variable pointing to the animation instance, you can simply call .play() immediately after creation:

.. code-block :: javascript
	:linenos:
	
	dojo.fadeOut({ node:"someId" }).play();
	
All Animations in Dojo (with the exception of dojo.anim, introduced in Dojo 1.2) use the "magic object" as a means of configuration. The `node:` parameter is the most important, and points to a node in the DOM on which to apply the animation. It can be a string ID of a DOM node, or a direct reference to a DOM node you already have:

.. code-block :: javascript
	:linenos:
		
	var target = dojo.byId("someId").parentNode;
	dojo.fadeOut({ node: target }).play();

Animation Options, or "Magic Object"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Animation Events
~~~~~~~~~~~~~~~~

The next most important public-facing aspect of the "private" _Animation class is the event handling: stub functions fired at various stages of an animation's life-cycle. 

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

You can define them as part of the "magic object" used to define the animation initially (as seen above) or use `dojo.connect <dojo/connect>`_ to connect directly to the instance and listen 
for the function calls.

.. code-block :: javascript

	var animation = dojo.fadeOut({ node:"someNodebyId" });
	dojo.connect(animation, "onEnd", function(){
	 	// connect externally to this animation instance's onEnd function
	});
	animation.play(); // start it up
	
