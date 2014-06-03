.. _dojo/dom:

========
dojo/dom
========

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 3

This module defines the core Dojo DOM API.  The standard return variable for this module is ``dom``.

The *deprecated* legacy features are set in :ref:`dojo/_base/html <dojo/_base/html>`.

Features
========

.. _dojo/dom#byid:

byId()
------

This is a simple alias to ``document.getElementById``, which not only is shorter to write, but fortunately works in all
browsers. It turns a domNode reference to some Node byId, or the same node reference if passed a domNode.

Usage
~~~~~

The basic usage is very straight forward:

.. js ::

  require(["dojo/dom"], function(dom){
      // fetch a node by id="someNode"
      var node = dom.byId("someNode");
  });

The node variable is just a native domNode, with properties you can manipulate. The most common, ''innerHTML'':

.. js ::

  // set some node to say "Hello World"
  require(["dojo/dom"], function(dom){
      dom.byId("someNode").innerHTML = "Hello World";
  });

If you pass byId a domNode reference, the same node is returned:

.. js ::

  require(["dojo/dom"], function(dom){
      var node = dom.byId("someNode");
      var other = dom.byId(node);
      console.log(node == other);
  });

  // output
  >>> true

If you pass ``byId()`` a string, and no domNode is found to match, ``undefined`` or the null object is returned
(depending on the browser), which is adequate truthiness to use conditionally:

.. js ::

  require(["dojo/dom"], function(dom){
    var node = dom.byId("fooBar");
    if(node){
      node.innerHTML = "I was found!";
    }else{
      console.log("no node with id='fooBar' found!");
    }
  });

Most (if not all) functions in Dojo accept either a string or DomNode as a parameter. If passed a string, the function
typically calls ``byId()``, ensuring a domNode is always the object. For instance:

.. js ::

  require(["dojo/dom", "dojo/dom-style"], function(dom, domStyle){
    domStyle.set(dom.byId("foo"), "opacity", 0.5);
    // is identical to:
    domStyle.set("foo", "opacity", 0.5);
  });

The latter is preferred, as the call to ``byId()`` is made in both cases. The passing of a string ID is consistent
throughout the Dojo Toolkit.

JavaScript has a fun convention for conditionals inline. Imagine wanting a domNode reference, and if not present,
default to some other node:

.. js ::

  require(["dojo/dom"], functiom(dom)){
    var othernode = dom.byId("fallbackNode");
    var node = dom.byId("missingNode") || othernode;
    node.innerHTML = "Which one?";
  }

Above, if the node id="missingNode" is in fact missing, the logical OR will continue, and use ``othernode`` as the value of node.

Arguments
~~~~~~~~~

======== ====== =====================================
Argument Type   Description
======== ====== =====================================
id       String The id of the DOM node to be returned
======== ====== =====================================

Examples
~~~~~~~~

The following example lets a node by id disappear from the screen.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example uses some of the basic libraries of ``dojo/on`` and ``dojo/_base/fx`` in addition to ``dojo/dom``.
  
  .. js ::

    require(["dojo/dom", "dojo/on", "dojo/_base/fx", "dojo/domReady!"], 
    function(dom, on, baseFx){
      var node = dom.byId("findMe");
      on(dom.byId("buttonOne"), "click", function(){
        baseFx.fadeOut({ node: node, duration: 300 }).play();
      });
      on(dom.byId("buttonTwo"), "click", function(){
        baseFx.fadeIn({ node: node, duration: 300 }).play();
      })
    });

  Some basic HTML to facilitate the example.

  .. html ::

    <button id="buttonOne">Hide Me!</button> <button id="buttonTwo">Show Me!</button>
    <div id="findMe">Hiya!</div>

  And some CSS styling so we can see what we are doing...

  .. css ::

      #findMe {
        width: 200px;
        height: 100px;
        background: #f3f3f3;
        border: 1px dotted #ccc;
        color: #444;
        padding: 10px;
        margin: 10px;
      }

isDescendant()
--------------

Returns true if node is a descendant of ancestor.

Usage
~~~~~

.. js::

  require(["dojo/dom"], function(dom){
    dom.isDescendant("someNode", "someOtherNode");
  });

Arguments
~~~~~~~~~

======== ============== ==========================================
Argument Type           Description
======== ============== ==========================================
node     DomNode|String The node you want to check is a descendant
ancestor DomNode|String The node you think might be the ancestor
======== ============== ==========================================

Examples
~~~~~~~~

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  Code that checks if two nodes are descended from a third.

  .. js ::

    require(["dojo/dom", "dojo/domReady!"], function(dom){
      var output = "";
      if (dom.isDescendant("child", "ancestor")){
        output += "'child' is a descendant of 'ancestor'</br>";
      }else{
        output += "'child' is not a descendant of 'ancestor'</br>";
      }
      if (dom.isDescendant("loner", "ancestor")){
        output += "'loner' is a descendant of 'ancestor'</br>";
      }else{
        output += "'loner' is not a descendant of 'ancestor'</br>";
      }
      dom.byId("output").innerHTML = output;
    });

  Some basic HTML to facilitate the example.

  .. html ::

    <div id="ancestor">
      <div id="child">I'm a child!</div>
    </div>
    <div id="loner">I'm not a child!</div>
    <div id="output"></div>


setSelectable()
---------------

Enable or disable selection on a node

Usage
~~~~~

.. js::

  require(["dojo/dom"], function(dom){
    dom.setSelectable("someNode", true);
  });

Arguments
~~~~~~~~~

========== ============== =====================================
Argument   Type           Description
========== ============== =====================================
node       DomNode|String The node you want to set selection on
selectable Boolean        True if selectable or false if not
========== ============== =====================================

Examples
~~~~~~~~

An example of how to set a node to selectable or not.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  Code using ``dojo/on`` to set the click handlers of two buttons to allow the ability to turn selectable on and off.

  .. js ::

    require(["dojo/dom", "dojo/on", "dojo/domReady!"], function(dom, on){
      on(dom.byId("button1"), "click", function(){
        dom.setSelectable("model", true);
      });
      on(dom.byId("button2"), "click", function(){
        dom.setSelectable("model", false);
      });
    });

  Some basic HTML to facilitate the example.

  .. html ::

    <div id="model">Am I selectable?</div>
    <button id="button1">setSelectable True</button>
    <button id="button2">setSelectable False</button>

See also
========

* :ref:`dojo/dom-attr <dojo/dom-attr>` - DOM attribute API

* :ref:`dojo/dom-class <dojo/dom-class>` - Dojo DOM Class API

* :ref:`dojo/dom-prop <dojo/dom-prop>` - DOM Property API

* :ref:`dojo/dom-style <dojo/dom-style>` - DOM Style API

* :ref:`dojo/_base/html <dojo/_base/html>` - Legacy API aliases
