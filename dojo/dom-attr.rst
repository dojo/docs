.. _dojo/dom-attr:

=============
dojo/dom-attr
=============

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 3

This module defines the core Dojo DOM attributes API. The standard return variable for this module is
``domAttr``.

The *deprecated* legacy features are set in :ref:`dojo/_base/html <dojo/_base/html>`.

Features
========

.. _dojo/dom-attr#has:

has()
-----

A function that checks if an attribute is present on a DOM node, and returns the truthy value if it is there, and falsy
value otherwise.

Usage
~~~~~

.. js ::
 
  // Dojo 1.7+ (AMD)
  require(["dojo/dom-attr"], function(domAttr){
    result = domAttr.has("myNode", "someAttr");
  });

Arguments
~~~~~~~~~

======== ====================================================
Argument Description
======== ====================================================
node     id or reference of the DOM node to get/set style for
attr     the attribute property name
result   truthy, if the attribute is present, falsy otherwise
======== ====================================================

Examples
~~~~~~~~

Checking to see if a particular node has an attribute.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-attr", "dojo/dom", "dojo/domReady!"], function(domAttr, dom){
      var output = "";
      if (domAttr.has("model", "name")){
        output += "Node model has attribute name <br/>";
        }else{
        output += "Node model does not have attribute name <br/>";
      }
      if (domAttr.has("model", "baz")){
        output += "Node 'model' has attribute baz <br/>";
      }else{
        output += "Node 'model' does not have attribute baz <br/>";
      }
      if (domAttr.has("model", "foo")){
        output += "Node 'model' has attribute foo <br/>";
      }else{
        output += "Node 'model' does not have attribute foo <br/>";
      }
      dom.byId("output").innerHTML = output;
    });

  .. html ::

    <input id="model" name="model" type="text" baz="foo" /> &mdash; our model node
    <div id="output"></div>

.. _dojo/dom-attr#get:

get()
-----

A function that handles normalized getting of attributes on DOM Nodes and return the value of the requested attribute or
null if that attribute does not have a specified or default value.

Usage
~~~~~

.. js ::
 
  // Dojo 1.7+ (AMD)
  require(["dojo/dom-attr"], function(domAttr){
    result = domAttr.get("myNode", "someAttr");
  });

Arguments
~~~~~~~~~

======== =======================================================
Argument Description
======== =======================================================
node     id or reference to the element to get the attribute on
attr     the name of the attribute to get
======== =======================================================

Examples
~~~~~~~~

Getting some values from a node.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  Here is the JavaScript code that will read the values of the attributes and output the results.

  .. js ::

    require(["dojo/dom-attr", "dojo/dom", "dojo/domReady!"], function(domAttr, dom){
      var output = "";
      output += "Node 'model' attribute 'name': "+ domAttr.get("model", "name") + "<br/>";
      output += "Node 'model' attribute 'baz': "+ domAttr.get("model", "baz") + "<br/>";
      output += "Node 'model' attribute 'foo': "+ domAttr.get("model", "foo") + "<br/>";
      dom.byId("output").innerHTML = output;
    });

  Here is our generic HTML snippet.

  .. html ::

    <input id="model" name="model" type="text" baz="foo" /> &mdash; our model node
    <div id="output"></div>

.. _dojo/dom-attr#set:

.. _dojo/dom-attr#set-function:

set()
-----

A function that handles normalized setting of attributes on DOM Nodes. When passing functions as values, note that they
will not be directly assigned to slots on the node, but rather the default behavior will be removed and the new behavior
will be added using ``dojo.connect()``, meaning that event handler properties will be normalized and that some caveats
with regards to non-standard behaviors for ``onsubmit`` apply. Namely that you should cancel form submission using
`evt.preventDefault()` on the passed event object instead of returning a boolean value
from the handler itself. It returns the DOM node.

Usage
~~~~~

.. js ::
 
  // Dojo 1.7+ (AMD)
  require(["dojo/dom-attr"], function(domAttr){
    result = domAttr.set("myNode", "someAttr", "value");
  });

Arguments
~~~~~~~~~

======== =====================================================================
Argument Description
======== =====================================================================
node     id or reference to the element to set the attribute on
attr     the name of the attribute to set, or a hash of key-value pairs to set
value    the value to set for the attribute, if the name is a string
======== =====================================================================

Examples
~~~~~~~~

Here is an example of changing a value of an attribute:

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-attr", "dojo/dom", "dojo/domReady!"], function(domAttr, dom){
      var output = "";
      output += "Node 'model' attribute 'baz' is: " + domAttr.get("model", "baz") + "<br/>";
      domAttr.set("model", "baz", "bar");
      output += "Node 'model' attribute 'baz' now is: " + domAttr.get("model", "baz") + "<br/>";
      dom.byId("output").innerHTML = output;
    });

  .. html ::

    <input id="model" name="model" type="text" baz="foo" /> &mdash; our model node
    <div id="output"></div>

Here is an example of using an object to set multiple attribute values:

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-attr", "dojo/dom", "dojo/domReady!"], function(domAttr, dom){
      var output = "";
      output += "Node 'model' attribute 'baz' is: " + domAttr.get("model", "baz") + "<br/>";
      output += "Node 'model' attribute 'value' is: " + domAttr.get("model", "value") + "<br/>";
      domAttr.set("model", { baz: "bar", value: "Hello World!" });
      output += "Node 'model' attribute 'baz' now is: " + domAttr.get("model", "baz") + "<br/>";
      output += "Node 'model' attribute 'value' now is: " + domAttr.get("model", "value") + "<br/>";
      dom.byId("output").innerHTML = output;
    });

  .. html ::

    <input id="model" name="model" type="text" baz="foo" /> &mdash; our model node
    <div id="output"></div>

.. _dojo/dom-attr#remove:

remove()
--------

Is a function that removes an attribute from a DOM node. It is modeled after DOM's `removeAttribute
<https://developer.mozilla.org/En/DOM/Element.removeAttribute>`_, but unlike the latter it normalizes standard attribute
names to smooth over differences between browsers, or to provide convenient aliases, (e.g., ``className`` is aliased to
``class``).

Usage
~~~~~

.. js ::
 
  // Dojo 1.7+ (AMD)
  require(["dojo/dom-attr"], function(domAttr){
    result = domAttr.remove("myNode", "someAttr");
  });

Arguments
~~~~~~~~~

======== =========================================================
Argument Description
======== =========================================================
node     id or reference to the element to remove the attribute on
attr     the attribute name
======== =========================================================

Examples
~~~~~~~~

Here is an example of removing the ``disabled`` attribute from a DOM node:

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-attr", "dojo/domReady!"], function(domAttr){
      removeDisabled = function(){
        domAttr.remove("model", "disabled");
      }
    });

  .. html ::

    <input id="model" name="model" disabled="disabled" type="text" baz="foo" /> &mdash; our model node <br/>
    <button onclick="removeDisabled();">Remove Disabled</button>

.. _dojo/dom-attr#getNodeProp:

getNodeProp()
-------------

Is a companion function for :ref:`domAttr.get <dojo/dom-attr#get>`. Unlike the latter it favors properties
falling back on attributes, if a property was not present.

It is useful when you don't care if somebody set an attribute on a node in HTML, or not, but you want to read a
default/current value, which is used by a browser. For example, if user didn't specify ``type`` attribute on ``input``
element, it is default value is ``"text"``. You don't need to know all defaults, or how browser interprets missing
attributes exactly, just use ``domAttr.getNodeProp``.

There is no corresponding ``setNodeProp``. If you want to set a property value, use straight assignment.

Usage
~~~~~

.. js ::
 
  // Dojo 1.7+ (AMD)
  require(["dojo/dom-attr"], function(domAttr){
    result = domAttr.getNodeProp("myNode", "someProperty");
  });

Arguments
~~~~~~~~~

======== =====================================================
Argument Description
======== =====================================================
node     id or reference to the element to get the property on
attr     the attribute property name
======== =====================================================

Examples
~~~~~~~~

The following example reads effective values from the ``input`` node.

.. code-example ::

  .. js ::

    require(["dojo/dom-attr", "dojo/dom"], function(domAttr, dom){
    
      function showAttribute(name){
        var result = domAttr.getNodeProp("model", name);
        var output = dom.byId("output").innerHTML;
        output += name + " is '" + result + "' <br/>";
        dom.byId("output").innerHTML = output;
      }
    
      checkAttributes = function(){
        showAttribute("id");
        showAttribute("type");
        showAttribute("name");
        showAttribute("value");
        showAttribute("innerHTML");
        showAttribute("foo");
        showAttribute("baz");
      }
    
    });

  .. html ::

    <p><input id="model" name="model" baz="foo"> &mdash; our model node</p>
    <p><button onclick="checkAttributes();">Check attributes</button></p>
    <p id="output"></p>


See also
========

* :ref:`dojo/dom <dojo/dom>` - Core DOM API

* :ref:`dojo/dom-class <dojo/dom-class>` - Dojo DOM Class API

* :ref:`dojo/dom-prop <dojo/dom-prop>` - DOM Property API

* :ref:`dojo/dom-style <dojo/dom-style>` - DOM Style API

* :ref:`dojo/_base/html <dojo/_base/html>` - Legacy API aliases
