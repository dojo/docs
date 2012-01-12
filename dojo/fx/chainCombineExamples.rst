.. _dojo/fx/chainCombineExamples:

========================================
dojo.fx.chain / dojo.fx.combine Examples
========================================

:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz


.. contents ::
    :depth: 2

This page is a landing point for demonstrating complex animations of DOM nodes built on uses of the chain and combine functions to perform complex animations with a single call to *'play()*.

Examples
========

Example 1:  Demonstration of combining three chained animations
---------------------------------------------------------------

*This animation changes position, size, opacity, and color in a single, combined, animation*

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx");
      dojo.require("dojo.fx.easing");
      function basicCombine(){
         // Function linked to the button to trigger the effects.
         function combineIt(){

            // Fade the node out, then in
            var displayAnim = dojo.fx.chain([
              dojo.fadeOut({node: "basicNode1", duration: 1000}),
              dojo.fadeIn({node: "basicNode1", duration: 1000})
            ]);

            // Move the node while it's fading out and in.
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
              })
            ]);

            // Resize and change color of the node as it moves too.
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
              })
            ]);


            // Combine the three sets of animations into one that runs in parallel.
            var combinedAnim = dojo.fx.combine([displayAnim, moveAnim, resizeColorAnim]);

            // Set it so that every time it ends, it runs again. (And connect the stop action to it!)
            var handle = dojo.connect(combinedAnim, "onEnd", function(){combineIt();});
            dojo.connect(dijit.byId("endButton"), "onClick", function(){dojo.disconnect(handle);});

            // Run it!
            combinedAnim.play();
         }
         dojo.connect(dijit.byId("startButton"), "onClick", combineIt);
      }
      dojo.ready(basicCombine);

  .. html ::

    <button data-dojo-type="dijit/form/Button" id="startButton">Start the complex loop!</button>
    <button data-dojo-type="dijit/form/Button" id="endButton">End the complex loop!</button>
    <div id="basicNode1" style="width: 100px; height: 100px; background-color: red;"></div>

See Also
========

* :ref:`Animation Quickstart <quickstart/Animation>`
* :ref:`Semi-complex chaining and combining of effects <dojo/fx/chainCombineExamples>`
* :ref:`dojo.fx.chain <dojo/fx/chain>`
* :ref:`dojo.animateProperty <dojo/animateProperty>`
* :ref:`dojo.fadeOut <dojo/fadeOut>`
* :ref:`dojo.fadeIn <dojo/fadeIn>`
* :ref:`dojo.fx.wipeOut <dojo/fx/wipeOut>`
* :ref:`dojo.fx.wipeIn <dojo/fx/wipeIn>`
* :ref:`dojo.fx.slideTo <dojo/fx/slideTo>`
