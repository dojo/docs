#format dojo_rst

dojo.empty
==========

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

Empty the contents of a DOM element. dojo.empty deletes all children but keeps the node there.


============
Introduction
============

dojo.empty safely removes all children of the node.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // Empty node's children byId:
   dojo.empty("someId");
 </script>

This function only works with DomNodes, and returns nothing.

=========  ==============  =============================================================================
Parameter  Type            Description
=========  ==============  =============================================================================
node       String|DomNode  A String ID or DomNode reference of the element to empty.
=========  ==============  =============================================================================


========
Examples
========

Empty a single node
---------------------

.. code-example::

  .. javascript::
    :label: Empty a DomNode

    <script type="text/javascript">
    dojo.require("dijit.form.Button");

    dojo.addOnLoad(function(){
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
    </script>

  .. html::
    :label: Some DomNodes

    <div id="testnode1">TestNode 1</div>
    <button id="progButtonNode" type="button"></button>
    <div id="result1"></div>


Empty all nodes in a list by reference
--------------------------------------

.. code-example::

  .. css::

    <style type="text/css">
    .green { color: white; min-width: 30px; min-height: 30px; 
        border: 1px #4d4d4d solid; margin-top: 4px; margin-right: 5px; 
        float: left; background-color: green }
    .red { color: white; min-width: 30px; min-height: 30px; 
        border: 1px #4d4d4d solid; margin-top: 4px; margin-right: 5px; 
        float: left; background-color: red }
    </style>

  .. javascript::
    :label: Empty all Nodes in a list by reference

    <script type="text/javascript">
    dojo.require("dijit.form.Button");

    dojo.addOnLoad(function(){
        // Create a button programmatically:
        var button2 = new dijit.form.Button({
            label: "Empty all red nodes",
            onClick: function(){
                // Empty all nodes in a list by reference:
                dojo.query(".go").forEach(dojo.empty);
                dojo.byId("result2").innerHTML = "All red nodes were emtpied.";
            }
        }, "progButtonNode2");

    });
    </script>

  .. html::
    :label: Some DomNodes

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

    <button id="progButtonNode2" type="button"></button>
    <div id="result2"></div>


========
See also
========

* `dojo.destroy <dojo/destroy>`_
* `DOM Utilities <quickstart/dom>`_
