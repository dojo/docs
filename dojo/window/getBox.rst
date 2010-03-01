#format dojo_rst

dojo.window.getBox
==================

:Status: Draft
:Version: 1.0
:Available: since V1.5

.. contents::
   :depth: 2

Gets the size of the viewport.

============
Introduction
============

Returns the size of the viewport (the part of the document that's visible on the screen, not including the part that's scrolled out of view).

========
Examples
========

Gray out the screen
-------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
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
