#format dojo_rst

dojox.av.widget
===============

:Status: Draft
:Version: 1.0
:Project owner: Mike Wilcox
:Available: since 1.2

.. contents::
   :depth: 2

dojox.av.widget provides base player control widgets for building a media player.


============
Introduction
============

This package includes a PlayButton, VolumeButton, ProgressSlider, Status container, and the Player container. These widgets were built primarily for use with dojox.av.FLVideo, but could also be used to create players of other media types, including dojox.av.FLAudio.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   dojo.require("dojo.parser");
   dojo.require("dojox.av.FLVideo");
   dojo.require("dojox.av.widget.Player");
   dojo.require("dojox.av.widget.PlayButton");
   dojo.require("dojox.av.widget.VolumeButton");
   dojo.require("dojox.av.widget.ProgressSlider");
   dojo.require("dojox.av.widget.Status");
 </script>

 <div dojoType="dojox.av.widget.Player" playerWidth="100%">
    <div controlType="video" initialVolume=".1" mediaUrl="video/Grog.flv" autoPlay="true" isDebug="false" dojoType="dojox.av.FLVideo"></div>
    <div controlType="play" dojoType="dojox.av.widget.PlayButton"></div>
    <div controlType="volume" dojoType="dojox.av.widget.VolumeButton"></div>
    <div controlType="progress" dojoType="dojox.av.widget.ProgressSlider"></div>
    <div controlType="status" dojoType="dojox.av.widget.Status"></div>
 </div>

See the test file in the SDK for more information.


========
See also
========

* `dojox.av <dojox/av>`_
* `dojox.av.FLAudio <dojox/av/FLAudio>`_
* `dojox.av.FLVideo <dojox/av/FLVideo>`_
