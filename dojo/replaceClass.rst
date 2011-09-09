#format dojo_rst

dojo.replaceClass
=================

.. contents::
   :depth: 2

Removes a class or a list of classes from a DOM node.

============
Introduction
============

Replaces one or more classes on a node if not present. Operates more quickly than calling dojo.removeClass and dojo.addClass 

=====
Usage
=====

The function takes up to three arguments:

1. A DOM node or its node id (as a string).
2. A String class name to add, or several space-separated class names, or an array of class names. 
3. A String class name to remove, or several space-separated class names, or an array of class names. 

Dojo 1.7 (AMD)
--------------
In dojo 1.7, dojo.replaceClass has been kept in dojo/_base/html as a compatibility of dojo version before, it is a alias of cls.replace in dojo/dom-class.

.. code-block :: javascript

  require(["dojo/_base/html"], function(dojo){   
      dojo.replaceClass("someNode", "add1 add2", "remove1 remove2"); 
  });

It's recommended to use cls.replace in dojo 1.7.

.. code-block :: javascript

  require(["dojo/dom-class"], function(cls){   
      cls.replace("someNode", "add1 add2", "remove1 remove2"); 
  });

Dojo < 1.7
----------

.. code-block :: javascript

    dojo.replaceClass("someNode", "add1 add2", "remove1 remove2");  

========
Examples
========

Replace all classes
-------------------

The following example replace all classes with addMe :

.. code-block :: javascript

  //dojo 1.7 (AMD)
  require(["dojo/dom-class"], function(cls){
      cls.replace("someNode", "addMe"); 
  });

  // dojo < 1.7
  dojo.replaceClass("someNode", "addMe"); 

Available in `dojo.NodeList()` for multiple toggles
---------------------------------------------------

.. code-block :: javascript

  //dojo 1.7 (AMD)
  require(["dojo/dom-class", "dojo/query"], function(cls, query){
      query(".findMe").replaceClass("addMe", "removeMe"); 
  });

  // dojo < 1.7
  dojo.query(".findMe").replaceClass("addMe", "removeMe"); 

========
See also
========

* `dojo.addClass <dojo/addClass>`_
* `dojo.removeClass <dojo/removeClass>`_
* `dojo.hasClass <dojo/hasClass>`_
* `dojo.toggleClass <dojo/toggleClass>`_
