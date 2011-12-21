.. _dojox/mobile/ProgressIndicator:

==============================
dojox.mobile.ProgressIndicator
==============================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.5

.. contents ::
    :depth: 2

ProgressIndicator is a round spinning graphical representation that indicates the current task is on-going.

.. image :: ProgressIndicator.png

The spinning object is NOT an animated gif, but a collection of div elements. Non-CSS3 browsers do not have ability to rotate dom nodes. In that case, the indicator becomes a rectangle shape, not a round shape.

Usage
=====

ProgressIndicator is not a widget. It is a singleton class. An instance of this class can be obtained by calling dojox.mobile.ProgressIndicator.getInstance(). The start() method of ProgressIndicator starts spinning, and the stop() method stops spinning. You need to explicitly add ProgressIndicator.domNode to somewhere visible. The stop() method automatically removes ProgressIndicator.domNode from the dom tree for you.

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|interval      |Number    |100      |The time interval in milliseconds for updating the spinning indicator.                                     |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|colors        |Array     |         |An array of indicator colors.                                                                              |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Method Detail
=============

start()
-------
    Starts the ProgressIndicator spinning.

stop()
------
    Stop the ProgressIndicator spinning.

setImage(/\*String\*/ file)
---------------------------
    Set an indicator icon image file (typically animated GIF). If null is specified, restores the default spinner.

    Parameters:
        file - a path for an indicator icon image file

Examples
========

In this example, get the progress indicator instance using getInstance(), add it to the current dom tree, and call the start() method to start spinning of the progress indicator. In the load() handler of dojo.xhr, call the stop() method to stop spinning and remove it from the dom tree.

.. js ::

  function loadPage(){
    ....
    var prog = dojox.mobile.ProgressIndicator.getInstance();
    container.appendChild(prog.domNode);
    prog.start(); // start the progress indicator

    dojo.xhrGet({
      url: url,
      handleAs: "text",
      load: function(response, ioArgs){
        prog.stop(); // stop the progress indicator
        container.innerHTML = response;
        dojox.mobile.parser.parse(container);
      }
    });
  }
