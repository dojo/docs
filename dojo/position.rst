## page was copied from dojo/coords
#format dojo_rst

dojo.position
=============

:Status: Draft
:Version: 1.0
:Available: since 1.4

.. contents::
   :depth: 2

Getter for the position and size of a dom node.


============
Introduction
============

The dojo.position function is used to obtain a plethora of coordinate information about a dom node.  The type of information it returns is the width and height of the dom node's border-box (or border-to-border size), and absolute position in the form of page x and y coordinates.  The return object looks like:

{ w: 300: h: 150, x: 700, y: 900, }

for a node with a width of 300px and a height of 150px, with page absolute coordinates of 700px on the x axis and 900px on the y axis.

==============
Usage Examples
==============

-----------------------------------------------------------------------
Example 1:  Look up a positioned DOM node and calculate its coordinates
-----------------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      function init() {
        var node = dojo.byId("box");
        var coords = dojo.position(node);
        var info = dojo.byId("info");

        info.appendChild(document.createTextNode("Width: " + coords.w + "px.   Height: " + coords.h + "px.  Absolute top: " + coords.y + "px.  Absolute left: " + coords.x + "px."));
      }
      dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <div id="box" style="width: 100px; height: 100px; background-color: darkgray;"></div>
    <br>
    <span id="info"></span>


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
