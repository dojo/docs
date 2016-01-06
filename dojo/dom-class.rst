.. _dojo/dom-class:

==============
dojo/dom-class
==============

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 3

This module defines the core dojo DOM class API.  The standard return variable for this module is ``domClass``.

The *deprecated* legacy features are set in :ref:`dojo/_base/html <dojo/_base/html>`.

Features
========

.. _dojo/dom-class#contains:

contains()
----------

Returns a boolean depending on whether or not a node has a passed class string.

Usage
~~~~~

.. js ::

  require(["dojo/dom-class"], function(domClass){
      // Do something if a node with id="someNode" has class="aSillyClassName" present
      if (domClass.contains("someNode", "aSillyClassName")){
        /* It does */
      }
  });

Attributes
~~~~~~~~~~

======== ============= ========================================
Argument Type          Description
======== ============= ========================================
node     Object|String A DOM node or its node id (as a string).
class    String        A CSS class name as a string.
======== ============= ========================================

Examples
~~~~~~~~

A basic example of checking a node to see if it contains a CSS class.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example uses ``dojo/dom`` as well.
  
  .. js ::

    require(["dojo/dom-class", "dojo/dom", "dojo/domReady!"], 
    function(domClass, dom){
      var output = "";
      if (domClass.contains("model", "modelClass1")){
        output += "'model' has class 'modelClass1'<br/>";
      }else{
        output += "'model' doesn't have class 'modelClass1'<br/>";
      }
      if (domClass.contains("model", "modelClass2")){
        output += "'model' has class 'modelClass2'<br/>";
      }else{
        output += "'model' doesn't have class 'modelClass2'<br/>";
      }
      dom.byId("output").innerHTML = output;
    });

  Some basic HTML to facilitate the example.

  .. html ::

    <div id="model" class="modelClass1">Hello World!</div>
    <div id="output"></div>

  And while the CSS isn't required, it does demonstrate the class is applied to the node.

  .. css ::

    .modelClass1 {
      font-weight: bold;
    }

.. _dojo/dom-class#add:

add()
-----

Safely adds a CSS class or a set of classes to a node avoiding duplications.

Usage
~~~~~

.. js ::

  require(["dojo/dom-class"], function(domClass){
      // Add a class to some node:
      domClass.add("someNode", "newClass");
  });

Attributes
~~~~~~~~~~

======== ============== ================================================================================
Argument Type           Description
======== ============== ================================================================================
node     DomNode|String A DOM node or its node id (as a string).
class    String|Array   A string, which can list classes separated by spaces, or an array of CSS classes 
                        as strings. In the latter case array elements cannot contain spaces.
======== ============== ================================================================================

Examples
~~~~~~~~

Here is an example of how to add a class to a node:

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  Here is the CSS class that will be applied to the node.

  .. css ::
    
      .style1 { background-color: #7c7c7c; color: #ffbf00; border: 1px solid #ffbf00; padding: 20px;}

  This code will add the class to the target node when the button is clicked.

  .. js ::

      require(["dojo/dom-class", "dojo/dom", "dojo/on", "dojo/domReady!"],
      function(domClass, dom, on){
        on(dom.byId("button1"), "click", function(){
          domClass.add("example1", "style1");
        });
      });

  Here is our basic HTML structure.
  
  .. html ::

    <div id="example1">This node will be changed.</div>
    <button id="button1" type="button">Add class</button>

.. _dojo/dom-class#remove:

remove()
--------

Removes a class or a list of classes from a DOM node.

Usage
~~~~~

.. js ::

  require(["dojo/dom-class"], function(domClass){
      // Remove a class from some node:
      domClass.remove("someNode", "someClass");
  });

Attributes
~~~~~~~~~~

======== ============== ================================================================================
Argument Type           Description
======== ============== ================================================================================
node     DomNode|String A DOM node or its node id (as a string).
class    String|Array   A string, which can list classes separated by spaces, or an array of CSS classes 
                        as strings. In the latter case array elements cannot contain spaces.
======== ============== ================================================================================

If the second argument is not specified or ``undefined``, all classes will be removed.

Examples
~~~~~~~~

Remove a class
''''''''''''''

The following example removes the class "style1" from the node "example1":

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. css ::

      .style1 { background-color: #7c7c7c; color: #ffbf00; border: 1px solid #ffbf00; padding: 20px;}

  .. js ::

      require(["dojo/dom-class", "dojo/dom", "dojo/on", "dojo/domReady!"], 
      function(domClass, dom, on){
        on(dom.byId("button1"), "click", function(){
          domClass.remove("example1", "style1");
        });
      });

  .. html ::

    <div id="example1" class="style1">This node will be changed.</div>
    <button id="button1" type="button">Remove class</button>


Remove several classes as a string
''''''''''''''''''''''''''''''''''

The following example removes two classes: "style1" and "style2" from the node "example1":

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. css ::

    .style1 { background-color: #7c7c7c; color: #ffbf00;}
    .style2 { border: 1px solid #ffbf00; padding: 20px;}

  .. js ::

    require(["dojo/dom-class", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(domClass, dom, on){
      on(dom.byId("button1"), "click", function(){
        domClass.remove("example1", "style1 style2");
      });
    });

  .. html ::

    <div id="example1" class="style2 style1">This node will be changed.</div>
    <button id="button1" type="button">Remove classes</button>


Remove several classes as an array
''''''''''''''''''''''''''''''''''

The following example removes two classes: "style1" and "style2" from the node "example1":

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. css ::

    .style1 { background-color: #7c7c7c; color: #ffbf00;}
    .style2 { border: 1px solid #ffbf00; padding: 20px;}

  .. js ::

    require(["dojo/dom-class", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(domClass, dom, on){
      on(dom.byId("button1"), "click", function(){
        domClass.remove("example1", ["style1", "style2"]);
      });
    });

  .. html ::

    <div id="example1" class="style2 style1">This node will be changed.</div>
    <button id="button1" type="button">Remove classes</button>

Remove all classes
''''''''''''''''''

The following example removes all classes from the node "example1":

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. css ::

    .style1 { background-color: #7c7c7c; color: #ffbf00;}
    .style2 { border: 1px solid #ffbf00; padding: 20px;}

  .. js ::

    require(["dojo/dom-class", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(domClass, dom, on){
      on(dom.byId("button1"), "click", function(){
        domClass.remove("example1");
      });
    });

  .. html ::

    <div id="example1" class="style2 style1">This node will be changed.</div>
    <button id="button1" type="button">Remove classes</button>


Remove from multiple nodes
''''''''''''''''''''''''''

This feature is exposed as ``removeClass`` for :ref:`NodeLists <dojo/NodeList>`, so that it's also possible to remove classes for multiple nodes. The following example removes the class for each node in the NodeList returned from a ``query()``:

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. css ::

    .style3 { background-color: #7c7c7c; color: #ffbf00; padding: 10px }
    .additionalStyle3 { background-color: #491f00; color: #36d900 }

  .. js ::

    require(["dojo/query", "dojo/NodeList-dom", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(query, NodeListDom, dom, on){
      on(dom.byId("button3"), "click", function(){
        query("#example3 div").removeClass("style3");
      });
    });

  .. html ::

    <div id="example3" class="additionalStyle3">
        <div class="style3">This node will be changed.</div>
        <div class="style3">This node also.</div>
        <div class="style3">And this is the last one.</div>
    </div>
    <button id="button3" type="button">Remove from multiple nodes</button>

.. _dojo/dom-class#replace:

replace()
---------

Replaces one or more classes on a node if not present. Operates more quickly than calling ``domClass.remove()`` and then
``domClass.add()``.

Usage
~~~~~

.. js ::

  require(["dojo/dom-class"], function(domClass){
      domClass.replace("someNode", "add1", "remove1");
  });

Attributes
~~~~~~~~~~

=========== ============== ================================================================================
Argument    Type           Description
=========== ============== ================================================================================
node        DomNode|String A DOM node or its node id (as a string).
addClass    String|Array   A string, which can list classes separated by spaces, or an array of CSS classes 
                           as strings. In the latter case array elements cannot contain spaces.
removeClass String|Array   A string, which can list classes separated by spaces, or an array of CSS classes 
                           as strings. In the latter case array elements cannot contain spaces.
=========== ============== ================================================================================

Examples
~~~~~~~~

The following example removes the class "oldStyle" from the node "example" and replaces it with "newStyle":

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. css ::

    .oldStyle { background-color: #7c7c7c; color: #ffbf00; border: 1px solid #ffbf00; padding: 20px; }
    .newStyle { background-color: #491f00; color: #36d900; border: 1px solid #black; padding: 10px; }

  .. js ::

    require(["dojo/dom-class", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(domClass, dom, on){
      on(dom.byId("button1"), "click", function(){
        domClass.replace("example", "newStyle", "oldStyle");
      });
    });

  .. html ::

    <div id="example" class="oldStyle">This node will be changed.</div>
    <button id="button1" type="button">Replace class</button>

.. _dojo/dom-class#toggle:

toggle()
--------

Adds a class to node if not present, or removes if present.

Usage
~~~~~

.. js ::

  require(["dojo/dom-class"], function(domClass){
      domClass.toggle("someNode", "someClass");
  });

Attributes
~~~~~~~~~~

========= ============== ================================================================================
Argument  Type           Description
========= ============== ================================================================================
node      DomNode|String A DOM node or its node id (as a string).
class     String|Array   A string, which can list classes separated by spaces, or an array of CSS classes 
                         as strings. In the latter case array elements cannot contain spaces.
condition Boolean        Optional. If ``true`` we add classes, otherwise we remove classes. If not specified, 
                         the class will be removed if it is already present on the node, and added otherwise.
========= ============== ================================================================================

Examples
~~~~~~~~

Simple toggle
'''''''''''''

The following example adds the class "style1" to the node "example1", if there is no such class for this node or removes
it, if there is already such a class:

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. css ::

    .style1 { background-color: #7c7c7c; color: #ffbf00; border: 1px solid #ffbf00; padding: 20px;}

  .. js ::

    require(["dojo/dom-class", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(domClass, dom, on){
      on(dom.byId("button1"), "click", function(){
        domClass.toggle("example1", "style1");
      });
    });

  .. html ::

    <div id="example1">This node will be changed.</div>
    <button id="button1" type="button">Toggle class</button>


Forcefully add a class
''''''''''''''''''''''

The following example adds the class "style2" to the node "example2", no matter if there is already such a class for
this node or not:

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. css ::

    .style2 { background-color: #7c7c7c; color: #ffbf00; border: 1px solid #ffbf00; padding: 20px;}
    .additionalStyle { border: 5px solid #ffbf00; padding: 20px;}

  .. js ::

    require(["dojo/dom-class", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(domClass, dom, on){
      on(dom.byId("button2"), "click", function(){
        domClass.toggle("example2", "style2", true);
      });
    });

  .. html ::

    <div id="example2" class="additionalStyle">This node will be changed.</div>
    <button id="button2" type="button">Add a class forcefully</button>

Toggle multiple nodes
'''''''''''''''''''''

This feature is exposed as ``toggleClass()`` for :ref:`NodeLists <dojo/NodeList>`, so that it's also possible to toggle
the class for multiple nodes. The following example toggles the class for each node in the NodeList returned from
``query()``:

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. css ::

    .style3 { background-color: #7c7c7c; color: #ffbf00; padding: 10px }
    .additionalStyle3 { background-color: #491f00; color: #36d900 }

  .. js ::

    require(["dojo/query", "dojo/NodeList-dom", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(query, NodeListDom, dom, on){
      on(dom.byId("button3"), "click", function(){
        query("#example3 div").toggleClass("style3");
      });
    });

  .. html ::

    <div id="example3" class="additionalStyle3">
        <div>This node will be changed.</div>
        <div>This node also.</div>
        <div>And this is the last one.</div>
    </div>
    <button id="button3" type="button">Toggle multiple nodes</button>

Technical Information
~~~~~~~~~~~~~~~~~~~~~

This function is a simple convenience wrapper for :ref:`contains() <dojo/dom-class#contains>`,
:ref:`add() <dojo/dom-class#add>` and :ref:`remove() <dojo/dom-class#remove>`. A simplified version
would look something like this:

.. js ::
  
  require(["dojo/dom-class"], function(domClass){
    function toggle(node, classStr, condition){
      if(condition === undefined){
        condition = !domClass.contains(node, classStr);
      }
      domClass[condition ? "add" : "remove"](node, classStr);
    }
  });

See also
========

* :ref:`dojo/dom <dojo/dom>` - Core DOM API

* :ref:`dojo/dom-attr <dojo/dom-attr>` - Dojo DOM Attribute API

* :ref:`dojo/dom-prop <dojo/dom-prop>` - DOM Property API

* :ref:`dojo/dom-style <dojo/dom-style>` - DOM Style API

* :ref:`dojo/_base/html <dojo/_base/html>` - Legacy API aliases
