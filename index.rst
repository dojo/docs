.. _index:

Dojo Toolkit Reference Guide
============================

.. contents::
   :depth: 2

=======
Welcome
=======

Dojo is a collection of JavaScript utilities providing solutions for a vast array of problems faced by the professional JavaScript developer. 

This document broken into logically related sections and attempts to document the full breadth of Dojo: `Dojo Base`_, the foundation of the Dojo Toolkit. `Dojo Core`_ being utilities built upon `Dojo Base`_. Dijit_ provides all core UI components and utilities, and DojoX_ ... building on everything else. Finally, the Utilities_ section provides extensive information about the :ref:`Dojo Build system <build/index>`, :ref:`Dojo Module Loader <loader/index>`, and a variety of other Dojo-related utilities.

=========
Dojo Base
=========

The base functionality of the Dojo Toolkit, provided by just including ``dojo.js``. This includes tons of features
like :ref:`CSS-based queries <dojo/query>`, :ref:`event handling <quickstart/events>`, :ref:`animations <quickstart/Animation>`, :ref:`Ajax <quickstart/ajax>`, :ref:`class-based programming <dojo/declare>`, and a package system that makes 
getting access to the rest of :ref:`Dojo <dojo/index>` a snap.

.. code-example ::

  .. js ::

        dojo.ready(function(){
            dojo.query("#showMe").onclick(function(e){
                var node = this,
                    anim = dojo.anim(node, {
                        backgroundColor: "#363636",
                        color: "#f7f7f7"
                    }, 1000)
                ;

                dojo.connect(anim, "onEnd", function(){
                    dojo.anim(node, { color: "#363636" }, null, null, function(){
                        node.innerHTML = "wow, that was easy!";
                        dojo.anim(node, { color: "white" });
                    });
                });
            });
        });

  .. html ::

    <div id="showMe" style="padding: 10px;">click here to see how it works</div>


=========
Dojo Core
=========

Additional stable (but optional) components for :ref:`advanced animations <dojo/fx>`, :ref:`I/O <dojo/io>`, :ref:`data <dojo/data>`, :ref:`Drag and Drop <dojo/dnd>` and much more.

.. code-example ::

  An example using a built in module ``dojo.fx.easing``

  .. js ::

    dojo.require("dojo.fx");
    dojo.require("dojo.fx.easing");
    dojo.ready(function(){

        dojo.query("#showMe2").onclick(function(e){
            
            dojo.animateProperty({
                node: e.target,
                properties:{
                    marginLeft:200
                },
                easing: dojo.fx.easing.elasticOut,
                duration:1200,
                onEnd: function(n){
                    dojo.anim(n, { marginLeft:2 }, 2000, dojo.fx.easing.bounceOut);
                }
            }).play();
            
        });
        
    });

  .. html ::

    <div id="showMe2" style="padding: 10px; margin-left:2px;">
         Click to Animate me with built in easing functions.
    </div>

=====
Dijit
=====

Dijit is Dojo's theme-able, accessible, easy-to-customize UI Library. There are many widgets to choose from, so be sure to check out the :ref:`quickstart <quickstart/index>` guide which covers the basics. Dijit requires ``dojo.js`` and other `Dojo Core`_ modules.

* :ref:`Dijit Reference <dijit/index>`

=====
DojoX
=====

DojoX contains a number of sub-projects based on `Dojo Base`_. Once can consider these projects Dojo e**X**tensions or e**x**periments. Each project has a varying states of maturity -- from very stable and robust, to alpha and e**x**perimental. All DojoX projects, at the least, contain ``README`` files that outline their maturity and authorship, so be sure to check those along with the documentation pages to get the full picture of where a module is headed.

Visit the :ref:`DojoX Reference Index <dojox/index>` to begin the adventure.

=========
Utilities
=========

Dojo ships a number of additional utility projects for internal use and general user consumption. The various utilities are outlined in their respective pages:

* :ref:`Dojo Build Sytem <build/index>` - optimize various types of resources
* :ref:`DOH <util/doh>` - Dojo Objective Harness, a unit test framework
* :ref:`Dojo Developer Notes <developer/index>` - various 
* :ref:`Dojo Doc System <util/doctools>`
* :ref:`More about Util <util/index>`
