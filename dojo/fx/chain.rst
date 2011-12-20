.. _dojo/fx/chain:

=============
dojo.fx.chain
=============

:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:since: v1.0

.. contents ::
    :depth: 2

The *dojo.fx.chain()* is a helper function that can take a list of dojo._Animation objects and combine them so that their effects run sequentially.  With this function animations that affect multiple nodes can be generated and executed with a single call.

Function Parameters
===================

The *dojo.fx.chain()* function takes a JavaScript array as its parameter.  This array is a list of dojo._Animation objects you want to run sequentially.

Return Value
============

The return value from a call to *dojo.fx.chain()* is another instance of dojo._Animation.  It can them be used as you would any other animation object, such as playing it, or combining it with other animation effects by passing it back to a *dojo.fx.chain()* call.

Examples
========

Example 1:  Fade and Wipe in two DOM nodes sequentially
-------------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx");
      function basicChain(){
         dojo.style("basicNode1", "opacity", "0");
         dojo.style("basicNode2", "height", "0px");

         // Function linked to the button to trigger the fade.
         function chainIt(){
            dojo.style("basicNode1", "opacity", "0");
            dojo.style("basicNode2", "height", "0px");
            dojo.style("basicNode2", "display", "none");
            dojo.fx.chain([
              dojo.fadeIn({node: "basicNode1", duration: 2000}),
              dojo.fx.wipeIn({node: "basicNode2", duration: 2000}),
            ]).play();
         }
         dojo.connect(dijit.byId("basicButton"), "onClick", chainIt);
      }
      dojo.ready(basicChain);

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
* :ref:`dojo.fx.combine <dojo/fx/combine>`
* :ref:`dojo.animateProperty <dojo/animateProperty>`
* :ref:`dojo.fadeOut <dojo/fadeOut>`
* :ref:`dojo.fadeIn <dojo/fadeIn>`
* :ref:`dojo.fx.wipeOut <dojo/fx/wipeOut>`
* :ref:`dojo.fx.wipeIn <dojo/fx/wipeIn>`
* :ref:`dojo.fx.slideTo <dojo/fx/slideTo>`
