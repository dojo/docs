#format dojo_rst

dojo.destroy
============

:Project owner: Peter Higgins
:Available: since V1.3

.. contents::
   :depth: 2

Destroys a DOM element. dojo.destroy deletes all children and the node itself.


============
Introduction
============

dojo.destroy removes a node from its parent, clobbering it and all of its children.

Since dojo 1.7, dojo.destroy has been kept in dojo/_base/html as a compatibility of dojo version before, it is an alias of ctr.destroy in dojo/dom.

=====
Usage
=====

Dojo 1.7 (AMD)
--------------

.. code-block :: javascript
 :linenos:

  <script type="text/javascript">
    require(["dojo/_base/html"], function(dojo){     
       // Destroy a node byId:
       dojo.destroy("someId");
    });
  </script>

It's recommended to use ctr.destroy in dojo 1.7.

.. code-block :: javascript
 :linenos:

  <script type="text/javascript">
    require(["dojo/dom-construct"], function(ctr){  // Note, ctr or any other variable name can be used      
       // Destroy a node byId:
       ctr.destroy("someId");
    });
  </script>

Dojo < 1.7
----------

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // Destroy a node byId:
   dojo.destroy("someId");
 </script>

This function only works with DomNodes, and returns nothing.

=========  ==============  =============================================================================
Parameter  Type            Description
=========  ==============  =============================================================================
node       String|DomNode  A String ID or DomNode reference of the element to be destroyed.
=========  ==============  =============================================================================


========
Examples
========

Destroy a single node
---------------------

.. code-example::

  .. javascript::
    :label: Destroy a DomNode

    <script type="text/javascript">
    dojo.require("dijit.form.Button");

    dojo.addOnLoad(function(){
        // Create a button programmatically:
        var button = new dijit.form.Button({
            label: "Destroy TestNode1",
            onClick: function(){
                // Destroy TestNode1:
                dojo.destroy("testnode1");
                dojo.byId("result1").innerHTML = "TestNode1 was destroyed.";
            }
        }, "progButtonNode");

    });
    </script>

  .. html::
    :label: Some DomNodes to destroy

    <div id="testnode1">TestNode 1</div>
    <button id="progButtonNode" type="button"></button>
    <div id="result1"></div>


Destroy all nodes in a list by reference
----------------------------------------

.. code-example::

  .. css::

    <style type="text/css">
    .stay { width: 30px; height: 30px; border: 1px #4d4d4d solid; margin-top: 4px; margin-right: 5px; float: left; background-color: green }
    .go { width: 30px; height: 30px; border: 1px #4d4d4d solid; margin-top: 4px; margin-right: 5px; float: left; background-color: red }
    </style>

  .. javascript::
    :label: Destroy all Nodes in a list by reference

    <script type="text/javascript">
    dojo.require("dijit.form.Button");

    dojo.addOnLoad(function(){
        // Create a button programmatically:
        var button2 = new dijit.form.Button({
            label: "Destroy all red nodes",
            onClick: function(){
                // Destroy all nodes in a list by reference:
                dojo.query(".go").forEach(dojo.destroy);
                dojo.byId("result2").innerHTML = "All red nodes were destroyed.";
            }
        }, "progButtonNode2");

    });
    </script>

  .. html::
    :label: Some DomNodes to destroy

    <div class="stay">&nbsp;</div>
    <div class="stay">&nbsp;</div>
    <div class="go">&nbsp;</div>
    <div class="stay">&nbsp;</div>
    <div class="go">&nbsp;</div>
    <div class="stay">&nbsp;</div>
    <div class="stay">&nbsp;</div>
    <div class="go">&nbsp;</div>
    <div class="go">&nbsp;</div>
    <div class="stay">&nbsp;</div>
    <div class="stay">&nbsp;</div>
    <div class="go">&nbsp;</div>
    <button id="progButtonNode2" type="button"></button>
    <div id="result2"></div>


========
See also
========

* `dojo.place <dojo/place>`_
* `dojo.create <dojo/create>`_
* `dojo.empty <dojo/empty>`_
* `DOM Utilities <quickstart/dom>`_
* `How to destroy a dijit widget <dijit/_Widget#lifecycle>`_
