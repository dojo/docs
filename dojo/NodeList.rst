.. _dojo/NodeList:

=============
dojo.NodeList
=============

.. contents ::
    :depth: 2

**[Note]** Since 1.7, dojo.NodeList is defined in dojo/query.js.

**NodeLists** are standard Arrays, decorated with many helpful functions which act on each DOM Node in the list.


Introduction
============

:ref:`dojo.query <dojo/query>` returns instances of ``dojo.NodeList``:

.. js ::
  
  require(["dojo/query", "dojo/NodeList-dom"], function(query){
      var nl = query(".selectable");
      // NodeLists have length like all other arrays
      console.log( nl.length );

      // hide each element (using style method added by NodeList-dom module)
      nl.style("display", "none");
  });


You can also create NodeLists manually and since NodeLists are "just an Array" all of the Array methods you already know Just Work (TM):

.. js ::
  
  require(["dojo/query", "dojo/dom", "dojo/NodeList-dom"], function(query, dom){
      // create an instance of a NodeList
      var nl = new query.NodeList();
      nl.push(dom.byId("someId"));
      nl.push(dom.byId("someOtherId"));

      // hide both
      nl.style("display", "none");
  });

The helper functions attached to the NodeList typically return the same instance of the ``NodeList``, allowing you to call several methods in a row:


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

Common NodeList Functions
=========================

The `entire NodeList API <http://dojotoolkit.org/api/dojo.NodeList>`_ is extensive,
so let's just focus on some of the most frequently used methods.

``forEach`` - runs a function for each element in a NodeList. If you want the option to break out of the loop, use ``every`` or ``some`` instead.

.. js ::
  
  require(["dojo/query"], function(query){
      query("div > h2").forEach(function(node, index, array){
          // append content to each h2 as a direct child of a <div>
          node.innerHTML += " - found";
      });
  });

The syntax is the same as :ref:`dojo.forEach <dojo/forEach>` except that the first parameter (the array) is implicitly provided. This pattern is repeated throughout the ``dojo.NodeList`` API.

For instance, :ref:`dojo.style() <dojo/style>` styles a single Node around a defined API. That API is mapped into ``NodeList``, dropping the node parameter and calling ``dojo.style`` on each node in the list:

.. js ::
  
  require(["dojo/query", "dojo/NodeList-dom"], function(query){
      // all elements with class="hidden"
      query(".hidden").
        style({ opacity:0, visibility:"visible" }).
        removeClass("hidden").
        addClass("readyToFade");
  });

As is the case for ``removeClass()``, ``addClass()``, ``place()``, and most other DOM-related functions in NodeList. All return the same NodeList, which allows for chaining. An exception is ``NodeList.coords``, which returns an array of the coordinate values of the matched nodes when called as a getter.

.. js ::
  
  require(["dojo/query", "dojo/_base/NodeList"], function(query){
      var nl = query(".foo"); // an array of nodes, NodeList
      var coords = nl.coords(); // an array of objects { w, h, t, l }
      nl.forEach(function(n, i){
         console.log(n, "has", coords[i].w, "width");
      });
  });

Events with NodeLists
=====================

``NodeList.connect()`` is provided as a way to add event handlers to all DOM Nodes in the list, matching the :ref:`dojo.connect <dojo/connect>` API, assuming again the node to connect to is the current item in the list.

In Dojo 1.7, ``NodeList.on()`` is provided as a similar analogue to the :ref:`dojo/on <dojo/on>` API.  ``NodeList.connect()`` is still available via the ``dojo/_base/NodeList`` module, which is pulled in automatically in legacy mode for backwards compatibility.

.. js ::
  
  require(["dojo/query", "dojo/_base/fx"], function(query, baseFx){
      query(".readyToFade").
        on("click", function(evt){
          baseFx.fadeIn({ node: evt.target }).play();
      });
  });

You can pass any event you would to :ref:`dojo.connect <dojo/connect>`, and expect the same results. As a convenience, many DOM events are exposed on ``NodeList`` directly as functions, so the above example could be written out as:

.. js ::
  
  require(["dojo/query", "dojo/_base/NodeList"], function(query){
       query(".readyToFade").
         onclick(function(evt){
           baseFx.fadeIn({ node: evt.target }).play();
       });
  });

Supported are ``onclick``, ``onmouseenter``, ``onmouseleave``, ``onmouseover``, ``omouseout``, ``ondblclick``, all the :ref:`normal dom events <quickstart/events>` you'd expect, and as of 1.2, ``onsubmit``, ``onload``, and ``onerror``.

.. js ::
  
  require(["dojo/query", "dojo/dom-style", "dojo/_base/NodeList"], function(query, domStyle){
       // setup some basic hovering behavior:
       query(".foo.bar")
         .onmouseenter(function(e){
             domStyle.set(e.target, "opacity", 1);
         })
         .onmouseleave(function(e){
             domStyle.set(e.target, "opacity", 0.5);
         });
  });

The Event object is the same as Dojo's normalized event when using dojo.connect.

.. js ::
  
  require(["dojo/query", "dojo/_base/xhr", "dojo/_base/NodeList"], function(query, xhr){
      // make an existing form use Ajax/xhrPost
      query("#myForm").onsubmit(function(e){
        // note that the event is always passed and has methods not regularly
        // supported on IE
        e.preventDefault();

        xhr.post({
          form:"myForm",
          load: function(data){
            console.log('server said: ', data);
          }
        });
     });
  });


This example prevents the form from submitting and instead uses Ajax to send the data to the form's ``action=""`` url in an unobtrusive manner.

An event delegation API is provided in :ref:`dojox.NodeList.delegate <dojox/NodeList/delegate>`

Extending NodeList
==================

Or, "Writing Your Own Plugins": Adding your own code to the dojo.NodeList class makes them available to dojo.query calls. Simply use :ref:`dojo.extend <dojo/extend>` to mix new functionality into the prototype of the ``NodeList`` class:

.. js ::
  
  require(["dojo/_base/lang", "dojo/query", "dojo/NodeList-dom"], function(lang, query){
      lang.extend(query.NodeList, {
        makeRed: function(){
          this.style({ color:"red" });
          return this;
        }
      });

      query(".greenText").makeRed();
  });

The import part being ``'return this'``, ensuring any following chains will work.


NodeList extensions
===================

To keep the Base size to a minimum, some NodeList functionality is provided by external modules. For instance, dojo.NodeList-fx add all the required FX/Animation code to NodeList, dojox.fx.ext-dojo.NodeList provides the animation functionality from dojox.fx, and dojo.NodeList-html adds advanced HTML manipulation functions. The hyphen in the filename is meant to indicate the module being loaded modifies an existing Class, as you won't be able to call hyphenated functions directly. Simply require in the necessary code:

.. js ::
  
  require(["dojo/query", "dojo/NodeList-fx", "dojo/domReady!"], function(query){
    query(".readyToFade").fadeIn().play();
  });


The NodeList animations do *not* return the NodeList instance. Instead, they return the created ``Animation`` object, which you have to explicitly call ``.play()`` on.

Additional Extensions
---------------------
  * **New in 1.7** :ref:`dojo.NodeList-dom <dojo/NodeList-dom>` - provides dom manipulation APIs (included in dojo base for back-compat)
  * :ref:`dojo.NodeList-data <dojo/NodeList-data>` - provides ``data`` and ``removeData`` APIs
  * :ref:`dojo.NodeList-traverse <dojo/NodeList-traverse>` - provides a variety of DOM Traversal APIs, like ``parents`` and ``closest``
  * :ref:`dojo.NodeList-manipulate <dojo/NodeList-manipulate>` - additional DOM Manipulation APIs
  * :ref:`dojo.NodeList-fx <dojo/NodeList-fx>` - Provides :ref:`dojo.Animation <dojo/Animation>` support to NodeLists
  * :ref:`dojo.NodeList-html <dojo/NodeList-html>` - Advanced content-setter functionality (with :ref:`dojo.parser <dojo/parser>` support.
  * :ref:`dojox.NodeList.delegate <dojox/NodeList/delegate>` - Event delegation for dojo.NodeList


API Details
===========

Array Methods
-------------

:at:
  Returns one (or more) elements from the list in a new ``NodeList`` based on integer index. This is a fast way to wrap elements in a ``NodeList``, exposing all the manipulation and DOM conveniences easily (can be chained).

.. js ::
  
  require(["dojo/query", "dojo/NodeList-dom"], function(query){
      // we only want to style the first one
      query("a").at(0).style("fontWeight", "bold");

      // get the 3rd and 5th elements:
      var ofInterest = query(".stories").at(2, 4);
  });


As of Dojo 1.5, .at() can also accept negative indices.

.. js ::
    
  require(["dojo/query"], function(query){
      query("a").at(0, -1).on("click", fn);
  });

Incidentally, you can .end() out of a NodeList returned from .at, providing you access to the original NodeList before filtering.

.. js ::
  
  require(["dojo/query", "dojo/_base/NodeList"], function(query){
    query("a")
      .at(0)
         .onclick(function(e){ ... })
      .end() // back to main <a> list
      .forEach(function(n){
            makePretty(n);
      });
  });
    

:forEach:
  like :ref:`dojo.forEach <dojo/forEach>` but with current list as the first parameter. Has the same API as `Array.forEach <https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Objects/Array/forEach>`_ in browsers that support it. Returns the source NodeList (can be chained).

.. js ::
  
  require(["dojo/query"], function(query){
      query("a").
        forEach(function(node, idx, arr){
          console.debug(node);
        });

      // alternately, use second param to provide the scope:
      query("a").
        forEach(console.debug, console);

      // or using the special shortened syntax from dojo.forEach:
      query("a").forEach("console.debug(item);");
  });
 

:map:
  like :ref:`dojo.map <dojo/map>` with the current list as the array or `Array.map <https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Objects/Array/map>`_ in browsers that support it.  Returns a new ``dojo.NodeList`` with the mapped-in elements (can be chained).

.. js ::
  
  require(["dojo/query"], function(query){
      var parents = query("a").
        map(function(node){
        return node.parentNode;
      });

      // or using the string version:
      var parents = query("a").map("return item.parentNode;");
  });

:slice:
  Used for grabbing only some of the elements in the list. Like `Array.slice <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:slice>`_, returns a new ``dojo.NodeList`` from a subset of the current list (can be chained).

.. js ::
    
  require(["dojo/query", "dojo/NodeList-dom"], function(query){
     query("a").slice(1, -1).addClass("emphasis");
  });

:splice:
  Useful for changing a list in-place instead of making a new copy. Like `Array.splice <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:splice>`_, returns a new ``dojo.NodeList`` containing the elements removed from the list (can be chained).

.. js ::
  
  require(["dojo/query", "dojo/NodeList-dom"], function(query){
      var anchors = query("a");
      // remove 3, starting with the second
      var removed = anchors.splice(1, 3);

      // ... and since we return a NodeList, style them:
      removed.style("opacity", 0.5);

      // bold the remaining anchors
      anchors.style("fontWeight", "bold");
  });

:concat:
  Joins other lists to the current list. Like `Array.concat <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:concat>`_, returns a new ``dojo.NodeList`` containing both the original elements and the new items (can be chained).

.. js ::
  
  require(["dojo/query"], function(query){
      var anchors = query("a");
      var bolds = query("b");
      var boldsAndAnchors = anchors.concat(bolds);
  });

:push:
  Like `Array.push <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:push>`_, ``push`` adds items to the ``NodeList``. Can be used to add multiple items at once. Returns the new list length (does not chain).

.. js ::
  
  require(["dojo/query", "dojo/_base/window"], function(query, baseWindow){
      var anchors = query("a");
      var a = baseWindow.doc.createElement("a");
      anchors.push(a, a.cloneNode(), a.cloneNode());
  });

:pop:
  Like `Array.pop <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:pop>`_, removes the last item from the ``NodeList`` (does not chain).

.. js ::
  
  require(["dojo/query", "dojo/dom-style"], function(query, domStyle){
      var anchors = query("a");
      // remove the last item from the list
      var a = anchors.pop();
      domStyle.set(a, "fontWeight", "bold");
  });


:shift:
  Like `Array.shift <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:shift>`_. Works like ``pop``, but instead pulls the *first* element from the list instead of the last (does not chain):

.. js ::
  
  require(["dojo/query", "dojo/dom-style"], function(query, domStyle){
      var anchors = query("a");
      // remove the first item from the list
      var a = anchors.shift();
      domStyle.set(a, "fontWeight", "bold");
  });

:unshift:
  Like `Array.unshift <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:shift>`_. Similar to ``push``, but instead puts elements at the *front* of the list. Returns the new length of the ``NodeList`` (does not chain):


.. js ::
  
  require(["dojo/query", "dojo/_base/window"], function(query, baseWindow){
      var anchors = query("a");
      var a = baseWindow.doc.createElement("a");
      var howMany = anchors.unshift(a);
  });

:indexOf:
  Like `Array.indexOf <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:indexOf>`_ (where supported) or `dojo.indexOf <dojo/indexOf>`_. Returns integer index if the tested element is found, ``-1`` if not found (does not chain).

.. js ::
  
  require(["dojo/query", "dojo/dom"], function(query, dom){
      var anchors = query("a");
      var tested = dom.byId("tested");
      console.debug("is it in the list?", ( anchors.indexOf(tested) != -1 ) );
  });

:lastIndexOf:
  Like `Array.lastIndexOf <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:lastIndexOf>`_ (where supported) or `dojo.lastIndexOf <dojo/lastIndexOf>`_. Returns integer index of the tested element found closest to the end of the list, ``-1`` if not found (does not chain).

:some:
  like `dojo.some <dojo/some>`_ and `Array.some <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:some>`_. Returns a boolean value indicating whether any of the items in the list match the filter function (does not chain).

.. js ::
  
  require(["dojo/query"], function(query){
      var hasFoo = query("a").
         some(function(node){
         return node.innerHTML == "foo";
      });

      // or using the string version (item is the node):
      var hasFoo = query("a").some("return item.innerHTML == 'foo';");
  });

:every:
  like `dojo.every <dojo/every>`_ and `Array.every <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:every>`_. Returns a boolean value indicating whether every item in the list matches the filter function (does not chain).


.. js ::
  
  require(["dojo/query", "dojo/NodeList-traverse"], function(query){
    var areOnlyChildren = query("a").
        every(function(node){
           return query(node.parentNode).children().length == 1
        });
  });

:filter:
  Like `dojo.filter <dojo/filter>`_ and `Array.filter <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:filter>`_. A new form of filter is added to support testing against simple CSS class matches. Returns a subset of the items in the list that pass the test (can be chained).

.. js ::
  
  require(["dojo/query", "dojo/NodeList-traverse"], function(query){
    // a list of anchors that are only children, same as query("a:only-child")
    var onlyChildren = query("a").
        filter(function(node){
          return query(node.parentNode).children().length == 1;
        });

     // anchors that also have the class ``foo`` and an attribute ``bar``:
     var fooBarAnchors = query("a").filter(".foo[bar]");

     query("*").filter(function(item){
         // highlight every paragraph
         return (item.nodeName == "p");
       }).style("backgroundColor", "yellow");

     // the same filtering using a CSS selector
     query("*").filter("p").styles("backgroundColor", "yellow");
  });

:query:
  Searches under all of the nodes in this list for nodes that match the passed query. Returns a flattened ``NodeList`` of all matching elements (can be chained).

.. js ::
  
  // search for all anchor tags under several nodes:
  require(["dojo/query", "dojo/NodeList-dom"], function(query){
      var anchors = query("#foo, #bar").query("a");
  });


DOM Methods
-----------

**[Note]** Since V1.7, the basic DOM APIs have been moved into ``dojo/NodeList-dom``. Please see :ref:`dojo/NodeList-dom <dojo/NodeList-dom>` for details.

When using Dojo in legacy applications (e.g. without ``async: true`` in ``dojoConfig``), ``dojo/NodeList-dom`` is automatically loaded for backwards compatibility.


Event Methods
-------------

:connect:
  Connect to an event of all the nodes in this list. Follows the pattern of :ref:`dojo.connect <dojo/connect>`, though assumes each node in the list to be the target to connect to.

.. js ::
    
  require(["dojo/query", "dojo/_base/NodeList"], function(query){
      query("a.external").connect("onclick", function(e){
        // `this` here refers to the node, as we've not explicitly set the context to something
      });
  
      query("form").connect("onsubmit", function(){});
  });


As a convenience, several common events are mapped as direct function calls. For example, the two following query() calls have identical results:

.. js ::

  var fn = function(e){ console.warn(e.target); }
  require(["dojo/query", "dojo/_base/NodeList"], function(query){
      query("a").onclick(fn);
      query("a").connect("onclick", fn);
  });

The full list of methods that are mapped in this way are: ``onblur``, ``onfocus``, ``onchange``, ``onclick``, ``onerror``, ``onkeydown``, ``onkeypress``, ``onkeyup``, ``onload``, ``onmousedown``, ``onmouseenter``, ``onmouseleave``, ``onmousemove``, ``onmouseout``, ``onmouseover``, ``onmouseup``, and ``onsubmit``.

It is also possible to manipulate the scope of the callback, just as :ref:`dojo.connect <dojo/connect>` would:

.. js ::
  
  require(["dojo/query", "dojo/_base/NodeList"], function(query){
      query("a").onclick(obj, "method");
      query("a").onclick(obj, obj.method);
  });
  
Animation
---------

Adding animation to lists of nodes requires including the module ``dojo.NodeList-fx`` which adds the required methods to instances of ``dojo.NodeList``. Please refer to :ref:`dojo.NodeList-fx <dojo/NodeList-fx>` for details.
