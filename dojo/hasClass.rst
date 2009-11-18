#format dojo_rst

dojo.hasClass
=============

:Status: Final
:Version: 1.0
:Project owner: Eugene Lazutkin
:Available: since 0.9

.. contents::
   :depth: 2

Returns a boolean depending on whether or not a node has a passed class string.

=====
Usage
=====

Consider the following html:

.. code-block :: html
  :linenos:
 
    <div id="bam" class="foo bar baz"></div>
    <div class="something else"></div>

Using hasClass to find if the node id="bam" has class="foo":

.. code-block :: javascript
  :linenos:

  if(dojo.hasClass("bam", "foo")){ 
    /* it does */
  }  

Using dojo.query to find a node and check if it has a class:

.. code-block :: javascript
  :linenos:

  dojo.query(".something").forEach(function(node){ 
     if(dojo.hasClass(node, "else"){
        /* it does */
     }
  });

Note: You do not need to explicitly check for hasClass before adding or removing a class with dojo.addClass or dojo.removeClass, they do it for you.


========
See also
========

* `dojo.addClass <dojo/addClass>`_
* `dojo.removeClass <dojo/removeClass>`_
* `dojo.toggleClass <dojo/toggleClass>`_
