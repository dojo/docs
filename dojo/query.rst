.. _dojo/query:

==========
dojo/query
==========

.. contents ::
    :depth: 2

``dojo/query`` returns a list of DOM nodes based on a CSS selector.

Introduction
============

:ref:`dojo/request <dojo/request>` and XHR is half of the AJAX story. Once you make a request for data and receive a response, you must change the page.  Being able to change the HTML is dependent on locating nodes.

To select DOM nodes in JavaScript, you can use the browser's native DOM API, but it's verbose and hard to work with, slow and can differ across browser.  For example, retrieving all nodes with the class "progressIndicator" uses this code:

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
  console.log(list);

``dojo/query`` gives us a more compact way to do it, and it is often faster, particularly as we ask for more sophisticated kinds of relationships. The following is essentially equivalent to our first example:

.. js ::

  require(["dojo/query"], function(query){
    console.log(query(".progressIndicator"));
  });

Usage
=====

Requring in the module is all that is needed:

.. js ::

  require(["dojo/query"], function(query){
    var nl = query(".someClass");
  });

``dojo/query`` returns an instance of :ref:`NodeList <dojo/NodeList>`, which is essentially a JavaScript Array that has been decorated with functions that make it easier to utilise.  There are extensions of the base ``NodeList`` that are available to provide additional functionality:

* :ref:`dojo/NodeList-data <dojo/NodeList-data>` - Allows the association of arbitrary data with items of a ``NodeList``.

* :ref:`dojo/NodeList-dom <dojo/NodeList-dom>` - DOM related functions that are similar functionality to the ``dojo/dom-*`` related modules.

* :ref:`dojo/NodeList-fx <dojo/NodeList-fx>` - Adds base and core FX support to ``NodeList``.

* :ref:`dojo/NodeList-html <dojo/NodeList-html>` - Adds advanced content setting functionality.

* :ref:`dojo/NodeList-manipulate <dojo/NodeList-manipulate>` - Functions that allow for manipulation of DOM nodes in similar way to jQuery.

* :ref:`dojo/NodeList-traverse <dojo/NodeList-traverse>` - Advanced node traversal functions.

The first argument is the ``selector`` which is a CSS selector string that identifies the nodes that need to be retrieved.  The second argument is an optional ``context`` which limits the scope of the selector and only children of ``context`` will be considered.  This can either be a string representing the node ID or a DOM node.  For example:

.. js ::

  require(["dojo/query", "dojo/dom"], function(query, dom){
    var nl = query(".someClass", "someId");
    // or
    var node = dom.byId("someId");
        nl = query(".someClass", node);
  });

``dojo/query`` and ``NodeList`` are specifically designed with chaining in mind.  Most functions on ``NodeList`` return an instance of ``NodeList``.  For example:

.. js ::

  require(["dojo/query", "dojo/NodeList-dom"], function(query){
    query("li").forEach(function(node){
      node.innerHTML = "Something";
    }).style("color", "red")
      .style("fontSize", "12px");
  });

Selector Engines
----------------

``dojo/query`` is responsible for loading the appropriate selector engine.  There are several different modes which ``dojo/query`` can run in:

* ``css2`` (or ``lite``) - This will always use the lite engine, which delegates to the native selector engine if 
  available for anything but very simple queries (like id lookups). When a native selector engine is not available (
  IE7 and below), this supports simple, basic CSS2 level queries, consisting of elemental selectors: ``.class``, 
  ``#id``, ``tag``, and ``*``, attribute selectors, and child (``>``), descendant (space), and union (``,``) 
  combinators.  If the native selector engine is, the engine does not support pseudo classes.

* ``css2.1`` - This will always use the ``lite`` engine when a native selector engine is available. When a native 
  selector engine is not available (IE7 and below), this will load ``acme``.

* ``css3`` - This will always use the ``lite`` engine when a native selector engine with significant CSS3 support is 
  available. When a CSS3 capable (supporting most features) native selector engine is not available (IE8 and below), this will load ``acme``.

* ``acme`` - The ``acme`` selector engine with full CSS3 features will be used. This supports certain features that 
  are not available in any native engine (albeit rarely used).

When you are running Dojo in legacy mode (``async: false``), ``dojo/query`` will run in ``acme`` mode.  When you are 
running with ``async: true`` the default selector engine level is ``css3``.

The summarize, the two alternate selector engines included with Dojo have the following features (which can be 
selected explicitly or by the module's CSS level needs):

* ``acme`` - Designed to have full CSS3 support, it is about 14KB (minified).

* ``lite`` - Basic CSS2 level queries, consisting of elemental selectors: ``.class``, ``#id``, ``tag``, and ``*``, 
  attribute selectors, and child (``>``), descendant (space), and union (``,``) combinators. With a native selector 
  engine, the ``lite`` engine does not support pseudo classes.  It is about 2KB (minified).

Specifying the Selector Level
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The selector level can be controlled though various mechanisms.  The default selector level can be specified in the build profile (see :ref:`Dojo Builder <build/index>`).  The selector engine can be specified as part of your Dojo configuration:

.. html ::

  <script data-dojo-config="selectorEngine: 'css2.1', async: true" src="dojo/dojo.js">
  </script>

Or:

.. html ::

  <script type="text/javascript">
    var dojoConfig = {
      selectorEngine: "css2.1",
      async: true
    };
  </script>
  <script src="dojo/dojo.js">

The selector engine level can be specificed as a loader plugin for each module.  For example, if the module needed to 
do a CSS3 level query, you could write:

.. js ::

  define(["dojo/query!css3"], function(query){
      query(".someClass:last-child").style("color", "red");
  });

If Dojo had started with the ``lite`` engine, this will ensure that CSS3 support is available, and will load ``acme`` on older browsers.  It is recommended that you use this syntax for modules that explicitly need more complex queries.
If your module is using a simpler query, then ``"dojo/query"`` or ``"dojo/query!css2.1"`` should be used.

Selector Support
----------------

The following tables summerize selector engine levels and their support.

Standard CSS2 Selectors
~~~~~~~~~~~~~~~~~~~~~~~

These selectors can be used with any selector engine.

====================== ==========
Pattern                Meaning
====================== ==========
\*                     any element
E                      an element of type E
E F                    an F element descendant of an E element
E > F                  an F element child of an E element
E:link
E:visited              an E element being the source anchor of a hyperlink of which the target is not yet visited 
                       (:link) or already visited (:visited)
E:active
E:hover
E:focus                an E element during certain user actions
E[foo]                 an E element with a "foo" attribute
E[foo="bar"]           an E element whose "foo" attribute value is exactly equal to "bar"
E[foo~="bar"]          an E element whose "foo" attribute value is a list of space-separated values, one of which is 
                       exactly equal to "bar"
E[hreflang|="en"]      an E element whose "hreflang" attribute has a hyphen-separated list of values beginning (from 
                       the left) with "en"
E:lang(fr)             an element of type E in language "fr" (the document language specifies how language is 
                       determined)
E.warning              an E element whose class is "warning" (the document language specifies how class is determined).
E#myid                 an E element with ID equal to "myid".
S1, S2                 union of two selectors, ex: div, span
====================== ==========

Additional Selectors Supported By Lite Engine
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

These selectors are not part of CSS2, but are supported by the lite engine, so effectively then can also be used with any specified selector engine.

====================== ==========
Pattern                Meaning
====================== ==========
E[foo^="bar"]          an E element whose "foo" attribute value begins exactly with the string "bar"
E[foo$="bar"]          an E element whose "foo" attribute value ends exactly with the string "bar"
E[foo*="bar"]          an E element whose "foo" attribute value contains the substring "bar"
====================== ==========

Standard CSS2.1 Selectors
~~~~~~~~~~~~~~~~~~~~~~~~~

To use these selectors, you must specify the ``css2.1``, ``css3``, or ``acme`` selector engine.

====================== ==========
Pattern                Meaning
====================== ==========
E:first-child          an E element, first child of its parent
E + F                  an F element immediately preceded by an E element
====================== ==========

Standard CSS3 Selectors
~~~~~~~~~~~~~~~~~~~~~~~

To use these selectors, you must specify the ``css3`` or ``acme`` selector engine.

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

We can also use other selector engine levels.  Both Sizzle and Slick are excellent selector engines that work with 
``dojo/query``.  AMD/Dojo compatible versions (just wrapped with AMD) are available here:

* https://github.com/kriszyp/sizzle

* https://github.com/kriszyp/slick

Once installed, you can use the selector engine module id as specified selector engine level. We could set Sizzle as the query engine for our page:

.. html ::

  <script data-dojo-config="selectorEngine: 'sizzle/sizzle'" src="dojo/dojo.js">
  </script>

or set Slick as the engine for a particular module:

.. js ::

  define(["dojo/query!slick/Source/slick"], function(query){
    query(".someClass:custom-pseudo").style("color", "red");
  });

Note for cross-domain legacy API usage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This use case should be quite rare, but presents a wrinkle worth noting.

When loading ``dojo.js`` cross-domain and electing to use an alternate selector engine not included in ``dojo.js`` 
itself, legacy APIs will not immediately work, since Dojo base does not finish loading until the selector engine is 
pulled in asynchronously.  In this case, it will be necessary to use ``require``.  In a pinch, legacy code can simply 
be wrapped like so:

.. js ::

  require(["dojo"], function(dojo){
    dojo.require(/* ... */);
    // etc...
  });

Again, this issue *only* affects use of legacy APIs when a selector engine is used which is not baked into ``dojo.js``.

Examples
========

Example Selector Queries
------------------------

The following tables provide example selector queries and what sort of nodes they would select.

========================================= =============================================================================
Query                                     Description
========================================= =============================================================================
``h3``                                    All nodes that are heading level 3
``h3:first-child``                        All nodes that are the first children of a ``<h3>`` header
``#main``                                 A node with ``id="main"`` [1]_
``#main h3``                              All ``<h3>`` nodes that are contained by a node with ``id="main"`` [1]_
``div#main``                              Only select a node with ``id="main"`` if it is a ``<div>``
``div#main h3``                           All nodes that are ``<h3>`` contained in a ``<div>`` with an ``id="main"``
``#main div > h3``                        All ``<h3>`` nodes that are immediate children of a ``<div>`` contained 
                                          within a node that has ``id="main"`` [1]_
``.foo``                                  All nodes with a ``class="foo"``
``.foo.bar``                              All nodes that have both ``foo`` and ``bar`` classes
``#main > h3``                            All ``<h3>`` nodes that are immediate children of a node with ``id="main"``
                                          [1]_
``#main > *``                             All immediate children of a node with ``id="main"`` [1]_
``.foo > *``                              All immediate children of a nodes with a ``class="foo"``
``.foo, .bar``                            All nodes with a ``class="foo"`` or a ``class="bar"``
``[foo]``                                 All nodes with an attribute of ``foo``
``[foo$=\"thud\"]``                       All nodes with an attribute of ``foo`` where the value ends in ``thud``
``[foo$=thud]``                           All nodes with an attribute of ``foo`` where the value ends in ``thud``
``[foo$=\"thudish\"]``                    All nodes with an attribute of ``foo`` where the value ends in ``thudish``
``#main [foo$=thud]``                     All nodes with an attribute of ``foo`` where the value ends in ``thud`` that 
                                          are contained within a node with an ``id="main"`` [1]_
``#main [ title $= thud ]``               All nodes with an attribute of ``title`` where the value ends in ``thud`` 
                                          that are contained within a node with an ``id="main"`` [1]_
``#main span[ title $= thud ]``           All ``<span>`` nodes with an attribute of ``title`` where the value ends in ``thud`` that are contained within a node with an ``id="main"`` [1]_
``[foo|=\"bar\"]``                        All nodes with an attribute of ``foo`` where the value contains ``bar`` in a 
                                          dash seperated list (e.g. ``foo="baz-bar-qat"``)
``[foo|=\"bar-baz\"]``                    All nodes with an attribute of ``foo`` where the value contains ``bar-baz`` 
                                          in a dash seperated list (e.g. ``foo="qat-bar-baz-qip"``)
``.foo:nth-child(2)``                     The 2nd children of nodes with a ``style="foo"``
``>``                                     All immediate childen
``> *``                                   All immediate children
``> [qux]``                               All immediate children that have an attribute of ``qux``
``.foo + span``                           All nodes that are a ``<span>`` that are directly after a node with a 
                                          ``style="foo"``
``.foo ~ span``                           All nodes that are a ``<span>`` that are siblings that follow a node with a 
                                          ``style="foo"``
``#foo ~ *``                              All nodes that are siblings that follow a node with an ``id="foo"`` [1]_
``#foo ~``                                All nodes that are siblings that follow a node with an ``id="foo"`` [1]_
``#main span.foo:not(span:first-child)``  All nodes that are a ``<span>`` with a ``class="foo"`` but not a ``<span>`` 
                                          and the first child of a node with an ``id="foo"``.
``#main span.foo:not(:first-child)``      All nodes that are a ``<span>`` with a ``class="foo"`` but not the first 
                                          child of a node with an ``id="foo"``. [1]_
``#main > h3:nth-child(odd)``             All nodes that are ``<h3>`` and the odd immediate children of a node with an 
                                          ``id="main"`` [1]_
``#main h3:nth-child(odd)``               All nodes that are ``<h3>`` and are odd children contained within a node 
                                          with an ``id="main"`` [1]_
``#main h3:nth-child(2n+1)``              All nodes that are ``<h3>``
``#main h3:nth-child(even)``
``#main h3:nth-child(2n)``                Every other nodes that are ``<h3>``
``#main2 > :checked``
``#main2 > input[type=checkbox]:checked``
``#main2 > input[type=radio]:checked``
========================================= =============================================================================

.. [1] It is usually less performant to utilize the selector query to select a node by ID and is only used here to faciliate the examples.  It is much better to pass the node name as a string or a node object as the second argument in the ``dojo/query`` call.

See Also
========

* :ref:`dojo/NodeList-data <dojo/NodeList-data>` - Allows the association of arbitrary data with items of a 
  ``NodeList``.

* :ref:`dojo/NodeList-dom <dojo/NodeList-dom>` - DOM related functions that are similar functionality to the
  ``dojo/dom-*`` related modules.

* :ref:`dojo/NodeList-fx <dojo/NodeList-fx>` - Adds base and core FX support to ``NodeList``.

* :ref:`dojo/NodeList-html <dojo/NodeList-html>` - Adds advanced content setting functionality.

* :ref:`dojo/NodeList-manipulate <dojo/NodeList-manipulate>` - Functions that allow for manipulation of DOM nodes in 
  similar way to jQuery.

* :ref:`dojo/NodeList-traverse <dojo/NodeList-traverse>` - Advanced node traversal functions.

* :ref:`dojo/selector/lite <dojo/selector/lite>` - The Dojo Lite selector.

* :ref:`dojo/selector/acme <dojo/selector/acme>` - The Dojo Acme selector.
