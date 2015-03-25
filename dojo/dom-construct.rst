.. _dojo/dom-construct:

==================
dojo/dom-construct
==================

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 3

This module defines the core dojo DOM construction API. The convention for the return variable for this module is
``domConstruct``.

To better understand this module, a good reference is the `Dojo DOM Tutorial <http://dojotoolkit.org/documentation/tutorials/1.7/dom_functions/>`_.

The *deprecated* legacy features are set in :ref:`dojo/_base/html <dojo/_base/html>`.

Features
========

.. _dojo/dom-construct#todom:

toDom()
-------

Instantiates an HTML fragment returning the corresponding DOM.

Usage
~~~~~

.. js ::

  require(["dojo/dom-construct"], function(domConstruct){
      // Take a string and turn it into a DOM node
      var node = domConstruct.toDom("<div>I'm a Node</div>");
  });

Attributes
~~~~~~~~~~

======== ============= ================================================================
Argument Type          Description
======== ============= ================================================================
frag     String        The fragment of HTML to be converted into a node
doc      DocumentNode? An optional document to use when creating DOM nodes, defaults to
                       ``dojo/_base/window::doc`` if not specified.
======== ============= ================================================================

Examples
~~~~~~~~

This example adds a row to a table.  This is somewhat contrived, since ``place()`` will handle the conversion of HTML fragments itself.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example uses ``dojo/dom`` and ``dojo/on`` as well.
  
  .. js ::

    require(["dojo/dom-construct", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(domConstruct, dom, on){
      on(dom.byId("button1"), "click", function(){
        var row = domConstruct.toDom("<tr><td>bar</td><td>Bar is also good</td></tr>");
        domConstruct.place(row, "example");
      });
    });

  Here is our HTML ``<table>`` which we will add the row to.

  .. html ::

    <button id="button1" type="button">Add a row</button>
    <table>
      <thead>
        <tr><th>Example</th><th>Description</th></tr>
      </thead>
      <tbody id="example">
        <tr><td>foo</td><td>Foo is good</td></tr>
      </tbody>
    </table>

.. _dojo/dom-construct#place:

place()
-------

``place()`` is a useful DOM node placement utility function. It can be used to place existing nodes somewhere in an HTML
document as well as create new nodes and immediately position them in the document. It encapsulates all necessary
boilerplate code required to place a node correctly, and take special cross-browser consideration when creating and
placing the nodes.

Usage
~~~~~

.. js ::
  
    require(["dojo/dom-construct"], function(domConstruct){
      domConstruct.place("someNode", "refNode", "after");
    });

``place()`` returns the node it placed. In case of an HTML fragment, if it has just one root element, that element is
returned directly. Otherwise a document fragment is returned. The returned node can be:

- A regular DOM element node: ``nodeType`` is 1 for ``ELEMENT_NODE`` , example: ``<div>42</div>``.

  See `DOM Core Level 1: Element <http://www.w3.org/TR/REC-DOM-Level-1/level-one-core.html#ID-745549614>`_ for more
  details.

- A document fragment representing a group of nodes: ``nodeType`` is 11 for ``DOCUMENT_FRAGMENT``, example: ``<p>1st
  paragraph</p><p>2nd paragraph</p>``.

  See `DOM Core Level 1: DocumentFragment <http://www.w3.org/TR/REC-DOM-Level-1/level-one-core.html#ID-B63ED1A3>`_ for
  more details.

  The document fragment is a very useful tool to work with a group of arbitrary nodes, because standard DOM methods
  can work with it as with a regular node operating on the whole group, e.g., inserting or appending it as a whole.

  Note that DocumentFragment is a Node, but not an Element. It does not support ``innerHTML``, ``style``, or any other
  familiar attributes of the element.

Attributes
~~~~~~~~~~

========= ============== ==============================================================================================
Argument  Type           Description
========= ============== ==============================================================================================
node      String|DomNode If it is a string starting with "<", it is assumed to be an HTML fragment, which will be
                         created. Otherwise it is assumed to be an id of a DOM node.

                         **Note:**

                         * An HTML fragment can have more than one top node.
                         * In the case of an invalid HTML fragment the result of instantiation is undefined.
                         * When instantiating an HTML fragment the owner document of the reference node is used.
refNode   String|DomNode The DOM node where the node should be placed.  If a string, it is assumed to be the ID of the
                         node
pos       String?        Optional argument. Can be a number or one of the following strings: "before", "after",
                         "replace", "only", "first", or "last". If omitted, "last" is assumed. The value of "only"
                         replaces all children of the refNode. If the position argument is a number, it indicates that
                         the node should be inserted as a child of ``refNode`` with this number (counting from 0).
                         
                         The naming of the positions are intentionally concise.
========= ============== ==============================================================================================

Examples
~~~~~~~~

Below is the full list of placement options with live examples illustrating their use.

Place "before" or "after"
'''''''''''''''''''''''''

This two options position the node in the reference node's parent children list. "before" places the node right before
the reference node, and "after" places the node right after the reference node.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-construct", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(domConstruct, dom, on){
      var n = 0;
      on(dom.byId("placeBA"), "click", function(){
        domConstruct.place("<div class='node'>new node #" + (++n) + "</div>", "refBA",
          dom.byId("posBA").value); // before/after
      });
    });

  .. html ::

    <p>
      <button id="placeBA">Place node</button>
      <select id="posBA">
        <option value="before">before</option>
        <option value="after">after</option>
      </select>
    </p>
    <p>
      <div>before: 1st</div>
      <div>before: 2nd</div>
      <div id="refBA" class="ref">
        <div class="child">the reference node's child #0</div>
        <div class="child">the reference node's child #1</div>
        <div class="child">the reference node's child #2</div>
      </div>
      <div>after: 1st</div>
      <div>after: 2nd</div>
    </p>

  .. css ::

    div.ref     { background-color: #fcc; }
    div.node    { background-color: #cfc; }
    div.child   { background-color: #ffc; }
    div.ref div { margin-left: 3em; }

Place "replace"
'''''''''''''''

"replace" replaces the reference node with the node.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-construct", "dojo/dom-attr", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(domConstruct, domAttr, dom, on){
      var n = 0;
      on(dom.byId("placeReplace"), "click", function(){
        domConstruct.place("<div class='node'>new node #" + (++n) + "</div>", "refReplace", "replace");
        domAttr.set("placeReplace", "disabled", "disabled");
      });
    });

  .. html ::

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

  .. css ::

    div.ref     { background-color: #fcc; }
    div.node    { background-color: #cfc; }
    div.child   { background-color: #ffc; }
    div.ref div { margin-left: 3em; }

Place as "first", "last", or "only"
'''''''''''''''''''''''''''''''''''

These three options position the node as a child of the reference node. "first" places the node as the first child,
"last" places the node as the last child, and "only" replaces all children of the reference node with the node.

If no position is specified, or position is not recognized, "last" is assumed as the default.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-construct", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(domConstruct, dom, on){
      var n = 0;
      on(dom.byId("placeFLO"), "click", function(){
        domConstruct.place("<div class='node'>new node #" + (++n) + "</div>", "refFLO",
          dom.byId("posFLO").value); // first/last/only
      });
    });

  .. html ::

    <p>
      <button id="placeFLO">Place node</button>
      <select id="posFLO">
        <option value="first">first</option>
        <option value="last">last</option>
        <option value="only">only</option>
      </select>
    </p>
    <p>
      <div>before: 1st</div>
      <div>before: 2nd</div>
      <div id="refFLO" class="ref">
        <div class="child">the reference node's child #0</div>
        <div class="child">the reference node's child #1</div>
        <div class="child">the reference node's child #2</div>
      </div>
      <div>after: 1st</div>
      <div>after: 2nd</div>
    </p>

  .. css ::

    div.ref     { background-color: #fcc; }
    div.node    { background-color: #cfc; }
    div.child   { background-color: #ffc; }
    div.ref div { margin-left: 3em; }

Place by numbers
''''''''''''''''

If ``pos`` is a number, the node will be placed as a child of the reference node with this number (counting from 0). For
example, if 3 is specified, the node will be placed as the 3rd child (0, 1, 2, and 3 will be our node) assuming that the
reference node has at least three existing children. If the number is more than number of children, the node will be
appended to the reference node making it the last child. If the number is less than 0, the node will be placed at
position 0 making it the first child of the reference node.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-construct", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(domConstruct, dom, on){
      var n = 0;
      on(dom.byId("placeNumber"), "click", function(){
        domConstruct.place("<div class='node'>new node #" + (++n) + "</div>", "refNumber",
          parseInt(dom.byId("posNumber").value));
      });
      // let's add nodes manually to ensure their number
      for(var i = 0; i < 3; ++i){
        domConstruct.place("<div class='child'>the reference node's child #" + i + "</div>", "refNumber");
      }
    });

  .. html ::

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

  .. css ::

    div.ref     { background-color: #fcc; }
    div.node    { background-color: #cfc; }
    div.child   { background-color: #ffc; }
    div.ref div { margin-left: 3em; }

Notes
.....

This placement method is useful when you know how many children the reference node has, and what they are. **Do not
forget that text nodes (even empty ones) are counted as children too:**

.. html ::
  
  <p>
    <span>1</span>
  </p>

In the fragment above the <p> node will have 3 children: a text node (spaces and a newline), the <span> node, and
another text node (spaces and a newline). **Be careful when using markup like that!** For example the next fragment will
have just one <span> node as a child:

.. html ::
  
  <p><span>1</span></p>

Or you can construct DOM programmatically.

Alternatives
~~~~~~~~~~~~

An alternative way to place (and create) a node is :ref:`dojo/dom-construct::create() <dojo/dom-construct#create>`.
It is a simple helper that creates a node with a given tag (or uses the existing node), and applies optionally
:ref:`dojo/dom-attr::set() <dojo/dom-attr#set-function>` and ``place()`` to it. While its creation part is not as rich,
it allows to set complex attributes and styles dynamically without messy string manipulations. The additional benefit of
:ref:`dojo/dom-construct::create() <dojo/dom-construct#create>` is that by using :ref:`dojo/dom-attr::set()
<dojo/dom-attr#set-function>` all attributes will be applied in a browser-independent way avoiding possible differences.

.. js ::
  
  // the third and fourth options are passed to place()
  // create a div, and place(n, win.body(), "first");
  
  require(["dojo/dom-construct", "dojo/_base/window"], function(domConstruct, win){
     domConstruct.create("div", null, win.body(), "first");
  });

.. _dojo/dom-construct#create:

create()
--------

A convenient DOM creation, manipulation and placement utility shorthand. It is designed to simplify the frequently used
sequence of DOM manipulation:

* create a node,
* set attributes on it,
* and place it in the DOM.

It can be used with existing nodes too, if you want to assign new attributes and place it afterwards.

Usage
~~~~~

.. js ::

  require(["dojo/dom-construct"], function(domConstruct){
      // create a div node
      var node = domConstruct.create("div");
  });

Attributes
~~~~~~~~~~

======== ================ =============================================================================================
Argument Type             Description
======== ================ =============================================================================================
tag      String|DomNode   A string of the element to create (e.g.: "div", "a", "p", "li", "script", "br"), or an
                          existing DOM node to process.
attrs    Object?          Optional. An object-hash of attributes to set on the newly created node. Can be ``null``, if
                          you don't want to set any attributes/styles.
refNode  String?|DomNode? Optional reference node. Used by ``place()`` to place the newly created node somewhere in the
                          dom relative to refNode. Can be a DomNode reference or String ID of a node.
pos      String?          Optional positional reference. Defaults to "last" by way of ``place()``, though can be set to
                          "first","after","before","last", "replace" or "only" to further control the placement of the
                          new node relative to the refNode. ``refNode`` is required if a ``pos`` is specified.
======== ================ =============================================================================================

Examples
~~~~~~~~

Create a ``<div>``:

.. js ::
  
  require(["dojo/dom-construct"], function(domConstruct){
    var n = domConstruct.create("div");
  });

Create a ``<div>`` with content:

.. js ::
  
  require(["dojo/dom-construct"], function(domConstruct){
    var n = domConstruct.create("div", { innerHTML: "<p>hi</p>" });
  });

Append a new ``<div>`` to ``<body>`` with no attributes:

.. js ::
  
  require(["dojo/dom-construct", "dojo/_base/window"], function(domConstruct, win){
    var n = domConstruct.create("div", null, win.body());
  });

Place a new ``<div>`` as the first child of ``<body>`` with no attributes:

.. js ::
  
  require(["dojo/dom-construct", "dojo/_base/window"], function(domConstruct, win){
    var n = domConstruct.create("div", null, win.body(), "first");
  });

Decorate and place an existing node:

.. js ::
  
  require(["dojo/dom-construct", "dojo/_base/window"], function(domConstruct, win){
    domConstruct.create(node, { style: { color: "red" } }, win.body());
  });

Create an ``<ul>``, and populate it with ``<li>``'s. Place the list as the first child of a node whose id equals
"someId":

.. js ::
  
  require(["dojo/dom-construct", "dojo/_base/array"], function(domConstruct, arrayUtil){
    var ul = domConstruct.create("ul", null, "someId", "first");
    var items = ["one", "two", "three", "four"];
    arrayUtil.forEach(items, function(data){
      domConstruct.create("li", { innerHTML: data }, ul);
    });
  });

Create an anchor, with an href. Place in ``<body>``:

.. js ::
  
  require(["dojo/dom-construct", "dojo/_base/window"], function(domConstruct, win){
    domConstruct.create("a", { href: "foo.html", title: "Goto FOO!", innerHTML: "link" }, win.body());
  });

Alternatives
~~~~~~~~~~~~

Creating and/or placing with place()
''''''''''''''''''''''''''''''''''''

In some cases it is easier to create a node from an HTML fragment and place it, without applying any attributes, or
specifying them as a part of the HTML fragment. If this is the case consider :ref:`dojo/dom-construct::place() <dojo/dom-construct#place>`:

.. js ::
  
  // duplicating the following line with domConstruct.place():
  // domConstruct.create("a", { href: "foo.html", title: "Goto FOO!", innerHTML: "link" }, win.body());
  
  require(["dojo/dom-construct", "dojo/_base/window"], function(domConstruct, win){
    domConstruct.place("<a href='foo.html' title='Goto FOO!'>link</a>", win.body());
  });

.. js ::
  
  // duplicating the following line with domConstruct.place():
  // var n = domConstruct.create("div", null, win.body());
  
  require(["dojo/dom-construct", "dojo/_base/window"], function(domConstruct, win){
    var n = domConstruct.place("<div></div>", win.body());
  });

Setting attributes with dojo/dom-attr::set()
''''''''''''''''''''''''''''''''''''''''''''

While you can use ``create()`` to set attributes on the existing node without placing it, using
:ref:`dojo/dom-attr::set() <dojo/dom-attr#set-function>` is recommended:

.. js ::
  
  // duplicating the following line with domAttr.set():
  // var n = domConstruct.create(node, { innerHTML: "<p>hi</p>" });
  
  require(["dojo/dom-attr"], function(domAttr){
    domAttr.set(node, "innerHTML", "<p>hi</p>");
  });

.. _dojo/dom-construct#empty:

empty()
-------

Safely empty the contents of a DOM element. ``empty()`` deletes all children but keeps the node there.

Usage
~~~~~

.. js ::
 
  require(["dojo/dom-construct"], function(domConstruct){
    // Empty node's children byId:
    domConstruct.empty("someId");
  });

This function only works with DomNodes, and returns nothing.

Attributes
~~~~~~~~~~

======== ============== ==================================
Argument Type           Description
======== ============== ==================================
node     String|DomNode A reference to a DOM node or an id
======== ============== ==================================

Examples
~~~~~~~~

Empty a single node
'''''''''''''''''''

The following example shows the basic functionality of ``empty()``:

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  Empty a DomNode by the node ID
   
  .. js ::

    require(["dojo/dom-construct", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(domConstruct, dom, on){
      on(dom.byId("progButtonNode"), "click", function(){
        domConstruct.empty("testnode1");
        dom.byId("result1").innerHTML = "TestNode1 has been emptied.";
      });
    });

  Some DomNodes
  
  .. html ::
    
    <div id="testnode1">TestNode 1</div>
    <button id="progButtonNode" type="button">Empty TestNode1</button>
    <div id="result1"></div>


Empty all nodes in a list by reference
''''''''''''''''''''''''''''''''''''''

The following example uses :ref:`dojo/query <dojo/query>` to retrieve a set of nodes and iterates over the list,
applying ``empty()``.

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  Empty all Nodes in a list who have the CSS class ``red``.
  
  .. js ::

    require(["dojo/dom-construct", "dojo/query", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(domConstruct, query, dom, on){
      on(dom.byId("progButtonNode2"), "click", function(){
        query(".red").forEach(domConstruct.empty);
        dom.byId("result2").innerHTML = "All red nodes were emptied.";
      });
    });

  Some DomNodes
  
  .. html ::

    <div class="green">greenNode</div>
    <div class="green">greenNode</div>
    <div class="red">redNode</div>
    <div class="green">greenNode</div>
    <div class="green">greenNode</div>
    <div class="red">redNode</div>
    <div class="red">redNode</div>
    <div class="green">greenNode</div>
    <div class="green">greenNode</div>
    <div class="red">redNode</div>
    <div class="red">redNode</div>
    <div class="red">redNode</div>
    <div class="green">greenNode</div>
    <div class="green">greenNode</div>
    <div class="red">redNode</div>

    <div id="panel">
        <button id="progButtonNode2" type="button">Empty all red nodes</button>
        <div id="result2"></div>
    </div>

  .. css ::

    .green { color: white; min-width: 30px; min-height: 30px;
        border: 1px #4d4d4d solid; margin-top: 4px; margin-right: 5px;
        float: left; background-color: green; padding: 2px }
    .red { color: white; min-width: 30px; min-height: 30px;
        border: 1px #4d4d4d solid; margin-top: 4px; margin-right: 5px;
        float: left; background-color: red; padding: 2px }
    #panel { clear: both }

.. _dojo/dom-construct#destroy:

destroy()
---------

Destroys a DOM element. ``destroy()`` deletes all children and the node itself.

Usage
~~~~~

.. js ::
 
  require(["dojo/dom-construct"], function(domConstruct){
    // Destroy a node byId
    domConstruct.destroy("someId");
  });

This function only works with DomNodes, and returns nothing.

Attributes
~~~~~~~~~~

======== ============== ==================================
Argument Type           Description
======== ============== ==================================
node     String|DomNode A reference to a DOM node or an id
======== ============== ==================================

Examples
~~~~~~~~

Destroy a single node
'''''''''''''''''''''

The following example shows the basic functionality of ``Destroy()``:

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  Destroy a DomNode by the node ID
   
  .. js ::

    require(["dojo/dom-construct", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(domConstruct, dom, on){
      on(dom.byId("progButtonNode"), "click", function(){
        domConstruct.destroy("testnode1");
        dom.byId("result1").innerHTML = "TestNode1 has been destroyed.";
      });
    });

  Some DomNodes
  
  .. html ::
    
    <div id="testnode1">TestNode 1</div>
    <button id="progButtonNode" type="button">Destroy TestNode1</button>
    <div id="result1"></div>


Destroy all nodes in a list by reference
''''''''''''''''''''''''''''''''''''''''

The following example uses :ref:`dojo/query <dojo/query>` to retrieve a set of nodes and iterates over the list,
applying ``Destroy()``.

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  Destroy all Nodes in a list who have the CSS class ``red``.
  
  .. js ::

    require(["dojo/dom-construct", "dojo/query", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(domConstruct, query, dom, on){
      on(dom.byId("progButtonNode2"), "click", function(){
        query(".red").forEach(domConstruct.destroy);
        dom.byId("result2").innerHTML = "All red nodes were destroyed.";
      });
    });

  Some DomNodes
  
  .. html ::

    <div class="green">greenNode</div>
    <div class="green">greenNode</div>
    <div class="red">redNode</div>
    <div class="green">greenNode</div>
    <div class="green">greenNode</div>
    <div class="red">redNode</div>
    <div class="red">redNode</div>
    <div class="green">greenNode</div>
    <div class="green">greenNode</div>
    <div class="red">redNode</div>
    <div class="red">redNode</div>
    <div class="red">redNode</div>
    <div class="green">greenNode</div>
    <div class="green">greenNode</div>
    <div class="red">redNode</div>

    <div id="panel">
        <button id="progButtonNode2" type="button">Destroy all red nodes</button>
        <div id="result2"></div>
    </div>

  .. css ::

    .green { color: white; min-width: 30px; min-height: 30px;
        border: 1px #4d4d4d solid; margin-top: 4px; margin-right: 5px;
        float: left; background-color: green; padding: 2px }
    .red { color: white; min-width: 30px; min-height: 30px;
        border: 1px #4d4d4d solid; margin-top: 4px; margin-right: 5px;
        float: left; background-color: red; padding: 2px }
    #panel { clear: both }

See also
========

* :ref:`dojo/dom <dojo/dom>` - Core DOM API

* :ref:`dojo/_base/html <dojo/_base/html>` - Legacy API aliases

* `Dojo DOM Functions Tutorial <http://dojotoolkit.org/documentation/tutorials/1.7/dom_functions/>`_
