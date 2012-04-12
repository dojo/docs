.. _dojox/mobile/ProgressIndicator:

==============================
dojox.mobile.ProgressIndicator
==============================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.5

.. contents ::
    :depth: 2

Introduction
============

dojox.mobile.ProgressIndicator is a round spinning graphical representation which indicates that the current task is on-going.

.. image :: ProgressIndicator.png

The spinning object is NOT an animated gif, but a collection of div elements. Non-CSS3 browsers do not have ability to rotate dom nodes. In that case, the indicator becomes a rectangle shape, not a round shape.

Usage
=====

Until V1.7, ProgressIndicator was a singleton class and not a widget. From V1.8, however, it became a widget, and you can create a new instance with the new operator. It can still be used as a singleton as well. A singleton instance can be obtained by calling dojox.mobile.ProgressIndicator.getInstance().

The start() method of ProgressIndicator starts the spinning, and the stop() method stops the spinning. You need to explicitly add ProgressIndicator.domNode to somewhere visible. The stop() method automatically removes ProgressIndicator.domNode from the dom tree for you.

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|interval      |Number    |100      |The time interval in milliseconds for updating the spinning indicator.                                     |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|size          |Number    |40       |The size of the indicator in pixels.                                                                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|removeOnStop  |Boolean   |true     |If true, this widget is removed from the parent node when stop() is called.                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|startSpinning |Boolean   |false    |If true, call start() to run the indicator at startup.                                                     |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|center        |Boolean   |true     |If true, the indicator is displayed as center aligned.                                                     |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|colors        |Array     |null     |An array of indicator colors. 12 colors have to be given. If colors are not specified, css styles          |
|              |          |         |(mblProg0Color - mblProg11Color) are used.                                                                 |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Method Detail
=============

start()
-------
    Starts the ProgressIndicator spinning.

stop()
------
    Stops the ProgressIndicator spinning.

setImage(/\*String\*/ file)
---------------------------
    Set an indicator icon image file (typically animated GIF). If null is specified, restores the default spinner.

    Parameters:
        file - a path for an indicator icon image file

Examples
========

Singleton example
-------------------
In this example, get the progress indicator instance using getInstance(), add it to the current dom tree, and call the start() method to start spinning the progress indicator. In the load() handler of dojo.xhr, call the stop() method to stop spinning and remove it from the dom tree.

.. js ::

  require([
    "dojo/_base/xhr",
    "dojox/mobile/parser",
    "dojox/mobile/ProgressIndicator"
  ], function(xhr, parser, ProgressIndicator){
    function loadPage(){
      var container; // dom node
      ....
      var prog = ProgressIndicator.getInstance();
      container.appendChild(prog.domNode);
      prog.start(); // start the progress indicator

      xhr.get({
        url: url,
        handleAs: "text",
        load: function(response, ioArgs){
          prog.stop(); // stop the progress indicator
          container.innerHTML = response;
          parser.parse(container);
        }
      });
    }
  });

Declarative example
-------------------

Default indicator
.. html ::

  <div data-dojo-type="dojox.mobile.ProgressIndicator" startSpinning="true"></div>

.. image :: ProgressIndicator-default.png

Large indicator
.. html ::

  <div data-dojo-type="dojox.mobile.ProgressIndicator" startSpinning="true"
       size="80"></div>

.. image :: ProgressIndicator-large.png

Color indicator
.. html ::

  <div data-dojo-type="dojox.mobile.ProgressIndicator" startSpinning="true"
       colors="['#E60012','#F39800','#FFF100','#8FC31F','#009944','#009E96',
                '#00A0E9','#0068B7','#1D2088','#920783','#E4007F','#E5004F']"></div>

.. image :: ProgressIndicator-color.png

Programmatic example
--------------------

.. js ::

  require([
    "dojo/_base/window",
    "dojox/mobile/ProgressIndicator"
  ], function(win, ProgressIndicator){
    var prog = new ProgressIndicator({size:40, center:false});
    win.body().appendChild(prog.domNode);
    prog.start();
  });

.. image :: ProgressIndicator-default.png
