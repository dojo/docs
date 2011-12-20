.. _dojo/destroy:

============
dojo.destroy
============

:Project owner: Peter Higgins
:since: V1.3

.. contents ::
   :depth: 2

Destroys a DOM element. dojo.destroy deletes all children and the node itself.


Introduction
============

dojo.destroy removes a node from its parent, clobbering it and all of its children.

Since Dojo 1.7, ``dojo.destroy`` is exposed via the ``destroy`` method of the ``dojo/dom-construct`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

Dojo 1.7 (AMD)
--------------

When using AMD format in a fully baseless application, ``destroy`` is accessed from the ``dojo/dom-construct`` module.

.. js ::
 
  require(["dojo/dom-construct"], function(domConstruct){
    // Destroy a node byId:
    domConstruct.destroy("someId");
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.destroy`` in the ``define`` or ``require`` callback:

.. js ::
 
  require(["dojo"], function(dojo){
    // Destroy a node byId:
    dojo.destroy("someId");
  });

Dojo < 1.7
----------

.. js ::
 
  // Destroy a node byId:
  dojo.destroy("someId");

This function only works with DomNodes, and returns nothing.

Examples
========

Destroy a single node
---------------------

.. code-example::

  Destroy a DomNode

  .. js ::

    dojo.require("dijit.form.Button");

    dojo.ready(function(){
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

  Some DomNodes to destroy
  
  .. html ::

    <div id="testnode1">TestNode 1</div>
    <button id="progButtonNode" type="button"></button>
    <div id="result1"></div>


Destroy all nodes in a list by reference
----------------------------------------

.. code-example::

  .. css ::

    .stay { width: 30px; height: 30px; border: 1px #4d4d4d solid; margin-top: 4px; margin-right: 5px; float: left; background-color: green }
    .go { width: 30px; height: 30px; border: 1px #4d4d4d solid; margin-top: 4px; margin-right: 5px; float: left; background-color: red }

  Destroy all Nodes in a list by reference
  
  .. js ::

    dojo.require("dijit.form.Button");

    dojo.ready(function(){
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

  Some DomNodes to destroy
  
  .. html ::
    
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

.. api-inline :: dojo.destroy

See also
========

* :ref:`dojo.place <dojo/place>`
* :ref:`dojo.create <dojo/create>`
* :ref:`dojo.empty <dojo/empty>`
* :ref:`DOM Utilities <quickstart/dom>`
* :ref:`How to destroy a dijit widget <dijit/_Widget>`
