#format dojo_rst

dojo.place
==========

:Status: Draft
:Version: 1.0
:Available: since 1.2

.. contents::
   :depth: 2

dojo.place() comes in very handy when you need to place nodes as siblings or children of other nodes.
Lets take a look at a few examples

========
Examples
========

Placing a node before another node
----------------------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // you don't need this, its for the looks

    dojo.addOnLoad(function(){
      dojo.connect(dijit.byId("buttonOne"), "onClick", function(){
        var node = dojo.doc.createElement("div");
        node.innerHTML = "New Node, placed before 'Three'!";

        dojo.place(node, dojo.byId("exampleThree"), "before");
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

Placing a node after another node
---------------------------------

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

Placing a node under another node at the end
--------------------------------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // you don't need this, its for the looks

    dojo.addOnLoad(function(){
      dojo.connect(dijit.byId("buttonThree"), "onClick", function(){
        var node = dojo.doc.createElement("div");
        node.innerHTML = "New Node, placed under 'Three' at the end!";

        dojo.place(node, dojo.byId("exampleThreeThree"), "last");
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


Placing a node under another node at he beginning
-------------------------------------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // you don't need this, its for the looks

    dojo.addOnLoad(function(){
      dojo.connect(dijit.byId("buttonFour"), "onClick", function(){
        var node = dojo.doc.createElement("div");
        node.innerHTML = "New Node, placed under 'Three' at the beginning!";

        dojo.place(node, dojo.byId("exampleFourThree"), "first");
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
