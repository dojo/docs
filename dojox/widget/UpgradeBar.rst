#format dojo_rst

dojox.widget.UpgradeBar
=========================

:Status: Up to date
:Version: 1.4
:Project owner: Mike Wilcox, Revin Guillen
:Author: Mike Wilcox
:Available: since 1.4

Basic Description
-----------------

Shows the "yellow bar" at the top of the screen when the user is to be notified that they should upgrade their browser or a plugin.

You can insert custom validations to trigger the UpgradeBar to display. An evaluation of 'true' shows the bar (as this version *is* less than it should be). Multiple validations may be checked, although only the first in the list will be displayed. The user would have to upgrade then refresh the page to see the next notification. Of course, validations can also be used for each browser, like only allowing those that support CSS3 or SVG, or maybe even something that's in IE8.

Markup and programmatic are supported. Markup is a little cleaner, since a majority of the parameters are the HTML snippets to be displayed. In markup, the validate code should be an expression that will evaluate to true or false. This expression is wrapped in a try/catch, so if it blows up, it is assumed to be true and trigger the bar. In programmatic, a function should be used that returns true or false. You would need to use your own try/catch in that.

Notifications
-------------

The only required parameter is *notifications*. This is an array of objects, and each object contains a validation expression and a message. The messages can be plain text, but HTML is recommended, so that you may provide a link to the upgrade site. If you don't provide a link, this widget may as well be named the HarassmentBar.

To provide the validation in markup, use _validate_ as an attribute like the two examples that follow:

.. code-block :: html
 :linenos:

 <div validate="!google.gears">
 <div validate="dojo.isFF<3">
 
As you can see, these should be expressions that evaluate to true or false. UpgradeBar wraps these expressions in a try/catch to ensure no errors are thrown. If Google Gears is not installed, that expression would throw an error. This should be kept in mind when creating the UpgradeBar programmatically, because you would need to supply your own try catch.


.. code-block :: javascript
 :linenos:
 
 function(){
     var evals = true;
     try{ evals = !google.gears; }catch(e){}
     return evals;	
 }
 
If doing something simple like testing a browser or version, a try/catch is not necessary: 
 
 
.. code-block :: javascript
 :linenos:
 
 function(){
     return dojo.isIE < Infinity;	
 }
 
Examples
--------

A programatic example:

.. code-block :: javascript
 :linenos:
 
 new dojox.widget.UpgradeBar({
     notifications:[
         {
             validate:function(){
                 return dojo.isIE<7;	
             },
             message:   '<span>You're using IE6? Really? Seriously?</span><a href="http://www.getfirefox.net/">Get Firefox</a>'
         },
         {
             validate:function(){
                 var evals = true;
                 try{ evals = dojox.embed.Flash.available<14}catch(e){}
                 return evals;	
             },
             message:   '<span>This app needs a version of Flash that has never been released.</span><a href="http://www.adobe.com/downloads/">Get Flash Player</a>'
         }
     ]	
 });
 
A markup example:
 
.. code-block :: html
 :linenos:
 
 <div dojoType="dojox.widget.UpgradeBar" id="upgradeBar" permDismiss="true">
     <div validate="dojo.isIE<7">
         <span>Unrecognized device attempting to read Internet files. Recommend that you:"</span>
         <a href="http://www.getfirefox.net/">Get Firefox</a>	
     </div>
     <div validate="dojo.isFF<3.5">
         <span>The rest of the planet has upgraded. Your turn:</span>
         <a href="http://www.getfirefox.net/">Get Firefox</a>	
     </div>
     <div validate="dojox.embed.Flash.available<9">
         <span>If the browser vendors paid attention to the File Input spec I wouldn't have to ask you to upgrade. But I do....</span>
         <a href="http://www.adobe.com/downloads/">Download Flash 10</a>
     </div>
     <div validate="!google.gears">
         <span>Don't know what Google Gears is? Trust me:</span>
         <a href="http://gears.google.com/download.html">Download Google Gears</a>
     </div>
 </div>
