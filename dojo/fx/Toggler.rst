#format dojo_rst

dojo.fx.Toggler
===============

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:Available: since V1.0

.. contents::
    :depth: 2

The dojo.fx.Toggler is a helper class for wrapping a DOM node with 'FX' to use when showing and hiding that node.  By default it uses the `dojo.fadeIn <dojo/fadeIn>`_ for showing and `dojo.fadeOut <dojo/fadeOut>`_ for hiding of a node.  The Togger is set up by passing in an JavaScript object of parameters that define the node, the animation functions to use, and the duration for the show and hide operations.


======================
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

===============================
show() and hide() return values
===============================

The functions *Toggler.show()* and *Toggler.hide()* both return the animation object for the animation in play.  This object can be used to stop, pause, set the current animation location 'percentage', and get the status of the animation.  For more information on animation objects, refer to the excellent `Animation Quickstart <quickstart/Animation>`_

========
Examples
========

Example 1:  Toggle a DOM node (with defaults)
---------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx");
      function basicToggle(){
         var toggler = new dojo.fx.Toggler({
           node: "basicNode"
         });
         dojo.connect(dijit.byId("showButton"), "onClick", toggler, "show");
         dojo.connect(dijit.byId("hideButton"), "onClick", toggler, "hide");
      }
      dojo.addOnLoad(basicToggle);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="hideButton">Hide the node!</button>
    <button dojoType="dijit.form.Button" id="showButton">Show the node!</button>
    <div id="basicNode" style="width: 200px; background-color: red;">
      <b>This is a container of random content to toggle!</b>
    </div>

Example 2:  Toggle a DOM node with custom durations
---------------------------------------------------

*This example has a slow fade out and a slowish fade in.*

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx");
      function basicToggle1(){
         var toggler = new dojo.fx.Toggler({
           node: "basicNode1",
           showDuration: 3000,
           hideDuration: 5000
         });
         dojo.connect(dijit.byId("showButton1"), "onClick", toggler, "show");
         dojo.connect(dijit.byId("hideButton1"), "onClick", toggler, "hide");
      }
      dojo.addOnLoad(basicToggle1);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="hideButton1">Hide the node!</button>
    <button dojoType="dijit.form.Button" id="showButton1">Show the node!</button>
    <div id="basicNode1" style="width: 200px; background-color: red;">
      <b>This is a container of random content to toggle!</b>
    </div>

Example 2:  Toggle a DOM node with custom animation functions
-------------------------------------------------------------

*This example uses the wipeOut and wipeIn functions.*

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx");
      function basicToggle2(){
         var toggler = new dojo.fx.Toggler({
           node: "basicNode2",
           showFunc: dojo.fx.wipeIn,
           hideFunc: dojo.fx.wipeOut
         });
         dojo.connect(dijit.byId("showButton2"), "onClick", toggler, "show");
         dojo.connect(dijit.byId("hideButton2"), "onClick", toggler, "hide");
      }
      dojo.addOnLoad(basicToggle2);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="hideButton2">Hide the node!</button>
    <button dojoType="dijit.form.Button" id="showButton2">Show the node!</button>
    <div id="basicNode2" style="width: 200px; background-color: red;">
      <b>This is a container of random content to toggle!</b>
    </div>
