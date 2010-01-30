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

Consider the following html:

.. code-block :: html
  :linenos:

    <div id="bam" class="foo bar baz"></div>
    <div class="something else"></div>

Using ``dojo.hasClass`` to find if the node ``id="bam"`` has ``class="foo"``:

.. code-block :: javascript
  :linenos:

  if(dojo.hasClass("bam", "foo")){
    /* it does */
  }

Using `dojo.query <dojo/query>`_ to find a node and check if it has a class:

.. code-block :: javascript
  :linenos:

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
