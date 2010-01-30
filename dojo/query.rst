## page was renamed from 1.2/dojo/query
#format dojo_rst

dojo.query
==========

.. contents::
    :depth: 2

**dojo.query()** returns a list of DOM nodes based on a CSS selector. 


============
Introduction
============

XHR is half of the AJAX story. Once you make a request for data and receive it via `dojo.xhr <dojo/_base/xhr>`__, you must change the page - display the new data in a panel, turn an indicator from red to green, or whatever. Changing HTML is, in turn, dependent on locating nodes.

A bad solution: using the DOM API
---------------------------------

To select HTML elements in JavaScript, you can use the browser's native DOM API, but they're verbose and hard to work with...not to mention slow. For example, retrieving all nodes with the class "progressIndicator" uses this code:

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
    // list every node with the class "progressIndicator":
    var list = [];
    var nodes = document.getElementsByTagName("*");
    // iterate over every node in the document....SLOOOW
    for(var x = 0; x < nodes.length; x++){
        // only nodes with the class "progressIndicator":
        if(nodes[x].className == "progressIndicator"){
            // add to array:
            list.push(nodes[x]);
        }
    }
    console.dir(list);
  </script>

Oy! That's a lot of code for what should be very simple. It's also very slow. 

Better and faster: dojo.query
-----------------------------

**dojo.query** gives us a more compact way to do it, and it's often faster, particularly as we ask for more sophisticated kinds of relationships. The following is exactly equivalent to our first example:


.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
    // list every node with the class "progressIndicator":
    console.dir( dojo.query(".progressIndicator") );
  </script>


=====
Usage
=====

Users of other libraries will find the syntax very familiar:

.. code-block :: javascript

  dojo.addOnLoad(function(){
    // every element in the page with the class "blueButton" assigned
    dojo.query(".blueButton").forEach(function(node, index, arr){
        console.debug(node.innerHTML);
    });
  });

The returned object of a **dojo.query()** call is an instance of `dojo.NodeList <dojo/NodeList>`_, a subclass of Array with many convenience methods added for making DOM manipulation and event handling easier. Custom extensions of the **dojo.NodeList** class are supported and encouraged.


========
Examples
========


Simple Queries
---------------

.. code-block :: javascript

  // all <h3> elements
  dojo.query('h3')  
  // all <h3> elements which are first-child of their parent node
  dojo.query('h3:first-child')
  // a node with id="main"
  dojo.query('#main')
  // all <h3> elements within a node with id="main"
  dojo.query('#main h3')
  // a <div> with an id="main"
  dojo.query('div#main')
  // all <h3> elements within a div with id="main"
  dojo.query('div#main h3')
  // all <h3> elements that are immediate children of a <div>, within node with id="main"
  dojo.query('#main div > h3')
  // all nodes with class="foo"
  dojo.query('.foo')
  // all nodes with classes "foo" and "bar"
  dojo.query('.foo.bar')
  // all <h3> elements that are immediate children of a node with id="main"
  dojo.query('#main > h3')


Immediate Child Elements
------------------------

.. code-block :: javascript

  dojo.query('#main > *')
  dojo.query('#main >')
  dojo.query('.foo >')
  dojo.query('.foo > *')


Queries rooted at a given element
----------------------------------

.. code-block :: javascript

  dojo.query('> *', dojo.byId('container'))
  dojo.query('> h3', 'main')

Compound queries
---------------------

Combining 2 or more selectors to produce one resultset

.. code-block :: javascript

  dojo.query('.foo, .bar')


Multiple class attribute values
---------------------------------

.. code-block :: javascript

  dojo.query('.foo.bar')


Using attribute selectors
-------------------------

Picking out elements with particular attributes/values

.. code-block :: javascript

  dojo.query('[foo]')
  dojo.query('[foo$=\"thud\"]')
  dojo.query('[foo$=thud]')
  dojo.query('[foo$=\"thudish\"]')
  dojo.query('#main [foo$=thud]')
  dojo.query('#main [ title $= thud ]')
  dojo.query('#main span[ title $= thud ]')
  dojo.query('[foo|=\"bar\"]')
  dojo.query('[foo|=\"bar-baz\"]')
  dojo.query('[foo|=\"baz\"]')
  dojo.query('.foo:nth-child(2)')


Descendant selectors
------------------------

.. code-block :: javascript

  dojo.query('>', 'container')
  dojo.query('> *', 'container')
  dojo.query('> [qux]', 'container')

Sibling selectors
--------------------

.. code-block :: javascript

  dojo.query('.foo + span')
  dojo.query('.foo ~ span')
  dojo.query('#foo ~ *')
  dojo.query('#foo ~')

Sub-selectors, using not()
-------------------------------

.. code-block :: javascript

  dojo.query('#main span.foo:not(span:first-child)')
  dojo.query('#main span.foo:not(:first-child)')

Nth-child 
----------

.. code-block :: javascript

  dojo.query('#main > h3:nth-child(odd)')
  dojo.query('#main h3:nth-child(odd)')
  dojo.query('#main h3:nth-child(2n+1)')
  dojo.query('#main h3:nth-child(even)')
  dojo.query('#main h3:nth-child(2n)')
  dojo.query('#main h3:nth-child(2n+3)')
  dojo.query('#main > *:nth-child(2n-5)')


Using pseudo-selectors
-----------------------

.. code-block :: javascript

  dojo.query('#main2 > :checked')
  dojo.query('#main2 > input[type=checkbox]:checked')
  dojo.query('#main2 > input[type=radio]:checked')


Count of checked checkboxes in a form with id myForm
----------------------------------------------------

.. code-block :: javascript

  dojo.query('input:checked', 'myForm').length


=======================
Standard CSS3 Selectors
=======================

Because dojo.query adopts the CSS3 standard for selecting nodes, you can use any CSS reference guide for help on choosing the right queries. Eric Meyer's CSS: The Definitive Guide is a good resource. For convenience, here's a chart of the standard CSS3 selectors, taken from the current working draft RFC.

====================== ==========
Pattern	               Meaning
====================== ==========
\*	               any element
E	               an element of type E
E[foo]	               an E element with a "foo" attribute
E[foo="bar"]	       an E element whose "foo" attribute value is exactly equal to "bar"
E[foo~="bar"]	       an E element whose "foo" attribute value is a list of space-separated values, one of which is exactly equal to "bar"
E[foo^="bar"]	       an E element whose "foo" attribute value begins exactly with the string "bar"
E[foo$="bar"]	       an E element whose "foo" attribute value ends exactly with the string "bar"
E[foo*="bar"]	       an E element whose "foo" attribute value contains the substring "bar"
E[hreflang|="en"]      an E element whose "hreflang" attribute has a hyphen-separated list of values beginning (from the left) with "en"
E:root	               an E element, root of the document
E:nth-child(n)	       an E element, the n-th child of its parent
E:nth-last-child(n)    an E element, the n-th child of its parent, counting from the last one
E:nth-of-type(n)       an E element, the n-th sibling of its type
E:nth-last-of-type(n)  an E element, the n-th sibling of its type, counting from the last one
E:first-child	       an E element, first child of its parent
E:last-child	       an E element, last child of its parent
E:first-of-type	       an E element, first sibling of its type
E:last-of-type	       an E element, last sibling of its type
E:only-child	       an E element, only child of its parent
E:only-of-type	       an E element, only sibling of its type
E:empty	               an E element that has no children (including text nodes)
E:link
E:visited	       an E element being the source anchor of a hyperlink of which the target is not yet visited (:link) or already visited (:visited)
E:active
E:hover
E:focus	               an E element during certain user actions
E:target	       an E element being the target of the referring URI
E:lang(fr)	       an element of type E in language "fr" (the document language specifies how language is determined)
E:enabled
E:disabled	       a user interface element E which is enabled or disabled
E:checked	       a user interface element E which is checked (for instance a radio-button or checkbox)
E::first-line	       the first formatted line of an E element
E::first-letter	       the first formatted letter of an E element
E::selection	       the portion of an E element that is currently selected/highlighted by the user
E::before	       generated content before an E element
E::after	       generated content after an E element
E.warning	       an E element whose class is "warning" (the document language specifies how class is determined).
E#myid	               an E element with ID equal to "myid".
E:not(s)	       an E element that does not match simple selector s
E F	               an F element descendant of an E element
E > F	               an F element child of an E element
E + F	               an F element immediately preceded by an E element
E ~ F	               an F element preceded by an E element
====================== ==========
