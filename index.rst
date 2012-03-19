.. _index:

============================
Dojo Toolkit Reference Guide
============================

.. contents ::
   :depth: 2

Welcome
=======

Dojo is a collection of JavaScript utilities providing solutions for a vast array of problems faced by the professional
JavaScript developer. This reference guide provides information on the following:

* `Dojo Base`_ is the foundation of the Dojo Toolkit and functionality such as DOM and AJAX convenience methods,
  animations, and other base functionality suitable for building simple Web sites.

* `Dojo Core`_ is a larger set of components built upon `Dojo Base`_ and includes things such as drag and drop, l10n and
  i18n components, and data stores.

* `Dijit`_ is a complete widget system, providing all core UI components and utilities.

* `DojoX`_ is a collection of advanced components, including data grids, low-level graphics libraries, mobile
  components, and other experimental software.

* `Utilities`_ section provides extensive information about the :ref:`Dojo Build system <build/index>`, :ref:`Dojo
  Module Loader <loader/index>`, and a variety of other Dojo-related utilities.

There are some additional resources within this reference guide as well:

* :ref:`Quick-Start Guides <quickstart/index>` - covering various topics, linking to related module documentation.

* :ref:`Developer Notes <developer/index>` - Various topics that are related to development of the toolkit

* :ref:`Release Notes <releasenotes/index>` - The release notes for Dojo, Dijit, DojoX and Utils

Dojo Base
=========

The base functionality of the Dojo Toolkit is provided by just including ``dojo.js``. This includes tons of features
like :ref:`CSS-based queries <dojo/query>`, :ref:`event handling <quickstart/events>`, 
:ref:`animations <quickstart/Animation>`, :ref:`Ajax <quickstart/ajax>`, :ref:`class-based programming <dojo/declare>`, 
and a package system that makes getting access to the rest of :ref:`Dojo <dojo/index>` a snap.

.. code-example ::

  An example doing a basic animation

  .. js ::

    require(["dojo/query", "dojo/_base/fx", "dojo/_base/connect", "dojo/domReady!"],
    function(query, baseFx, conn){
      query("#showMe").on("click", function(e){
        var node = this,
            anim = baseFx.anim(node, {
              backgroundColor: "#363636",
              color: "#f7f7f7"
            }, 1000);
    
        conn.connect(anim, "onEnd", function(){
          baseFx.anim(node, { color: "#363636" }, null, null, function(){
            node.innerHTML = "wow, that was easy!";
            baseFx.anim(node, { color: "white" });
          });
        });
      });
    });

  .. html ::

    <div id="showMe" style="padding: 10px;">click here to see how it works</div>

Checkout the :ref:`full contents <dojo/index>` of the Dojo modules.

Dojo Core
=========

Additional stable (but optional) components for :ref:`advanced animations <dojo/fx>`, :ref:`I/O <dojo/io>`, 
:ref:`data <dojo/data>`, :ref:`Drag and Drop <dojo/dnd>` and much more.

.. code-example ::

  An example using a built in module ``dojo/fx/easing``

  .. js ::

    require(["dojo/query", "dojo/_base/fx", "dojo/fx/easing", "dojo/domReady!"],
    function(query, baseFx, easing){
      query("#showMe2").on("click", function(e){
        baseFx.animateProperty({
          node: e.target,
          properties: {
            marginLeft: 200
          },
          easing: easing.elasticOut,
          duration: 1200,
          onEnd: function(n){
            baseFx.anim(n, { marginLeft: 2 }, 2000, easing.bounceOut);
          }
        }).play();
      });
    });

  .. html ::

    <div id="showMe2" style="padding: 10px; margin-left:2px;">
         Click to Animate me with built in easing functions.
    </div>

Dijit
=====

Dijit is Dojo's theme-able, accessible (i18n, l10n), easy-to-customize UI Library. Dijit requires `Dojo Base`_ and various `Dojo Core`_ modules to use. 

* :ref:`Quickstart Guides <quickstart/index>`
* :ref:`Dijit Reference <dijit/info>`
* :ref:`Overview of Components <dijit/index>`

    * :ref:`Layouts <dijit/layout>`
    * :ref:`Form Components <dijit/form>`

DojoX
=====

DojoX contains a number of sub-projects based on `Dojo Base`_. Once can consider these projects Dojo e\ **X**\tensions
or e\ **X**\periments. Each project has a varying states of maturity -- from very stable and robust, to alpha and e\
**X**\perimental. All DojoX projects, at the least, contain ``README`` files that outline their maturity and authorship,
so be sure to check those along with the documentation pages to get the full picture of where a module is headed.

Visit the :ref:`DojoX Reference Index <dojox/index>` to begin the adventure.

Utilities
=========

Dojo ships a number of additional utility projects for internal use and general user consumption. The various 
utilities are outlined in their respective pages:

* :ref:`Dojo Build System <build/index>` - optimize various types of resources
* :ref:`DOH <util/doh>` - Dojo Objective Harness, a unit test framework
* :ref:`Dojo Developer Notes <developer/index>` - various 
* :ref:`Dojo Doc System <util/doctools>`
* :ref:`More about Util <util/index>`
