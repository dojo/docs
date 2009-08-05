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

The dojo.position function is used to obtain position and size information about a DOM node.  The type of information it returns is the width and height of the DOM node's border-box (or borderStart-to-borderEnd size), and absolute position (border-start) in the form of x and y coordinates.  If the optional second parameter (default=false) has the value true, then the returned x and y values are offsets from the document root (unaffected by window scrolling), otherwise they are relative to the current viewport.  The return object looks like:

{ w: 300: h: 150, x: 700, y: 900, }

for a node with a width of 300px and a height of 150px, with page absolute coordinates of 700px on the x-axis and 900px on the y-axis.

==============
Usage Examples
==============

-------------------------------------------------------------------------------------------------------------------------
Example 1:  Center a small DOM node over a larger DOM node both vertically and horizontally relative to the document root
-------------------------------------------------------------------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.addOnLoad(function(){
        var divInfo = dojo.coords('div1', true);
        var span = dojo.byId('span1');
        var spanInfo = dojo.coords(span, false);
        dojo.body().appendChild(span);
        dojo.style(span, {
            left: divInfo.x + (divInfo.w - spanInfo.w) / 2 + "px",
            top: divInfo.y + (divInfo.h - spanInfo.h) / 2 + "px",
            visibility: "visible"
        });
      });
    </script>

  .. cv :: html 

    <span id="span1" style="position:absolute; visibility:hidden; border:10px groove black; padding:10px; font:14px monospace;">centered</span>
    <div id='div1' style="height:100px;width:120px;margin:20px;border:5px solid black;"></div>


----------------------------------------------------------------------------------------------------------------------------
Example 2:  Center a small DOM node over a larger DOM node both vertically and horizontally relative to the current viewport
----------------------------------------------------------------------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.addOnLoad(function(){
        var span = dojo.byId('text2');
        var divInfo = dojo.coords('underlay2', false);
        var spanInfo = dojo.coords(span);
        dojo.style(span, {
          left: divInfo.x + (divInfo.w - spanInfo.w) / 2 + "px",
          top: divInfo.y + (divInfo.h - spanInfo.h) / 2 + "px",
          visibility: "visible"
        });
      });
    </script>

  .. cv :: html 

    <div id='underlay2' style="height:100px;width:120px;margin:20px;border:5px solid black;"></div>
    <span id='text2' style="position:fixed;visibility:hidden;border:10px groove black;padding:10px;font:14px monospace;">centered</span>


--------------------------------------------------------------------
Example 3:  Look up a positioned dijit and calculate its coordinates
--------------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.TextBox");
      function init() {
        var node = dijit.byId("textbox").domNode;
        var coords = dojo.position(node);
        var info = dojo.byId("infoSpan");

        info.appendChild(document.createTextNode("Width: " + coords.w + "px.   Height: " + coords.h + "px. Absolute top: " + coords.y + "px.  Absolute left: " + coords.x + "px."));
      }
      dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <div id="textbox" dojoType="dijit.form.TextBox"></div>
    <br>
    <br>
    <span id="infoSpan"></span>



=====
Notes
=====
* Remember that page coordinates start as the top leftmost of the page is 0px, 0px
