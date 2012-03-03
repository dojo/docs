.. _dojo/addClass:

=============
dojo.addClass
=============

:Project owner: Eugene Lazutkin
:since: V0.9

.. contents ::
   :depth: 2

Safely adds a CSS class or a set of classes to a node avoiding duplications.

Since Dojo 1.7, ``dojo.addClass`` is exposed via the ``.add()`` method of the :ref:`dojo/dom-class <dojo/dom-class>` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

The function takes two arguments:

1. A DOM node or its node id (as a string).
2. A string, which can list classes separated by spaces, or an array of CSS classes as strings. In the latter case array elements cannot contain spaces.

Space-separated classes and arrays are supported since 1.4.

Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``add`` is accessed from the ``dojo/dom-class`` module.

.. js ::

  require(["dojo/dom-class"], function(domClass){
      // Add a class to some node:
      domClass.add("someNode", "anewClass");
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.addClass`` in the ``define`` or ``require`` callback:

.. js ::

  require(["dojo"], function(dojo){
      // Add a class to some node:
      dojo.addClass("someNode", "anewClass");
  });

Dojo < 1.7
----------

.. js ::

    // Add a class to some node:
    dojo.addClass("someNode", "anewClass");

Examples
========

Add a class
-------------

The following example adds the class "style1" to the node "example1":

.. js ::

  // dojo 1.7+ (AMD)
  require(["dojo/dom-class"], function(domClass){
      domClass.add("example1", "style1");
  });

  // dojo < 1.7
  dojo.addClass("example1", "style1");

See it in action:

.. code-example ::

  .. css ::
    
        .style1 { background-color: #7c7c7c; color: #ffbf00; border: 1px solid #ffbf00; padding: 20px;}

  .. js ::

        dojo.require("dojo.parser");
        dojo.require("dijit.form.Button");

        function add1(){
            // add the class "style1" to the node "example1":
            dojo.addClass("example1", "style1");
        }

        dojo.ready(function(){
            dojo.connect(dojo.byId("button1"), "onclick", add1);
        });

  .. html ::

    <div id="example1">This node will be changed.</div>
    <button id="button1" data-dojo-type="dijit.form.Button" type="button">Add class</button>


Add several classes as a string
-------------------------------

The following example adds two classes: "style1" and "style2" to the node "example1":

.. js ::

  // dojo 1.7+ (AMD)
  require(["dojo/dom-class"], function(domClass){
      domClass.add("example1", "style1 style2");
  });

  // dojo < 1.7
  dojo.addClass("example1", "style1 style2");

See it in action:

.. code-example ::
 

  .. css ::
    
        .style1 { background-color: #7c7c7c; color: #ffbf00;}
        .style2 { border: 1px solid #ffbf00; padding: 20px;}

  .. js ::

        dojo.require("dojo.parser");
        dojo.require("dijit.form.Button");

        function add1(){
            // add classes "style1" and "style2" to the node "example1":
            dojo.addClass("example1", "style1 style2");
        }

        dojo.ready(function(){
            dojo.connect(dojo.byId("button1"), "onclick", add1);
        });

  .. html ::

    <div id="example1">This node will be changed.</div>
    <button id="button1" data-dojo-type="dijit.form.Button" type="button">Add classes</button>


Add several classes as an array
-------------------------------

The following example adds two classes: "style1" and "style2" to the node "example1":

.. js ::

  // dojo 1.7+ (AMD)
  require(["dojo/dom-class"], function(domClass){
      domClass.add("example1", ["style1", "style2"]);
  });

  // dojo < 1.7
  dojo.addClass("example1", ["style1", "style2"]);

See it in action:

.. code-example ::
  
  .. css ::
    
        .style1 { background-color: #7c7c7c; color: #ffbf00;}
        .style2 { border: 1px solid #ffbf00; padding: 20px;}

  .. js ::

        dojo.require("dojo.parser");
        dojo.require("dijit.form.Button");

        function add1(){
            // add classes "style1" and "style2" to the node "example1":
            dojo.addClass("example1", ["style1", "style2"]);
        }

        dojo.ready(function(){
            dojo.connect(dojo.byId("button1"), "onclick", add1);
        });

  .. html ::

    <div id="example1">This node will be changed.</div>
    <button id="button1" data-dojo-type="dijit.form.Button" type="button">Add classes</button>


Add to multiple nodes
---------------------

``addClass`` is also available for :ref:`NodeLists <dojo/NodeList>`, so that it's also possible to add classes for multiple nodes. The following example adds the class for each node in the NodeList returned from dojo.query:

.. js ::

  // dojo 1.7+ (AMD)
  require(["dojo/query", "dojo/NodeList-dom"], function(query){
      query("#example3 div").addClass("style3");
  });

  // dojo < 1.7
  dojo.query("#example3 div").addClass("style3");

See it in action:

.. code-example ::

  .. css ::
    
        .style3 { background-color: #7c7c7c; color: #ffbf00; padding: 10px }
        .additionalStyle3 { background-color: #491f00; color: #36d900 }

  .. js ::

        dojo.require("dojo.parser");
        dojo.require("dijit.form.Button");

        function add3(){
            // add the class "style3" to each <div> node:
            dojo.query("#example3 div").addClass("style3");
        }

        dojo.ready(function(){
            dojo.connect(dojo.byId("button3"), "onclick", add3);
        });

  .. html ::

    <div id="example3" class="additionalStyle3">
        <div>This node will be changed.</div>
        <div>This node also.</div>
        <div>And this is the last one.</div>
    </div>
    <button id="button3" data-dojo-type="dijit.form.Button" type="button">Add to multiple nodes</button>


See also
========

* :ref:`dojo.hasClass <dojo/hasClass>`
* :ref:`dojo.removeClass <dojo/removeClass>`
* :ref:`dojo.toggleClass <dojo/toggleClass>`
