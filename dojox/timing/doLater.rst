#format dojo_rst

dojox.timing.doLater
====================

:Status: Draft
:Version: 1.0
:Project owner: Mike Wilcox
:Author: Mike Wilcox
:Available: since 1.3

.. contents::
   :depth: 2

dojox.timing.doLater checks if a parameter is ready, and if not, it will "do it later".

============
Introduction
============

The idea behind doLater is when you have multiple methods all calling one object that may or may not yet be available. Instead of having duplicative if-statements in each of these methods, doLater allows for a simple timer-based callback that has a simple method signature and fits in one line of code.

One use of doLater is controlling a Flash SWF. A SWF takes some time to load, and is most likely not ready when you first attempt communication. Other uses for doLater would be popup windows, iframes, lazy loaded scripts, or server calls. But as the examples show, it can be used to delay any call based on whatever conditional is passed to it.

The following example shows basic usage of doLater. The property "swf" represents an actual SWF file, and is sent to doLater to determine if it exists. If it does not exist, doLater returns true for "yes, we will do later", so that the function can terminate. The original caller (tellSwfPlay) and its arguments (frameNumber) are held by doLater for a set interval, after which the call is made again repeatedly until the swf property returns something "truthy":

.. code-block :: javascript
 :linenos:
 
 var tellSwfPlay = function(frameNumber){
     if(dojox.timing.doLater(swf)){return;} 
     swf.play( frameNumber );
 }
 
The second argument for doLater allows for context so the code can be executed from within objects:

.. code-block :: javascript
 :linenos:
 
 swfController.play = function(frameNumber){
     if(dojox.timing.doLater(this.swf, this)){return;} 
     this.swf.play( frameNumber );
 }
 
The interval of doLater calls defaults to 100 milliseconds and can be changed with the third argument.

The next example shows that the first argument does not have to be a property, it can be any expression that results in true or false:

.. code-block :: javascript
 :linenos:
 
 var count = 0
 setTimeout(function(){
     if(dojox.timing.doLater(++count>=10)){return;}
     console.log("incremented count:", count);
 },0);
 
In this case, doLater executes ten times before the expression results in true. Anything that works in an if statement will evaluate properly. The previous example also shows that anonymous functions work perfectly well.
