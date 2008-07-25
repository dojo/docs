#format dojo_rst

dojo.addOnLoad
==============

:Status: Contributed, Draft
:Version: 1.0

This is a simple alias to ''document.getElementById'', which not only is shorted to write, but fortunately works in all browsers. It turns a domNode reference to some Node byId, or the same node reference if passed a domNode. 

(need help with code blocks)

// fetch a node by id="someNode"
var node = dojo.byId("someNode");

The node variable is just a native domNode, with properties you can manipulate. The most common, ''innerHTML'':

// set some node to say "Hello World"
dojo.byId("someNode").innerHTML = "Hello World";

If you pass byId a domNode reference, the same node is returned:

.. code-block :: javascript
  :linenos:

  var node = dojo.byId("someNode");
  var other = dojo.byId(node);
  console.log(node == other);
  >>> true

If you pass dojo.byId a string, and no domNode is found to match, ''undefined'' is returned, which is adequate truthiness to use conditionally:

.. code-block :: javascript

  var node = dojo.byId("fooBar");
  if(node){
    node.innerHTML = "I was found!";
  }else{
    console.log("no node with id='fooBar' found!");
  }

JavaScript has a fun convention for conditionals inline. Imagine wanting a domNode reference, and if not present, default to some other node:

.. code-block :: javascript

  var othernode = dojo.byId("fallbackNode");
  var node = dojo.byId("missingNode") || othernode;
  node.innerHTML = "Which one?";

Above, if the node id="missingNode" is in fact missing, the logical OR will continue, and use othernode as the value of node.
