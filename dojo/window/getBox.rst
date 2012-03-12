.. _dojo/window/getBox:

==================
dojo.window.getBox
==================

:since: V1.5

.. contents ::
   :depth: 2

Gets the size of the viewport.


Introduction
============

The viewport is the part of the document that's visible on the screen. In contrast to this, the part of the document that's scrolled out of view is not part of the viewport. In order to get the size of the viewport, you can use dojo.window.getBox().

Usage
=====

.. js ::

 // Load the window-related functions:
 require(["dojo/window"], function(win){
      // Get the viewport-size of the document:
      var vs = win.getBox();
      console.log('viewport size:', ' width: ', vs.w, ', height: ', vs.h, ', left: ', vs.l, ', top: ', vs.t);
 );


Examples
========

Gray out the screen
-------------------

.. code-example ::
  
  .. js ::

       dojo.require("dojo.window");

        function block(){
            var vs = dojo.window.getBox(),
            div = dojo.create("div", {
                style: {
                    position: "absolute",
                    top: "0px",
                    left: "0px",
                    width: vs.w + "px",
                    height: vs.h + "px",
                    backgroundColor: "gray",
                    opacity: 0.1
                }
            }, dojo.body());

            setTimeout(function(){
                dojo.destroy(div);
           }, 500);
        }

  .. html ::

    <button type="button" onclick="block();">gray the screen</button>
