.. _dojo/dom-geometry/getPadExtents:

==================================
dojo/dom-geometry::getPadExtents()
==================================

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 2

Returns object with special values specifically useful for node fitting.

* ``l``/``t``/``r``/``b`` = the sum of left/top/right/bottom padding (respectively)
* ``w`` = the sum of the left and right padding
* ``h`` = the sum of the top and bottom padding

If ``node`` has position, ``l``/``t`` forms the origin for child nodes. The ``w`` and ``h`` are used for calculating
boxes.

Normally application code will not need to invoke this directly, and will use the ``...box...`` functions instead.

Usage
=====

.. js ::

  require(["dojo/dom-geometry", "dojo/dom", "dojo/dom-style"], function(domGeom, dom, style){
    var node = dom.byId("someNode");
    var computedStyle = style.getComputedStyle(node);
    var output = domGeom.getPadExtents(node, computedStyle);
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
        var output = domGeom.getPadExtents(node, computedStyle);
        dom.byId("output").innerHTML = JSON.stringify(output);
      });
    });

  .. html ::

    <button id="command" type="button">getPadExtents()</button>
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
