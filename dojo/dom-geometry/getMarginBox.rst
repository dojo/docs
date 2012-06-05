.. _dojo/dom-geometry/getMarginBox:

=================================
dojo/dom-geometry::getMarginBox()
=================================

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 2

Returns an object that encodes the width, height, left and top positions of the node's margin box.

Usage
=====

.. js ::

  require(["dojo/dom-geometry", "dojo/dom", "dojo/dom-style"], function(domGeom, dom, style){
    var node = dom.byId("someNode");
    var computedStyle = style.getComputedStyle(node);
    var output = domGeom.getMarginBox(node, computedStyle);
  });

Attributes
==========

============= ============== ===========================================================================================
Arguments     Type           Description
============= ============== ===========================================================================================
node          String|DOMNode The node to return the information for
computedStyle Object?        This parameter accepts computed styles object. If this parameter is omitted, the function
                             will call ``dojo/dom-style::getComputedStyle()`` to get one. It is a better calling
                             ``dojo/dom-style::getComputedStyle()`` once, and then passing the reference as an argument,
                             wherever possible.
============= ============== ===========================================================================================

Examples
========

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-geometry", "dojo/dom", "dojo/dom-style", "dojo/on", "dojo/json", "dojo/domReady!"],
    function(domGeom, dom, style, on, JSON){
      on(dom.byId("command"), "click", function(){
        var node = dom.byId("example");
        var computedStyle = style.getComputedStyle(node);
        var output = domGeom.getMarginBox(node, computedStyle);
        dom.byId("output").innerHTML = JSON.stringify(output);
      });
    });

  .. html ::

    <button id="command" type="button">getMarginBox()</button>
    <div class="example" id="example">Some example node</div>
    <p><strong>Output:</strong></p>
    <pre id="output"></pre>

  .. css ::

    .example{
      margin: 1em;
      text-align: center;
      padding: 1em;
      border: 2px solid black;
      color: white;
      background-color: blue;
      width: 200px;
      height: 100px;
    }

See also
========

* :ref:`dojo/dom-geometry <dojo/dom-geometry>`

* :ref:`dojo/dom-style <dojo/dom-style>`
