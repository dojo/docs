
.. _dojox/mobile/transition-events:

==============================
Listening to Transition Events
==============================

:Authors: Yoshiroh Kamiyama

.. contents ::
    :depth: 2

There are two ways to listen to various transition events, connect and pub/sub.

Connect to Transition Events
============================

The View widget has five stub methods, onStartView, onBeforeTransitionIn, onAfterTransitionIn, onBeforeTransitionOut, and onAfterTransitionOut, to which you can connect.

onStartView
-----------

Summary

  A method that is called only when this view is shown at startup time. That is, if the view is invisible at startup time and then becomes visible as a result of a view transition, onStartView does NOT fire.

Syntax

  onStartView()

Example

  .. js ::

    dojo.connect(view1, "onStartView", null, function(){
        console.log("startView: view="+this);
    });

onBeforeTransitionIn
--------------------

Summary

  A method that is called immediately before a view transition that makes this view visible.

Syntax

  onBeforeTransitionIn(moveTo, dir, transition, context, method)

  * moveTo - The destination view id to transition the current view to.
  * dir - The transition direction. If 1, transition forward. If -1, transition backward.
  * transition - The name of transition to perform. Ex. "slide"
  * context - The object that the callback function will receive as "this".
  * method - A callback function that is called when the transition has finished.

Example

  .. js ::

    dojo.connect(view1, "onBeforeTransitionIn", null,
       function(moveTo, dir, transition, context, method){
           print("onBeforeTransitionIn");
    });

onAfterTransitionIn
-------------------

Summary

  A method that is called immediately after a view transition that makes this view visible.

Syntax

  onAfterTransitionIn(moveTo, dir, transition, context, method)

  * moveTo - The destination view id to transition the current view to.
  * dir - The transition direction. If 1, transition forward. If -1, transition backward.
  * transition - The name of transition to perform. Ex. "slide"
  * context - The object that the callback function will receive as "this".
  * method - A callback function that is called when the transition has finished.

Example

  .. js ::

    dojo.connect(view1, "onAfterTransitionIn", null,
       function(moveTo, dir, transition, context, method){
          print("afterTransitionIn");
    });

onBeforeTransitionOut
---------------------

Summary

  A method that is called immediately before a view transition that makes this view hidden.

Syntax

  onBeforeTransitionOut(moveTo, dir, transition, context, method)

  * moveTo - The destination view id to transition the current view to.
  * dir - The transition direction. If 1, transition forward. If -1, transition backward.
  * transition - The name of transition to perform. Ex. "slide"
  * context - The object that the callback function will receive as "this".
  * method - A callback function that is called when the transition has finished.

Example

  .. js ::

    dojo.connect(view1, "onBeforeTransitionOut", null,
       function(moveTo, dir, transition, context, method){
          print("onBeforeTransitionOut");
    });

onAfterTransitionOut
--------------------

Summary

  A method that is called immediately after a view transition that makes this view hidden.

Syntax

  onAfterTransitionOut(moveTo, dir, transition, context, method)

  * moveTo - The destination view id to transition the current view to.
  * dir - The transition direction. If 1, transition forward. If -1, transition backward.
  * transition - The name of transition to perform. Ex. "slide"
  * context - The object that the callback function will receive as "this".
  * method - A callback function that is called when the transition has finished.

Example

  .. js ::

    dojo.connect(view1, "onAfterTransitionOut", null,
       function(moveTo, dir, transition, context, method){
          print("afterTransitionOut");
    });

Subscribe Transition Events
===========================

The View widget publishes five topics that are related to view transition.

/dojox/mobile/startView
-----------------------

Summary

  A topic that is published only when this view is shown at startup time. That is, if the view is invisible at startup time and then becomes visible as a result of a view transition, the view does NOT publish this topic.

Topic Subscriber

  function(view)

  * view - A view that initiated the view transition.

Example

  .. js ::

    dojo.subscribe("/dojox/mobile/startView", function(view){
        console.log("startView: view="+view);
    });

/dojox/mobile/beforeTransitionIn
--------------------------------

Summary

  A topic that is published immediately before a view transition that makes this view visible.

Topic Subscriber

  function(view, moveTo, dir, transition, context, method)

  * view - The destination view
  * moveTo - The destination view id to transition the current view to.
  * dir - The transition direction. If 1, transition forward. If -1, transition backward.
  * transition - The name of transition to perform. Ex. "slide"
  * context - The object that the callback function will receive as "this".
  * method - A callback function that is called when the transition has finished.

Example

  .. js ::

    dojo.subscribe("/dojox/mobile/beforeTransitionIn",
        function(view, moveTo, dir, transition, context, method){
          print("onBeforeTransitionIn");
    });

/dojox/mobile/afterTransitionIn
-------------------------------

Summary

  A topic that is published immediately after a view transition that makes this view visible.

Topic Subscriber

  function(view, moveTo, dir, transition, context, method)

  * view - The destination view
  * moveTo - The destination view id to transition the current view to.
  * dir - The transition direction. If 1, transition forward. If -1, transition backward.
  * transition - The name of transition to perform. Ex. "slide"
  * context - The object that the callback function will receive as "this".
  * method - A callback function that is called when the transition has finished.

Example

  .. js ::

    dojo.subscribe("/dojox/mobile/afterTransitionIn",
        function(view, moveTo, dir, transition, context, method){
          print("afterTransitionIn");
    });

/dojox/mobile/beforeTransitionOut
---------------------------------

Summary

  A topic that is published immediately before a view transition that makes this view hidden.

Topic Subscriber

  function(view, moveTo, dir, transition, context, method)

  * view - The start view. (A view that initiated the transition)
  * moveTo - The destination view id to transition the current view to.
  * dir - The transition direction. If 1, transition forward. If -1, transition backward.
  * transition - The name of transition to perform. Ex. "slide"
  * context - The object that the callback function will receive as "this".
  * method - A callback function that is called when the transition has finished.

Example

  .. js ::

    dojo.subscribe("/dojox/mobile/beforeTransitionOut",
        function(view, moveTo, dir, transition, context, method){
           print("onBeforeTransitionOut");
    });

/dojox/mobile/afterTransitionOut
--------------------------------

Summary

  A topic that is published immediately after a view transition that makes this view hidden.

Topic Subscriber

  function(view, moveTo, dir, transition, context, method)

  * view - The start view. (A view that initiated the transition)
  * moveTo - The destination view id to transition the current view to.
  * dir - The transition direction. If 1, transition forward. If -1, transition backward.
  * transition - The name of transition to perform. Ex. "slide"
  * context - The object that the callback function will receive as "this".
  * method - A callback function that is called when the transition has finished.

Example

  .. js ::

    dojo.subscribe("/dojox/mobile/afterTransitionOut",
        function(view, moveTo, dir, transition, context, method){
           print("afterTransitionOut");
    });
