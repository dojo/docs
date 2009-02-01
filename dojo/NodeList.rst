## page was renamed from 1.2/dojo/NodeList
#format dojo_rst

dojo.NodeList
=============

:Status: Draft
:Version: 1.0
:Available: since Version 0.9

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

``forEach`` - runs a function for each element in a NodeList. 

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

The NodeList animations do *not* return the NodeList instance. Instead, they return the created ``_Animation`` object, which you have to explictly call ``.play()`` on.
