#format dojo_rst

dojox.timing
============

:Status: Draft
:Version: beta
:Authors: Tom Trenka, Wolfram Kriesing, Jonathan Bond-Caron, Pete Higgins

DojoX Timing is a project that deals with any kind of advanced use of timing
constructs.

==================
dojox.timing.Timer
==================

The central object of ``dojox.timing`` is ``dojox.timing.Timer``
(included by default), is a simple object that fires a callback
on each tick of the timer, as well as when starting or stopping it.
The interval of each tick is settable, but the default is 1
second--useful for driving something such as a clock.

.. code-block :: javascript
  
  dojo.require('dojox.timing');
  t = new dojox.timing.Timer(1000);
  t.onTick = function() {
   console.info("One second elapsed");
  }
  t.onStart = function() {
   console.info("Starting timer");
  }
  t.start();

==============
Other elements
==============

dojox.timing.Streamer is an object designed to facilitate streaming/buffer-type
scenarios; it takes an input and an output function, will execute the output
function onTick, and run the input function when the internal buffer gets 
beneath a certain threshold of items.  This can be useful for something timed--
such as updating a data plot at every N interval, and getting new data from
a source when there's less than X data points in the internal buffer (think
real-time data updating).

dojox.timing.Sequencer is an object, similar to Streamer, that will allow you
to set up a set of functions to be executed in a specific order, at specific
intervals.

The DojoX Timing ThreadPool is a port from the original implementation in the
f(m) library.  It allows a user to feed a set of callback functions (wrapped
in a Thread constructor) to a pool for background processing.
