.. _index:

Dojo Toolkit Reference Guide
============================

.. contents::
   :depth: 2

.. image:: /logodojocdocssmall.png
   :alt: Dojo Documentation
   :class: logowelcome;


====
Dojo
====

* :ref:`dojo.js <dojo/index>`

  The base functionality of the Dojo Toolkit, provided by just including ``dojo.js``. This includes tons of features like CSS-based queries, event handling, animations, Ajax, class-based programming, and a package system that makes getting access to the rest of Dojo a snap.

.. cv-compound::

  .. cv:: javascript

    <script>
        dojo.ready(function(){
            dojo.query("#showMe").onclick(function(e){
                var node = e.target;

                var a = dojo.anim(node, {
                    backgroundColor: "#363636",
                    color: "#f7f7f7"
                }, 1000);

                dojo.connect(a, "onEnd", function(){
                    dojo.anim(node, { color: "#363636" }, null, null, function(){
                        node.innerHTML = "wow, that was easy!";
                        dojo.anim(node, { color: "white" });
                    });
                });
            });
        });
    </script>

  .. cv:: html

    <div id="showMe" style="padding: 10px;">
        click here to see how it works
    </div>

* :ref:`Dojo Core <dojo/index>`

  Additional stable (but optional) components for advanced animations, I/O, data, Drag and Drop and much more.

.. cv-compound::

  .. cv:: javascript

    <script>
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
    </script>

  .. cv:: html

    <div id="showMe2" style="padding: 10px; margin-left:2px;">
         Click to Animate me with built in easing functions.
    </div>

=====
Dijit
=====

Dijit is Dojo's themeable, accessible, easy-to-customize UI Library. There are many widgets to choose from, so be sure to check out the :ref:`quickstart <quickstart/index>` guide which covers the basics. Dijit requires ``dojo.js`` and other Core modules. 

* :ref:`Dijit Reference <dijit/index>`

=====
DojoX
=====

DojoX stands for Dojo eXtensions and contains many useful sub-projects and varying states of maturity -- from very stable and robust, to alpha and experimental. All DojoX projects contain README files that outline their maturity and authorship, so be sure to check those along with the documentation pages to get the full picture of where a module is headed.

* :ref:`DojoX Reference <dojox/index>`


=====
DojoC
=====

DojoC is an external svn repository used by DojoCampus for a variety of widgets, tutorials, sandbox, and other demos. You are welcome to explore and contribute, though absolutely nothing is guaranteed to work. DojoC is meant as a community workshop, and code comes and goes frequently, often times 'promoted' to :ref:`DojoX projects <dojox/index>`.

* :ref:`More about DojoC <dojoc/index>`


=========
Utilities
=========

Dojo has a number of utility scripts, including the :ref:`Dojo Build System <build/index>`.

* :ref:`More about Util <util/index>`


=============
Miscellaneous
=============

* :ref:`Multiple Versions of Dojo on a Page <quickstart/multiversion>` - Dojo has special configuration and build options to allow you to use different versions of Dojo on the same page.

* :ref:`Developer Notes <developer/index>`
* :ref:`Styleguides <styleguides/index>` **obsolete**
