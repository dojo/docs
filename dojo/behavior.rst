.. _dojo/behavior:

=============
dojo.behavior
=============

:Authors: Peter Higgins, Nikolai Onken
:Developers: ?-
:since: V?

.. contents ::
    :depth: 2

A very simple, lightweight mechanism for applying code to existing documents, based around :ref:`dojo.query <dojo/query>` for node selection, and a simple two-command API: dojo.behavior.add() and dojo.behavior.apply();


Usage
=====

To use, simply require in the dojo.behavior module, after ``dojo.js`` is loaded:

Then, define a "behavior". This behavior is just an object, with a lot of special tokens. They work by selecting nodes using a CSS3 selector.

As a shorthand, if a function is passed (instead of an object) to a selector, it is assumed to be the ``found:`` function:

.. js ::

  require(["dojo/behavior"], function(behavior){
      behavior.add({
          "#someId": function(n){
              // we found id="someId"
              console.log(n);
          }
      });
      behavior.apply();
  });


Behaviors with events
=====================

Beyond simple application, we can bind selectors to Dom Events, and more, using an Object hash. Simply pass the selector and object with named events, and functions as handlers.

.. js ::

  require(["dojo/behavior"], function(behavior){
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
      behavior.add(myBehavior);
      behavior.apply();
  });

The ``found:`` function is applied to all found nodes. The ``onclick:`` identifier will bind an onclick function to all found nodes. You can use any Dom Event name, such as ``onclick``, ``onmouseenter``, ``onmouseleave``, ``onblur``, etc.


Behaviors with topics
=====================

Using Dojo's :ref:`native topic system <quickstart/topics>`, you can pass a named channel, and any node found during the apply() period will publish on that channel:

.. js ::

  require(["dojo/behavior", "dojo/topic"], function(behavior, topic){
      behavior.add({
          "#someUl > li": "/found/li"
      });
      topic.subscribe("/found/li", function(msg){
          console.log('message: ', msg);
      });
      behavior.apply();
  });
