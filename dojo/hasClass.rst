.. _dojo/hasClass:

=============
dojo.hasClass
=============

:Project owner: Eugene Lazutkin
:since: V0.9

.. contents ::
   :depth: 2

Returns a boolean depending on whether or not a node has a passed class string.

Since Dojo 1.7, ``dojo.hasClass`` is exposed via the ``contains()`` method of the :ref:`dojo/dom-class <dojo/dom-class>` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

The function takes two arguments:

1. A DOM node or its node id (as a string).
2. A CSS class name as a string.

It returns ``true`` if the node has the class, and ``false`` otherwise.

Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``contains`` is accessed from the ``dojo/dom-class`` module.

.. js ::

  require(["dojo/dom-class"], function(domClass){
      // Do something if a node with id="someNode" has class="aSillyClassName" present
      if(domClass.contains("someNode", "aSillyClassName")){ ... }
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.hasClass`` in the ``define`` or ``require`` callback:

.. js ::

  require(["dojo"], function(dojo){
      // Do something if a node with id="someNode" has class="aSillyClassName" present
      if(dojo.hasClass("someNode", "aSillyClassName")){ ... }
  });

Dojo < 1.7
----------

.. js ::

    // Do something if a node with id="someNode" has class="aSillyClassName" present
    if(dojo.hasClass("someNode", "aSillyClassName")){ ... }


Consider the following html:

.. html ::
  
    <div id="bam" class="foo bar baz"></div>
    <div class="something else"></div>

Using ``dojo.hasClass`` to find if the node ``id="bam"`` has ``class="foo"``:

.. js ::
  
  // Dojo 1.7+ (AMD)
  require(["dojo/dom-class"], function(domClass){
    if(domClass.contains("bam", "foo")){
      /* it does */
    }
  });

  // Dojo < 1.7
  if(dojo.hasClass("bam", "foo")){
    /* it does */
  }

Using :ref:`dojo.query <dojo/query>` to find a node and check if it has a class:

.. js ::
  
  // Dojo 1.7+ (AMD)
  require(["dojo/dom-class", "dojo/query"], function(domClass, query){
     query(".something").forEach(function(node){
       if(domClass.contains(node, "else"){
          /* it does */
       }
    });
  });

  // Dojo < 1.7
  dojo.query(".something").forEach(function(node){
     if(dojo.hasClass(node, "else"){
        /* it does */
     }
  });

Note: You do not need to explicitly check for ``dojo.hasClass`` before adding or removing a class with :ref:`dojo.addClass <dojo/addClass>` or :ref:`dojo.removeClass <dojo/removeClass>`, they do it for you.


See also
========

* :ref:`dojo.addClass <dojo/addClass>`
* :ref:`dojo.removeClass <dojo/removeClass>`
* :ref:`dojo.toggleClass <dojo/toggleClass>`
