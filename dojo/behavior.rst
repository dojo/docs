#format dojo_rst

dojo.behavior
=============

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Nikolai Onken
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2

A very simple, lightweight mechanism for applying code to existing documents, based around `dojo.query <dojo/query>`_ for node selection, and a simple two-command API: dojo.behavior.add() and dojo.behavior.apply();


=====
Usage
=====

To use, simply require in the dojo.behavior module, after ``dojo.js`` is loaded:

.. code-block :: javascript

  dojo.require("dojo.behavior");

Then, define a "behavior". This behavior is just an object, with a lot of special tokens. They work by selecting nodes using a CSS3 selector. 

As a shorthand, if a function is passed (instead of an object) to a selector, it is assumed to be the ``found:`` function:

.. code-block :: javascript

  dojo.behavior.add({
      "#someId": function(n){
          // we found id="someId"
          console.log(n);
      }
  });
  dojo.behavior.apply();

Calling ``.apply()`` applies all the added behaviors.


=====================
Behaviors with events
=====================

Beyond simple application, we can bind selectors to Dom Events, and more, using an Object hash. Simply pass the selector and object with named events, and functions as handlers. 

.. code-block :: javascript

  var myBehavior = {
     // all <a class="noclick"></a> nodes:
     "a.noclick" : {
          // event names become event connections:
          onclick: function(e){
             e.preventDefault(); // stop the default event handler
             console.log('clicked! ', e.target); 
          }
      },
      // all <span> nodes
      "span" : {
          // for each:
          found: function(n){
              console.log('found', n);
          }
       }
  };
  dojo.behavior.add(myBehavior);
  dojo.behavior.apply();

The ``found:`` function is applied to all found nodes. The ``onclick:`` identifier will bind an onclick function to all found nodes. You can use any Dom Event name, such as ``onclick``, ``onmouseenter``, ``onmouseleave``, ``onblur``, etc. 


=====================
Behaviors with topics
=====================

Using Dojo's `native topic system <quickstart/topics>`_, you can pass a named channel, and any node found during the apply() period will publish on that channel:

.. code-block :: javascript

  dojo.behavior.add({ 
      "#someUl > li": "/found/li"
  });
  dojo.subscribe("/found/li", function(msg){
      console.log('message: ', msg);
  });
  dojo.behavior.apply();
