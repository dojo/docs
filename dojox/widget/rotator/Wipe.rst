.. _dojox/widget/rotator/Wipe:

=========================
dojox.widget.rotator.Wipe
=========================

:Authors: Chris Barber
:Project owner: Chris Barber
:since: V1.4

.. contents ::
   :depth: 2

A wipe transition for a :ref:`dojox.widget.Rotator <dojox/widget/Rotator>` or :ref:`dojox.widget.AutoRotator <dojox/widget/AutoRotator>`.

Usage
=====

The wipe rotator transition is not an instantiated object, but rather a series of functions which consist of:

* wipeDown() - Returns a dojo.Animation that wipes in the next rotator pane from the top.
* wipeRight() - Returns a dojo.Animation that wipes in the next rotator pane from the right.
* wipeUp() - Returns a dojo.Animation that wipes in the next rotator pane from the bottom.
* wipeLeft() - Returns a dojo.Animation that wipes in the next rotator pane from the left.

These functions are invoked by the rotator and may be different per pane.

Each function is passed an object containing the "transitionParams" along with the rotator's current and next pane which are to be panned, then returns a dojo.Animation object describing the animated sequence.

Examples
========

Programmatic example
--------------------

Example of a different wipe direction for each pane.

.. code-example::

  .. css ::

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

  .. js ::

        dojo.require("dojox.widget.AutoRotator");
        dojo.require("dojox.widget.rotator.Wipe");
        dojo.ready(function(){
            new dojox.widget.AutoRotator(
                {
                    transition: "dojox.widget.rotator.wipeLeft",
                    transitionParams: "quick:true,continuous:true",
                    duration: 2500,
                    panes: [
                        { className: "pane pane0", innerHTML: "<h3>Dojo</h3><p>Tons of features like CSS-based queries, event handling, animations, Ajax, class-based programming, and a package system</p>" },
                        { className: "pane pane1", transition: "dojox.widget.rotator.wipeRight", innerHTML: "<h3>Dijit</h3><p>Dojo's themeable, accessible, easy-to-customize UI Library</p>" },
                        { className: "pane pane2", transition: "dojox.widget.rotator.wipeUp", innerHTML: "<h3>DojoX</h3><p>Dojo eXtensions</p>" }
                    ]

                },
                dojo.byId("myAutoRotator1")
            );
        });

  .. html ::

    <div id="myAutoRotator1" class="rotator"></div>

    <button onclick="dojo.publish('myAutoRotator1/rotator/control', ['prev']);">Prev</button>
    <button onclick="dojo.publish('myAutoRotator1/rotator/control', ['go', 0]);">Go 1</button>
    <button onclick="dojo.publish('myAutoRotator1/rotator/control', ['go', 1]);">Go 2</button>
    <button onclick="dojo.publish('myAutoRotator1/rotator/control', ['go', 2]);">Go 3</button>
    <button onclick="dojo.publish('myAutoRotator1/rotator/control', ['next']);">Next</button>


Declarative example
-------------------

Example of a different wipe direction for each pane.

.. code-example::

  .. css ::

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

  .. js ::

        dojo.require("dojox.widget.AutoRotator");
        dojo.require("dojox.widget.rotator.Wipe");
  
  .. html ::

    <div data-dojo-type="dojox.widget.AutoRotator" class="rotator" id="myAutoRotator2" data-dojo-id="myAutoRotatorInstance2" data-dojo-props="transition:'dojox.widget.rotator.wipeLeft', duration:2500">
        <div class="pane pane0">Pane 0<br/>Pane 1 will wipe in from the top</div>
        <div class="pane pane1" transition="dojox.widget.rotator.wipeDown">Pane 1<br/>Pane 2 will wipe in from the right</div>
        <div class="pane pane2" transition="dojox.widget.rotator.wipeRight">Pane 2<br/>Pane 0 will use the default transition to wipe in from the left</div>
    </div>

    <button onclick="dojo.publish('myAutoRotator2/rotator/control', ['prev']);">Prev</button>
    <button onclick="dojo.publish('myAutoRotator2/rotator/control', ['go', 0]);">Go 1 (wipe left)</button>
    <button onclick="dojo.publish('myAutoRotator2/rotator/control', ['go', 1]);">Go 2 (wipe down)</button>
    <button onclick="dojo.publish('myAutoRotator2/rotator/control', ['go', 2]);">Go 3 (wipe right)</button>
    <button onclick="dojo.publish('myAutoRotator2/rotator/control', ['next']);">Next</button>


See also
========

* :ref:`dojox.widget.Rotator <dojox/widget/Rotator>` rotates through a series of panes using a transitions.
* :ref:`dojox.widget.AutoRotator <dojox/widget/AutoRotator>` adds automatic rotating to a Rotator.
* :ref:`dojox.widget.rotator.Fade <dojox/widget/rotator/Fade>` is a fade and crossfade transition for the Rotator.
* :ref:`dojox.widget.rotator.Pan <dojox/widget/rotator/Pan>` is a pan and continuous pan transition for the Rotator.
* :ref:`dojox.widget.rotator.Slide <dojox/widget/rotator/Slide>` is a sliding transition for the Rotator.
