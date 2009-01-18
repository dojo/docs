#format dojo_rst

dojo.place
==========

:Status: Draft
:Version: 1.0
:Available: since 1.2

.. contents::
   :depth: 2

``dojo.place()`` is a useful DOM Node placement utility function. It comes in very handy when you need to place nodes as siblings or children of other nodes.

The function takes up to three arguments:

.. code-block :: javascript

  dojo.place(node, refNode, pos);

Here is the definition of arguments:

node
  Can be a string or a DOM node. If it is a string starting with "<", it is assumed to be an HTML fragment, which will be instantiated. Otherwise it is assumed to be an id of a DOM node.

  Notes:

  - An HTML fragment can have more than one top node.
  - In the case of an invalid HTML fragment the result of instantiation is undefined.

refNode
  Can be a string (interpreted as an id of a DOM node) or a DOM node.

pos
  Optional argument. Can be one of the following strings: "before", "after", "replace", "only", "first", or "last". If omitted, "last" is assumed.

The function returns a node it placed, or ``null`` if the placement failed. In case of an HTML fragment, the returned node can be of type 1 (``nodeType`` is ``ELEMENT_NODE``, example: "<div>42</div>"), type 3 (``nodeType`` is ``TEXT_NODE``, example: "Hello, world!"), or type 11 (``nodeType`` is ``DOCUMENT_FRAGMENT``, example: "<p>1st paragraph</p><p>2nd paragraph</p>").

Below is the full list of placement options with examples illustrating their use.

Place "before"
--------------

"before" places a node right before the reference node.

.. cv-compound::

  .. cv:: javascript

    <script>
      dojo.addOnload(function(){
        dojo.connect(dojo.byId("placeBefore"), "onclick", function(){
          dojo.place("nodeBefore", "refBefore", "before");
        });
        dojo.connect(dojo.byId("resetBefore"), "onclick", function(){
          dojo.place("nodeBefore", "parentBefore");
        });
      });
    </script>

  .. cv:: html

    <p>
      <button id="placeBefore">Place node</button>
      <button id="resetBefore">Reset</button>
    </p>
    <p id="parentBefore">
      <div id="nodeBefore" class="node">the placed node</div>
    </p>
    <p>
      <div>before: 1st</div>
      <div>before: 2nd</div>
      <div id="refBefore" class="ref">
        the reference node
        <div class="child">child #1</div>
        <div class="child">child #2</div>
        <div class="child">child #3</div>
      </div>
      <div>after: 1st</div>
      <div>after: 2nd</div>
    </p>

  .. cv:: css

    <style>
      div.ref   { background-color: #fcc; }
      div.node  { background-color: #cfc; }
      div.child { background-color: #ffc; margin-left: 1em; }
    </style>

========
Examples
========

dojo.place places "a node" relative to "some other node". By default, the moving node is placed "last" in the reference node. Calling these two functions have the same results:

.. code-block :: javascript
  :linenos:

  // recommended:
  dojo.place("someId", "someOtherId");
  // much longer, but identical:
  dojo.byId("someOtherId").appendChild(dojo.byId("someId");

Here we place the node with id="someId" as the "last" node of the reference node (id="someOtherId").

Place accepts one of six positional arguments: "before", "after", "replace", "only", "first", and "last". "last" is the default, and can be omitted. "first" and "last" place the node inside the reference node, "before" and "after" place the node as a sibling relative to the reference node, "replace" replaces the reference node with the new node, and "only" replaces all children of the reference node.

1Place "last" (default)
-----------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // you don't need this, its for the looks

    dojo.addOnLoad(function(){
      dojo.connect(dijit.byId("buttonThree"), "onClick", function(){
        var node = dojo.doc.createElement("div");
        node.innerHTML = "New Node, placed under 'Three' at the end!";

        dojo.place(node, "exampleThreeThree");
      });
    });
    </script>

  .. cv:: html

    <button dojoType="dijit.form.Button" id="buttonThree">Add node</button>

    </div>
      <div>One</div>
      <div>Two</div>
      <div id="exampleThreeThree">Three</div>
      <div>Four</div>
      <div>Five</div>
    </div>

1Place "before"
---------------

This inserts the moving node into the DOM immediately "before" the passed reference node, making it a sibling.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // you don't need this, its for the looks

    dojo.addOnLoad(function(){
      dojo.connect(dijit.byId("buttonOne"), "onClick", function(){
        var node = dojo.create("div");
        node.innerHTML = "New Node, placed before 'Three'!";

        dojo.place(node, "exampleThree", "before");
      });
    });
    </script>

  .. cv:: html

    <button dojoType="dijit.form.Button" id="buttonOne">Add node</button>

    </div>
      <div>One</div>
      <div>Two</div>
      <div id="exampleThree">Three</div>
      <div>Four</div>
      <div>Five</div>
    </div>

1Place "after"
--------------

This inserts a node "after" the reference node in the DOM, making it a sibling of the reference node.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // you don't need this, its for the looks

    dojo.addOnLoad(function(){
      dojo.connect(dijit.byId("buttonTwo"), "onClick", function(){
        var node = dojo.doc.createElement("div");
        node.innerHTML = "New Node, placed after 'Three'!";

        dojo.place(node, dojo.byId("exampleTwoThree"), "after");
      });
    });
    </script>

  .. cv:: html

    <button dojoType="dijit.form.Button" id="buttonTwo">Add node</button>

    </div>
      <div>One</div>
      <div>Two</div>
      <div id="exampleTwoThree">Three</div>
      <div>Four</div>
      <div>Five</div>
    </div>

1Place "first"
--------------

Placing a node under another node at he beginning

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // you don't need this, its for the looks

    dojo.addOnLoad(function(){
      dojo.connect(dijit.byId("buttonFour"), "onClick", function(){
        var node = dojo.doc.createElement("div");
        node.innerHTML = "New Node, placed under 'Three' at the beginning!";

        dojo.place(node, "exampleFourThree", "first");
      });
    });
    </script>

  .. cv:: html

    <button dojoType="dijit.form.Button" id="buttonFour">Add node</button>

    </div>
      <div>One</div>
      <div>Two</div>
      <div id="exampleFourThree">Three</div>
      <div>Four</div>
      <div>Five</div>
    </div>

Alternate Reference Nodes
-------------------------

These examples all use id's for the reference node. The node passed as the reference node can be a string ID or DomNode reference, such a node you create which is already in the DOM, or a node found via `dojo.query <dojo/query>`_:

.. code-block :: javascript
  :linenos:

  var n = dojo.query(".foo")[0];
  // place n as a first-child of the <body> element
  dojo.place(n, dojo.body(), "first");

  // place a new div inside that found node (Dojo > 1.3):
  dojo.place(dojo.create('div'), n);

  // place a newly created node in the found node (for Dojo < 1.3)
  dojo.place(dojo.doc.createElement('div'), n);


Place using create()
--------------------

Though the above example uses dojo.create as an alias to dojo.doc.createElement, `dojo.create <dojo/create>`_ can also act as a shorthand for dojo.place() in this scenario. This is limited, however, to Dojo 1.3 or higher.

.. code-block :: javascript
  :linenos:

  // the third and fourth options are passed to dojo.place()
  // create a div, and place(n, dojo.body(), "first");
  dojo.create("div", null, dojo.body(), "first");
