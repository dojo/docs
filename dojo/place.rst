#format dojo_rst

dojo.place
==========

:Status: Draft
:Version: 1.0
:Available: since 1.2

.. contents::
   :depth: 2

Place is a useful DOM Node placement utility function. 
dojo.place() comes in very handy when you need to place nodes as siblings or children of other nodes.

========
Examples
========

There is only one way to use dojo.place. Place "a node" relative to "some other node". By default, the moving node is placed "last" in the reference node. Calling these two functions have the same results:

.. code-block :: javascript
  :linenos:

  // recommended:
  dojo.place("someId", "someOtherId");
  // much longer, but identical: 
  dojo.byId("someOtherId").appendChild(dojo.byId("someId");

Here we place the node with id="someId" as the "last" node of the reference node (id="someOtherId"). Place accepts one of four positional arguments: "before", "after", "first", and "last". "last" is the default, and can be omitted. "first" and "last" place the node inside the reference node, "before" and "after" place the node as a sibling relative to the reference node. 

Place "last" (default)
----------------------

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

Place "before"
--------------

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

Place "after"
-------------

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

Place "first"
-------------

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
  
