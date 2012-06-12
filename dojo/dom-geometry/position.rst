.. _dojo/dom-geometry/position:

=================================
dojo/dom-geometry::position()
=================================

:Project owner:	Doug Hays
:since: V1.7

.. contents ::
    :depth: 2

The ``position()`` is used to obtain position and size information about a DOM node. The type of information it returns
is the width and height of the DOM node's border-box (or borderStart-to-borderEnd size), and absolute position
(border-start) in the form of x and y coordinates. If the optional includeScroll boolean parameter (default=``false``)
has the value ``true``, then the returned ``x`` and ``y`` values are offsets from the document root (unaffected by
window scrolling), otherwise they are relative to the current viewport. The return object looks like:

.. js ::

  { w: 300: h: 150, x: 700, y: 900, }

for a node with a width of 300px and a height of 150px, with page absolute coordinates of 700px on the x-axis and 900px
on the y-axis.

Usage
=====

.. js ::

  require(["dojo/dom-geometry", "dojo/dom", "dojo/dom-style"], function(domGeom, dom, style){
    var node = dom.byId("someNode");
    var includeScroll = false;
    var output = domGeom.position(node, includeScroll);
  });

Attributes
==========

============= ============== ===========================================================================================
Arguments     Type           Description
============= ============== ===========================================================================================
node          String|DOMNode The node to return the information for
includeScroll Boolean?       Defaults to ``false``.  If ``true`` the ``x`` and ``y`` values will be relative to the 
                             scroll position of the document.
============= ============== ===========================================================================================

Examples
========

Basic usage
-----------

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-geometry", "dojo/dom", "dojo/on", "dojo/json", "dojo/domReady!"],
    function(domGeom, dom, on, JSON){
      on(dom.byId("command"), "click", function(){
        var node = dom.byId("example");
        var output = domGeom.position(node);
        dom.byId("output").innerHTML = JSON.stringify(output);
      });
    });

  .. html ::

    <button id="command" type="button">position()</button>
    <div class="example" id="example">Some example node</div>
    <p><strong>Output:</strong></p>
    <pre id="output"></pre>

  .. css ::

    .example{
      margin: 1em;
      text-align: center;
      padding: 1em;
      border: 2px solid black;
      color: white;
      background-color: blue;
      width: 200px;
      height: 100px;
    }

Centering a DOM node
--------------------

This example shows how to center a small DOM node (with background image) over a larger DOM node (the frame) both
vertically and horizontally relative to the document root.

.. code-example ::
  :version: 1.7-2.0
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-geometry", "dojo/dom", "dojo/dom-style", "dojo/on", "dojo/domReady!"],
    function(domGeom, dom, style, on){
      var lastX = 0,
          lastY = 0;
      on(dom.byId("doit"), "click", function(){
        var divInfo = domGeom.position("div1", true), // use true to get the x/y relative to the document root
            span = dom.byId("span1"),
            spanInfo = domGeom.position(span, true);
        lastX += divInfo.x - spanInfo.x + (divInfo.w - spanInfo.w) / 2;
        lastY += divInfo.y - spanInfo.y + (divInfo.h - spanInfo.h) / 2;
        style.set(span, {
          left: lastX + "px",
          top: lastY + "px"
        });
      });
    });

  .. html ::

    <span id="span1" class="centered" style=""></span>
    <div id="div1" class="container" style=""></div>
    <button id="doit" type="button">Click to center the image over the frame</button>

  .. css ::

    .container {
        background: url("../../dojo/frame.png") no-repeat;
        width: 237px;
        height: 181px;
    }

    .centered {
        background: url("../../dojo/img.png") no-repeat;
        width: 171px;
        height: 121px;
        position: absolute;
        left: 0;
        top: 0;
        border: 1px solid white;
    }

Comparison of various DOM node position/size methods
----------------------------------------------------

To see the effect of dojo.position's includeScroll boolean parameter, scroll the window down and click the 15x120
content area.

.. code-example ::
  :version: 1.7-2.0
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-geometry", "dojo/dom", "dojo/_base/html", "dojo/domReady!"],
    function(domGeom, dom, html){
      var testNode = dom.byId("testNode"),
          contentBox = domGeom.getContentBox(testNode),
          marginBox = domGeom.getMarginBox(testNode),
          position_win = domGeom.position(testNode, true),
          position_view = domGeom.position(testNode, false),
          coords_win = html.coords(testNode, true),
          coords_view = html.coords(testNode, false);
      for(var attr in { x: 0, y: 0, w: 0, h: 0, l: 0, t: 0 }){
        for(var fcn in { position_win: 0, position_view: 0, marginBox: 0, contentBox: 0, coords_win: 0, coords_view: 0}){
          var val = eval(fcn)[attr];
          dom.byId(fcn + "_" + attr).innerHTML = !isNaN(val)?val:"--";
        }
      }
    });

  .. html ::

    <fieldset style="display:inline;border:15px solid gray;border-width:15px 0 0 15px;margin:0px;padding:0px;font:14px monospace;background-color:white;outline:1px dotted black;">
    <fieldset style="display:inline;border:0px;border:0px;padding:0px;width:270px;height:165px;overflow:hidden;position:relative;left:-15px;top:-15px;">
        <div id="testNode" style="display:inline;margin:25px;border:20px solid gray;padding:30px;float:left;position:relative;left:15px;top:15px;" onclick="compareMethods()">
            <center style="display:block;margin:0px;padding:0px;border:0px;width:120px;height:15px;background-color:gray;color:white;overflow:hidden;">120x15 content</center>
            <nobr style="position:absolute;left:2px;top:2px;color:black;">padding 30px</nobr>
            <nobr style="position:absolute;left:-18px;top:-18px;color:white;">border 20px</nobr>
            <nobr style="position:absolute;left:-43px;top:-43px;color:black;">margin 25px</nobr>
            <nobr style="position:absolute;left:-63px;top:-63px;color:white;">left/top 15px</nobr>
        </div>
    </fieldset>
    </fieldset>
    <table rules=all cellpadding=2 cellspacing=2 border=2 style="font:16px monospace;text-align:center;">
    <tr><td></td><td colspan="6">attribute</td></tr>
    <tr><td>function</td><td>x</td><td>y</td><td>w</td><td>h</td><td>l</td><td>t</td></tr>
    <tr><td style="text-align:left;">dojo.position(node,true)</td><td id="position_win_x"></td><td id="position_win_y"></td><td id="position_win_w"></td><td id="position_win_h"></td><td id="position_win_l"></td><td id="position_win_t"></td></tr>
    <tr><td style="text-align:left;">dojo.position(node,false)</td><td id="position_view_x"></td><td id="position_view_y"></td><td id="position_view_w"></td><td id="position_view_h"></td><td id="position_view_l"></td><td id="position_view_t"></td></tr>
    <tr><td style="text-align:left;">dojo.marginBox(node)</td><td id="marginBox_x"></td><td id="marginBox_y"></td><td id="marginBox_w"></td><td id="marginBox_h"></td><td id="marginBox_l"></td><td id="marginBox_t"></td></tr>
    <tr><td style="text-align:left;">dojo.contentBox(node)</td><td id="contentBox_x"></td><td id="contentBox_y"></td><td id="contentBox_w"></td><td id="contentBox_h"></td><td id="contentBox_l"></td><td id="contentBox_t"></td></tr>
    <tr style="color:gray;"><td style="text-align:left;">dojo.coords(node,true)</td><td id="coords_win_x"></td><td id="coords_win_y"></td><td id="coords_win_w"></td><td id="coords_win_h"></td><td id="coords_win_l"></td><td id="coords_win_t"></td></tr>
    <tr style="color:gray;"><td style="text-align:left;">dojo.coords(node,false)</td><td id="coords_view_x"></td><td id="coords_view_y"></td><td id="coords_view_w"></td><td id="coords_view_h"></td><td id="coords_view_l"></td><td id="coords_view_t"></td></tr>
    </table>

Notes
~~~~~

* Remember that page coordinates start as the top leftmost of the page is 0px, 0px

See also
========

* :ref:`dojo/dom-geometry <dojo/dom-geometry>`

* :ref:`dojo/_base/html <dojo/_base/html>`

* :ref:`dojo/dom-style <dojo/dom-style>`
