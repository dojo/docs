.. _dojo/dom-geometry/docScroll:

==============================
dojo/dom-geometry::docScroll()
==============================

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 2

Returns a normalized object with ``{x, y}`` with corresponding offsets for the scroll position for the current document.

Usage
=====

.. js ::

  require(["dojo/dom-geometry"], function(domGeom){
    var output = domGeom.docScroll();
  });

Attributes
==========

This function requires no arguments, and references the current document.

Examples
========

.. code-example::

  .. js ::

    require(["dojo/dom-geometry", "dojo/dom", "dojo/on", "dojo/json", "dojo/domReady!"],
    function(domGeom, dom, on, JSON){
      on(dom.byId("command"), "click", function(){
        var output = domGeom.docScroll();
        dom.byId("output").innerHTML = JSON.stringify(output);
      });
    });

  .. html ::

    <div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div>
    <button id="command" type="button">Execute docScroll()</button>
    <pre id="output"></pre>
    <div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div>
    <div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div>
    <div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div>

See also
========

* :ref:`dojo/dom-geometry <dojo/dom-geometry>`
