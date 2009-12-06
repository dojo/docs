#format dojo_rst

dojox.widget.Rotator
====================

:Status: Draft
:Version: 1.0
:Project owner: Chris Barber
:Available: since V1.4

.. contents::
   :depth: 2

A widget for rotating through child nodes using transitions.

============
Introduction
============

A small, fast, extensible, awesome rotator that cycles, with transitions, through panes (child nodes) displaying only one at a time and ties into controllers used to change state.

The Rotator does not rely on dijit.  It is designed to be as lightweight as possible.  Controllers and transitions have been externalized so builds can be as optimized with only the components you want to use. 

=====
Usage
=====

================  ======  ======================================================================
Parameter         Type    Description
================  ======  ======================================================================
transition        String  The name of a function that is passed two panes nodes and a duration, then returns a dojo.Animation object. The default value is "dojox.widget.rotator.swap".
transitionParams  String  Parameters for the transition. The string is read in and eval'd as an object.  If the duration is absent, the default value will be used.
panes             Array   Array of panes to be created in the Rotator. Each array element will be passed as attributes to a dojo.create() call.
================  ======  ======================================================================

The Rotator should be declared using a block element such as a <div>. Direct descendant nodes are the panes to be rotated. The Rotator will accept any DOM node for a rotator pane, however a block element (such as <div> or <img>) or a element with display:block is recommended. For best results, each rotator pane should be the same height and width as the Rotator container node and consider setting overflow to hidden.

There may be z-index issues for complex layouts. The z-index of the current pane is 1 and the z-index of the pane that is about to be transitioned in is 2.

If the rotator node isn't explicitly positioned, then it will automatically position the rotator node relative so that the panes can be positioned absolute.

You can do some interesting things by stacking multiple rotators on top of each other, then wiring up the topics so that they all transition at the same time.

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

Programmatic examples
---------------------

Example showing how the Rotator can create the pane DOM nodes for you.

.. code-block :: html
 :linenos:
 
 <script type="text/javascript">
   dojo.require("dojox.widget.Rotator");
   dojo.require("dojox.widget.rotator.fade");
   dojo.addOnLoad(function(){
     new dojox.widget.Rotator(
       {
         transition: "dojox.widget.rotator.fade",
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

Example showing how the Rotator will use DOM nodes that already exist.

.. code-block :: html
 :linenos:

 <script type="text/javascript">
   dojo.require("dojox.widget.Rotator");
   dojo.require("dojox.widget.rotator.fade");
   dojo.addOnLoad(function(){
     // add a 3rd pane
     dojo.create("div", { className: "pane", innerHTML: "pane3" }, "myRotator");
 
     new dojox.widget.Rotator(
       {
         transition: "dojox.widget.rotator.fade"
       },
       dojo.byId("myRotator");
     );
   });
 </script>
 
 <div id="myRotator">
   <div class="pane">Pane 1</div>
   <div class="pane">Pane 2</div>
 </div>
 
 <button onclick="dojo.publish('myRotator/rotator/control', ['prev']);">Prev</button>
 <button onclick="dojo.publish('myRotator/rotator/control', ['next']);">Next</button>

Declarative examples
--------------------

Example showing how to create a minimal Rotator instance.

.. code-example::

  .. javascript::

    <script type="text/javascript">
        dojo.require("dojox.widget.Rotator");
    </script>

  .. html::

    <div dojoType="dojox.widget.Rotator">
        <div>Pane 1</div>
        <div>Pane 2</div>
        <div>Pane 3</div>
    </div>



.. code-block :: html
 :linenos:

 <script type="text/javascript">
   dojo.require("dojox.widget.Rotator");
 </script>
 
 <div dojoType="dojox.widget.Rotator">
   <div>Pane 1</div>
   <div>Pane 2</div>
   <div>Pane 3</div>
 </div>

Example using the crossfade transition.

.. code-block :: html
 :linenos:
 
 <script type="text/javascript">
   dojo.require("dojox.widget.Rotator");
   dojo.require("dojox.widget.rotator.Fade");
 </script>
 
 <div dojoType="dojox.widget.Rotator" transition="dojox.widget.rotator.crossFade">
   <div>Pane 1</div>
   <div>Pane 2</div>
   <div>Pane 3</div>
 </div>

Example of controlling a Rotator by referencing its instance. We define a jsId so that the dojo.parser will create a global JavaScript variable pointing to our Rotator instance.

.. code-block :: html
 :linenos:
 
 <script type="text/javascript">
   dojo.require("dojox.widget.Rotator");
   dojo.require("dojox.widget.rotator.Fade");
 </script>
 
 <div dojoType="dojox.widget.Rotator" id="myRotator" jsId="myRotatorInstance" transition="dojox.widget.rotator.crossFade">
   <div>Pane 1</div>
   <div>Pane 2</div>
   <div>Pane 3</div>
 </div>
 
 <button onclick="myRotatorInstance.prev();">Prev</button>
 <button onclick="myRotatorInstance.next();">Next</button>

Example of using different transitions per pane.

.. code-block :: html
 :linenos:
 
 <script type="text/javascript">
   dojo.require("dojox.widget.Rotator");
   dojo.require("dojox.widget.rotator.Fade");
   dojo.require("dojox.widget.rotator.Pan");
   dojo.require("dojox.widget.rotator.Slide");
   dojo.require("dojox.widget.rotator.Wipe");
 </script>
 
 <div dojoType="dojox.widget.Rotator" id="myRotator" jsId="myRotatorInstance" transition="dojox.widget.rotator.crossFade">
   <div>Pane 1</div>
   <div transition="dojox.widget.rotator.panRight">Pane 2</div>
   <div transition="dojox.widget.rotator.slideLeft">Pane 3</div>
   <div transition="dojox.widget.rotator.wipeDown">Pane 4</div>
 </div>
 
 <button onclick="myRotatorInstance.prev();">Prev</button>
 <button onclick="myRotatorInstance.next();">Next</button>

Example of using passing in transition parameters. In this case, the `Pan <dojox/widget/rotator/Pan>`_ transition is told to do a continuous pan from the current pane to the target pane while transitioning to any panes in between. We also specify a duration of the actual pan transition and tell it to do a quick transition.

.. code-block :: html
 :linenos:
 
 <script type="text/javascript">
   dojo.require("dojox.widget.Rotator");
   dojo.require("dojox.widget.rotator.Pan");
 </script>
 
 <div dojoType="dojox.widget.Rotator" id="myRotator" jsId="myRotatorInstance" transition="dojox.widget.rotator.pan" transitionParams="continuous:true,quick:true,duration:500">
   <div>Pane 1</div>
   <div>Pane 2</div>
   <div>Pane 3</div>
 </div>
 
 <button onclick="myRotatorInstance.prev();">Prev</button>
 <button onclick="myRotatorInstance.next();">Next</button>

=================
Subscribed Topics
=================

The Rotator subscribes to the following topic where the [id] is the id of the Rotator:

.. code-block :: text
 
 [id]/rotator/control

This allows you to publish to this topic and control the Rotator. It will invoke a method of the Rotator or subclass and allow you to pass in arguments.

Parameters
----------

================  ========  ======================================================================
Parameter         Type      Description
================  ========  ======================================================================
action            String    The name of a method of the Rotator to run such as "prev", "next", and "go". If the action is not a valid method of the Rotator or its subclass, then a warning is thrown to the console.
args              Anything  One or more arguments to pass to the action. If the action is "go", then you may pass in the number of the pane you want to go to.
================  ========  ======================================================================

Example
-------

.. code-block :: html
 :linenos:
 
 <script type="text/javascript">
   dojo.require("dojox.widget.Rotator");
 </script>
 
 <div dojoType="dojox.widget.Rotator" id="myRotator">
   <div>Pane 1</div>
   <div>Pane 2</div>
   <div>Pane 3</div>
 </div>
 
 <button onclick="dojo.publish('myRotator/rotator/control', ['prev']);">Prev</button>
 <button onclick="dojo.publish('myRotator/rotator/control', ['next']);">Next</button>
 <button onclick="dojo.publish('myRotator/rotator/control', ['go', 2]);">Goto Pane 2</button>

================
Published Topics
================

The Rotator publishes the following topic where the [id] is the id of the Rotator:

.. code-block :: text
 
 [id]/rotator/update

By subscribing to this topic, you can hook into various events fired by the Rotator.

Parameters
----------

================  ====================  ======================================================================
Parameter         Type                  Description
================  ====================  ======================================================================
type              String                The type of notification.
rotator           dojox.widget.Rotator  The instance of the Rotator.
params            Object?               Various parameters associated with the event.
================  ====================  ======================================================================

Example
-------

.. code-block :: javascript
 :linenos:
 
 <div dojoType="dojox.widget.Rotator" id="myRotator"></div>
 <script type="text/javascript">
   dojo.addOnLoad(function(){
     dojo.subscribe("myrotator/rotator/update", function(type, rotator, params){
       console.info("The rotator just published a '", type, "' message");
     });
   });
 </script>

=======================
Waiting for Event Topic
=======================

The Rotator contains plumbing for bypassing automated transitioning implemented by subclasses such as the `dojox.widget.AutoRotator <dojox/widget/AutoRotator>`_. It allows you to specify per pane the name of a topic to listen for before continuing to the next pane. Visit the `dojox.widget.AutoRotator <dojox/widget/AutoRotator>`_ page for a code example.

========
See also
========

* `dojox.widget.AutoRotator <dojox/widget/AutoRotator>`_ extends this Rotator adding automatic transitioning.
* `dojox.widget.rotator.Controller <dojox/widget/rotator/Controller>`_ manipulates a Rotator or AutoRotator.
* `dojox.widget.rotator.Fade <dojox/widget/rotator/Fade>`_ is a fade and crossfade transition for the Rotator.
* `dojox.widget.rotator.Pan <dojox/widget/rotator/Pan>`_ is a pan and continuous pan transition for the Rotator.
* `dojox.widget.rotator.Slide <dojox/widget/rotator/Slide>`_ is a sliding transition for the Rotator.
* `dojox.widget.rotator.Wipe <dojox/widget/rotator/Wipe>`_ is a wiping transition for the Rotator.
