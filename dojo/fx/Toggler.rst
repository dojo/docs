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
default it uses the :ref:`dojo/_base/fx::fadeIn() <dojo/_base/fx#fadein>` for showing and :ref:`dojo/_base/fx::fadeOut() <dojo/_base/fx#fadeout>` for hiding of a node. The Toggler is set up by passing in an JavaScript object of parameters
that define the node, the animation functions to use, and the duration for the show and hide operations.

Usage
=====

Usage is creating a new instance of the class, passing at least the DOMNode that the instance should relate to:

.. js ::

  require(["dojo/fx/Toggler"], function(Toggler),{
    // Create a new Toggler with default options
    var toggler = new Togger({
      node: "someId"
    });
    
    // Hide the node
    toggler.hide();
    
    // Show the node
    toggler.show();
  });

The constructor takes a hash of parameters:

============ ============== ============================================================================================
Parameter    Type           Description
============ ============== ============================================================================================
node         DOMNode|String The DOMNode or ID of the node that the Toggler applies to
showDuration Integer?       *Optional* How long, in milliseconds, the show function is applied for.  Defaults to 
                            ``200``.
showFunc     Function?      *Optional* The function that is applied on ``.show()``.  Defaults to 
                            :ref:`dojo/_base/fx::fadeIn() <dojo/_base/fx#fadein>`
hideDuration Integer?       *Optional* How long, in milliseconds, the hide function is applied for.  Default to ``200``.
hideFuc      Function?      *Optional* The function that is applied on ``.hide()``.  Defaults to 
                            :ref:`dojo/_base/fx::fadeOut() <dojo/_base/fx#fadeout>`
============ ============== ============================================================================================

show()
------

This method plays the show animation and takes one optional argument:

======== ======== ======================================================================================================
Argument Type     Description
======== ======== ======================================================================================================
delay    Integer? *Optional* The amount of time, in milliseconds, that the animation should be delayed before starting.  
                  Defaults to ``0``.
======== ======== ======================================================================================================

``.show()`` returns an instance of :ref:`dojo/_base/fx::Animation <dojo/_base/fx#animation>`.

hide()
------

This method plays the hide animation and takes one optional argument:

======== ======== ======================================================================================================
Argument Type     Description
======== ======== ======================================================================================================
delay    Integer? *Optional* The amount of time, in milliseconds, that the animation should be delayed before starting.  
                  Defaults to ``0``.
======== ======== ======================================================================================================

``.hide()`` returns an instance of :ref:`dojo/_base/fx::Animation <dojo/_base/fx#animation>`.

Examples
========

Example 1:  Toggle a DOM node (with defaults)
---------------------------------------------

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

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
  :djConfig: async: true, parseOnLoad: false

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
  :djConfig: async: true, parseOnLoad: false

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

See also
========

* :ref:`dojo/_base/fx <dojo/_base/fx>` - Details on the Dojo Base FX Library

* :ref:`dojo/fx <dojo/fx>` - Overview of the Core FX Library

* :ref:`dojox/fx <dojox/fx>` - Additional FX libraries

* `Animation Tutorial <http://dojotoolkit.org/documentation/tutorials/1.7/animation/>`_ - The tutorial to find out about
  Dojo's FX API
