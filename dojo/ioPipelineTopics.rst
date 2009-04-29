#format dojo_rst

IO Pipeline Topics
==================

:Status: Draft
:Version: 1.0
:Available: since V1.4

.. contents::
   :depth: 2

Topics that are published via `dojo.publish <dojo/publish>`_ that correspond to events in the Input/Output (IO) pipeline used by Dojo.

============
Introduction
============

As of Dojo 1.4, there are topics that are published for the pipeline used to handle all IO operations. dojo.xhr, dojo.io.script and dojo.io.iframe all use the IO pipeline, so they can all publish the pipeline topics. By default, the topics are turned off. To enable them, set **djConfig.ioPublish = true**. After they are globally enabled, you can disable them for specific IO requests by setting **ioPublish: false** in the arg object you pass to dojo.xhr*(), dojo.io.script.get() or dojo.io.iframe.send().

=====
Usage
=====

Here is a list of topics that you can subscribe to, with the parameters they pass:

.. code-block :: javascript
  :linenos:
  
  dojo.subscribe("/dojo/io/start", function(){
    //Triggered when there are no outstanding IO requests,
    //and a new IO request is started. No arguments are passed with this topic.
  });

  dojo.subscribe("/dojo/io/send", function(/*dojo.Deferrred*/dfd){
    //Triggered whenever a new IO request is started.
    //It passes the dojo.Deferred for the request.
  });

  dojo.subscribe("/dojo/io/load", function(/*dojo.Deferrred*/dfd, /*Object*/response){
    //Triggered whenever an IO request has loaded
    //successfully. It passes the response and the
    //dojo.Deferred for the request.
  });


  dojo.subscribe("/dojo/io/error", function(/*dojo.Deferrred*/dfd, /*Object*/response){
    //Triggered whenever an IO request has errored.
    //It passes the error and the dojo.Deferred
    //for the request with the topic.
  });


  dojo.subscribe("/dojo/io/done", function(/*dojo.Deferrred*/dfd, /*Object*/response){
    //Triggered whenever an IO request has completed,
    //either by loading or by erroring. It passes the error and
    //the dojo.Deferred for the request with the topic.
  });


  dojo.subscribe("/dojo/io/stop", function(){
    //Triggered when all outstanding IO requests have
    //finished. No arguments are passed with this topic.
  });

========
See also
========

* `dojo.publish <dojo/publish>`_
* `dojo.subscribe <dojo/subscribe>`_
