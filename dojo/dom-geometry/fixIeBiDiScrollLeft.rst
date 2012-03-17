.. _dojo/dom-geometry/fixIeBiDiScrollLeft:

========================================
dojo/dom-geometry::fixIeBiDiScrollLeft()
========================================

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 2

In RTL direction, scrollLeft should be a negative value, but IE returns a positive one. All codes using
``documentElement.scrollLeft`` must call this function to fix this error, otherwise the position will offset to right
when there is a horizontal scrollbar.

Usage
=====

When needing to reference the scrollLeft of a DOM node, pass this number into ``fixIeBiDiScrollLeft()`` and the number
will be adjusted if required.

.. js ::

  require(["dojo/dom-geometry", "dojo/dom"], function(domGeom){
    var node = dom.byId("someNode");
    var output = domGeom.fixIeBiDiScrollLeft(node.scrollLeft);
  });

Attributes
==========

========== ====== =======================================
Argument   Type   Description
========== ====== =======================================
scrollLeft Number The value of the scrollLeft of the node
========== ====== =======================================

See also
========

* :ref:`dojo/dom-geometry <dojo/dom-geometry>`
