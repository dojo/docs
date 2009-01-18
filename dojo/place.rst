#format dojo_rst

dojo.place
==========

:Status: Draft
:Version: 1.0
:Available: since 1.2

.. contents::
   :depth: 2

*Warning: not finished yet!*

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

"before" places the node right before the reference node in the list of children of the reference node's parent.

.. cv-compound::

  .. cv:: javascript

    <script>
      dojo.addOnLoad(function(){
        var n = 0;
        dojo.connect(dojo.byId("placeBefore"), "onclick", function(){
          dojo.place("<div class='node'>new node #" + (++n) + "</div>", "refBefore", "before");
        });
      });
    </script>

  .. cv:: html

    <p>
      <button id="placeBefore">Place node</button>
    </p>
    <p>
      <div>before: 1st</div>
      <div>before: 2nd</div>
      <div id="refBefore" class="ref">
        <div class="child">the reference node's child #1</div>
        <div class="child">the reference node's child #2</div>
        <div class="child">the reference node's child #3</div>
      </div>
      <div>after: 1st</div>
      <div>after: 2nd</div>
    </p>

  .. cv:: css

    <style>
      div.ref     { background-color: #fcc; }
      div.node    { background-color: #cfc; }
      div.child   { background-color: #ffc; }
      div.ref div { margin-left: 3em; }
    </style>

Place "after"
-------------

"after" places the node right after the reference node in the list of children of the reference node's parent.

.. cv-compound::

  .. cv:: javascript

    <script>
      dojo.addOnLoad(function(){
        var n = 0;
        dojo.connect(dojo.byId("placeAfter"), "onclick", function(){
          dojo.place("<div class='node'>new node #" + (++n) + "</div>", "refAfter", "after");
        });
      });
    </script>

  .. cv:: html

    <p>
      <button id="placeAfter">Place node</button>
    </p>
    <p>
      <div>before: 1st</div>
      <div>before: 2nd</div>
      <div id="refAfter" class="ref">
        <div class="child">the reference node's child #1</div>
        <div class="child">the reference node's child #2</div>
        <div class="child">the reference node's child #3</div>
      </div>
      <div>after: 1st</div>
      <div>after: 2nd</div>
    </p>

  .. cv:: css

    <style>
      div.ref     { background-color: #fcc; }
      div.node    { background-color: #cfc; }
      div.child   { background-color: #ffc; }
      div.ref div { margin-left: 3em; }
    </style>

Place "replace"
---------------

"replace" replaces the reference node with the node.

.. cv-compound::

  .. cv:: javascript

    <script>
      dojo.addOnLoad(function(){
        var n = 0;
        dojo.connect(dojo.byId("placeReplace"), "onclick", function(){
          dojo.place("<div class='node'>new node #" + (++n) + "</div>", "refReplace", "replace");
          dojo.attr("placeReplace", "disabled", "disabled");
        });
      });
    </script>

  .. cv:: html

    <p>
      <button id="placeReplace">Place node</button>
    </p>
    <p>
      <div>before: 1st</div>
      <div>before: 2nd</div>
      <div id="refReplace" class="ref">
        <div class="child">the reference node's child #1</div>
        <div class="child">the reference node's child #2</div>
        <div class="child">the reference node's child #3</div>
      </div>
      <div>after: 1st</div>
      <div>after: 2nd</div>
    </p>

  .. cv:: css

    <style>
      div.ref     { background-color: #fcc; }
      div.node    { background-color: #cfc; }
      div.child   { background-color: #ffc; }
      div.ref div { margin-left: 3em; }
    </style>

Place "only"
------------

"only" replaces all children of the reference node with the node.

.. cv-compound::

  .. cv:: javascript

    <script>
      dojo.addOnLoad(function(){
        var n = 0;
        dojo.connect(dojo.byId("placeOnly"), "onclick", function(){
          dojo.place("<div class='node'>new node #" + (++n) + "</div>", "refOnly", "only");
        });
      });
    </script>

  .. cv:: html

    <p>
      <button id="placeOnly">Place node</button>
    </p>
    <p>
      <div>before: 1st</div>
      <div>before: 2nd</div>
      <div id="refOnly" class="ref">
        <div class="child">the reference node's child #1</div>
        <div class="child">the reference node's child #2</div>
        <div class="child">the reference node's child #3</div>
      </div>
      <div>after: 1st</div>
      <div>after: 2nd</div>
    </p>

  .. cv:: css

    <style>
      div.ref     { background-color: #fcc; }
      div.node    { background-color: #cfc; }
      div.child   { background-color: #ffc; }
      div.ref div { margin-left: 3em; }
    </style>

Place "first"
-------------

"first" places the node as the first child of the reference node.

.. cv-compound::

  .. cv:: javascript

    <script>
      dojo.addOnLoad(function(){
        var n = 0;
        dojo.connect(dojo.byId("placeFirst"), "onclick", function(){
          dojo.place("<div class='node'>new node #" + (++n) + "</div>", "refFirst", "first");
        });
      });
    </script>

  .. cv:: html

    <p>
      <button id="placeFirst">Place node</button>
    </p>
    <p>
      <div>before: 1st</div>
      <div>before: 2nd</div>
      <div id="refFirst" class="ref">
        <div class="child">the reference node's child #1</div>
        <div class="child">the reference node's child #2</div>
        <div class="child">the reference node's child #3</div>
      </div>
      <div>after: 1st</div>
      <div>after: 2nd</div>
    </p>

  .. cv:: css

    <style>
      div.ref     { background-color: #fcc; }
      div.node    { background-color: #cfc; }
      div.child   { background-color: #ffc; }
      div.ref div { margin-left: 3em; }
    </style>

Place "last" (default)
----------------------

"last" places the node as the last child of the reference node.

.. cv-compound::

  .. cv:: javascript

    <script>
      dojo.addOnLoad(function(){
        var n = 0;
        dojo.connect(dojo.byId("placeLast"), "onclick", function(){
          dojo.place("<div class='node'>new node #" + (++n) + "</div>", "refLast", "last");
        });
      });
    </script>

  .. cv:: html

    <p>
      <button id="placeLast">Place node</button>
    </p>
    <p>
      <div>before: 1st</div>
      <div>before: 2nd</div>
      <div id="refLast" class="ref">
        <div class="child">the reference node's child #1</div>
        <div class="child">the reference node's child #2</div>
        <div class="child">the reference node's child #3</div>
      </div>
      <div>after: 1st</div>
      <div>after: 2nd</div>
    </p>

  .. cv:: css

    <style>
      div.ref     { background-color: #fcc; }
      div.node    { background-color: #cfc; }
      div.child   { background-color: #ffc; }
      div.ref div { margin-left: 3em; }
    </style>

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
