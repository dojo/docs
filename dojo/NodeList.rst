## page was renamed from 1.2/dojo/NodeList
#format dojo_rst

dojo.NodeList
=============

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins
:Developers: James Burke, Peter Higgins, Eugene Lazutkin, Adam Peller, Neil Roberts, Alex Russell, Dylan Schiemann
:Available: since V?

.. contents::
    :depth: 2

A **NodeList** is a standard Array, decorated with several very helpful functions.  


============
Introduction
============

`dojo.query <dojo/query>`_ returns a instance of a dojo.NodeList, though you can use them standalone. 

.. code-block :: javascript

  // create an instance of a NodeList
  var nl = dojo.query(".selectable");
  console.log(nl.length);

The helper functions attached to the NodeList typically return the same instance of a NodeList, allowing for chaining:

.. code-block :: javascript
 
  dojo.query("#ul > li").style({ opacity:0.5, visibility:"visible" }).onclick(function(e){
      dojo.query(e.target).style({ opacity:1 }).toggleClass("clicked");
  });


=========================
Common NodeList Functions
=========================

The `entire NodeList API <http://api.dojotoolkit.org/jsdoc/dojo/HEAD/dojo.NodeList>`_ is rather extensive, so just we're covering the most common functions here.

forEach - run a function for each element in this NodeList

.. code-block :: javascript

  dojo.query("div > h2").forEach(function(node){
      // append content to each h2 as a direct child of a <div>
      node.innerHTML += " - found"; 
  });

All the same syntax and parameters found in `dojo.forEach <dojo/forEach>`_ apply to NodeList.forEach(), as is the case with most of the Dom Utility functions borrowed from the dojo namespace. 

For instance, `dojo.style() <dojo/style>`_ styles a single Node around a defined API. That API is mapped into NodeList, though dropping the node parameter, and calling dojo.style for each node in the list:

.. code-block :: javascript
  
   // all elements with class="hidden"
   dojo.query(".hidden").style({ opacity:0, visibility:"visible" }).removeClass("hidden").addClass("readyToFade");
   
As is the case for .removeClass, .addClass, .place, and most other dom-related functions in NodeList. All return the instance of the same NodeList, and allow for chaining. 


=====================
Events with NodeLists
=====================

NodeList.connect() is provided as a way to add event handlers to all Nodes in the list, matching the `dojo.connect <dojo/connect>`_ API, assuming again the node to connect to is the current item in the list

.. code-block :: javascript

   dojo.query(".readyToFade").connect("onclick", function(evt){
       dojo.fadeIn({ node: evt.target }).play();
   });

You can pass any event you would to dojo.connect, and expect the same results. All the DOM Level 2 events are mixed into nodelist directly as functions, so the above example could be written out as:

.. code-block :: javascript

   dojo.query(".readyToFade").onclick(function(evt){
       dojo.fadeIn({ node: evt.target }).play();
   });

Supported are onclick, onmouseenter, onmouseleave, onmouseover, omouseout, ondblclick, all the `normal dom events <quickstart/events>`_ you'd expect, and as of 1.2, onsubmit, onload, and onerror. 

.. code-block :: javascript 
 
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

   // make an existing form use Ajax/xhrPost
   dojo.query("#myForm").onsubmit(function(e){
       e.preventDefault();
       dojo.xhrPost({
           form:"myForm", 
           load: function(data){
               console.log('server said: ', data);
           }
       });
   });

Here, we've prevent a normal form from submitting, and use Ajax to send the data to the form's action="" url in an unobtrusive manner.


==================
Extending NodeList
==================

Or, Writing Your Own Plugins: Adding your own code to the dojo.NodeList class makes them available to dojo.query calls. Simply use `dojo.extend <dojo/extend>`_ to mix in new functionality into the prototype:

.. code-block :: javascript

  dojo.extend(dojo.NodeList, {
      makeRed: function(){
         return this.style({ color:"red" });
      }
  });
  dojo.query(".greenText").makeRed();

The import part being 'return this', ensuring any following chains will work. 


===================
NodeList extensions
===================

To keep the Base size to a minimum, some NodeList functionality is provided by external modules. For instance, dojo.NodeList-fx add all the required FX/Animation code to NodeList, dojox.fx.ext-dojo.NodeList provides the animation functionality from dojox.fx, and dojo.NodeList-html adds advanced HTML manipulation functions. The hyphen in the filename is meant to indicate the module being loaded modifies an existing Class, as you won't be able to call hyphenated functions directly. Simply require in the the necessary code:

.. code-block :: javascript

  dojo.require("dojo.NodeList-fx");
  dojo.addOnLoad(function(){
      dojo.query(".readyToFade").fadeIn().play();
  }); 

The NodeList animations do *not* return the NodeList instance. Instead, they return the created _Animation object, which you have to explictly call .play() on.
