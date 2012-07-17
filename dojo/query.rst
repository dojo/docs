.. _dojo/query:

==========
dojo/query
==========

.. contents ::
    :depth: 2

dojo/query returns a list of DOM nodes based on a CSS selector.

Introduction
============

XHR is half of the AJAX story. Once you make a request for data and receive it via :ref:`dojo.xhr <dojo/xhr>`, you must change the page - display the new data in a panel, turn an indicator from red to green, or whatever. Changing HTML is, in turn, dependent on locating nodes.

A bad solution: using the DOM API
---------------------------------

To select HTML elements in JavaScript, you can use the browser's native DOM API, but it's verbose and hard to work with...not to mention slow. For example, retrieving all nodes with the class "progressIndicator" uses this code:

.. js ::

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

Oy! That's a lot of code for what should be very simple. It's also very slow.

Better and faster: dojo.query
-----------------------------

**dojo.query** gives us a more compact way to do it, and it's often faster, particularly as we ask for more sophisticated kinds of relationships. The following is exactly equivalent to our first example:


.. js ::

    // list every node with the class "progressIndicator":
    console.dir( dojo.query(".progressIndicator") );



Usage
=====

Users of other libraries will find the syntax very familiar:

.. js ::

  require("dojo/query", function(query){  // Note, query or any other variable name can be used

    // find and dump contents of every element in the page with the class "blueButton" assigned
    query(".blueButton").forEach(function(node, index, arr){
      console.debug(node.innerHTML);
    });

  });

The returned object of a **dojo.query()** call is an instance of :ref:`dojo.NodeList <dojo/NodeList>`, a subclass of Array with many convenience methods added for making DOM manipulation and event handling easier. Custom extensions of the **dojo.NodeList** class are supported and encouraged.


Examples
========


Simple Queries
---------------

.. js ::

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

.. js ::

  dojo.query('#main > *')
  dojo.query('#main >')
  dojo.query('.foo >')
  dojo.query('.foo > *')


Queries rooted at a given element
---------------------------------

.. js ::

  dojo.query('> *', dojo.byId('container'))
  dojo.query('> h3', 'main')

Compound queries
----------------

Combining 2 or more selectors to produce one resultset

.. js ::

  dojo.query('.foo, .bar')


Multiple class attribute values
-------------------------------

.. js ::

  dojo.query('.foo.bar')


Using attribute selectors
-------------------------

Picking out elements with particular attributes/values

.. js ::

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
--------------------

.. js ::

  dojo.query('>', 'container')
  dojo.query('> *', 'container')
  dojo.query('> [qux]', 'container')

Sibling selectors
-----------------

.. js ::

  dojo.query('.foo + span')
  dojo.query('.foo ~ span')
  dojo.query('#foo ~ *')
  dojo.query('#foo ~')

Sub-selectors, using not()
--------------------------

.. js ::

  dojo.query('#main span.foo:not(span:first-child)')
  dojo.query('#main span.foo:not(:first-child)')

Nth-child
---------

.. js ::

  dojo.query('#main > h3:nth-child(odd)')
  dojo.query('#main h3:nth-child(odd)')
  dojo.query('#main h3:nth-child(2n+1)')
  dojo.query('#main h3:nth-child(even)')
  dojo.query('#main h3:nth-child(2n)')
  dojo.query('#main h3:nth-child(2n+3)')
  dojo.query('#main > *:nth-child(2n-5)')


Using pseudo-selectors
----------------------

.. js ::

  dojo.query('#main2 > :checked')
  dojo.query('#main2 > input[type=checkbox]:checked')
  dojo.query('#main2 > input[type=radio]:checked')


Count of checked checkboxes in a form with id myForm
----------------------------------------------------

.. js ::

  dojo.query('input:checked', 'myForm').length



Selector Engine Levels
======================

You can specify alternate selector engines and compliance levels.
By default, Dojo base will use the acme selector engine, which supports a large set of CSS3 selectors.
However, not all applications need all of these selectors,
and most queries can be performed with the native selector engines or with a simpler engine.
Dojo 1.7 includes a new lite selector engine for situations where simpler queries are sufficient.
The acme selector engine is about 14KB (minified, not gzipped), whereas the lite selector engine is about 2KB,
which can be a big advantage for mobile applications.

There are several different levels of CSS compliance that can be selected:

* css2 (or lite) - This will always use the lite engine, which delegates to the native selector engine if available
  for anything but very simple queries (like id lookups). When a native selector engine is not available
  (IE7 and below), this supports simple, basic CSS2 level queries, consisting of elemental selectors:
  .class, #id, tag, and star, attribute selectors, and child (>), descendant (space), and union (,) combinators.
  With a native selector engine, the lite engine does not support pseudo classes.
* css2.1 - This will always use the lite engine when a native selector engine is available.
  When a native selector engine is not available (IE7 and below), this will load acme.
* css3 - This will always use the lite engine when a native selector engine with significant CSS3 support is available.
  When a CSS3 capable (supporting most features) native selector engine is not available (IE8 and below), this will load acme.
* acme - The acme selector engine with full CSS3 features will be used.
  This supports certain features that are not available in any native engine (albeit rarely used).

When you are not using Dojo base (running async without a dependency on base module "dojo"),
the default selector engine level is "css3".
Again, if you are using Dojo base, the default is "acme".

The summarize, the two alternate selector engines included with Dojo have the following features
(which can be selected explicitly or by the module's CSS level needs):

* acme - Designed to have full CSS3 support.
* lite - Basic CSS2 level queries, consisting of elemental selectors: .class, #id, tag, and star, attribute selectors, and child (>), descendant (space), and union (,) combinators. With a native selector engine, the lite engine does not support pseudo classes.

Specifying Selector Level
-------------------------

There are a couple of ways to set the selector engine. First, we can define the selector engine as part of the dojo configuration for the whole page:

.. html ::

  <script data-dojo-config="selectorEngine='css2.1'" src="dojo/dojo.js">
  </script>

You can also specify the selector engine level you are dependent on for each of your modules. This is done by indicating the CSS selector engine level after ! in the dojo/query module id. For example, if your module needed to do a CSS3 level query, you could write:

.. js ::

  define(["dojo/query!css3"], function(query){
      query(".someClass:last-child").style("color", "red");
  });

If Dojo had started with the lite engine, this will ensure that CSS3 support is available, and will load Acme on older browsers.
It is recommended that you use this syntax for modules that make more complex queries.
If your module is using a simpler query, then ``"dojo/query"`` or ``"dojo/query!css2.1"`` should be used.


Standard CSS2 Selectors
-----------------------

These selectors can be used with any selector engine.

====================== ==========
Pattern                Meaning
====================== ==========
\*                     any element
E                      an element of type E
E F                    an F element descendant of an E element
E > F                  an F element child of an E element
E:link
E:visited              an E element being the source anchor of a hyperlink of which the target is not yet visited (:link) or already visited (:visited)
E:active
E:hover
E:focus                an E element during certain user actions
E[foo]                 an E element with a "foo" attribute
E[foo="bar"]           an E element whose "foo" attribute value is exactly equal to "bar"
E[foo~="bar"]          an E element whose "foo" attribute value is a list of space-separated values, one of which is exactly equal to "bar"
E[hreflang|="en"]      an E element whose "hreflang" attribute has a hyphen-separated list of values beginning (from the left) with "en"
E:lang(fr)             an element of type E in language "fr" (the document language specifies how language is determined)
E.warning              an E element whose class is "warning" (the document language specifies how class is determined).
E#myid                 an E element with ID equal to "myid".
S1, S2                 union of two selectors, ex: div, span
====================== ==========


Additional Selectors Supported By Lite Engine
---------------------------------------------
These selectors are not part of CSS2, but are supported by the lite engine, so effectively then can also be used
with any specified selector engine.

====================== ==========
Pattern                Meaning
====================== ==========
E[foo^="bar"]          an E element whose "foo" attribute value begins exactly with the string "bar"
E[foo$="bar"]          an E element whose "foo" attribute value ends exactly with the string "bar"
E[foo*="bar"]          an E element whose "foo" attribute value contains the substring "bar"
====================== ==========


Standard CSS2.1 Selectors
-------------------------

To use these selectors, you must specify the css2.1, css3, or acme selector engine.

====================== ==========
Pattern                Meaning
====================== ==========
E:first-child          an E element, first child of its parent
E + F                  an F element immediately preceded by an E element
====================== ==========

Standard CSS3 Selectors
-----------------------

To use these selectors, you must specify the css3 or acme selector engine.

====================== ==========
Pattern                Meaning
====================== ==========
E ~ F                  an F element preceded by an E element
E:nth-child(n)         an E element, the n-th child of its parent
E:checked              a user interface element E which is checked (for instance a radio-button or checkbox)
E:empty                an E element that has no children (including text nodes)
E:root                 an E element, root of the document
E:nth-last-child(n)    an E element, the n-th child of its parent, counting from the last one
E:nth-of-type(n)       an E element, the n-th sibling of its type
E:nth-last-of-type(n)  an E element, the n-th sibling of its type, counting from the last one
E:last-child           an E element, last child of its parent
E:first-of-type        an E element, first sibling of its type
E:last-of-type         an E element, last sibling of its type
E:only-child           an E element, only child of its parent
E:only-of-type         an E element, only sibling of its type
E:target               an E element being the target of the referring URI
E:enabled
E:disabled             a user interface element E which is enabled or disabled
E::first-line          the first formatted line of an E element
E::first-letter        the first formatted letter of an E element
E::selection           the portion of an E element that is currently selected/highlighted by the user
E::before              generated content before an E element
E::after               generated content after an E element
E:not(s)               an E element that does not match simple selector s
====================== ==========


Alternate Selector Engines
--------------------------

We can also use other selector engine levels.
Both Sizzle and Slick are excellent selector engines that work with dojo/query.
AMD/Dojo compatible versions (just wrapped with AMD) are available here:
https://github.com/kriszyp/sizzle and https://github.com/kriszyp/slick.
Once installed, you can use the selector engine module id as specified selector engine level.
We could set Sizzle as the query engine for our page:

.. html ::

  <script data-dojo-config="selectorEngine='sizzle/sizzle'" src="dojo/dojo.js">
  </script>

or set Slick as the engine for a particular module:

.. html ::

  define(["dojo/query!slick/Source/slick"], function(query){
      query(".someClass:custom-pseudo").style("color", "red");
  });

Note for cross-domain legacy API usage
``````````````````````````````````````

This use-case should be quite rare, but presents a wrinkle worth noting.

When loading dojo.js cross-domain and electing to use an alternate selector engine not included in
``dojo.js`` itself, legacy APIs will not immediately work, since Dojo base does not finish loading
until the selector engine is pulled in asynchronously.  In this case, it will be necessary to use
``require``.  In a pinch, legacy code can simply be wrapped like so:

.. js ::

    require(["dojo"], function(dojo){
        dojo.require(/* ... */);
        // etc...
    });

Again, this issue *only* affects use of legacy APIs when a selector engine is used which is not
baked into ``dojo.js``.
