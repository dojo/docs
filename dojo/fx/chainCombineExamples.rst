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

Example 1:  Demonstration of combining two chained animations.
--------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx");
      dojo.require("dojo.fx.easing");
      function basicCombine(){
         //Function linked to the button to trigger the effects.
         function combineIt() {
            var displayAnim = dojo.fx.chain([
              dojo.fadeOut({node: "basicNode1", duration: 1000}),
              dojo.fadeIn({node: "basicNode1", duration: 1000}),
            ]);

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

            //Combine the two sets of animations into one that runs in parallel.
            dojo.fx.combine([displayAnim, moveAnim]).play();
         }
         dojo.connect(dijit.byId("basicButton"), "onClick", combineIt);
      }
      dojo.addOnLoad(basicCombine);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicButton">Fade and Wipe in Nodes!!</button>
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
