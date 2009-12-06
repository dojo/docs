#format dojo_rst

dojox.widget.AutoRotator
========================

:Authors: Chris Barber, Marcus Reimann
:Project owner: Chris Barber
:Available: since V1.4

.. contents::
   :depth: 2

A rotator that automatically transitions between child nodes.


============
Introduction
============

Adds automatic rotating to the `dojox.widget.Rotator <dojox/widget/Rotator>`_. The AutoRotator has parameters that control how user input can affect the rotator including a suspend when hovering over the rotator and pausing when the user manually advances to another pane.


=====
Usage
=====

===================  =======  ======================================================================
Parameter            Type     Description
===================  =======  ======================================================================
suspendOnHover       boolean  Pause the rotator when the mouse hovers over it. The default value is false.
duration             int      The time in milliseconds before transitioning to the next pane.  The default value is 4000 (4 seconds).
autoStart            boolean  Starts the timer to transition children upon creation. The default value is true.
pauseOnManualChange  boolean  Pause the rotator when the pane is changed or a controller's next or previous buttons are clicked. The default value is false.
cycles               int      Number of cycles before pausing. By default, it will cycle indefinitely.
random               boolean  Determines if the panes should cycle randomly. The default value is false.
reverse              boolean  Causes the rotator to rotate in reverse order. The default value is false.
===================  =======  ======================================================================

The AutoRotator follows the same general Guidelines as the `dojox.widget.Rotator <dojox/widget/Rotator>`_.


========
Examples
========

Programmatic example
--------------------

Example showing how the AutoRotator can create the pane DOM nodes for you.

.. code-example::
  :version: local

  .. css::

    <style type="text/css">
        .rotator{
            background-color:#fff;
            border:solid 1px #e5e5e5;
            width:400px;
            height:180px;
            overflow:hidden;
        }
        .pane{
            background-color:#fff;
            width:400px;
            height:180px;
            overflow:hidden;
            padding: 10px;
        }
        .pane0{
            background-color:#fff79e;
        }
        .pane1{
            background-color:#ffd4a0;
        }
        .pane2{
            background-color:#ffa0a0;
        }
    </style>

  .. javascript::

    <script type="text/javascript">
        dojo.require("dojox.widget.AutoRotator");
        dojo.require("dojox.widget.rotator.Fade");
        dojo.addOnLoad(function(){
            new dojox.widget.AutoRotator(
                {
                    transition: "dojox.widget.rotator.fade",
                    duration: 2500,
                    pauseOnManualChange: true,
                    suspendOnHover: true,
                    panes: [
                        { className: "pane pane0", innerHTML: "<h3>Dojo</h3><p>Tons of features like CSS-based queries, event handling, animations, Ajax, class-based programming, and a package system</p>" },
                        { className: "pane pane1", innerHTML: "<h3>Dijit</h3><p>Dojo's themeable, accessible, easy-to-customize UI Library</p>" },
                        { className: "pane pane2", innerHTML: "<h3>DojoX</h3><p>Dojo eXtensions</p>" }
                    ]

                },
                dojo.byId("myAutoRotator1")
            );
        });
    </script>

  .. html::

    <div id="myAutoRotator1" class="rotator"></div>

    <button onclick="dojo.publish('myAutoRotator1/rotator/control', ['prev']);">Prev</button>
    <button onclick="dojo.publish('myAutoRotator1/rotator/control', ['next']);">Next</button>


Declarative example
-------------------

Example of an AutoRotator that cycles to 4 random panes, then pauses.

.. code-example::
  :version: local

  .. css::

    <style type="text/css">
        .rotator{
            background-color:#fff;
            border:solid 1px #e5e5e5;
            width:400px;
            height:100px;
            overflow:hidden;
        }
        .pane{
            background-color:#fff;
            width:400px;
            height:100px;
            overflow:hidden;
        }
        .pane0{
            background-color:#fff79e;
        }
        .pane1{
            background-color:#ffd4a0;
        }
        .pane2{
            background-color:#ffa0a0;
        }
    </style>

  .. javascript::

    <script type="text/javascript">
        dojo.require("dojox.widget.AutoRotator");
        dojo.require("dojox.widget.rotator.Fade");
    </script>
  
  .. html::

    <div dojoType="dojox.widget.AutoRotator" class="rotator" id="myAutoRotator2" jsId="myAutoRotatorInstance2" transition="dojox.widget.rotator.crossFade" duration="2500" random="true" cycles="4">
        <div class="pane pane0">Pane 0</div>
        <div class="pane pane1">Pane 1</div>
        <div class="pane pane2">Pane 2</div>
    </div>


Example of using the "wait for event" feature. The 2nd pane will wait for a event to be published by the button before proceeding.

.. code-example::
  :version: local

  .. css::

    <style type="text/css">
        .rotator{
            background-color:#fff;
            border:solid 1px #e5e5e5;
            width:400px;
            height:180px;
            overflow:hidden;
        }
        .pane{
            background-color:#fff;
            width:400px;
            height:180px;
            overflow:hidden;
            padding: 10px;
        }
        .pane0{
            background-color:#fff79e;
        }
        .pane1{
            background-color:#ffd4a0;
        }
        .pane2{
            background-color:#ffa0a0;
        }
    </style>

  .. javascript::

    <script type="text/javascript">
        dojo.require("dojox.widget.AutoRotator");
        dojo.require("dojox.widget.rotator.Fade");
    </script>
  
  .. html::

    <div dojoType="dojox.widget.AutoRotator" class="rotator" id="myAutoRotator3" jsId="myAutoRotatorInstance3" duration="2000" transition="dojox.widget.rotator.crossFade">
        <div class="pane pane0">
            <h3>Dojo</h3>
            <p>Tons of features like CSS-based queries, event handling, animations, Ajax, class-based programming, and a package system</p>
        </div>
        <div class="pane pane1" waitForEvent="myEvent">
            <h3>Dijit</h3>
            <p>Dojo's themeable, accessible, easy-to-customize UI Library</p>
            <p><button onclick="dojo.publish('myEvent')">Continue!</button></p>
        </div>
        <div class="pane pane2">
            <h3>DojoX</h3>
            <p>Dojo eXtensions</p>
        </div>
    </div>


========
See also
========

* `dojox.widget.Rotator <dojox/widget/Rotator>`_ is the base class of the AutoRotator.
* `dojox.widget.rotator.Controller <dojox/widget/rotator/Controller>`_ manipulates a Rotator or AutoRotator.
* `dojox.widget.rotator.Fade <dojox/widget/rotator/Fade>`_ is a fade and crossfade transition for the Rotator.
* `dojox.widget.rotator.Pan <dojox/widget/rotator/Pan>`_ is a pan and continuous pan transition for the Rotator.
* `dojox.widget.rotator.Slide <dojox/widget/rotator/Slide>`_ is a sliding transition for the Rotator.
* `dojox.widget.rotator.Wipe <dojox/widget/rotator/Wipe>`_ is a wiping transition for the Rotator.
