#format dojo_rst

dojo.toggleClass
================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

Simply toggles a className (or now in 1.4 an array of classNames).

============
Introduction
============

dojo.toggleClass adds a class to node if not present, or removes if present.


=====
Usage
=====

Pass a boolean condition if you want to explicitly add or remove.

dojo.toggleClass(node, classStr, condition)

  =========  ==============  =================================================
  Parameter  Type            Description
  =========  ==============  =================================================
  node       DomNode|String  The node which should changed.
  classStr   string          name of the class to add or remove
  condition  true|false      Optional. true means to add the class, false means to remove.
  =========  ==============  =================================================


========
Examples
========

Simple toggle
-------------

The following example adds the class "style1" to the node "example1", if there is no such class for this node or removes it, if there is already such a class:

.. cv-compound::

  .. css::
    :label: The CSS

    <style type="text/css">
        .style1 { background-color: #7c7c7c; color: #ffbf00; border: 1px solid #ffbf00; padding: 20px;}
    </style>

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");

        function toggle1() {
            // add or remove the class "style1" to/from the node "example1":
            dojo.toggleClass("example1", "style1");
        }

        dojo.addOnLoad(function() {
            dojo.connect(dojo.byId("button1"), "onclick", toggle1);
        });
    </script>

  .. cv:: html

    <div id="example1">This node will be changed.</div>
    <button id="button1" dojoType="dijit.form.Button" type="button">Toggle class</button>


Forcefully add a class
----------------------

The following example adds the class "style2" to the node "example2", no matter if there is already such a class for this node or not:

.. cv-compound::

  .. css::
    :label: The CSS

    <style type="text/css">
        .style2 { background-color: #7c7c7c; color: #ffbf00; border: 1px solid #ffbf00; padding: 20px;}
        .additionalStyle { border: 5px solid #ffbf00; padding: 20px;}
    </style>

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");

        function toggle2() {
            // add or remove the class "style2" to/from the node "example2":
            dojo.toggleClass("example2", "style2", true);
        }

        dojo.addOnLoad(function() {
            dojo.connect(dojo.byId("button2"), "onclick", toggle2);
        });
    </script>

  .. cv:: html

    <div id="example2" class="additionalStyle">This node will be changed.</div>
    <button id="button2" dojoType="dijit.form.Button" type="button">Add a class forcefully</button>


Toggle multiple nodes
---------------------

toggleClass is also available for NodeLists, so that it's also possible to toggle the class for multiple nodes. The following example toggles the class for each node in the NodeList returned from dojo.query:

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

        function toggle3() {
            // add or remove the class "style3" to/from each <div> node:
            dojo.query("#example3 div").toggleClass("style3");
        }

        dojo.addOnLoad(function() {
            dojo.connect(dojo.byId("button3"), "onclick", toggle3);
        });
    </script>

  .. cv:: html

    <div id="example3" class="additionalStyle3">
        <div>This node will be changed.</div>
        <div>This node also.</div>
        <div>And this is the last one.</div>
    </div>
    <button id="button3" dojoType="dijit.form.Button" type="button">Toggle multiple nodes</button>


========
See also
========

* `dojo.addClass <dojo/addClass>`_
* `dojo.hasClass <dojo/hasClass>`_
* `dojo.removeClass <dojo/removeClass>`_
* `dojo.style <dojo/style>`_
