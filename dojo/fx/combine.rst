.. _dojo/fx/combine:

===============
dojo.fx.combine
===============

:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:since: V1.0

.. contents ::
    :depth: 2

The *dojo.fx.combine()* is a helper function that can take a list of dojo._Animation objects and combine them so that their effects all run in parallel.  With this function animations that affect multiple nodes can be generated and executed at the same time.

Function Parameters
===================

The *dojo.fx.combine()* function takes a JavaScript array as its parameter.  This array is a list of dojo._Animation objects you want to run in parallel.


Return Value
============

The return value from a call to *dojo.fx.combine()* is another instance of dojo._Animation.  It can them be used as you would any other animation object, such as playing it, or combining it with other animation effects by passing it back to a *dojo.fx.combine()* call.


Examples
========

Example 1:  Fade and Wipe in two DOM nodes at the same time
-----------------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx");
      function basicCombine(){
         dojo.style("basicNode1", "opacity", "0");
         dojo.style("basicNode2", "height", "0px");

         // Function linked to the button to trigger the fade.
         function combineIt(){
            dojo.style("basicNode1", "opacity", "0");
            dojo.style("basicNode2", "height", "0px");
            dojo.fx.combine([
              dojo.fadeIn({node: "basicNode1", duration: 2000}),
              dojo.fx.wipeIn({node: "basicNode2", duration: 2000}),
            ]).play();
         }
         dojo.connect(dijit.byId("basicButton"), "onClick", combineIt);
      }
      dojo.ready(basicCombine);

  .. html ::

    <button data-dojo-type="dijit.form.Button" id="basicButton">Fade and Wipe in Nodes!!</button>
    <div id="basicNode1" style="width: 100px; height: 100px; background-color: red;"></div>
    <br>
    <div id="basicNode2" style="width: 100px; background-color: green; display: none;">
      <b>Some random text in a node to wipe in.</b>
    </div>


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
