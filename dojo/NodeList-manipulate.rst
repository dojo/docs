#format dojo_rst

dojo.NodeList-manipulate
========================

:Status: Draft
:Version: 1.0
:Project owner: James Burke
:Available: since 1.4

.. contents::
   :depth: 2

Method extensions to `dojo.NodeList <dojo/NodeList>`_/`dojo.query <dojo/query>`_ that manipulate HTML. These methods are intended to match the API naming and behavior as the similarly names methods in jQuery.


============
Introduction
============

Doing a dojo.require("dojo.NodeList-manipulate") will add some addition methods to `dojo.NodeList <dojo/NodeList>`_ (the return object from a `dojo.query <dojo/query>`_ call) that allow easier manipulation of HTML as it relates to the nodes in the dojo.NodeList.


=====
Usage
=====

Here is a simple example showing how dojo.NodeList-manipulate adds an "after" method to dojo.NodeList that can be called via the normal method chaining done with a dojo.query result:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
 
  //Add a span that says Hello World after each div in the DOM
  //by using the "after" method added by dojo.NodeList-manipulate
  dojo.query("div").after("<span>Hello World');


=========================================
Methods added by dojo.NodeList-manipulate
=========================================

innerHTML
--------------------
Allows setting the innerHTML of each node in the NodeList,
if there is a value passed in, otherwise, reads the innerHTML value of the **first node** in the dojo.NodeList.

This method is simpler than the dojo.NodeList.html() method provided by
`dojo.NodeList-html`. This method just does proper innerHTML insertion of HTML fragments,
and it allows for the innerHTML to be read for the first node in the node list.

Since dojo.NodeList-html already took the "html" name, this method is called
"innerHTML". However, if dojo.NodeList-html has not been loaded yet, this
module will define an "html" method that can be used instead.

Be careful if you are working in an environment where it is possible that dojo.NodeList-html could
have been loaded, since its definition of "html" will take precedence.

The nodes represented by the value argument will be cloned if more than one
node is in this NodeList. The nodes in this NodeList are returned in the "set"
usage of this method, not the HTML that was inserted.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div id="foo"></div>
  <div id="bar"></div>

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  //inserts <p>Hello World</p> into both divs:
  dojo.query("div").innerHTML("<p>Hello World</p>");

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div id="foo"><p>Hello Mars</p></div>
  <div id="bar"><p>Hello World</p></div>

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  //This code returns "<p>Hello Mars</p>":
  var message = dojo.query("div").innerHTML();


html
--------------------
An alias for the "innerHTML" method, but only defined if there is not an existing "html" method on dojo.NodeList. Be careful if you are working in an environment where it is possible that `dojo.NodeList-html <dojo/NodeList-html>`_ could have been loaded, since its definition of "html" will take precedence.

If you are not sure if dojo.NodeList-html could be loaded, use the "innerHTML" method.

text
--------------------
Allows setting the text value of each node in the NodeList, if there is a value passed in, otherwise, returns the text value for all the
nodes in the NodeList in one string.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div id="foo"></div>
  <div id="bar"></div>

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  //This code inserts "Hello World" into both divs:
  dojo.query("div").text("Hello World");

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div id="foo"><p>Hello Mars <span>today</span></p></div>
  <div id="bar"><p>Hello World</p></div>
.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  //This code returns "Hello Mars today":
  var message = dojo.query("div").text();


val
--------------------
If a value is passed, allows seting the value property of form elements in this
NodeList, or properly selecting/checking the right value for radio/checkbox/select
elements. If no value is passed, the value of the first node in this NodeList
is returned.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <input type="text" value="foo">
  <select multiple>
    <option value="red" selected>Red</option>
    <option value="blue">Blue</option>
    <option value="yellow" selected>Yellow</option>
  </select>

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  This code gets and sets the values for the form fields above:
  dojo.query('[type="text"]).val(); //gets value foo
  dojo.query('[type="text"]).val("bar"); //sets the input's value to "bar"
  dojo.query("select").val() //gets array value ["red", "yellow"]
  dojo.query("select").val(["blue", "yellow"]) //Sets the blue and yellow options to selected.


append
--------------------
Appends the content to every node in the NodeList.

The content will be cloned if the length of NodeList
is greater than 1. Only the DOM nodes are cloned, not
any attached event handlers. The nodes currently in
this NodeList will be returned, not the appended content.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div id="foo"><p>Hello Mars</p></div>
  <div id="bar"><p>Hello World</p></div>

Running this code:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  dojo.query("div").append("<span>append</span>");

Results in this DOM structure:

.. code-block :: html
  :linenos:

  <div id="foo"><p>Hello Mars</p><span>append</span></div>
  <div id="bar"><p>Hello World</p><span>append</span></div>


appendTo
--------------------
Appends nodes in this NodeList to the nodes matched by the query passed to appendTo.

The nodes in this NodeList will be cloned if the query
matches more than one element. Only the DOM nodes are cloned, not
any attached event handlers. The nodes currently in
this NodeList will be returned, not the matched nodes
from the query.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <span>append</span>
  <p>Hello Mars</p>
  <p>Hello World</p>

Running this code:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  dojo.query("span").appendTo("p");

Results in this DOM structure:

.. code-block :: html
  :linenos:

  <p>Hello Mars<span>append</span></p>
  <p>Hello World<span>append</span></p>


prepend
--------------------
Prepends the content to every node in the NodeList.

The content will be cloned if the length of NodeList
is greater than 1. Only the DOM nodes are cloned, not
any attached event handlers. The nodes currently in
this NodeList will be returned, not the prepended content.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div id="foo"><p>Hello Mars</p></div>
  <div id="bar"><p>Hello World</p></div>

Running this code:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  dojo.query("div").prepend("<span>prepend</span>");

Results in this DOM structure:

.. code-block :: html
  :linenos:

  <div id="foo"><span>prepend</span><p>Hello Mars</p></div>
  <div id="bar"><span>prepend</span><p>Hello World</p></div>


prependTo
--------------------
Prepends nodes in this NodeList to the nodes matched by
the query passed to prependTo.

The nodes in this NodeList will be cloned if the query
matches more than one element. Only the DOM nodes are cloned, not
any attached event handlers. The nodes currently in
this NodeList will be returned, not the matched nodes
from the query.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <span>prepend</span>
  <p>Hello Mars</p>
  <p>Hello World</p>

Running this code:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  dojo.query("span").prependTo("p");

Results in this DOM structure:

.. code-block :: html
  :linenos:

  <p><span>prepend</span>Hello Mars</p>
  <p><span>prepend</span>Hello World</p>


after
--------------------
Places the content after every node in the NodeList.

The content will be cloned if the length of NodeList
is greater than 1. Only the DOM nodes are cloned, not
any attached event handlers. The nodes currently in
this NodeList will be returned, not the content.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div id="foo"><p>Hello Mars</p></div>
  <div id="bar"><p>Hello World</p></div>

Running this code:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  dojo.query("div").after("<span>after</span>");

Results in this DOM structure:

.. code-block :: html
  :linenos:

  <div id="foo"><p>Hello Mars</p></div><span>after</span>
  <div id="bar"><p>Hello World</p></div><span>after</span>


insertAfter
--------------------
The nodes in this NodeList will be placed after the nodes
matched by the query passed to insertAfter.

The nodes in this NodeList will be cloned if the query
matches more than one element. Only the DOM nodes are cloned, not
any attached event handlers. The nodes currently in
this NodeList will be returned, not the matched nodes
from the query.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <span>after</span>
  <p>Hello Mars</p>
  <p>Hello World</p>

Running this code:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  dojo.query("span").insertAfter("p");

Results in this DOM structure:

.. code-block :: html
  :linenos:

  <p>Hello Mars</p><span>after</span>
  <p>Hello World</p><span>after</span>


before
--------------------
Places the content before every node in the NodeList.

The content will be cloned if the length of NodeList
is greater than 1. Only the DOM nodes are cloned, not
any attached event handlers. The nodes currently in this NodeList
will be returned, not the content.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div id="foo"><p>Hello Mars</p></div>
  <div id="bar"><p>Hello World</p></div>

Running this code:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  dojo.query("div").before("<span>before</span>");

Results in this DOM structure:

.. code-block :: html
  :linenos:

  <span>before</span><div id="foo"><p>Hello Mars</p></div>
  <span>before</span><div id="bar"><p>Hello World</p></div>


insertBefore
--------------------
The nodes in this NodeList will be placed after the nodes
matched by the query passed to insertAfter.

The nodes in this NodeList will be cloned if the query
matches more than one element. Only the DOM nodes are cloned, not
any attached event handlers. The nodes currently in
this NodeList will be returned, not the matched nodes
from the query.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <span>before</span>
  <p>Hello Mars</p>
  <p>Hello World</p>

Running this code:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  dojo.query("span").insertBefore("p");

Results in this DOM structure:

.. code-block :: html
  :linenos:

  <span>before</span><p>Hello Mars</p>
  <span>before</span><p>Hello World</p>


remove
--------------------
Alias for dojo.NodeList's orphan method. Removes elements
in this list that match the simple filter from their parents
and returns them as a new NodeList.

wrap
--------------------
Wrap each node in the NodeList with html passed to wrap.

html will be cloned if the NodeList has more than one
element. Only DOM nodes are cloned, not any attached
event handlers. The nodes in the current NodeList will
be returned, not the nodes from html.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <b>one</b>
  <b>two</b>

Running this code:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  dojo.query("b").wrap("<div><span></span></div>");

Results in this DOM structure:

.. code-block :: html
  :linenos:

  <div><span><b>one</b></span></div>
  <div><span><b>two</b></span></div>


wrapAll
--------------------
Insert html where the first node in this NodeList lives, then place all
nodes in this NodeList as the child of the html.

The nodes in the current NodeList will be returned, not the nodes from html.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="red">Red One</div>
    <div class="blue">Blue One</div>
    <div class="red">Red Two</div>
    <div class="blue">Blue Two</div>
  </div>

Running this code:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  dojo.query(".red").wrapAll('<div class="allRed"></div>');

Results in this DOM structure:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="allRed">
      <div class="red">Red One</div>
      <div class="red">Red Two</div>
    </div>
    <div class="blue">Blue One</div>
    <div class="blue">Blue Two</div>
  </div>


wrapInner
--------------------
For each node in the NodeList, wrap all its children with the passed in html.

html will be cloned if the NodeList has more than one
element. Only DOM nodes are cloned, not any attached
event handlers. The nodes in the current NodeList will
be returned, not the nodes from html.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="red">Red One</div>
    <div class="blue">Blue One</div>
    <div class="red">Red Two</div>
    <div class="blue">Blue Two</div>
  </div>

Running this code:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  dojo.query(".red").wrapInner('<span class="special"></span>');

Results in this DOM structure:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="red"><span class="special">Red One</span></div>
    <div class="blue">Blue One</div>
    <div class="red"><span class="special">Red Two</span></div>
    <div class="blue">Blue Two</div>
  </div>


replaceWith
--------------------
Replaces each node in ths NodeList with the content passed to replaceWith.

The content will be cloned if the length of NodeList
is greater than 1. Only the DOM nodes are cloned, not
any attached event handlers. The nodes currently in
this NodeList will be returned, not the replacing content.
Note that the returned nodes have been removed from the DOM.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="red">Red One</div>
    <div class="blue">Blue One</div>
    <div class="red">Red Two</div>
    <div class="blue">Blue Two</div>
  </div>

Running this code:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  dojo.query(".red").replaceWith('<div class="green">Green</div>');

Results in this DOM structure:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="green">Green</div>
    <div class="blue">Blue One</div>
    <div class="green">Green</div>
    <div class="blue">Blue Two</div>
  </div>


replaceAll
--------------------
Replaces nodes matched by the query passed to replaceAll with the nodes
in this NodeList.

The nodes in this NodeList will be cloned if the query
matches more than one element. Only the DOM nodes are cloned, not
any attached event handlers. The nodes currently in
this NodeList will be returned, not the matched nodes
from the query. The nodes currently in this NodeLIst could have
been cloned, so the returned NodeList will include the cloned nodes.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="spacer">___</div>	
    <div class="red">Red One</div>
    <div class="spacer">___</div>	
    <div class="blue">Blue One</div>
    <div class="spacer">___</div>	
    <div class="red">Red Two</div>
    <div class="spacer">___</div>	
    <div class="blue">Blue Two</div>
  </div>

Running this code:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  dojo.query(".red").replaceAll(".blue");

Results in this DOM structure:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="spacer">___</div>	
    <div class="spacer">___</div>	
    <div class="red">Red One</div>
    <div class="red">Red Two</div>
    <div class="spacer">___</div>	
    <div class="spacer">___</div>	
    <div class="red">Red One</div>
    <div class="red">Red Two</div>
  </div>


clone
--------------------
Clones all the nodes in this NodeList and returns them as a new NodeList.

Only the DOM nodes are cloned, not any attached event handlers.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="red">Red One</div>
    <div class="blue">Blue One</div>
    <div class="red">Red Two</div>
    <div class="blue">Blue Two</div>
  </div>

Running this code:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-manipulate");
  
  dojo.query(".red").clone().appendTo(".container");

Results in this DOM structure:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="red">Red One</div>
    <div class="blue">Blue One</div>
    <div class="red">Red Two</div>
    <div class="blue">Blue Two</div>
    <div class="red">Red One</div>
    <div class="red">Red Two</div>
  </div>


========
See also
========

* `dojo.NodeList <dojo/NodeList>`_
* `dojo.NodeList-traverse <dojo/NodeList-traverse>`_
