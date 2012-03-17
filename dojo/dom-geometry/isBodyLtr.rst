.. _dojo/dom-geometry/isBodyLtr:

==============================
dojo/dom-geometry::isBodyLtr()
==============================

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 2

Returns true if the current language is left-to-right, and false otherwise.

Usage
=====

.. js ::

  require(["dojo/dom-geometry"], function(domGeom){
    var output = domGeom.isBodyLtr();
  });

Attributes
==========

This function requires no arguments, and references the current document.

Examples
========

.. code-example::

  .. js ::

    require(["dojo/dom-geometry", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(domGeom, dom, on){
      on(dom.byId("command"), "click", function(){
        var output = domGeom.isBodyLtr();
        dom.byId("output").innerHTML = output;
      });
    });

  .. html ::

    <button id="command" type="button">Execute isBodyLtr()</button>
    <pre id="output"></pre>

See also
========

* :ref:`dojo/dom-geometry <dojo/dom-geometry>`
