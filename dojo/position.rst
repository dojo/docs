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

The dojo.position function is used to obtain position and size information about a DOM node.  The type of information it returns is the width and height of the DOM node's border-box (or borderStart-to-borderEnd size), and absolute position (borderStart) in the form of page x and y coordinates.  The return object looks like:

{ w: 300: h: 150, x: 700, y: 900, }

for a node with a width of 300px and a height of 150px, with page absolute coordinates of 700px on the x-axis and 900px on the y-axis.

==============
Usage Examples
==============

-------------------------------------------------------------------------------------------
Example 1:  Center a small DOM node over a larger DOM node both vertically and horizontally
-------------------------------------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.addOnLoad(function(){
        var span = dojo.byId('text');
        var divInfo = dojo.position('underlay', true);
        var spanInfo = dojo.position(span);
        dojo.style(span, {
          left: divInfo.x + (divInfo.w - spanInfo.w) / 2 + "px",
          top: divInfo.y + (divInfo.h - spanInfo.h) / 2 + "px",
          visibility: "visible"
        });
      });
    </script>

  .. cv :: html 

    <div id='underlay' style="height:100px;width:120px;margin:20px;border:5px solid black;"></div>
    <span id='text' style="position:absolute;left:0;top:0;visibility:hidden;border:10px groove black;padding:10px;font:14px monospace;">centered</span>


--------------------------------------------------------------------
Example 2:  Look up a positioned dijit and calculate its coordinates
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
