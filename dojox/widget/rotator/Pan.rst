#format dojo_rst

dojox.widget.rotator.Pan
========================

:Authors: Chris Barber
:Project owner: Chris Barber
:Available: since V1.4

.. contents::
   :depth: 2

A pan and continuous pan transition for a `dojox.widget.Rotator <dojox/widget/Rotator>`_ or `dojox.widget.AutoRotator <dojox/widget/AutoRotator>`_.

=====
Usage
=====

The pan rotator transition is not an instantiated object, but rather a series of functions which consist of:

* pan()
* panDown()
* panRight()
* panUp()
* panLeft()

These functions are invoked by the rotator and may be different per pane.

Each function is passed an object containing information about the rotator's current and next pane which are to be panned, then returns a dojo.Animation object describing the animated sequence. You do not need to concern yourself with this detail to use this transition.

========
Examples
========

Programmatic example
--------------------

Example of a continuous pan.

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
        dojo.require("dojox.widget.rotator.Pan");
        dojo.addOnLoad(function(){
            new dojox.widget.AutoRotator(
                {
                    transition: "dojox.widget.rotator.pan",
                    transitionParams: "quick:true,continuous:true",
                    duration: 2500,
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
    <button onclick="dojo.publish('myAutoRotator1/rotator/control', ['go', 0]);">Go 1</button>
    <button onclick="dojo.publish('myAutoRotator1/rotator/control', ['go', 1]);">Go 2</button>
    <button onclick="dojo.publish('myAutoRotator1/rotator/control', ['go', 2]);">Go 3</button>
    <button onclick="dojo.publish('myAutoRotator1/rotator/control', ['next']);">Next</button>


Declarative example
-------------------

Example using different pan directions for each pane.

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
        dojo.require("dojox.widget.rotator.Pan");
    </script>
  
  .. html::

    <div dojoType="dojox.widget.AutoRotator" class="rotator" id="myAutoRotator2" jsId="myAutoRotatorInstance2" transition="dojox.widget.rotator.panLeft" duration="2500">
        <div class="pane pane0">Pane 0<br/>Panning down to Pane 1</div>
        <div class="pane pane1" transition="dojox.widget.rotator.panDown">Pane 1<br/>Panning right to Pane 2</div>
        <div class="pane pane2" transition="dojox.widget.rotator.panRight">Pane 2<br/>Using default transition to pan left to Pane 0</div>
    </div>

    <button onclick="dojo.publish('myAutoRotator2/rotator/control', ['prev']);">Prev</button>
    <button onclick="dojo.publish('myAutoRotator2/rotator/control', ['go', 0]);">Go 1</button>
    <button onclick="dojo.publish('myAutoRotator2/rotator/control', ['go', 1]);">Go 2</button>
    <button onclick="dojo.publish('myAutoRotator2/rotator/control', ['go', 2]);">Go 3</button>
    <button onclick="dojo.publish('myAutoRotator2/rotator/control', ['next']);">Next</button>


========
See also
========

* `dojox.widget.Rotator <dojox/widget/Rotator>`_ rotates through a series of panes using a transitions.
* `dojox.widget.AutoRotator <dojox/widget/AutoRotator>`_ adds automatic rotating to a Rotator.
* `dojox.widget.rotator.Fade <dojox/widget/rotator/Fade>`_ is a fade and crossfade transition for the Rotator.
* `dojox.widget.rotator.Slide <dojox/widget/rotator/Slide>`_ is a sliding transition for the Rotator.
* `dojox.widget.rotator.Wipe <dojox/widget/rotator/Wipe>`_ is a wiping transition for the Rotator.
