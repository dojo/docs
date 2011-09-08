#format dojo_rst

dojo.hasClass
=============

:Project owner: Eugene Lazutkin
:Available: since V0.9

.. contents::
   :depth: 2

Returns a boolean depending on whether or not a node has a passed class string.

=====
Usage
=====

The function takes two arguments:

1. A DOM node or its node id (as a string).
2. A CSS class name as a string.

It returns ``true`` if the node has the class, and ``false`` otherwise.

Dojo 1.7 (AMD)
--------------
In dojo 1.7, dojo.hasClass has been moved to dojo/_base/html.

.. code-block :: javascript

  require(["dojo/_base/html"], function(dojo){   
      // Do something if a node with id="someNode" has class="aSillyClassName" present
      if(dojo.hasClass("someNode","aSillyClassName")){ ... }
  });

It's recommend to use cls.contains in dojo 1.7.

.. code-block :: javascript

  require(["dojo/dom-class"], function(cls){   
      // Do something if a node with id="someNode" has class="aSillyClassName" present
      if(cls.contains("someNode","aSillyClassName")){ ... }
  });

Dojo < 1.7
----------

.. code-block :: javascript

    // Do something if a node with id="someNode" has class="aSillyClassName" present
    if(dojo.hasClass("someNode","aSillyClassName")){ ... }


Consider the following html:

.. code-block :: html
  :linenos:

    <div id="bam" class="foo bar baz"></div>
    <div class="something else"></div>

Using ``dojo.hasClass`` to find if the node ``id="bam"`` has ``class="foo"``:

.. code-block :: javascript
  :linenos:

  // Dojo 1.7 (AMD)
  require(["dojo/dom-class"], function(cls){   
    if(cls.contains("bam", "foo")){
      /* it does */
    }
  });

  // Dojo < 1.7
  if(dojo.hasClass("bam", "foo")){
    /* it does */
  }

Using `dojo.query <dojo/query>`_ to find a node and check if it has a class:

.. code-block :: javascript
  :linenos:

  // Dojo 1.7 (AMD)
  require(["dojo/dom-class", "dojo/query"], function(cls, query){   
     query(".something").forEach(function(node){
       if(cls.contains(node, "else"){
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

Note: You do not need to explicitly check for ``dojo.hasClass`` before adding or removing a class with `dojo.addClass <dojo/addClass>`_ or `dojo.removeClass <dojo/removeClass>`_, they do it for you.


========
See also
========

* `dojo.addClass <dojo/addClass>`_
* `dojo.removeClass <dojo/removeClass>`_
* `dojo.toggleClass <dojo/toggleClass>`_
