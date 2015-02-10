.. _dojo/NodeList:

========
NodeList
========

.. contents ::
    :depth: 2


A ``NodeList`` is a JavaScript Array that has been decorated with many helpful functions that operate on each member of the array.  It is what gets returned as the results of a :ref:`dojo/query() <dojo/query>` call.

Usage
=====

When using ``dojo/query``, it returns an instance of ``NodeList``:

.. js ::

  require(["dojo/query"], function(query){
    var nodelist = query(".something");
    // nodelist contains an instance of NodeList
  });

You can also create an instance of ``NodeList`` directly:

.. js ::

  require(["dojo/query", "dojo/dom"], function(query, dom){
    var nodelist = query.NodeList();
    nodelist.push(dom.byId("someId"));
    nodelist.push(dom.byId("someOtherId"));
    // nodelist now contains the two DOM nodes
  });

Most of the functions that decorate ``NodeList`` return the same instance, therefore easily allowing method chaining:

.. js ::
  
  require(["dojo/query", "dojo/NodeList-dom"], function(query){
        // get all "li" elements
      query("ul > li").
        // make them visible but, slightly transparent
        style({ opacity: 0.5, visibility: "visible" }).
        // and set a handler to make a clicked item fully opaque
        onclick(function(e){
          // a node to dojo.query() is a fast way to get a list
          query(e.target).style({ opacity:1 }).toggleClass("clicked");
        });
  });

Beyond the basic functionality defined in ``dojo/query``, there are also several other modules which add additional functionality:

* :ref:`dojo/NodeList-data <dojo/NodeList-data>` - Allows the association of arbitrary data with items of a ``NodeList``.

* :ref:`dojo/NodeList-dom <dojo/NodeList-dom>` - DOM related functions that are similar in functionality to the ``dojo/dom-*`` related modules.

* :ref:`dojo/NodeList-fx <dojo/NodeList-fx>` - Adds base and core FX support to ``NodeList``.

* :ref:`dojo/NodeList-html <dojo/NodeList-html>` - Adds advanced content setting functionality.

* :ref:`dojo/NodeList-manipulate <dojo/NodeList-manipulate>` - Functions that allow for manipulation of DOM nodes in similar way to jQuery.

* :ref:`dojo/NodeList-traverse <dojo/NodeList-traverse>` - Advanced node traversal functions.

Features
========

The following sections provide an overview of the base functionality provide by ``dojo/query``.

at()
----

Returns a new ``NodeList`` with the items specified by index assuming a 0 based array.  Negative values will return values from the end of the ``NodeList``.

.. js ::

  require(["dojo/query"], function(query){
    var nodelist = query("ul > li").at(0, -1);
    // nodelist contains first and last nodes of an unordered list
  });

concat()
--------

Returns a new ``NodeList`` which contains the original list in addition to any passed arguments.

.. js ::

  require(["dojo/query"], function(query)){
    var nodelist = query("h1").concat(query("h2"));
    // nodelist contains all the documents headers that are level 1 and 2
  }

end()
-----

Used when "chaining" to revert back to the previous ``NodeList`` that generated the current ``NodeList``.

.. js ::

  require(["dojo/query", "dojo/NodeList-dom"], function(query){
    query("a")
      // Contains all anchors
        .filter(".disabled")
        // Only contains anchors with class "disabled"
          .style("color", "grey")
     .end()
        // Reverts back to all anchors now
        .style("fontSize", "14px");
  });

This function takes no arguments.

every()
-------

Returns ``true`` if every node of the ``NodeList`` returns ``true`` for the supplied function, or ``false`` if any element returns ``false`` for the supplied function.  This works just like :ref:`dojo/_base/array::every() <dojo/_base/array#every>` except the target is implied to be the ``NodeList``.

.. js ::

  require(["dojo/query"], function(query){
    if(query(".someclass").every(function(node){
      return node.innerHTML == "hello";
    })){
      // function is true for every node
    }else{
      // function is not true for every node
    }
  });

forEach()
---------

Iterates over every node of the ``NodeList`` passing the nodes to a function.  This function will process each node.  If you want the ability to "short circuit" see ``every()`` or ``some()`` instead.

.. js ::

  require(["dojo/query"], function(query){
    query(".someclass").forEach(function(node){
      // node will be each node in the list.
    });
  });

indexOf()
---------

Returns the index of the first occurance of a node in a ``NodeList``.  If not found, it returns ``-1``.

.. js ::

  require(["dojo/query", "dojo/dom"], function(query, dom){
    var node = dom.byId("someId");
    var idx = query(".someClass").indexOf(node);
    // if idx >= 0 then node has a class of someClass
    // if idx = -1 then node doesn't have class of someClass
  });

instantiate()
-------------

Instantiates objects for each class, passing the optional configuration object to the constructor.  This is similar
to the functionality of the :ref:`dojo/parser <dojo/parser>` but instead of scanning the DOM for marked up nodes, it 
uses the nodes in the ``NodeList``.

.. js ::

  require(["dojo/query", "dijit/form/Button"], function(query, Button){
    // Converts all button nodes to dijit/form/Buttons
    query("button").instantiate(Button, {
      showLabel: true
    });
  });

The function returns a ``NodeList`` where the members are the instantiated objects.

lastIndexOf()
-------------

Returns the index of the last occurrence of a node in a ``NodeList``.  If the node is not found, the value of ``-1`` is
returned.

.. js ::

  require(["dojo/query", "dojo/dom"], function(query, dom){
    var node = dom.byId("someId");
    var idx = query(".someClass").lastIndexOf(node);
    // if idx >= 0 then the value is the last occurrence of node
    // if idx = -1 then node was not found in the NodeList
  });

map()
-----

``map()`` interates all the nodes in the ``NodeList``, passing them to the ``callback`` function and then returning a new ``NodeList`` with any of the modified results.

.. js ::

  require(["dojo/query"], function(query){
    var nodelist = query("h1").map(function(node){
      return node.parentNode;
    });
    // nodelist contains all the parent nodes of every heading level 1 node
  });

The function has the following signature:

======== =================== ==================================================================================
Name     Type                Description
======== =================== ==================================================================================
callback **Function|String** The function (or function name in the optional scope object) to apply to each node
thisObj  *Object*            The optional scope object to be used as ``this``.
======== =================== ==================================================================================

The function returns a ``NodeList`` with the returned values of the ``callback`` function.

on()
----

Attaches an event listener to the nodes of the ``NodeList``.  This feature leverages :ref:`dojo/on <dojo/on>` to provide this mechanism.  Please refer to that for additional information.

.. js ::

  require("dojo/query", function(query){
    query("button").on("click", function(e){
      console.log("click!");
    });
    // Every button will log "click!" to the console when clicked
  });

``on()`` supports event delegation by using selectors as the first argument with the event names as pseudo selectors. 
For example:

.. js ::

  require("dojo/query", function(query){
    query("#mylist").on("li:click", function(e){
      console.log("click!");
    });
    // Listens for onclick events on list items in the list with an ID of "myList"
  });

Because ``on()`` supports CSS selector syntax, comma delimited events can be used as well:

.. js ::

  require("dojo/query", function(query){
    query("#mylist").on("li button:mouseover, li:click", function(e){
      console.log("hello!");
    });
  });

This function returns a ``NodeList`` where each node has a ``remove()`` function that can be used to remove any 
listeners.

slice()
-------

Returns a new ``NodeList`` that is a "slice" of the source ``NodeList``.  Like all array type functions, the indexes are zero based.

.. js ::

  require("dojo/query", function(query){
    var nodelist = query("div").slice(0, 3);
    // nodelist contains the first 4 <div> elements
  });

some()
------

Returns ``true`` if any node of the ``NodeList`` returns ``true`` for the supplied function, or ``false`` if no elements return ``false`` for the supplied function.  This works just like :ref:`dojo/_base/array::some() <dojo/_base/array#some>` except the target is implied to be the ``NodeList``.

.. js ::

  require(["dojo/query"], function(query){
    if(query(".someclass").some(function(node){
      return node.innerHTML == "hello";
    })){
      // function is true for at least one node
    }else{
      // function is not true for any node
    }
  });

splice()
--------

Returns a new ``NodeList`` that is a manipulated version based on the passed arguments that may insert new nodes or remove nodes.

.. js ::

  require(["dojo/query"], function(query){
    var nodelist = query("div").splice(0, 3);
    // nodelist contains a list with the first 3 elements spliced out
    // from the source
  });

Other
-----

In addition, standard JavaScript ``Array`` functions will also work, like ``push()``, ``pop()``, ``shift()`` and 
``unshift()``.  Since ``NodeList`` is essentially a JavaScript array that has been extended, these core array 
functions are provided by the underlying JavaScript engine.

Extending
=========

``NodeList`` is specifically designed to be extended, which is exactly what the other ``dojo/NodeList-*`` modules do.  By using :ref:`dojo/_base/lang::extend() <dojo/_base/lang#extend>` you can add functionality to the ``NodeList`` quite easily.  It is recommended that you do this via creating an AMD module.

For example, create a custom module named ``myapp/NodeList-custom.js``:

.. js ::

  define(["dojo/_base/lang", "dojo/query", "dojo/NodeList-dom"], function(lang, query){
    lang.extend(query.NodeList, {
      makeRed: function(){
        this.style({ color: "red" });
        return this;
      }
    });
  });

And then to use the extension:

.. js ::

  require(["dojo/query", "myapp/NodeList-custom"], function(query){
    query(".geenText").makeRed();
  });

It is important that you return an instance of ``NodeList`` for chaining to work as expected, which in most cases will be ``return this;``.

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  Provides an example of working with a ``NodeList`` in an array like fashion.

  .. js ::

    require(["dojo/query", "dojo/dom", "dojo/dom-construct", "dojo/json", "dojo/on", "dojo/domReady!"],
    function(query, dom, domConst, JSON, on){
      query("button").on("click", function(e){
        var nodelist = query("li");
        domConst.place("<p>Length: " + nodelist.length, dom.byId("output"));
        var ih = [];
        nodelist.slice(0, 3).forEach(function(node){
          ih.push(node.innerHTML);
        });
        domConst.place("<pre>" + JSON.stringify(ih) + "</pre>", dom.byId("output"));
      });
    });

  .. html ::

    <button id="start" type="button">Start</button>
    <div id="content">
      <div class="test1"></div>
      <div class="test1">
        <ul>
          <li>Item 1</li>
          <li>Item 2</li>
          <li>Item 3</li>
          <li>Item 4</li>
          <li>Item 5</li>
          <li>Item 6</li>
        </ul>
      </div>
    </div>
    <h2>Output</h2>
    <div id="output"></div>

See Also
========

* :ref:`dojo/NodeList-data <dojo/NodeList-data>` - Allows the association of arbitrary data with items of a ``NodeList``.

* :ref:`dojo/NodeList-dom <dojo/NodeList-dom>` - DOM related functions that are similar functionality to the ``dojo/dom-*`` related modules.

* :ref:`dojo/NodeList-fx <dojo/NodeList-fx>` - Adds base and core FX support to ``NodeList``.

* :ref:`dojo/NodeList-html <dojo/NodeList-html>` - Adds advanced content setting functionality.

* :ref:`dojo/NodeList-manipulate <dojo/NodeList-manipulate>` - Functions that allow for manipulation of DOM nodes in similar way to jQuery.

* :ref:`dojo/NodeList-traverse <dojo/NodeList-traverse>` - Advanced node traversal functions.

* :ref:`dojox/NodeList/delegate <dojox/NodeList/delegate>` - An event delegation API for ``NodeList``.
