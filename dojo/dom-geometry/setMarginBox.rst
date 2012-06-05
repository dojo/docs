.. _dojo/dom-geometry/setMarginBox:

=================================
dojo/dom-geometry::setMarginBox()
=================================

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 2

Sets the size of the node's margin box and placement (left/top), irrespective of box model. Think of it as a passthrough
to setBox that handles box-model vagaries for you.

Usage
=====

.. js ::

  require(["dojo/dom-geometry", "dojo/dom", "dojo/dom-style"], function(domGeom, dom, style){
    var node = dom.byId("someNode");
    var box = { l: 20, t: 20, w: 200, h: 200 };
    var computedStyle = style.getComputedStyle(node);
    domGeom.setMarginBox(node, box, computedStyle);
  });

Attributes
==========

============= ============== ===========================================================================================
Arguments     Type           Description
============= ============== ===========================================================================================
node          String|DOMNode The node to return the information for
box           Object         A hash with optional ``l``, ``t``, ``w``, and ``h`` properties for "left", "right",
                             "width", and "height" respectively. All specified properties should have numeric values in
                             whole pixels.
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

    require(["dojo/dom-geometry", "dojo/dom", "dojo/dom-style", "dojo/on", "dojo/domReady!"],
    function(domGeom, dom, style, on, JSON){
      on(dom.byId("command"), "click", function(){
        var node = dom.byId("example");
        var box = { l: 40, t: 40, w: 200, h: 200 };
        var computedStyle = style.getComputedStyle(node);
        domGeom.setMarginBox(node, box, computedStyle);
      });
    });

  .. html ::

    <button id="command" type="button">setMarginBox()</button>
    <div class="example" id="example">Some example node</div>

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
