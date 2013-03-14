.. _dojox/mobile/Video:

==================
dojox/mobile/Video
==================

:Authors: Hikaru Tamura
:Developers: Hikaru Tamura
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

dojox/mobile/Video is a widget which plays video. This widget wraps the HTML5 ``<video>`` tag. 
If all sources cannot be played (typically, in desktop browsers that do not support ``<video>``), 
dojox/mobile/Video automatically replaces ``<video>`` with ``<embed>``, such that the browser tries 
to play it with a suitable plug-in.

.. image :: Video.png

Constructor Parameters
======================

+--------------+----------+---------+-------------------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                        |
+--------------+----------+---------+-------------------------------------------------------------------------------------------------------------------+
|source        |Array     |null     |An array of ``src`` and ``type`` pairs (e.g. [{src:"a.mp4",type:"video/mp4"},{src:"a.ogv",type:"video/ogg"},...]). |
|              |          |         |``src`` and ``type`` specify the path and respectively the type of the media resource.                             |
+--------------+----------+---------+-------------------------------------------------------------------------------------------------------------------+
|width         |String    |"200px"  |Width used when creating the ``<embed>`` tag.                                                                      |
+--------------+----------+---------+-------------------------------------------------------------------------------------------------------------------+
|height        |String    |"150px"  |Height used when creating the ``<embed>`` tag.                                                                     |
+--------------+----------+---------+-------------------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/Video"
  ]);

.. html ::

  <video data-dojo-type="dojox/mobile/Video" controls>
    <source src="video/sample.mp4" type="video/mp4">
    <source src="video/sample.ogv" type="video/ogg">
    <source src="video/sample.webm" type="video/webm">
  </video>

Programmatic example
--------------------

.. js ::

  require([
      "dojo/_base/window",
      "dojo/ready",
      "dojox/mobile/Video",
      "dojox/mobile/parser",
      "dojox/mobile"
  ], function(win, ready, Video){
      ready(function(){
        var widget = Video({
            source: [{src:"video/sample.mp4", type:"video/mp4"},
                     {src:"video/sample.ogv", type:"video/ogg"},
                     {src:"video/sample.webm", type:"video/webm"}]
        });
        win.body().appendChild(widget.domNode);
        widget.startup();
      });
  });
