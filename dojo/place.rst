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
  Optional argument. Can be a number or one of the following strings: "before", "after", "replace", "only", "first", or "last". If omitted, "last" is assumed. The number indicates that the node should be inserted as a child of ``refNode`` with this number (counting from 0).

The function returns a node it placed. In case of an HTML fragment, if it has just one root element, that element is returned directly. Otherwise a document fragment is returned. The returned node can be:

- A regular DOM element node: ``nodeType`` is 1 for ``ELEMENT_NODE`` , example: "<div>42</div>".

  See `DOM Core Level 1: Element <http://www.w3.org/TR/REC-DOM-Level-1/level-one-core.html#ID-745549614>`_ for more details.

- A text node: ``nodeType`` is 3 for ``TEXT_NODE``, example: "Hello, world!".

  See `DOM Core Level 1: Text <http://www.w3.org/TR/REC-DOM-Level-1/level-one-core.html#ID-1312295772>`_ for more details.

- A document fragment representing a group of nodes: ``nodeType`` is 11 for ``DOCUMENT_FRAGMENT``, example: "<p>1st paragraph</p><p>2nd paragraph</p>".

  See `DOM Core Level 1: DocumentFragment <http://www.w3.org/TR/REC-DOM-Level-1/level-one-core.html#ID-B63ED1A3>`_ for more details.

  The document fragment is a very useful tool to work with a group of elements, because standard DOM methods can work with it as with a regular node operating on the whole group, e.g., inserting or appending it as a whole.

Below is the full list of placement options with live examples illustrating their use.

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
        <div class="child">the reference node's child #0</div>
        <div class="child">the reference node's child #1</div>
        <div class="child">the reference node's child #2</div>
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
        <div class="child">the reference node's child #0</div>
        <div class="child">the reference node's child #1</div>
        <div class="child">the reference node's child #2</div>
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
        <div class="child">the reference node's child #0</div>
        <div class="child">the reference node's child #1</div>
        <div class="child">the reference node's child #2</div>
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
        <div class="child">the reference node's child #0</div>
        <div class="child">the reference node's child #1</div>
        <div class="child">the reference node's child #2</div>
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
        <div class="child">the reference node's child #0</div>
        <div class="child">the reference node's child #1</div>
        <div class="child">the reference node's child #2</div>
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
        <div class="child">the reference node's child #0</div>
        <div class="child">the reference node's child #1</div>
        <div class="child">the reference node's child #2</div>
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

Place by numbers
----------------

If ``pos`` is a number, the node will be placed as a child of the reference node with this number (counting from 0). For example, if 3 is specified, the node will be placed as the 3rd child (0, 1, 2, and 3 will be our node) assuming that the reference node has at least three existing children. If the number is more than number of children, the node will be appended to the reference node making it the last child. If the number is less than 0, the node will be placed at position 0 making it the first child of the reference node.

.. cv-compound::

  .. cv:: javascript

    <script>
      dojo.addOnLoad(function(){
        var n = 0;
        dojo.connect(dojo.byId("placeNumber"), "onclick", function(){
          var pos = dojo.query("> option", dojo.byId("posNumber")).
                      filter(function(opt){ return opt.selected; }).
                      map(function(opt){ return opt.value; })[0];
          dojo.place("<div class='node'>new node #" + (++n) + "</div>", "refNumber", parseInt(dojo.byId("posNumber").value));
        });
        // let's add nodes manually to ensure their number
        for(var i = 0; i < 3; ++i){
          dojo.place("<div class='child'>the reference node's child #" + i + "</div>", "refNumber");
        }
      });
    </script>

  .. cv:: html

    <p>
      <button id="placeNumber">Place node</button>
      as child
      <select id="posNumber">
        <option value="0">#0</option>
        <option value="1">#1</option>
        <option value="2">#2</option>
        <option value="3">#3</option>
        <option value="4">#4</option>
        <option value="5">#5</option>
      </select>
    </p>
    <p>
      <div>before: 1st</div>
      <div>before: 2nd</div>
      <div id="refNumber" class="ref"></div>
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

Notes
~~~~~

This placement method is useful when you know how many children the reference node has, and what they are. **Do not forget that text nodes (even empty ones) are counted as children too:**

.. code-block :: html
  :linenos:

  <p>
    <span>1</span>
  </p>

In the fragment above the <p> node will have 3 children: a text node (spaces and a newline), the <span> node, and another text node (spaces and a newline). **Be careful when using markup like that!** For example the next fragment will have just one <span> node as a child:

.. code-block :: html
  :linenos:

  <p><span>1</span></p>

Or you can construct DOM programmatically.

Place using create()
--------------------

*TODO: revise and expand this section.*

Alternative way to place (and create) a node is `dojo.create <dojo/create>`_.

.. code-block :: javascript
  :linenos:

  // the third and fourth options are passed to dojo.place()
  // create a div, and place(n, dojo.body(), "first");
  dojo.create("div", null, dojo.body(), "first");
