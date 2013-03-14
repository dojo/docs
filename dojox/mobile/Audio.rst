.. _dojox/mobile/Audio:

==================
dojox/mobile/Audio
==================

:Authors: Hikaru Tamura
:Developers: Hikaru Tamura
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

dojox/mobile/Audio is a widget which plays audio. This widget wraps the HTML5 ``<audio>`` tag. 
If all sources cannot be played (typically, in desktop browsers that do not support ``<audio>``), 
dojox/mobile/Audio automatically replaces ``<audio>`` with ``<embed>``, such that the browser tries 
to play it with a suitable plug-in.

.. image :: Audio.png

Constructor Parameters
======================

+--------------+----------+---------+-------------------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                        |
+--------------+----------+---------+-------------------------------------------------------------------------------------------------------------------+
|source        |Array     |null     |An array of ``src`` and ``type`` pairs, e.g. [{src:"a.mp3",type:"audio/mpeg"},{src:"a.ogg",type:"audio/ogg"},...]. |
|              |          |         |``src`` and ``type`` specify the path and respectively the type of the media resource.                             |
+--------------+----------+---------+-------------------------------------------------------------------------------------------------------------------+
|width         |String    |"200px"  |Width used when creating the ``<embed>`` tag.                                                                      |
+--------------+----------+---------+-------------------------------------------------------------------------------------------------------------------+
|height        |String    |"15px"   |Height used when creating the ``<embed>`` tag.                                                                     |
+--------------+----------+---------+-------------------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/Audio"
  ]);

.. html ::

  <audio data-dojo-type="dojox/mobile/Audio" controls>
    <source src="audio/sample.mp3" type="audio/mpeg">
    <source src="audio/sample.ogg" type="audio/ogg">
    <source src="audio/sample.wav" type="audio/wav">
  </audio>

Programmatic example
--------------------

.. js ::

  require([
      "dojo/_base/window",
      "dojo/ready",
      "dojox/mobile/Audio",
      "dojox/mobile/parser",
      "dojox/mobile"
  ], function(win, ready, Audio){
      ready(function(){
        var widget = new Audio({
                       source: [{src:"audio/sample.mp3", type:"audio/mpeg"},
                                {src:"audio/sample.ogg", type:"audio/ogg"},
                                {src:"audio/sample.wav", type:"audio/wav"}]
                     });
        win.body().appendChild(widget.domNode);
        widget.startup();
      });
  });
