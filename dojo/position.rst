## page was copied from dojo/coords
#format dojo_rst

dojo.position
=============

:Status: Draft
:Version: 1.0
:Available: since 1.4

.. contents::
   :depth: 2

Getter for the position and size of a DOM node.


============
Introduction
============

The dojo.position function is used to obtain position and size information about a DOM node.  The type of information it returns is the width and height of the DOM node's border-box (or borderStart-to-borderEnd size), and absolute position (border-start) in the form of x and y coordinates.  If the optional includeScroll boolean parameter (default=false) has the value true, then the returned x and y values are offsets from the document root (unaffected by window scrolling), otherwise they are relative to the current viewport.  The return object looks like:

{ w: 300: h: 150, x: 700, y: 900, }

for a node with a width of 300px and a height of 150px, with page absolute coordinates of 700px on the x-axis and 900px on the y-axis.

==============
Usage Examples
==============

-------------------------------------------------------------------------------------------------------------------------------------------------------------
Example 1:  Center a small DOM node (with background image) over a larger DOM node (the frame) both vertically and horizontally relative to the document root
-------------------------------------------------------------------------------------------------------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      var lastX = 0, lastY = 0;
      function doit(){
        var divInfo = dojo.position('div1', true), // use true to get the x/y relative to the document root
            span = dojo.byId('span1'),
            spanInfo = dojo.position(span, true);
        lastX += divInfo.x - spanInfo.x + (divInfo.w - spanInfo.w) / 2;
        lastY += divInfo.y - spanInfo.y + (divInfo.h - spanInfo.h) / 2;
        dojo.style(span, {
            left: lastX + "px",
            top: lastY + "px"
        });
      }
    </script>

  .. cv :: html 

    <span id="span1" class="centered" style=""></span>
    <div id="div1" class="container" style=""></div>
    <button type="button" onclick="doit()" class="">Click to center the image over the frame</button>

  .. cv :: css

    <style type="text/css">
      .container {
          background: url(http://docs.dojocampus.org/dojo/position?action=AttachFile&do=get&target=frame.png) no-repeat;
          width: 237px;
          height: 181px;
      }

      .centered {
          background: url(http://docs.dojocampus.org/dojo/position?action=AttachFile&do=get&target=img.png) no-repeat;
          width: 171px;
          height: 121px;
          position: absolute;
          left: 0;
          top: 0;
          border: 1px solid white;
      }
    </style>

----------------------------------------------------
Comparison of various DOM node position/size methods
----------------------------------------------------
To see the effect of dojo.position's includeScroll boolean parameter, scroll the window down and click the 15x120 content area.

.. code-example ::
  
  .. javascript :: 

    <script type="text/javascript">
       </script>

  .. html :: 

    <div>hi</div>



=====
Notes
=====
* Remember that page coordinates start as the top leftmost of the page is 0px, 0px
* dojo.coords is deprecated starting in Dojo 1.4 since it's a mixin of the much faster dojo.position and dojo.marginBox
