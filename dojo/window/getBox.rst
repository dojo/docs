.. _dojo/window/getBox:

=====================
dojo/window::getBox()
=====================

:since: v1.5

.. contents ::
  :depth: 2

**getBox()** returns an object which represents the size of the viewport.

The viewport is the part of the document that is visible on the screen. In contrast to this, the part of the document that is scrolled out of view is not part of the viewport. In order to get the size of the viewport, you can use ``getBox()``.

Usage
=====

.. js ::

 require(["dojo/window"], function(win){
    var vs = win.getBox();
    // vs is an object that is the size of the viewport
 });


Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example "grays out" the screen.

  .. js ::

    require(["dojo/window", "dojo/dom-construct", "dojo/_base/window", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(win, domConst, baseWin, dom, on){
      on(dom.byId("gray"), "click", function(){
        var vs = win.getBox(),
            div = domConst.create("div", {
              style: {
                position: "absolute",
                top: "0px",
                left: "0px",
                width: vs.w + "px",
                height: vs.h + "px",
                backgroundColor: "gray",
                opacity: 0.1
              }
            }, baseWin.body());

        setTimeout(function(){
          domConst.destroy(div);
        }, 1000);
      });
    });

  .. html ::

    <button type="button" id="gray">Gray the Screen</button>

See Also
========

* :ref:`dojo/window <dojo/window>`

* :ref:`dojo/_base/window <dojo/_base/window>` - The base window features
