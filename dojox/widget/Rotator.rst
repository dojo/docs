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

========
Examples
========

Programmatic examples
---------------------

Example showing how the Rotator can create the pane DOM nodes for you.

.. code-block :: javascript
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

 <button onclick="dojo.publish("myRotator/rotator/control", ['prev']);">Prev</button>
 <button onclick="dojo.publish("myRotator/rotator/control", ['next']);">Next</button>

Example showing how the Rotator will use DOM nodes that already exist.

.. code-block :: javascript
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

 <button onclick="dojo.publish("myRotator/rotator/control", ['prev']);">Prev</button>
 <button onclick="dojo.publish("myRotator/rotator/control", ['next']);">Next</button>

Declarative examples
--------------------

Example showing how to create a minimal Rotator instance.

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

Example of controlling a Rotator by referencing its instance. We define a jsId so that the 

.. code-block :: html
 :linenos:
 
 <script type="text/javascript">
   dojo.require("dojox.widget.Rotator");
   dojo.require("dojox.widget.rotator.Fade");
 </script>
 <div dojoType="dojox.widget.Rotator" jsId="" transition="dojox.widget.rotator.crossFade">
   <div>Pane 1</div>
   <div>Pane 2</div>
   <div>Pane 3</div>
 </div>

=================
Subscribed Topics
=================

The Rotator subscribes to the following topic where the [id] is the id of the Rotator:

.. code-block :: text
 
 [id]/rotator/control

This allows you to publish to this topic and control the Rotator. It will invoke a method of the Rotator or subclass and allow you to pass in arguments.

Parameters
----------

* action [string] - The name of a method of the Rotator to run such as "prev", "next", and "go". If the action is not a valid method of the Rotator or its subclass, then a warning is thrown to the console.
* args [anything] - One or more arguments to pass to the action. If the action is "go", then you may pass in the number of the pane you want to go to.

Example
-------

.. code-block :: html
 :linenos:
 
 <div dojoType="dojox.widget.Rotator" id="myRotator"></div>
 <button onclick="dojo.publish('myRotator/rotator/control', ['prev']);">Prev</button>
 <button onclick="dojo.publish('myRotator/rotator/control', ['next']);">Next</button>
 <button onclick="dojo.publish('myRotator/rotator/control', ['go', 1]);">Goto Pane 1</button>

================
Published Topics
================

The Rotator publishes the following topic where the [id] is the id of the Rotator:

.. code-block :: text
 
 [id]/rotator/update

By subscribing to this topic, you can hook into various events fired by the Rotator.

Parameters
----------

* type [string] - The type of notification.
* rotator [dojox.widget.Rotator] - The instance of the Rotator.
* params [object?] - Various parameters associated with the event.

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

The Rotator contains plumbing for bypassing automated transitioning implemented by subclasses such as the `AutoRotator <dojox/widget/AutoRotator>`_. It allows you to specify per pane the name of a topic to listen for before continuing to the next pane. Visit the `AutoRotator <dojox/widget/AutoRotator>`_ page for a code example.

========
See also
========

* `AutoRotator <dojox/widget/AutoRotator>`_ extends this Rotator adding automatic transitioning.
