#format dojo_rst

dojox.fx.ext-dojo.reverse
=========================

:Status: Up to date
:Version: 1.5
:Project owner: Mike Wilcox
:Author: Mike Wilcox
:Available: since 1.5

Basic Description
-----------------

A dojo.Animation extension that enables an easy reversal.

To use, simply require dojox.fx.ext-dojo.reverse and a reverse() method will be added to all dojo.Animations. It can be used at any time during the animation. It does not need to be called when it ends. It also reverses the easing - if dojo.fx.easing.quadIn is used, dojo.fx.easing.quadOut will be used when animating backwards.

The reverse method has two optional arguments:

* keepPaused
	By default, calling reverse() will play the animation if it was paused. Pass in true to keep it paused (will have no effect if reverse is called while animation is playing).

* reverseEase
	A function to use for the reverse easing. This allows for the possibility of custom eases that are not in the dojo.fx library.
	
Example
-------

CSS:

.. code-block :: css
 :linenos:
 
 .lft{
    width:300px;
    height:300px;
    border:1px solid #666;
    position:relative;
    float:left;
 }
 #ball{
    width:50px;
    height:50px;
    margin:0px auto;
    top:125px;
    position:relative;
    border:1px solid #000;
    background:#0000ff;
 }

HTML:

.. code-block :: html
 :linenos:
 
 <button id="btn">Reverse</button>
 <div class="lft">
     <div id="ball"></div>
 </div>

JavaScript:

.. code-block :: javascript
 :linenos:
 
 dojo.require("dojox.fx.ext-dojo.reverse");
 dojo.addOnLoad(function(){
    var ani = dojo.animateProperty({
        node:dojo.byId("ball"),
        duration:1000,
        easing:dojo.fx.easing.bounceOut,
        properties:{
            width:{
                start:50,
                end:150,
                units:"px"
            },
            height:{
                start:50,
                end:150,
                units:"px"
            },
            top:{
                start:125,
                end:75,
                units:"px"
            },
            opacity:{
                start:1,
                end:.2
            },
            backgroundColor:{
                start:"#0000ff",
                end:"#ff0000"
            }
        }
    });
    ani.play();
    
    dojo.connect(dojo.byId("btn"), "click", function(){
        ani.reverse();
    })
 });
 
