.. _dojo/removeClass:

================
dojo.removeClass
================

:Project owner: Eugene Lazutkin
:since: V0.9

.. contents ::
   :depth: 2

Removes a class or a list of classes from a DOM node.

Introduction
============

Follows the same pattern as most Dojo functionality by accepting a string ID of a Node, or a DOM Node reference, removing a passed class from the class="" attribute.

Since Dojo 1.7, ``dojo.removeClass`` is exposed via the ``remove()`` method of the :ref:`dojo/dom-class <dojo/dom-class>` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.


Usage
=====

The function takes up to two arguments:

1. A DOM node or its node id (as a string).
2. Optional. A string, which can list classes separated by spaces, or an array of CSS classes as strings. In the latter case array elements cannot contain spaces.

If the second argument is not specified or ``undefined``, all classes will be removed.

Space-separated classes, arrays, and optional removing of all classes are supported since 1.4.

Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``remove`` is accessed from the ``dojo/dom-class`` module.

.. js ::

  require(["dojo/dom-class"], function(domClass){
      // Remove a class from some node:
      domClass.remove("someNode", "firstClass");
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.removeClass`` in the ``define`` or ``require`` callback:

.. js ::

  require(["dojo"], function(dojo){
      // Remove a class from some node:
      dojo.removeClass("someNode", "firstClass");
  });

Dojo < 1.7
----------

.. js ::

    // Remove a class from some node:
    dojo.removeClass("someNode", "firstClass");

Examples
========

Remove a class
--------------

The following example removes the class "style1" from the node "example1":

.. js ::

  // dojo 1.7+ (AMD)
  require(["dojo/dom-class"], function(domClass){
      domClass.remove("example1", "style1");
  });

  // dojo < 1.7
  dojo.removeClass("example1", "style1");

See it in action:

.. code-example ::

  .. css ::

        .style1 { background-color: #7c7c7c; color: #ffbf00; border: 1px solid #ffbf00; padding: 20px;}

  .. js ::

        dojo.require("dojo.parser");
        dojo.require("dijit.form.Button");

        function doIt(){
            // remove the class "style1" from the node "example1":
            dojo.removeClass("example1", "style1");
        }

        dojo.ready(function(){
            dojo.connect(dojo.byId("button1"), "onclick", doIt);
        });

  .. html ::

    <div id="example1" class="style1">This node will be changed.</div>
    <button id="button1" data-dojo-type="dijit.form.Button" type="button">Remove class</button>


Remove several classes as a string
----------------------------------

The following example removes two classes: "style1" and "style2" from the node "example1":

.. js ::

  // dojo 1.7+ (AMD)
  require(["dojo/dom-class"], function(domClass){
      domClass.remove("example1", "style1 style2");
  });

  // dojo < 1.7
  dojo.removeClass("example1", "style1 style2");

See it in action:

.. code-example ::

  .. css ::

        .style1 { background-color: #7c7c7c; color: #ffbf00;}
        .style2 { border: 1px solid #ffbf00; padding: 20px;}

  .. js ::

        dojo.require("dojo.parser");
        dojo.require("dijit.form.Button");

        function doIt(){
            // remove classes "style1" and "style2" from the node "example1":
            dojo.removeClass("example1", "style1 style2");
        }

        dojo.ready(function(){
            dojo.connect(dojo.byId("button1"), "onclick", doIt);
        });

  .. html ::

    <div id="example1" class="style2 style1">This node will be changed.</div>
    <button id="button1" data-dojo-type="dijit.form.Button" type="button">Remove classes</button>


Remove several classes as an array
----------------------------------

The following example removes two classes: "style1" and "style2" from the node "example1":

.. js ::

  // dojo 1.7+ (AMD)
  require(["dojo/dom-class"], function(domClass){
      domClass.remove("example1", ["style1", "style2"]);
  });

  // dojo < 1.7
  dojo.removeClass("example1", ["style1", "style2"]);

See it in action:

.. code-example ::

  .. css ::

        .style1 { background-color: #7c7c7c; color: #ffbf00;}
        .style2 { border: 1px solid #ffbf00; padding: 20px;}

  .. js ::

        dojo.require("dojo.parser");
        dojo.require("dijit.form.Button");

        function doIt(){
            // remove classes "style1" and "style2" from the node "example1":
            dojo.removeClass("example1", ["style1", "style2"]);
        }

        dojo.ready(function(){
            dojo.connect(dojo.byId("button1"), "onclick", doIt);
        });

  .. html ::

    <div id="example1" class="style2 style1">This node will be changed.</div>
    <button id="button1" data-dojo-type="dijit.form.Button" type="button">Remove classes</button>


Remove all classes
------------------

The following example removes all classes from the node "example1":

.. js ::

  // dojo 1.7+ (AMD)
  require(["dojo/dom-class"], function(domClass){
      domClass.remove("example1");
  });

  // dojo < 1.7
  dojo.removeClass("example1");

See it in action:

.. code-example ::

  .. css ::

        .style1 { background-color: #7c7c7c; color: #ffbf00;}
        .style2 { border: 1px solid #ffbf00; padding: 20px;}

  .. js ::

        dojo.require("dojo.parser");
        dojo.require("dijit.form.Button");

        function doIt(){
            // remove all classes from the node "example1":
            dojo.removeClass("example1");
        }

        dojo.ready(function(){
            dojo.connect(dojo.byId("button1"), "onclick", doIt);
        });

  .. html ::

    <div id="example1" class="style2 style1">This node will be changed.</div>
    <button id="button1" data-dojo-type="dijit.form.Button" type="button">Remove classes</button>


Remove from multiple nodes
--------------------------

``removeClass`` is also available for :ref:`NodeLists <dojo/NodeList>`, so that it's also possible to remove classes for multiple nodes. The following example removes the class for each node in the NodeList returned from dojo.query:

.. js ::

  // dojo 1.7+ (AMD)
  require(["dojo/query", "dojo/NodeList-dom"], function(query){
      query("#example3 div").removeClass("style3");
  });

  // dojo < 1.7
  dojo.query("#example3 div").removeClass("style3");

See it in action:

.. code-example ::

  .. css ::

        .style3 { background-color: #7c7c7c; color: #ffbf00; padding: 10px }
        .additionalStyle3 { background-color: #491f00; color: #36d900 }

  .. js ::

        dojo.require("dojo.parser");
        dojo.require("dijit.form.Button");

        function doIt(){
            // remove the class "style3" from each <div> node:
            dojo.query("#example3 div").removeClass("style3");
        }

        dojo.ready(function(){
            dojo.connect(dojo.byId("button3"), "onclick", doIt);
        });

  .. html ::

    <div id="example3" class="additionalStyle3">
        <div class="style3">This node will be changed.</div>
        <div class="style3">This node also.</div>
        <div class="style3">And this is the last one.</div>
    </div>
    <button id="button3" data-dojo-type="dijit.form.Button" type="button">Remove from multiple nodes</button>


See also
========

* :ref:`dojo.addClass <dojo/addClass>`
* :ref:`dojo.replaceClass <dojo/replaceClass>`
* :ref:`dojo.hasClass <dojo/hasClass>`
* :ref:`dojo.toggleClass <dojo/toggleClass>`
