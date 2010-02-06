#format dojo_rst


:Status: Up to date
:Version: 1.5
:Project owner: Mike Wilcox
:Author: Mike Wilcox
:Available: since 1.5

=========================
dojox.fx.ext-dojo.complex
=========================

Basic Description
-----------------

A dojo.Animation extension which adds functionality that animates a "complex property". The primary example is the clip style: rect(10px 30px 10px 50px).

The standard animation doesn't know what to do with something like rect(...). This class identifies complex properties by they being a string and having parenthesis. If so, that property is made into a dojox.fx._Complex object and the getValue() is obtained from there.

Frankly, the clip style is not very useful nor exciting. But the dojox.fx.ext-dojo.complex class will animate any property contained within parenthesis. So it can also be used with (and is actually intended for) CSS3 properties, such as transform: 

.. code-block :: css
 :linenos:
 
 transform: rotate(10deg) translateX(0px)  
 
or even gradients (it would only affect the properties within the color-stops): 

.. code-block :: css
 :linenos:
 
 background-image: -webkit-gradient(linear, right top, left top, color-stop(0, #ff0000),color-stop(1.0, #0000FF));

To use, simply require dojox.fx.ext-dojo.complex and complex properties will be handled in all dojo.Animations.
    
Example
-------

CSS:

.. code-block :: css
 :linenos:
 
 #cnt{
    width:300px;
    height:300px;
    border:1px solid #666;
    position:relative;
 }
 #words{
    width:300px;
    height:300px;
    margin:0px;
    padding:5px;
    top:0px;
    position:absolute;
    border:1px solid #000;
    background:#0000ff;
    clip:rect(10px 30px 30px 10px);
 }
 #words p{
    font-size:48px;
 }

HTML:

.. code-block :: html
 :linenos:
 
 <div id="cnt">
    <div id="words">
        <p>Dojo</p>
    </div>
 </div>

JavaScript:

.. code-block :: javascript
 :linenos:
 
 dojo.require("dojox.fx.ext-dojo.complex");
            
 dojo.addOnLoad(function(){
    var ani = dojo.animateProperty({
        node:dojo.byId("words"),
        duration:800,
        properties:{
            clip:{start:'rect(150px 150px 150px 150px)', end:'rect(0px 300px 300px 0px)'}
        }
    }).play();
 });
 
