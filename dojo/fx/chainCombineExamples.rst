#format dojo_rst

Semi-Complex chain and combine examples
=======================================

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz


.. contents::
    :depth: 2

This page is a landing point for demonstrating complex animations of DOM nodes built on uses of the chain and combine functions to perform complex animations with a single call to *'play()*.

========
Examples
========

Example 1:  Demonstration of combining three chained animations
---------------------------------------------------------------

*This animation changes position, size, opacity, and color in a single, combined, animation*

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx");
      dojo.require("dojo.fx.easing");
      function basicCombine(){
         //Function linked to the button to trigger the effects.
         function combineIt() {

            //Fade the node out, then in
            var displayAnim = dojo.fx.chain([
              dojo.fadeOut({node: "basicNode1", duration: 1000}),
              dojo.fadeIn({node: "basicNode1", duration: 1000}),
            ]);

            //Move the node while it's fading out and in.
            var moveAnim = dojo.fx.chain([
              dojo.animateProperty({node: "basicNode1", 
                properties: { 
                  marginLeft: {start: 0, end: 400, unit: "px"}
                }, 
                duration: 1000,
                easing: dojo.fx.easing.backOut
              }),
              dojo.animateProperty({node: "basicNode1", 
                properties: { 
                  marginLeft: {start: 400, end: 0, unit: "px"}
                }, 
                duration: 1000,
                easing: dojo.fx.easing.backOut
              }),
            ]);

            //Resize and change color of the node as it moves too.
            var resizeColorAnim = dojo.fx.chain([
              dojo.animateProperty({node: "basicNode1", 
                properties: { 
                  width: {start: 100, end: 200, unit: "px"},
                  height: {start: 100, end: 200, unit: "px"},
                  backgroundColor: {start: "red", end: "green"}
                }, 
                duration: 1000
              }),
              dojo.animateProperty({node: "basicNode1", 
                properties: { 
                  width: {start: 200, end: 100, unit: "px"},
                  height: {start: 200, end: 100, unit: "px"},
                  backgroundColor: {start: "green", end: "red"}
                }, 
                duration: 1000
              }),
            ]);


            //Combine the three sets of animations into one that runs in parallel.
            var combinedAnim = dojo.fx.combine([displayAnim, moveAnim, resizeColorAnim]);

            //Set it so that every time it ends, it runs again. (And connect the stop action to it!)
            var handle = dojo.connect(combinedAnim, "onEnd", function(){combineIt();});
            dojo.connect(dijit.byId("endButton"), "onClick", function(){dojo.disconnect(handle);});

            //Run it!
            combinedAnim.play();
         }
         dojo.connect(dijit.byId("startButton"), "onClick", combineIt);
      }
      dojo.addOnLoad(basicCombine);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="startButton">Start the complex loop!</button>
    <button dojoType="dijit.form.Button" id="endButton">End the complex loop!</button>
    <div id="basicNode1" style="width: 100px; height: 100px; background-color: red;"></div>

========
See Also
========

* `Animation Quickstart <quickstart/Animation>`_
* `Semi-complex chaining and combining of effects <dojo/fx/chainCombineExamples>`_
* `dojo/fx/chain <dojo/fx/chain>`_
* `dojo/animateProperty <dojo/animateProperty>`_
* `dojo/fadeOut <dojo/fadeOut>`_
* `dojo/fadeIn <dojo/fadeIn>`_
* `dojo/wipeOut <dojo/fx/wipeOut>`_
* `dojo/wipeIn <dojo/fx/wipeIn>`_
