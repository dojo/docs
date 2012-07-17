.. _dojo/window/scrollIntoView:

=============================
dojo/window::scrollIntoView()
=============================

:since: v1.5

.. contents ::
   :depth: 2

Scrolls a node into view, similar to ``node.scrollIntoView()`` but working around browser quirks.

Usage
=====

.. js ::

  require(["dojo/window"], function(win){
    win.scrollIntoView(node);
  });

``scrollIntoView()`` takes a DOMNode as the first parameter and takes a position object as a second optional parameter.
Calculating the box geometry of a DOMNode can be quite expensive, and so if the value has already been calculated, it 
should be passed, otherwise ``scrollIntoView()`` will call 
:ref:`dojo/dom-geometry::position <dojo/dom-geometry/position>` itself.

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  Two buttons that scroll the other one into view.

  .. js ::

    require(["dojo/window", "dojo/on", "dojo/dom", "dojo/dom-geometry", "dojo/domReady!"], 
    function(win, on, dom, domGeom){
      on(dom.byId("button1"), "click", function(){
        win.scrollIntoView("button2");
      });

      on(dom.byId("button2"), "click", function(){
        win.scrollIntoView("button1");
      });
    });

  .. html ::

    <button type="button" id="button1">Scroll to Button 2</button>
    <div style="height: 500px; border: 1px solid black">div to separate buttons</div>
    <button type="button" id="button2">Scroll to Button 1</button>

See Also
========

* :ref:`dojo/window <dojo/window>`

* :ref:`dojo/_base/window <dojo/_base/window>` - The base window features
