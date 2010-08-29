## page was renamed from 1.2/dojo/NodeList
#format dojo_rst

dojo.NodeList
=============

:Available: since V 0.9

.. contents::
    :depth: 2

**NodeLists** are standard Arrays, decorated with many helpful functions which act on each DOM Node in the list.


============
Introduction
============

`dojo.query <dojo/query>`_ returns instances of ``dojo.NodeList``:

.. code-block :: javascript
  :linenos:

  var nl = dojo.query(".selectable");
  // NodeLists have length like all other arrays
  console.log( nl.length );

  // hide each element
  nl.style("display","none");

You can also create NodeLists manually and since NodeLists are "just an Array" all of the Array methods you already know Just Work (TM):

.. code-block :: javascript
  :linenos:

  // create an instance of a NodeList
  var nl = new dojo.NodeList();
  nl.push(dojo.byId("someId"));
  nl.push(dojo.byId("someOtherId"));

  // hide both
  nl.style("display", "none");

The helper functions attached to the NodeList typically return the same instance of the ``NodeList``, allowing you to call several methods in a row:

.. code-block :: javascript
  :linenos:

  // get all "li" elements
  dojo.query("ul > li").
    // make them visible but, slightly transparent
    style({ opacity: 0.5, visibility: "visible" }).
    // and set a handler to make a clicked item fully opaque
    onclick(function(e){
      // a node to dojo.query() is a fast way to get a list
      dojo.query(e.target).style({ opacity:1 }).toggleClass("clicked");
    });


=========================
Common NodeList Functions
=========================

The `entire NodeList API <http://api.dojotoolkit.org/jsdoc/dojo/HEAD/dojo.NodeList>`_ is extensive, so lets just focus on some of the most frequently used methods.

``forEach`` - runs a function for each element in a NodeList. If you want the option to break out of the loop, use ``every`` or ``some`` instead.

.. code-block :: javascript
  :linenos:

  dojo.query("div > h2").forEach(function(node, index, array){
      // append content to each h2 as a direct child of a <div>
      node.innerHTML += " - found";
  });

The syntax is the same as `dojo.forEach <dojo/forEach>`_ except that the first parameter (the array) is implicitly provided. This pattern is repeated throught the ``dojo.NodeList`` API.

For instance, `dojo.style() <dojo/style>`_ styles a single Node around a defined API. That API is mapped into ``NodeList``, dropping the node parameter and calling ``dojo.style`` on each node in the list:

.. code-block :: javascript
  :linenos:

  // all elements with class="hidden"
  dojo.query(".hidden").
    style({ opacity:0, visibility:"visible" }).
    removeClass("hidden").
    addClass("readyToFade");

As is the case for ``removeClass()``, ``addClass()``, ``place()``, and most other DOM-related functions in NodeList. All return the same NodeList, which allows for chaining. An exception is ``NodeList.coords``, which returns an array of the coordinate values of the matched nodes when called as a getter.

.. code-block :: javascript
  :linenos:

  var nl = dojo.query(".foo"); // an array of nodes, NodeList
  var coords = nl.coords(); // an array of objects { w, h, t, l }
  nl.forEach(function(n, i){
     console.log(n, "has", coords[i].w, "width");
  });


=====================
Events with NodeLists
=====================

``NodeList.connect()`` is provided as a way to add event handlers to all DOM Nodes in the list, matching the `dojo.connect <dojo/connect>`_ API, assuming again the node to connect to is the current item in the list:

.. code-block :: javascript
  :linenos:

  dojo.query(".readyToFade").
    connect("onclick", function(evt){
      dojo.fadeIn({ node: evt.target }).play();
    });

You can pass any event you would to `dojo.connect <dojo/connect>`_, and expect the same results. As a convenience, many DOM events are exposed on ``NodeList`` directly as functions, so the above example could be written out as:

.. code-block :: javascript
  :linenos:

   dojo.query(".readyToFade").
     onclick(function(evt){
       dojo.fadeIn({ node: evt.target }).play();
     });

Supported are ``onclick``, ``onmouseenter``, ``onmouseleave``, ``onmouseover``, ``omouseout``, ``ondblclick``, all the `normal dom events <quickstart/events>`_ you'd expect, and as of 1.2, ``onsubmit``, ``onload``, and ``onerror``.

.. code-block :: javascript
  :linenos:

   // setup some basic hovering behavior:
   dojo.query(".foo.bar")
       .onmouseenter(function(e){
           dojo.style(e.target, "opacity", 1);
       })
       .onmouseleave(function(e){
           dojo.style(e.target, "opacity", 0.5);
       })
   ;

The Event object is the same as Dojo's normalized event when using dojo.connect.

.. code-block :: javascript
  :linenos:

  // make an existing form use Ajax/xhrPost
  dojo.query("#myForm").onsubmit(function(e){
    // note that the event is always passed and has methods not regularly
    // supported on IE
    e.preventDefault();

    dojo.xhrPost({
      form:"myForm",
      load: function(data){
        console.log('server said: ', data);
      }
    });

  });

This example prevents the form from submitting and instead uses Ajax to send the data to the form's ``action=""`` url in an unobtrusive manner.

An event delegation API is providing in `dojox.NodeList.delegate <dojox/NodeList/delegate>`_

==================
Extending NodeList
==================

Or, "Writing Your Own Plugins": Adding your own code to the dojo.NodeList class makes them available to dojo.query calls. Simply use `dojo.extend <dojo/extend>`_ to mix new functionality into the prototype of the ``NodeList`` class:

.. code-block :: javascript
  :linenos:

  dojo.extend(dojo.NodeList, {
    makeRed: function(){
      this.style({ color:"red" });
      return this;
    }
  });

  dojo.query(".greenText").makeRed();

The import part being ``'return this'``, ensuring any following chains will work.


===================
NodeList extensions
===================

To keep the Base size to a minimum, some NodeList functionality is provided by external modules. For instance, dojo.NodeList-fx add all the required FX/Animation code to NodeList, dojox.fx.ext-dojo.NodeList provides the animation functionality from dojox.fx, and dojo.NodeList-html adds advanced HTML manipulation functions. The hyphen in the filename is meant to indicate the module being loaded modifies an existing Class, as you won't be able to call hyphenated functions directly. Simply require in the the necessary code:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-fx");

  dojo.addOnLoad(function(){
    dojo.query(".readyToFade").fadeIn().play();
  });

The NodeList animations do *not* return the NodeList instance. Instead, they return the created ``Animation`` object, which you have to explictly call ``.play()`` on.

Additional Extensions
---------------------

  * `dojo.NodeList-data <dojo/NodeList-data>`_ - provides ``data`` and ``removeData`` APIs
  * `dojo.NodeList-traverse <dojo/NodeList-traverse>`_ - provides a variety of DOM Traversal APIs, like ``parents`` and ``closest``
  * `dojo.NodeList-manipulate <dojo/NodeList-manipulate>`_ - additional DOM Manipulation APIs
  * `dojo.NodeList-fx <dojo/NodeList-fx>`_ - Provides `dojo.Animation <dojo/Animation>`_ support to NodeLists
  * `dojo.NodeList-html <dojo/NodeList-html>`_ - Advanced content-setter functionality (with `dojo.parser <dojo/parser>`_ support. 
  * `dojox.NodeList.delegate <dojox/NodeList/delegate>`_ - Event delegation for dojo.NodeList


===========
API Details
===========

Array Methods
-------------

:at:
  Returns one (or more) elements from the list in a new ``NodeList`` based on integer index. This is a fast way to wrap elements in a ``NodeList``, exposing all the manipulation and DOM conveniences easily (can be chained). 

.. code-block :: javascript
  :linenos:

  // we only want to style the first one
  dojo.query("a").at(0).style("fontWeight", "bold");

  // get the 3rd and 5th elements:
  var ofInterest = dojo.query(".stories").at(2, 4);

.. code-block :: javascript
  :linenos:
  
  // new in Dojo 1.5, .at() can accept negative indices
  dojo.query("a").at(0, -1).onclick(fn); 
  
Incidentally, you can .end() out of a NodeList returned from .at, providing you access to the original NodeList before filtering.

.. code-block :: javascript
  :linenos:
  
  dojo.query("a")
      .at(0)
         .onclick(function(e){ ... })
      .end() // back to main <a> list
      .forEach(function(n){
            makePretty(n);
      });
    
:forEach:
  like `dojo.forEach <dojo/forEach>`_ but with current list as the first parameter. Has the same API as `Array.forEach <https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Objects/Array/forEach>`_ in browsers that support it. Returns the source NodeList (can be chained).

.. code-block :: javascript
  :linenos:

  dojo.query("a").
    forEach(function(node, idx, arr){
      console.debug(node);
    });

  // alternately, use second param to provide the scope:
  dojo.query("a").
    forEach(console.debug, console);

  // or using the special shortened syntax from dojo.forEach:
  dojo.query("a").forEach("console.debug(item);");

:map:
  like `dojo.map <dojo/map>`_ with the current list as the array or `Array.map <https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Objects/Array/map>`_ in browsers that support it.  Returns a new ``dojo.NodeList`` with the mapped-in elements (can be chained).

.. code-block :: javascript
  :linenos:

  var parents = dojo.query("a").
    map(function(node){
      return node.parentNode;
    });

  // or using the string version:
  var parents = dojo.query("a").some("return item.parentNode;");

:slice:
  Used for grabbing only some of the elements in the list. Like `Array.slice <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:slice>`_, returns a new ``dojo.NodeList`` from a subset of the current list (can be chained).

.. code-block :: javascript
  :linenos:

  // style all but the first and last:
  dojo.query("a").slice(1, -1).addClass("emphasis");

:splice:
  Useful for changing a list in-place instead of making a new copy. Like `Array.splice <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:splice>`_, returns a new ``dojo.NodeList`` containing the elements removed from the list (can be chained).

.. code-block :: javascript
  :linenos:

  var anchors = dojo.query("a");

  // remove 3, starting with the second
  var removed = anchors.splice(1, 3);

  // ... and since we return a NodeList, style them:
  removed.style("opacity", 0.5);

  // bold the remaining anchors
  anchors.style("fontWeight", "bold");


:concat:
  Joins other lists to the current list. Like `Array.concat <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:concat>`_, returns a new ``dojo.NodeList`` containing both the original elements and the new items (can be chained).

.. code-block :: javascript
  :linenos:

  var anchors = dojo.query("a");
  var bolds = dojo.query("b");
  var boldsAndAnchors = anchors.concat(bolds);

:push:
  Like `Array.push <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:push>`_, ``push`` adds items to the ``NodeList``. Can be used to add multiple items at once. Returns the new list length (does not chain).

.. code-block :: javascript
  :linenos:

  var anchors = dojo.query("a");
  var a = dojo.doc.createElement("a");
  // add "a" and 2 copies
  anchors.push(a, a.cloneNode(), a.cloneNode());

:pop:
  Like `Array.pop <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:pop>`_, removes the last item from the ``NodeList`` (does not chain).

.. code-block :: javascript
  :linenos:

  var anchors = dojo.query("a");
  // remove the last item from the list
  var a = anchors.pop();
  dojo.style(a, "fontWeight", "bold");

:shift:
  Like `Array.shift <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:shift>`_. Works like ``pop``, but instead pulls the *first* element from the list instead of the last (does not chain):

.. code-block :: javascript
  :linenos:

  var anchors = dojo.query("a");
  // remove the first item from the list
  var a = anchors.shift();
  dojo.style(a, "fontWeight", "bold");

:unshift:
  Like `Array.unshift <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:shift>`_. Similar to ``push``, but instead puts elements at the *front* of the list. Returns the new length of the ``NodeList`` (does not chain):

.. code-block :: javascript
  :linenos:

  var anchors = dojo.query("a");
  var a = dojo.doc.createElement("a");
  var howMany = anchors.unshift(a);

:indexOf:
  Like `Array.indexOf <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:indexOf>`_ (where supported) or `dojo.indexOf <dojo/indexOf>`_. Returns integer index if the tested element is found, ``-1`` if not found (does not chain).

.. code-block :: javascript
  :linenos:

  var anchors = dojo.query("a");
  var tested = dojo.byId("tested");
  console.debug("is it in the list?", ( anchors.indexOf(tested) != -1 ) );

:lastIndexOf:
  Like `Array.lastIndexOf <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:lastIndexOf>`_ (where supported) or `dojo.lastIndexOf <dojo/lastIndexOf>`_. Returns integer index of the tested element found closest to the end of the list, ``-1`` if not found (does not chain).

:some:
  like `dojo.some <dojo/some>`_ and `Array.some <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:some>`_. Returns a boolean value indicating whether any of the items in the list match the filter function (does not chain).

.. code-block :: javascript
  :linenos:

  var hasFoo = dojo.query("a").
    some(function(node){
      return node.innerHTML == "foo";
    });

  // or using the string version (item is the node):
  var hasFoo = dojo.query("a").some("return item.innerHTML == 'foo';");

:every:
  like `dojo.every <dojo/every>`_ and `Array.every <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:every>`_. Returns a boolean value indicating whether every item in the list matches the filter function (does not chain).

.. code-block :: javascript
  :linenos:

  // dojo.require("dojo.NodeList-traverse"); must be added in your code to use dojo.query().children() (new in 1.4)
  var areOnlyChildren = dojo.query("a").
    every(function(node){
       return dojo.query(node.parentNode).children().length == 1
    });

  // or using the string version (item is the node):
  var areOnlyChildren = dojo.query("a").every("return dojo.query(item.parentNode).children().length == 1;");


:filter:
  Like `dojo.filter <dojo/filter>`_ and `Array.filter <http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:Array:filter>`_. A new form of filter is added to support testing against simple CSS class matches. Returns a subset of the items in the list that pass the test (can be chained).

.. code-block :: javascript
  :linenos:

  // a list of anchors that are only children, same as dojo.query("a:only-child")
  // dojo.require("dojo.NodeList-traverse"); must be added in your code to use dojo.query().children() (new in 1.4)
  var onlyChildren = dojo.query("a").
    filter(function(node){
      return dojo.query(node.parentNode).children().length == 1;
    });

  // anchors that also have the class ``foo`` and an attribute ``bar``:
  var fooBarAnchors = dojo.query("a").filter(".foo[bar]");

  dojo.query("*").filter(function(item){
    // highlight every paragraph
    return (item.nodeName == "p");
  }).style("backgroundColor", "yellow");

  // the same filtering using a CSS selector
  dojo.query("*").filter("p").styles("backgroundColor", "yellow");

:query:
  Searches under all of the nodes in this list for nodes that match the passed query. Returns a flattened ``NodeList`` of all matching elements (can be chained).

.. code-block :: javascript
  :linenos:

  // search for all anchor tags under several nodes:
  var anchors = dojo.query("#foo, #bar").query("a");

DOM Methods
-----------

Click on a method name to see a documentation page for it.

:`attr <dojo/NodeList/attr>`_:
  Attribute getter/setter for this list of nodes. Mimics `dojo.attr <dojo/attr>`_, excluding the node passed.

:`removeAttr <dojo/NodeList/removeAttr>`_:
  **New in 1.4** - Forcefully remove the passed attribute from a node. Mimics `dojo.removeAttr <dojo/removeAttr>`_.

:style:
  Get or set styles to the nodes in this list. For more information see `dojo.style <dojo/style>`_

:addClass:
  Add the passed class to the nodes in this list. For more information see `dojo.addClass <dojo/addClass>`_

:removeClass:
  Remove the passed class to the nodes in this list. For more information see `dojo.removeClass <dojo/removeClass>`_

:toggleClass:
  Add the passed class to the nodes in this list, if the class is not present, otherwise removes it. For more information see `dojo.toggleClass <dojo/toggleClass>`_

:place:
  TODOC

:orphan:
  TODOC

:adopt:
  TODOC

:addContent:
  TODOC

:empty:
  Empties the content of the nodes in this list, leaving the nodes in place. see `dojo.empty <dojo/empty>`_

:coords:
  Partially "deprecated", using NodeList.position is recommended in Dojo 1.4 and higher. Returns the coordinate values
  of all the nodes in this list. 

:position:
  Returns the coordinate values of all the nodes in this list. 

Event Methods
-------------

:connect:
  Connect to an event of all the nodes in this list. Follows the pattern of `dojo.connect <dojo/connect>`_, though assumes each node in the list to be the target to connect to.
  
.. code-block :: javascript
  :linenos:
  
  dojo.query("a.external").connect("onclick", function(e){
    // `this` here refers to the node, as we've not explicitly set the context to something
  });
  
  dojo.query("form").connect("onsubmit", function(){});
  
As a convenience, several common events are mapped as direct function calls. For example, the two following query() calls have identical results:

.. code-block :: javascript
  :linenos:   
  
  var fn = function(e){ console.warn(e.target); }
  dojo.query("a").onclick(fn);
  dojo.query("a").connect("onclick", fn);

The full list of methods that are mapped in this way are: ``onblur``, ``onfocus``, ``onchange``, ``onclick``, ``onerror``, ``onkeydown``, ``onkeypress``, ``onkeyup``, ``onload``, ``onmousedown``, ``onmouseenter``, ``onmouseleave``, ``onmousemove``, ``onmouseout``, ``onmouseover``, ``onmouseup``, and ``onsubmit``.

It is also possible to manipulate the scope of the callback, just as `dojo.connect <dojo/connect>`_ would:

.. code-block :: javascript
  :linenos:
  
  // both call obj.method(e) in context of obj onclick:
  dojo.query("a").onclick(obj, "method"); 
  dojo.query("a").onclick(obj, obj.method);
  
Animation
---------

Adding animation to lists of nodes requires including the module ``dojo.NodeList-fx`` which adds the required methods to instances of ``dojo.NodeList``. They are:

:anim:
  TODOC
:fadeIn:
  TODOC
:fadeOut:
  TODOC
:slideTo:
  TODOC
:wipeIn:
  TODOC
:wipeOut:
  TODOC
:animateProperty:
  TODOC
