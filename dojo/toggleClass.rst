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

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   dojo.toggleClass("someNode", "hovered");

   // Forcefully add a class:
   dojo.toggleClass("someNode", "hovered", true);

   // Available in `dojo.NodeList` for multiple toggles:
   dojo.query(".toggleMe").toggleClass("toggleMe");
 </script>


========
Examples
========

Simple toggle
-------------

The following example adds the class "hovered" to the node "example1", if there is no such class for this node or removes it, if there is already such a class:

.. cv-compound::

  .. css::
    :label: The CSS

    <style type="text/css">
      .hovered { background-color: #7c7c7c; color: #ffbf00; border: 1px solid #ffbf00; padding: 20px;}
    </style>

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");

        function toggleMe() {
            // add or remove the class "hovered" to/from the node "example1":
            dojo.toggleClass("example1", "hovered");
        }

        dojo.addOnLoad(function() {
            dojo.connect(dojo.byId("button1"), "onclick", toggleMe);
        });
    </script>

  .. cv:: html

    <div id="example1">This node will be changed.</div>
    <button id="button1" dojoType="dijit.form.Button" type="button">Toggle class</button>


========
See also
========

* `dojo.addClass <dojo/addClass>`_
* `dojo.hasClass <dojo/hasClass>`_
* `dojo.removeClass <dojo/removeClass>`_
* `dojo.style <dojo/style>`_
