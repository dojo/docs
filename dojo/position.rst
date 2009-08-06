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
      dojo.addOnLoad(function(){
        var divInfo = dojo.position('div1', true), // use true to get the x/y relative to the document root
            span = dojo.byId('span1'),
            spanInfo = dojo.position(span, false); // use false since x/y are not needed
        dojo.body().appendChild(span);
   span.h = spanInfo.h;
   var div = dojo.byId('div1');
   div.y = divInfo.y;
   div.h = divInfo.h;
        dojo.style(span, {
            left: divInfo.x + (divInfo.w - spanInfo.w) / 2 + "px",
            top: divInfo.y + (divInfo.h - spanInfo.h) / 2 + "px",
            visibility: "visible"
        });
      });
    </script>

  .. cv :: html 

    <span id="span1" testclass="centered" style="position:absolute;border:1px solid red;;">centered</span>
    <div id="div1" testclass="container" style="width:200px;height:100px;border:1px solid blue;"></div>

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
          visibility: hidden;
          position: absolute;
          border: 1px solid white;
      }
    </style>

----------------------------------------------------
Comparison of various DOM node position/size methods
----------------------------------------------------
To see the effect of dojo.position's includeScroll boolean parameter, scroll the window down and click the 15x120 content area.

.. cv-compound ::
  
  .. cv :: javascript

    <script>
    function compareMethods(){
	var testNode = dojo.byId('testNode'),
	    contentBox = dojo.contentBox(testNode),
	    marginBox = dojo.marginBox(testNode),
	    position_win = dojo.position(testNode, true),
	    position_view = dojo.position(testNode, false),
	    coords_win = dojo.coords(testNode, true),
	    coords_view = dojo.coords(testNode, false);
	for (var attr in {x:0,y:0,w:0,h:0,l:0,t:0}){
		for (var fcn in {position_win:0, position_view:0, marginBox:0, contentBox:0, coords_win:0, coords_view:0}){
			var val = eval(fcn)[attr];
			dojo.byId(fcn+"_"+attr).innerHTML = !isNaN(val)?val:"--";
		}
	}
    }
    dojo.addOnLoad(function(){
	compareMethods();
    });
    </script>

  .. cv :: html 

    <fieldset style="display:inline;border:15px solid gray;border-width:15px 0 0 15px;margin:0px;padding:0px;font:14px monospace;background-color:white;outline:1px dotted black;">
	<fieldset style="display:inline;border:0px;border:0px;padding:0px;width:270px;height:165px;overflow:hidden;position:relative;left:-15px;top:-15px;">
		<div id="testNode" style="display:inline;margin:25px;border:20px solid gray;padding:30px;float:left;position:relative;left:15px;top:15px;" onclick="compareMethods()">
			<center style="display:block;margin:0px;padding:0px;border:0px;width:120px;height:15px;background-color:gray;color:white;overflow:hidden;">15x120 content</center>
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



=====
Notes
=====
* Remember that page coordinates start as the top leftmost of the page is 0px, 0px
* dojo.coords is deprecated starting in Dojo 1.4 since it's a mixin of the much faster dojo.position and dojo.marginBox
