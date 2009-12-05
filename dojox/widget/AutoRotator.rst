#format dojo_rst

dojox.widget.AutoRotator
========================

:Status: Draft
:Version: 1.0
:Project owner: Chris Barber
:Available: since V1.4

.. contents::
   :depth: 2

A rotator that automatically transitions between child nodes.

============
Introduction
============

Adds automatic rotating to the `dojox.widget.Rotator <dojox/widget/Rotator>`_. The AutoRotator has parameters that control how user input can affect the rotator including a suspend when hovering over the rotator and pausing when the user manually advances to another pane.

=====
Usage
=====

===================  =======  ======================================================================
Parameter            Type     Description
===================  =======  ======================================================================
suspendOnHover       boolean  Pause the rotator when the mouse hovers over it. The default value is false.
duration             int      The time in milliseconds before transitioning to the next pane.  The default value is 4000 (4 seconds).
autoStart            boolean  Starts the timer to transition children upon creation. The default value is true.
pauseOnManualChange  boolean  Pause the rotator when the pane is changed or a controller's next or previous buttons are clicked. The default value is false.
cycles               int      Number of cycles before pausing. By default, it will cycle indefinitely.
random               boolean  Determines if the panes should cycle randomly. The default value is false.
reverse              boolean  Causes the rotator to rotate in reverse order. The default value is false.
===================  =======  ======================================================================

The AutoRotator follows the same general Guidelines as the `dojox.widget.Rotator <dojox/widget/Rotator>`_.

The following examples will use the following CSS:

.. code-block :: css
 :linenos:
 
 #myRotator {
   border: solid 1px #000;
   height: 100px;
   width: 400px;
 }
 
 .pane {
   height: 100px;
   overflow: hidden;
   width: 400px;
 }

========
Examples
========

Programmatic example
--------------------

Example showing how the AutoRotator can create the pane DOM nodes for you.

.. code-block :: html
 :linenos:
 
 <script type="text/javascript">
   dojo.require("dojox.widget.AutoRotator");
   dojo.require("dojox.widget.rotator.fade");
   dojo.addOnLoad(function(){
     new dojox.widget.AutoRotator(
       {
         transition: "dojox.widget.rotator.fade",
         duration: 2500,
         pauseOnManualChange: true,
         suspendOnHover: true,
         panes: [
           { className: "pane", innerHTML: "Pane 1" },
           { className: "pane", innerHTML: "Pane 2" },
           { className: "pane", innerHTML: "Pane 3" }
         ]
       },
       dojo.byId("myRotator");
     );
   });
 </script>
 
 <div id="myRotator"></div>
 
 <button onclick="dojo.publish('myRotator/rotator/control', ['prev']);">Prev</button>
 <button onclick="dojo.publish('myRotator/rotator/control', ['next']);">Next</button>

Declarative example
-------------------

Example of an AutoRotator that cycles to 4 random panes, then pauses.

.. code-block :: html
 :linenos:
 
 <script type="text/javascript">
   dojo.require("dojox.widget.AutoRotator");
   dojo.require("dojox.widget.rotator.fade");
 </script>
 
 <div dojoType="dojox.widget.AutoRotator" id="myRotator" jsId="myRotatorInstance" transition="dojox.widget.rotator.crossFade" duration="2500" random="true" cycles="4">
   <div>Pane 1</div>
   <div>Pane 2</div>
   <div>Pane 3</div>
 </div>
 
 <button onclick="myRotatorInstance.prev();">Prev</button>
 <button onclick="myRotatorInstance.next();">Next</button>

Example of using the "wait for event" feature. The 2nd pane will wait for a event to be published by the button before proceeding.

.. code-block :: html
 :linenos:
 
 <script type="text/javascript">
   dojo.require("dojox.widget.AutoRotator");
   dojo.require("dojox.widget.rotator.fade");
 </script>
 
 <div dojoType="dojox.widget.AutoRotator" class="rotator" jsId="myRotator3" duration="2000" transition="dojox.widget.rotator.crossFade">
   <div class="pane">Pane 1</div>
   <div class="pane" waitForEvent="myEvent">
     Pane 2<br>
     <button onclick="dojo.publish('myEvent')">Continue!</button>
   </div>
   <div class="pane">Pane 3</div>
 </div>

========
See also
========

* TODO: links to other related articles
