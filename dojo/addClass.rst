#format dojo_rst

dojo.addClass
=============

:Project owner: Eugene Lazutkin
:Available: since V0.9

.. contents::
   :depth: 2

Safely adds a CSS class or a set of classes to a node avoiding duplications.

=====
Usage
=====

The function takes two arguments:

1. A DOM node or its node id (as a string).
2. A string, which can list classes separated by spaces, or an array of CSS classes as strings. In the latter case array elements cannot contain spaces.

Space-separated classes and arrays are supported since 1.4.


========
Examples
========

Add a class
-------------

The following example adds the class "style1" to the node "example1":

.. code-block :: javascript

  dojo.addClass("example1", "style1");

See it in action:

.. cv-compound::

  .. css::
    :label: The CSS

    <style type="text/css">
        .style1 { background-color: #7c7c7c; color: #ffbf00; border: 1px solid #ffbf00; padding: 20px;}
    </style>

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");

        function add1() {
            // add the class "style1" to the node "example1":
            dojo.addClass("example1", "style1");
        }

        dojo.addOnLoad(function() {
            dojo.connect(dojo.byId("button1"), "onclick", add1);
        });
    </script>

  .. cv:: html

    <div id="example1">This node will be changed.</div>
    <button id="button1" dojoType="dijit.form.Button" type="button">Add class</button>


Add several classes as a string
-------------------------------

The following example adds two classes: "style1" and "style2" to the node "example1":

.. code-block :: javascript

  dojo.addClass("example1", "style1 style2");

See it in action:

.. cv-compound::
  :version: local

  .. css::
    :label: The CSS

    <style type="text/css">
        .style1 { background-color: #7c7c7c; color: #ffbf00;}
        .style2 { border: 1px solid #ffbf00; padding: 20px;}
    </style>

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");

        function add1() {
            // add classes "style1" and "style2" to the node "example1":
            dojo.addClass("example1", "style1 style2");
        }

        dojo.addOnLoad(function() {
            dojo.connect(dojo.byId("button1"), "onclick", add1);
        });
    </script>

  .. cv:: html

    <div id="example1">This node will be changed.</div>
    <button id="button1" dojoType="dijit.form.Button" type="button">Add classes</button>


Add several classes as an array
-------------------------------

The following example adds two classes: "style1" and "style2" to the node "example1":

.. code-block :: javascript

  dojo.addClass("example1", ["style1", "style2"]);

See it in action:

.. cv-compound::
  :version: local

  .. css::
    :label: The CSS

    <style type="text/css">
        .style1 { background-color: #7c7c7c; color: #ffbf00;}
        .style2 { border: 1px solid #ffbf00; padding: 20px;}
    </style>

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");

        function add1() {
            // add classes "style1" and "style2" to the node "example1":
            dojo.addClass("example1", ["style1", "style2"]);
        }

        dojo.addOnLoad(function() {
            dojo.connect(dojo.byId("button1"), "onclick", add1);
        });
    </script>

  .. cv:: html

    <div id="example1">This node will be changed.</div>
    <button id="button1" dojoType="dijit.form.Button" type="button">Add classes</button>


Add to multiple nodes
---------------------

``addClass`` is also available for `NodeLists <dojo/NodeList>`_, so that it's also possible to add classes for multiple nodes. The following example adds the class for each node in the NodeList returned from dojo.query:

.. code-block :: javascript

  dojo.query("#example3 div").addClass("style3");

See it in action:

.. cv-compound::

  .. css::
    :label: The CSS

    <style type="text/css">
        .style3 { background-color: #7c7c7c; color: #ffbf00; padding: 10px }
        .additionalStyle3 { background-color: #491f00; color: #36d900 }
    </style>

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");

        function add3() {
            // add the class "style3" to each <div> node:
            dojo.query("#example3 div").addClass("style3");
        }

        dojo.addOnLoad(function() {
            dojo.connect(dojo.byId("button3"), "onclick", add3);
        });
    </script>

  .. cv:: html

    <div id="example3" class="additionalStyle3">
        <div>This node will be changed.</div>
        <div>This node also.</div>
        <div>And this is the last one.</div>
    </div>
    <button id="button3" dojoType="dijit.form.Button" type="button">Add to multiple nodes</button>


========
See also
========

* `dojo.hasClass <dojo/hasClass>`_
* `dojo.removeClass <dojo/removeClass>`_
* `dojo.toggleClass <dojo/toggleClass>`_
