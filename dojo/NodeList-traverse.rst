#format dojo_rst

dojo.NodeList-traverse
========================

:Status: Draft
:Version: 1.0
:Project owner: James Burke
:Available: since 1.4

.. contents::
   :depth: 2

Method extensions to `dojo.NodeList <dojo/NodeList>`_/`dojo.query <dojo/query>`_ for traversing the DOM. These methods are intended to match the API naming and behavior as the similarly named methods in jQuery.

============
Introduction
============

Doing a dojo.require("dojo.NodeList-traverse") will add some addition methods to `dojo.NodeList <dojo/NodeList>`_ (the return object from a `dojo.query <dojo/query>`_ call) that allow easier traversal of the DOM as it relates to the nodes in the dojo.NodeList.


=====
Usage
=====

Here is a simple example showing how dojo.NodeList-traverse adds a "children" method to dojo.NodeList that can be called via the normal method chaining done with a dojo.query result:

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-traverse");
  
  //Grabs all child nodes of all divs
  //and returns a dojo.NodeList object
  //to allow further chaining operations
  dojo.query("div").children();


=========================================
Methods added by dojo.NodeList-traverse
=========================================

children
---------
Returns all immediate child elements for nodes in this dojo.NodeList.
Optionally takes a query to filter the child elements.

**Note**: the optional query can only be single-expression CSS rule. For example, ".thinger" or
"#someId[attrName='value']" but not "div > span". In short,
anything which does not invoke a descent to evaluate but
can instead be used to test a single node is acceptable.

.end() can be used on the returned dojo.NodeList to get back to the
original dojo.NodeList.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="red">Red One</div>
    Some Text
    <div class="blue">Blue One</div>
    <div class="red">Red Two</div>
    <div class="blue">Blue Two</div>
  </div>


.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-traverse");
  
  //This code returns the four child divs in a dojo.NodeList:
  dojo.query(".container").children();

  //This code returns the two divs that have the class "red" in a dojo.NodeList:
  dojo.query(".container").children(".red");


closest
---------
Returns closest parent that matches query, **including** current node in this
dojo.NodeList if it matches the query. Optionally takes a query to filter the closest nodes.

**Note**: the optional query can only be single-expression CSS rule. For example, ".thinger" or
"#someId[attrName='value']" but not "div > span". In short,
anything which does not invoke a descent to evaluate but
can instead be used to test a single node is acceptable.

.end() can be used on the returned dojo.NodeList to get back to the
original dojo.NodeList.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="red">Red One</div>
    Some Text
    <div class="blue">Blue One</div>
    <div class="red">Red Two</div>
    <div class="blue">Blue Two</div>
  </div>


.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-traverse");
  
  //This code returns the div with class "container" in a dojo.NodeList:
  dojo.query(".red").closest(".container");


parent
---------
Returns immediate parent elements for nodes in this dojo.NodeList.
Optionally takes a query to filter the parent elements.

**Note**: the optional query can only be single-expression CSS rule. For example, ".thinger" or
"#someId[attrName='value']" but not "div > span". In short,
anything which does not invoke a descent to evaluate but
can instead be used to test a single node is acceptable.

.end() can be used on the returned dojo.NodeList to get back to the
original dojo.NodeList.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="red">Red One</div>
    <div class="blue first"><span class="text">Blue One</span></div>
    <div class="red">Red Two</div>
    <div class="blue"><span class="text">Blue Two</span></div>
  </div>

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-traverse");
  
  //This code returns the two divs with class "blue" in a dojo.NodeList:
  dojo.query(".text").parent();

  //This code returns the one div with class "blue" and "first" in a dojo.NodeList:
  dojo.query(".text").parent(".first");


parents
---------
Returns all parent elements for nodes in this dojo.NodeList.
Optionally takes a query to filter the parent elements.

**Note**: the optional query can only be single-expression CSS rule. For example, ".thinger" or
"#someId[attrName='value']" but not "div > span". In short,
anything which does not invoke a descent to evaluate but
can instead be used to test a single node is acceptable.

.end() can be used on the returned dojo.NodeList to get back to the
original dojo.NodeList.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="red">Red One</div>
    <div class="blue first"><span class="text">Blue One</span></div>
    <div class="red">Red Two</div>
    <div class="blue"><span class="text">Blue Two</span></div>
  </div>

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-traverse");
  
  //This code returns the two divs with class "blue" and the div with class "container" in a dojo.NodeList:
  dojo.query(".text").parents();

  //This code returns the one div with class "container" in a dojo.NodeList:
  dojo.query(".text").parents(".first");

siblings
---------
Returns all sibling elements for nodes in this dojo.NodeList.
Optionally takes a query to filter the sibling elements.

**Note**: the optional query can only be single-expression CSS rule. For example, ".thinger" or
"#someId[attrName='value']" but not "div > span". In short,
anything which does not invoke a descent to evaluate but
can instead be used to test a single node is acceptable.

.end() can be used on the returned dojo.NodeList to get back to the
original dojo.NodeList.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="red">Red One</div>
    Some Text
    <div class="blue first">Blue One</div>
    <div class="red">Red Two</div>
    <div class="blue">Blue Two</div>
  </div>

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-traverse");
  
  //This code returns the two div with class "red" and the other div
  //with class "blue" that does not have "first". in a dojo.NodeList:
  dojo.query(".first").siblings();

  //This code returns the two div with class "red" in a dojo.NodeList:
  dojo.query(".first").siblings(".red");

next
---------
Returns the next element for nodes in this dojo.NodeList.
Optionally takes a query to filter the next elements.

**Note**: the optional query can only be single-expression CSS rule. For example, ".thinger" or
"#someId[attrName='value']" but not "div > span". In short,
anything which does not invoke a descent to evaluate but
can instead be used to test a single node is acceptable.

.end() can be used on the returned dojo.NodeList to get back to the
original dojo.NodeList.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="red">Red One</div>
    Some Text
    <div class="blue first">Blue One</div>
    <div class="red">Red Two</div>
    <div class="blue last">Blue Two</div>
  </div>

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-traverse");
  
  //This code returns the div with class "red" and has innerHTML of "Red Two" in a dojo.NodeList:
  dojo.query(".first").next();

  //This code does not match any nodes so it returns an empty dojo.NodeList:
  dojo.query(".last").next(".red");


prev
---------
Returns the previous element for nodes in this dojo.NodeList.
Optionally takes a query to filter the previous elements.

**Note**: the optional query can only be single-expression CSS rule. For example, ".thinger" or
"#someId[attrName='value']" but not "div > span". In short,
anything which does not invoke a descent to evaluate but
can instead be used to test a single node is acceptable.

.end() can be used on the returned dojo.NodeList to get back to the
original dojo.NodeList.

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="red">Red One</div>
    Some Text
    <div class="blue first">Blue One</div>
    <div class="red">Red Two</div>
    <div class="blue last">Blue Two</div>
  </div>

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-traverse");
  
  //This code returns the div with class "red" and has innerHTML of "Red One" in a dojo.NodeList:
  dojo.query(".first").prev();

  //This code does not match any nodes so it returns an empty dojo.NodeList:
  dojo.query(".first").prev(".blue");


first
---------
Returns the first node in this dojo.NodeList as a dojo.NodeList.

This method is provided due to a difference in the Acme query engine used by default in Dojo. The Acme engine does not support ":first" queries, since it is not part of the CSS3 spec. This method can be used to give the same effect. For instance, instead of doing dojo.query("div:first"), you can do dojo.query("div").first().

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="red">Red One</div>
    Some Text
    <div class="blue first">Blue One</div>
    <div class="red">Red Two</div>
    <div class="blue last">Blue Two</div>
  </div>

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-traverse");
  
  //This code returns the div with class "blue" and "first" in a dojo.NodeList:
  dojo.query(".blue").first();


last
---------
Returns the last node in this dojo.NodeList as a dojo.NodeList.

This method is provided due to a difference in the Acme query engine used by default in Dojo. The Acme engine does not support ":last" queries, since it is not part of the CSS3 spec. This method can be used to give the same effect. For instance, instead of doing dojo.query("div:last"), you can do dojo.query("div").last().

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="red">Red One</div>
    Some Text
    <div class="blue first">Blue One</div>
    <div class="red">Red Two</div>
    <div class="blue last">Blue Two</div>
  </div>

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-traverse");
  
  //This code returns the last div with class "blue" in a dojo.NodeList:
  dojo.query(".blue").last();


even
---------
Returns the even nodes in this dojo.NodeList as a dojo.NodeList.

This method is provided due to a difference in the Acme query engine used by default in Dojo. The Acme engine does not support ":even" queries, since it is not part of the CSS3 spec. This method can be used to give the same effect. For instance, instead of doing dojo.query("div:even"), you can do dojo.query("div").even().

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="interior red">Red One</div>
    <div class="interior blue">Blue One</div>
    <div class="interior red">Red Two</div>
    <div class="interior blue">Blue Two</div>
  </div>

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-traverse");
  
  //This code returns the two divs with class "blue" in a dojo.NodeList:
  dojo.query(".interior").even();


odd
---------
Returns the odd nodes in this dojo.NodeList as a dojo.NodeList.

This method is provided due to a difference in the Acme query engine used by default in Dojo. The Acme engine does not support ":odd" queries, since it is not part of the CSS3 spec. This method can be used to give the same effect. For instance, instead of doing dojo.query("div:odd"), you can do dojo.query("div").odd().

**Example**

Assume a DOM created by this markup:

.. code-block :: html
  :linenos:

  <div class="container">
    <div class="interior red">Red One</div>
    <div class="interior blue">Blue One</div>
    <div class="interior red">Red Two</div>
    <div class="interior blue">Blue Two</div>
  </div>

.. code-block :: javascript
  :linenos:

  dojo.require("dojo.NodeList-traverse");
  
  //This code returns the two divs with class "red" in a dojo.NodeList:
  dojo.query(".interior").odd();
