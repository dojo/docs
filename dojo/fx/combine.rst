#format dojo_rst

dojo.fx.combine
===============

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:Available: since V1.0

.. contents::
    :depth: 2

The *dojo.fx.combine()* is a helper function that can take a list of dojo._Animation objects and combine them so that their effects all run in parallel.  With this function animations that affect multiple nodes can be generated and executed at the same time.

===================
Function Parameters
===================

The *dojo.fx.combine()* function takes a JavaScript array as its parameter.  This array is a list of dojo._Animation objects you want to run in parallel.

============
Return Value
============

The return value from a call to *dojo.fx.combine()* is another instance of dojo._Animation.  It can them be used as you would any other animation object, such as playing it, or combining it with other animation effects by passing it back to a *dojo.fx.combine()* call.

========
Examples
========

Example 1:  Fade and Wipe in two DOM nodes at the same time
-----------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx");
      function basicCombine(){
         //Style the dom node to opacity 0;
         dojo.style("basicNode1", "opacity", "0");
         dojo.style("basicNode2", "opacity", "0");

         //Function linked to the button to trigger the fade.
         function combineIt() {
            dojo.style("basicNode1", "opacity", "0");
            dojo.style("basicNode2", "height", "0");
            dojo.fx.combine([
              dojo.fadeIn({node: "basicNode1"}),
              dojo.fx.wipeIn({node: "basicNode2"}),
            ]).play();
         }
         dojo.connect(dijit.byId("basicButton"), "onClick", combineIt);
      }
      dojo.addOnLoad(basicCombine);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicButton">Fade and Wipe in Nodes!!</button>
    <div id="basicNode1" style="width: 100px; height: 100px; background-color: red;"></div>
    <div id="basicNode2" style="width: 100px; height: 100px; background-color: green;"></div>




========
See Also
========

* `Animation Quickstart <quickstart/Animation>`_
* `dojo/fx/chain <dojo/fx/chain>`_
* `dojo/animateProperty <dojo/animateProperty>`_
* `dojo/fadeOut <dojo/fadeOut>`_
* `dojo/fadeIn <dojo/fadeIn>`_
* `dojo/wipeOut <dojo/fx/wipeOut>`_
* `dojo/wipeIn <dojo/fx/wipeIn>`_
