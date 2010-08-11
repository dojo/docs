#format dojo_rst

dojox.fx.Timeline
=================

:Status: Up to date
:Version: 1.5
:Project owner: Mike Wilcox
:Author: Mike Wilcox
:Available: since 1.5

Basic Description
-----------------

An add-on to dojo.fx that provides the ability to create a complex property animation based on an array of "keyframes".

The Timeline is a replacement for the default *dojo._Line*. Instead of *_Line.getValue* returning a float between 0-1, *_Timeline.getValue* returns an object with all properties and their current values. A property does not have to appear in every keyframe. As in the example below, "height" is transitioned from the first keyframe to the third. "width" is transitioned from the first to the second to the third.

After including dojox.fx.Timeline, the factory method *dojox.fx.animateTimeline* becomes available. This method accepts two arguments. The second is the node or id of the node to animate. The first is an object which expects two properties:

* duration
    Duration of the animation in milliseconds. Defaults to 1000.

* keys
    An array of objects, with style properties and values.
    
The objects in the *keys* array are key-value pairs of CSS properties, similar as in dojo.animateProperty. In addition to the CSS key-values, a *keys* object accepts two custom properties:

* step 
    The start, finish or percentage that this keyframe represents. Allowed parameters are:     
        0%-100% (as a string)
        
        from (same as 0%, used to conform with the Webkit animation spec)     
        
        to (same as 100%, used to conform with the Webkit animation spec)

* ease
    The string name of a dojo.fx.easing ease. Defaults to "linear". Use the suffix name of the ease, like: "quadIn", not: "dojo.fx.quadIn".


Example
-------

CSS:

.. code-block :: css
 :linenos:
 
 .rgt{
    width:300px;
    height:400px;
    border:1px solid #666;
    position:relative;
    float:left;
    margin-left:10px;
 }
 #myDiv{
    width:90px;
    height:40px;
    position:relative;
    border:1px solid #000;
    background:#ffff00;
    margin:10px auto;
    text-align:center;
 }

HTML:

.. code-block :: html
 :linenos:
 
 <div class="rgt">
    <div id="myDiv">Animate&nbsp;Me</div>
 </div>

JavaScript:

.. code-block :: javascript
 :linenos:
 
 dojo.require("dojox.fx.Timeline");
 var keys = [
    {
        step:"0px",
        ease:"quadInOut",
        width:"90px",
        height:"40px",
        lineHeight:"40px"
    },{
        step:"25%",
        width:"190px"
    },{
        step:"100%",
        width:"90px",
        height:"200px",
        lineHeight:"200px"
    }
 ];
 
 dojo.addOnLoad(function(){
    ani = dojox.fx.animateTimeline({keys:keys, duration:2000}, "myDiv").play();
 });
 

reverse
-------

If you include *dojox.fx.ext-dojo.reverse*, the Timeline animation can be reversed.
