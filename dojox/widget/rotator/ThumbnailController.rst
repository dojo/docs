.. _dojox/widget/rotator/ThumbnailController:

========================================
dojox.widget.rotator.ThumbnailController
========================================

:Authors: Chris Barber
:Project owner: Chris Barber
:since: V1.4.1

.. contents ::
   :depth: 2

A controller that manipulates a :ref:`dojox.widget.Rotator <dojox/widget/Rotator>` or :ref:`dojox.widget.AutoRotator <dojox/widget/AutoRotator>` by displaying thumbnails for each pane.

Introduction
============

The ThumbnailController will look at each of the rotator's panes and only if the node is an <img> tag, then it will create an thumbnail of the pane's image using the <img> tag's "thumbsrc" or "src" attribute.

You may have multiple Controllers tied to a single Rotator instance.

The size of the thumbnails and the style of the selected thumbnail is controlled using CSS. The Controller's DOM node may also be styled for positioning or other styled preferences.

Usage
=====

==========  =======  ======================================================================
Parameter   Type     Description
==========  =======  ======================================================================
rotator     string   The name of an instance of a Rotator widget defined by data-dojo-id.
==========  =======  ======================================================================

Examples
========

Programmatic example
--------------------


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
        dojo.require("dojox.widget.rotator.Controller");
        dojo.require("dojox.widget.rotator.Fade");

        dojo.ready(function(){
            var myAutoRotatorInstance1 = new dojox.widget.AutoRotator(
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

            new dojox.widget.rotator.Controller(
                { rotator: myAutoRotatorInstance1 },
                dojo.byId("myRotatorController")
            );
        });

  .. html ::

    <div id="myAutoRotator1" class="rotator"></div>
    <div id="myRotatorController"></div>

    <button onclick="dojo.publish('myAutoRotator1/rotator/control', ['prev']);">Prev</button>
    <button onclick="dojo.publish('myAutoRotator1/rotator/control', ['next']);">Next</button>


Declarative example
-------------------


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
        dojo.require("dojox.widget.rotator.Controller");
        dojo.require("dojox.widget.rotator.Fade");
  
  .. html ::

    <div data-dojo-type="dojox.widget.AutoRotator" class="rotator" id="myAutoRotator2" data-dojo-id="myAutoRotatorInstance2" data-dojo-props="transition:'dojox.widget.rotator.crossFade', duration:2500">
        <div class="pane pane0">Pane 0</div>
        <div class="pane pane1">Pane 1</div>
        <div class="pane pane2">Pane 2</div>
    </div>

    <h3>Default Controller</h3>
    <div data-dojo-type="dojox.widget.rotator.Controller" data-dojo-props="rotator:myAutoRotatorInstance2"></div>

    <h3>Prev, Numbers, Next</h3>
    <div data-dojo-type="dojox.widget.rotator.Controller" data-dojo-props="rotator:myAutoRotatorInstance2, commands:'prev,#,next'"></div>

See also
========

* :ref:`dojox.widget.Rotator <dojox/widget/Rotator>` rotates through a series of panes using a transitions.
* :ref:`dojox.widget.AutoRotator <dojox/widget/AutoRotator>` adds automatic rotating to a Rotator.
