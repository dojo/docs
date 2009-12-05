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

For best results, each rotator pane should be the same height and width as the Rotator container node and consider setting overflow to hidden. While the Rotator will accept any DOM node for a rotator pane, a block element or element with display:block is recommended.



=====
Usage
=====

TODO: how to use the component/class/method

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // your code
 </script>



========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


=================
Subscribed Topics
=================

The Rotator subscribes to the following topic where the [id] is the id of the Rotator:

.. code-block :: text
 
 [id]/rotator/control

This allows you to publish to this topic and control the Rotator. It will invoke a method of the Rotator or subclass and allow you to pass in arguments.

Parameters
----------

action [string] - The name of a method of the Rotator to run such as "prev", "next", and "go". If the action is not a valid method of the Rotator or its subclass, then a warning is thrown to the console.

args [anything] - One or more arguments to pass to the action. If the action is "go", then you may pass in the number of the pane you want to go to.

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

type [string] - The type of notification.

rotator [dojox.widget.Rotator] - The instance of the Rotator.

params [object?] - Various parameters associated with the event.

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



========
See also
========

* TODO: links to other related articles
