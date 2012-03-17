.. _dojo/dom-geometry/setContentSize:

===================================
dojo/dom-geometry::setContentSize()
===================================

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 2

Sets the size of the node's contents, irrespective of margins, padding, or borders.

Usage
=====

.. js ::

  require(["dojo/dom-geometry", "dojo/dom", "dojo/dom-style"], function(domGeom, dom, style){
    var node = dom.byId("someNode");
    var box = { w: 300, h: 400 };
    var computedStyle = style.getComputedStyle(node);
    domGeom.setContentSize(node, box, computedStyle);
  });

Attributes
==========

============= ============== ===========================================================================================
Arguments     Type           Description
============= ============== ===========================================================================================
node          String|DOMNode The node to return the information for
box           Object         An object that contains the box size where ``w`` is the width and ``h`` is the height as 
                             whole number pixels.
computedStyle Object?        This parameter accepts computed styles object. If this parameter is omitted, the function
                             will call ``dojo/dom-style::getComputedStyle()`` to get one. It is a better calling
                             ``dojo/dom-style::getComputedStyle()`` once, and then passing the reference as an argument,
                             wherever possible.
============= ============== ===========================================================================================

Examples
========

.. code-example::

  This example changes the size of the example node to 300px wide by 300px tall.

  .. js ::

    require(["dojo/dom-geometry", "dojo/dom", "dojo/dom-style", "dojo/on", "dojo/domReady!"],
    function(domGeom, dom, style, on, JSON){
      on(dom.byId("command"), "click", function(){
        var node = dom.byId("example");
        var box = { w: 300, h: 300 };
        var computedStyle = style.getComputedStyle(node);
        domGeom.setContentSize(node, box, computedStyle);
      });
    });

  .. html ::

    <button id="command" type="button">setContentSize()</button>
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
