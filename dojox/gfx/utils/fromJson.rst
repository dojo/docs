#format dojo_rst

dojox.gfx.utils.fromJson
========================

:Status: Contributed, Draft
:Version: 1.4
:Author: Eugene Lazukin, Jared Jurkiewicz
:Available: since V1.0

.. contents::
  :depth: 2

The *dojox.gfx.utils.fromJson* is a helper function designed to take a JSON serialized dojox.gfx.Surface object and restore its contents into another dojox.gfx.Surface. The function itself is simple to use.  

=====
Usage
=====

If you wish to use this function, then your code must do a *dojo.require("dojox.gfx.utils");* to load it.  

The function signature is:
   *dojox.gfx.utils.fromJson(/*dojox.gfx.Surface*/ surface, /*String*/ json);

So basic usage is:

.. code-block :: javascript

  var mySurface = dojox.gfx.createSurface(newNode, 200, 200);
  dojox.gfx.utils.toJson(mySurface, json);

Functional Exaple 
-----------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.gfx");
      dojo.require("dojox.gfx.utils");
      dojo.require("dijit.form.Button");
   
      function init(){
 
         //Create our surface.
         var drawing = dojox.gfx.createSurface(dojo.byId("gfxObject"), 200, 200);
         var copy = dojox.gfx.createSurface(dojo.byId("gfxObject2"), 200, 200);
         drawing.createRect({ 
           width:  100,
           height: 100,
           x: 50,
           y: 50
         }).setFill("blue").setStroke("black");

         dojo.connect(dijit.byId("button"), "onClick", function() {
            var json = dojox.gfx.utils.toJson(drawing);
            dojox.gfx.utils.fromJson(copy, json);
         });
      }
      //Set the init function to run when dojo loading and page parsing has completed.
      dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <b>Original surface:</b>
    <div id="gfxObject"></div>
    <div dojoType="dijit.form.Button" id="button">Click me to copy the surface via JSON to another surface!</div>
    <br>
    <br>  
    <b>JSON restored surface:</b>
    <div id="gfxObject2">
    </div>
