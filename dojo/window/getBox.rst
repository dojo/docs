#format dojo_rst

dojo.window.getBox
==================

:Available: since V1.5

.. contents::
   :depth: 2

Gets the size of the viewport.


============
Introduction
============

The viewport is the part of the document that's visible on the screen. In contrast to this, the part of the document that's scrolled out of view is not part of the viewport. In order to get the size of the viewport, you can use dojo.window.getBox().

=====
Usage
=====

.. code-block :: javascript

  // Load the function:
  dojo.require("dojo.window");

  // Get the viewport-size of the document:
  var vs = dojo.window.getBox();

  console.log('viewport size:', ' width: ', vs.w, ', height: ', vs.h, ', left: ', vs.l, ', top: ', vs.t);


========
Examples
========

Gray out the screen
-------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
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
    </script>

  .. cv :: html 

    <button type="button" onlick="block();">gray the screen</button>
