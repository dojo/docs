.. _dojo/fx/Toggler:

===============
dojo/fx/Toggler
===============

:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:since: V1.0

.. contents ::
    :depth: 2

**dojo/fx/Toggler** is a helper class for wrapping a DOM node with 'FX' to use when showing and hiding that node. By
default it uses the :ref:`dojo/_base/fx::fadeIn() <dojo/_base/fx#fadein>` for showing and :ref:`dojo/_base/fx::fadeOut()
<dojo/_base/fx#fadeout>` for hiding of a node. The Toggler is set up by passing in an JavaScript object of parameters
that define the node, the animation functions to use, and the duration for the show and hide operations.


Constructor Parameters
======================

+-------------------------------+--------------------------------------------------------------------------------------------+
+**Parameter**                  |**Description**                                                                             |
+-------------------------------+--------------------------------------------------------------------------------------------+
| node                          |The domNode or node id create the toggler for.                                              |
|                               |                                                                                            |
|                               |**required**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| showDuration                  |How long, in milliseconds, the show animation should take.  The default is 200 milliseconds |
|                               |(.2 seconds).                                                                               |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| showFunc                      |The animation function to use when showing the node.  The default is *dojo.fadeIn*.         |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| hideDuration                  |How long, in milliseconds, the hide animation should take.  The default is 200 milliseconds |
|                               |(.2 seconds).                                                                               |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| hideFunc                      |The animation function to use when hiding the node.  The default is *dojo.fadeOut*.         |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+

show() and hide() return values
===============================

The functions *Toggler.show()* and *Toggler.hide()* both return the animation object for the animation in play.  This object can be used to stop, pause, set the current animation location 'percentage', and get the status of the animation.  For more information on animation objects, refer to the excellent :ref:`Animation Quickstart <quickstart/Animation>`

Examples
========

Example 1:  Toggle a DOM node (with defaults)
---------------------------------------------

.. code-example ::
  
  .. js ::

    require(["dojo/fx/Toggler", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(Toggler, dom, on){
      var toggler = new Toggler({
        node: "basicNode"
      });
      on(dom.byId("hideButton"), "click", function(e){
        toggler.hide();
      });
      on(dom.byId("showButton"), "click", function(e){
        toggler.show();
      });
    });

  .. html ::

    <button type="button" id="hideButton">Hide the node! </button>
    <button type="button" id="showButton">Show the node! </button>
    <div id="basicNode" style="width: 200px; background-color: red;">
      <b>This is a container of random content to toggle!</b>
    </div>

Example 2:  Toggle a DOM node with custom durations
---------------------------------------------------

.. code-example ::

  This example has a slow fade out and a slowish fade in.

  .. js ::

    require(["dojo/fx/Toggler", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(Toggler, dom, on){
      var toggler = new Toggler({
        node: "basicNode",
        showDuration: 3000,
        hideDuration: 5000
      });
      on(dom.byId("hideButton"), "click", function(e){
        toggler.hide();
      });
      on(dom.byId("showButton"), "click", function(e){
        toggler.show();
      });
    });

  .. html ::

    <button type="button" id="hideButton">Hide the node! </button>
    <button type="button" id="showButton">Show the node! </button>
    <div id="basicNode" style="width: 200px; background-color: red;">
      <b>This is a container of random content to toggle!</b>
    </div>

Example 3:  Toggle a DOM node with custom animation functions
-------------------------------------------------------------

.. code-example ::

  This examples uses the `wipeOut` and `wipeIn` functions.

  .. js ::

    require(["dojo/fx/Toggler", "dojo/fx", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(Toggler, coreFx, dom, on){
      var toggler = new Toggler({
        node: "basicNode",
        showFunc: coreFx.wipeIn,
        hideFunc: coreFx.wipeOut
      });
      on(dom.byId("hideButton"), "click", function(e){
        toggler.hide();
      });
      on(dom.byId("showButton"), "click", function(e){
        toggler.show();
      });
    });

  .. html ::

    <button type="button" id="hideButton">Hide the node! </button>
    <button type="button" id="showButton">Show the node! </button>
    <div id="basicNode" style="width: 200px; background-color: red;">
      <b>This is a container of random content to toggle!</b>
    </div>
