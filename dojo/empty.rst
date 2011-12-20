.. _dojo/empty:

==========
dojo.empty
==========

:Project owner: Peter Higgins
:since: V1.0

.. contents ::
   :depth: 2

Empty the contents of a DOM element. dojo.empty deletes all children but keeps the node there.


Introduction
============

dojo.empty safely removes all children of the node.

Since Dojo 1.7, ``dojo.empty`` is exposed via the ``empty`` method of the ``dojo/dom-construct`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====


Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``empty`` is accessed from the ``dojo/dom-construct`` module.

.. js ::
 
  require(["dojo/dom-construct"], function(domConstruct){
    // Empty node's children byId:
    domConstruct.empty("someId");
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.empty`` in the ``define`` or ``require`` callback:

.. js ::
 
  require(["dojo"], function(dojo){
    // Empty node's children byId:
    dojo.empty("someId");
  });

Dojo < 1.7
----------

.. js ::
 
  // Empty node's children byId:
  dojo.empty("someId");

This function only works with DomNodes, and returns nothing.

Examples
========

Empty a single node
---------------------

.. code-example::

   Empty a DomNode
   
  .. js ::

    dojo.require("dijit.form.Button");

    dojo.ready(function(){
        // Create a button programmatically:
        var button = new dijit.form.Button({
            label: "Empty TestNode1",
            onClick: function(){
                // Empty TestNode1:
                dojo.empty("testnode1");
                dojo.byId("result1").innerHTML = "TestNode1 has been emptied.";
            }
        }, "progButtonNode");

    });

  Some DomNodes
  
  .. html ::
    
    <div id="testnode1">TestNode 1</div>
    <button id="progButtonNode" type="button"></button>
    <div id="result1"></div>


Empty all nodes in a list by reference
--------------------------------------

.. code-example::

  .. css ::

    .green { color: white; min-width: 30px; min-height: 30px;
        border: 1px #4d4d4d solid; margin-top: 4px; margin-right: 5px;
        float: left; background-color: green; padding: 2px }
    .red { color: white; min-width: 30px; min-height: 30px;
        border: 1px #4d4d4d solid; margin-top: 4px; margin-right: 5px;
        float: left; background-color: red; padding: 2px }
    #panel { clear: both }

  Empty all Nodes in a list by reference
  
  .. js ::

    dojo.require("dijit.form.Button");

    dojo.ready(function(){
        // Create a button programmatically:
        var button2 = new dijit.form.Button({
            label: "Empty all red nodes",
            onClick: function(){
                // Empty all nodes in a list by reference:
                dojo.query(".red").forEach(dojo.empty);
                dojo.byId("result2").innerHTML = "All red nodes were emptied.";
            }
        }, "progButtonNode2");

    });

  Some DomNodes
  
  .. html ::

    <div class="green">greenNode</div>
    <div class="green">greenNode</div>
    <div class="red">redNode</div>
    <div class="green">greenNode</div>
    <div class="green">greenNode</div>
    <div class="red">redNode</div>
    <div class="red">redNode</div>
    <div class="green">greenNode</div>
    <div class="green">greenNode</div>
    <div class="red">redNode</div>
    <div class="red">redNode</div>
    <div class="red">redNode</div>
    <div class="green">greenNode</div>
    <div class="green">greenNode</div>
    <div class="red">redNode</div>

    <div id="panel">
        <button id="progButtonNode2" type="button"></button>
        <div id="result2"></div>
    </div>

.. api-inline :: dojo.empty

See also
========

* :ref:`dojo.create <dojo/create>`
* :ref:`dojo.place <dojo/place>`
* :ref:`dojo.destroy <dojo/destroy>`
* :ref:`DOM Utilities <quickstart/dom>`
