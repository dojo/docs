.. _dojo/toggleClass:

================
dojo.toggleClass
================

:Project owner: Eugene Lazutkin
:since: V0.9

.. contents ::
   :depth: 2

Simply toggles (adds or removes) a CSS class.

Introduction
============

dojo.toggleClass adds a class to node if not present, or removes if present.

Since Dojo 1.7, ``dojo.toggleClass`` is exposed via the ``toggle()`` method of the :ref:`dojo/dom-class <dojo/dom-class>` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

The function takes up to three arguments:

1. A DOM node or its node id (as a string).
2. A CSS class name as a string.
3. Optional. A Boolean flag. If ``true`` we add classes, otherwise we remove classes. If not specified, the class will be removed if it is already present on the node, and added otherwise.


Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``toggle`` is accessed from the ``dojo/dom-class`` module.

.. js ::

  require(["dojo/dom-class"], function(domClass){
      domClass.toggle("someNode", "hovered");
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.toggleClass`` in the ``define`` or ``require`` callback:

.. js ::

  require(["dojo"], function(dojo){
      dojo.toggleClass("someNode", "hovered");
  });

Dojo < 1.7
----------

.. js ::

    dojo.toggleClass("someNode", "hovered");

Examples
========

Simple toggle
-------------

The following example adds the class "style1" to the node "example1", if there is no such class for this node or removes it, if there is already such a class:

.. js ::

  // dojo 1.7+ (AMD)
  require(["dojo/dom-class"], function(domClass){
      domClass.toggle("example1", "style1");
  });

  // dojo < 1.7
  dojo.toggleClass("example1", "style1");

See it in action:

.. code-example ::

  .. css ::

        .style1 { background-color: #7c7c7c; color: #ffbf00; border: 1px solid #ffbf00; padding: 20px;}

  .. js ::

        dojo.require("dojo.parser");
        dojo.require("dijit.form.Button");

        function toggle1(){
            // add or remove the class "style1" to/from the node "example1":
            dojo.toggleClass("example1", "style1");
        }

        dojo.ready(function(){
            dojo.connect(dojo.byId("button1"), "onclick", toggle1);
        });

  .. html ::

    <div id="example1">This node will be changed.</div>
    <button id="button1" data-dojo-type="dijit.form.Button" type="button">Toggle class</button>


Forcefully add a class
----------------------

The following example adds the class "style2" to the node "example2", no matter if there is already such a class for this node or not:

.. js ::

  // dojo 1.7+ (AMD)
  require(["dojo/dom-class"], function(domClass){
      domClass.toggle("example2", "style2", true);
  });

  // dojo < 1.7
  dojo.toggleClass("example2", "style2", true);

See it in action:

.. code-example ::

  .. css ::

        .style2 { background-color: #7c7c7c; color: #ffbf00; border: 1px solid #ffbf00; padding: 20px;}
        .additionalStyle { border: 5px solid #ffbf00; padding: 20px;}

  .. js ::

        dojo.require("dojo.parser");
        dojo.require("dijit.form.Button");

        function toggle2(){
            // add or remove the class "style2" to/from the node "example2":
            dojo.toggleClass("example2", "style2", true);
        }

        dojo.ready(function(){
            dojo.connect(dojo.byId("button2"), "onclick", toggle2);
        });

  .. html ::

    <div id="example2" class="additionalStyle">This node will be changed.</div>
    <button id="button2" data-dojo-type="dijit.form.Button" type="button">Add a class forcefully</button>


Toggle multiple nodes
---------------------

toggleClass is also available for :ref:`NodeLists <dojo/NodeList>`, so that it's also possible to toggle the class for multiple nodes. The following example toggles the class for each node in the NodeList returned from dojo.query:

.. js ::

  // dojo 1.7+ (AMD)
  require(["dojo/query", "dojo/NodeList-dom"], function(query){
      query("#example3 div").toggleClass("style3");
  });

  // dojo < 1.7
  dojo.query("#example3 div").toggleClass("style3");

See it in action:

.. code-example ::

  .. css ::

        .style3 { background-color: #7c7c7c; color: #ffbf00; padding: 10px }
        .additionalStyle3 { background-color: #491f00; color: #36d900 }

  .. js ::

        dojo.require("dojo.parser");
        dojo.require("dijit.form.Button");

        function toggle3(){
            // add or remove the class "style3" to/from each <div> node:
            dojo.query("#example3 div").toggleClass("style3");
        }

        dojo.ready(function(){
            dojo.connect(dojo.byId("button3"), "onclick", toggle3);
        });

  .. html ::

    <div id="example3" class="additionalStyle3">
        <div>This node will be changed.</div>
        <div>This node also.</div>
        <div>And this is the last one.</div>
    </div>
    <button id="button3" data-dojo-type="dijit.form.Button" type="button">Toggle multiple nodes</button>

Technical information
=====================

This function is a simple convenience wrapper for :ref:`dojo.hasClass <dojo/hasClass>`, :ref:`dojo.addClass <dojo/addClass>` and :ref:`dojo.removeClass <dojo/removeClass>`.  A simplified version would look something like this:

.. js ::
  
  // dojo 1.7+ (AMD)
  require(["dojo/dom-class"], function(domClass){
    function toggle(node, classStr, condition){
      if(condition === undefined){
        condition = !domClass.contains(node, classStr);
      }
      domClass[condition ? "add" : "remove"](node, classStr);
    }
  });

  // dojo < 1.7
  dojo.toggleClass = function(node, classStr, condition){
    if(condition === undefined){
      condition = !dojo.hasClass(node, classStr);
    }
    dojo[condition ? "addClass" : "removeClass"](node, classStr);
  };


See also
========

* :ref:`dojo.addClass <dojo/addClass>`
* :ref:`dojo.hasClass <dojo/hasClass>`
* :ref:`dojo.removeClass <dojo/removeClass>`
