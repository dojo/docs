.. _dojox/av/widget:

===============
dojox.av.widget
===============

:Project owner: Mike Wilcox
:since: 1.2

.. contents ::
   :depth: 2

dojox.av.widget provides base player control widgets for building a media player.


Introduction
============

This package includes a PlayButton, VolumeButton, ProgressSlider, Status container, and the Player container. These widgets were built primarily for use with dojox.av.FLVideo, but could also be used to create players of other media types, including dojox.av.FLAudio.


Usage
=====

.. js ::
 
   dojo.require("dojo.parser");
   dojo.require("dojox.av.FLVideo");
   dojo.require("dojox.av.widget.Player");
   dojo.require("dojox.av.widget.PlayButton");
   dojo.require("dojox.av.widget.VolumeButton");
   dojo.require("dojox.av.widget.ProgressSlider");
   dojo.require("dojox.av.widget.Status");

.. html ::

 <div data-dojo-type="dojox.av.widget.Player" data-dojo-props="playerWidth:'100%'">
    <div data-dojo-type="dojox.av.FLVideo" data-dojo-props="controlType:'video', initialVolume:0.1, mediaUrl:'video/Grog.flv', autoPlay:true, isDebug:false"></div>
    <div data-dojo-type="dojox.av.widget.PlayButton" data-dojo-props="controlType:'play'"></div>
    <div data-dojo-type="dojox.av.widget.VolumeButton" data-dojo-props="controlType:'volume'"></div>
    <div data-dojo-type="dojox.av.widget.ProgressSlider" data-dojo-props="controlType:'progress'"></div>
    <div data-dojo-type="dojox.av.widget.Status" data-dojo-props="controlType:'status'"></div>
 </div>

See the test file in the SDK for more information.


See also
========

* :ref:`dojox.av <dojox/av>`
* :ref:`dojox.av.FLAudio <dojox/av/FLAudio>`
* :ref:`dojox.av.FLVideo <dojox/av/FLVideo>`
