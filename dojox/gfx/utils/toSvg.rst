.. _dojox/gfx/utils/toSvg:

=====================
dojox.gfx.utils.toSvg
=====================

:Authors: Eugene Lazutkin, Jared Jurkiewicz
:since: V1.0

.. contents ::
    :depth: 2

The *dojox.gfx.utils.toSvg* is a helper function designed to serialize a dojox.gfx.Surface object into SVG text on any dojo supported browser. This is useful for situations where you may want to generate a standards-based graphics representation for post-back to a server side service. For example, this can be very useful for converting a DataChart to a JPEG, PNG, or even PDF via Apache Batik.


Usage
=====

This function is generally easy to use. At its most basic, you need to do the following:

*dojo.require("dojox.gfx.utils");* to load it.

The function signature is:
    var deferred = *dojox.gfx.utils.toJson(/*dojox.gfx.Surface*/ surface);

So basic usage is:

.. js ::
  
  dojox.gfx.utils.toJson(mySurface).then(
     function(svg){
        alert(svg);
     },
     function(error){
        alert("Error occurred: " + error);
     }
  );

As the above code example demonstrates, the serialization is an async operation. This is because in browsers without native SVG support (and GFX is using VML, Silverlight, or Canvas), the rendering to SVG text occurs in a hidden iframe that has dojo loaded with the renderer forced to svg mode so that an SVG dom tree can be constructed. The iframe itself loads and works in async so the render output must be handled in an async manner for compatibility across all browsers (Firefox, Internet Explorer, etc).

Cross-Domain considerations
---------------------------

If you are using a cross-domain build of dojo, then you must do some extra work in order to get the SVG serializer working. Namely, you must specify a dojoConfig option that points to a 'svg iframe proxy' HTML page on your server so that the iframe itself does not believe it is running in cross-domain mode and as such, allows the contents of the frame to be accessed and manipulated. Basically, this means you need to do the following:

* Copy the dojox/gfx/resources/gfxSvgProxyFrame.html to the server that is serving your application
* Set the dojoConfig option 'dojoxGfxSvgProxyFrameUrl' to point to the file you copied to your server, much as you would set for 'blank.html'. For example, a modified dojoConfig setting for dojo:

.. js ::
  
  <script type="text/javascript" src="http://some.xdomain.server/dojo.js" data-dojo-config='dojoxGfxSvgProxyFrameUrl: "mylocaldir/gfxSvgProxyFrame.html", parseOnLoad: true'>


Example
=======


.. code-example ::
  
  .. js ::

      dojo.require("dojox.gfx");
      dojo.require("dojox.gfx.utils");
      dojo.require("dijit.form.Button");
   
      var drawing;

      dojo.ready(function(){
         // Create our surface.
         var node = dojo.byId("gfxObject");
         drawing = dojox.gfx.createSurface(node, 200, 200);
         drawing.createRect({
           width:  100,
           height: 100,
           x: 50,
           y: 50
         }).setFill("blue").setStroke("black");
      });
   
      function serialize(){
        dojox.gfx.utils.toSvg(drawing).then(
            function(svg){
                dojo.byId("svg").innerHTML = svg;
            },
            function(err){
               alert(err);
            }
        );
      }

  .. html ::

    <div id="gfxObject"></div>
    <div data-dojo-type="dijit.form.Button" id="button" onClick="serialize();">
        Click me to serialize the GFX object to SVG!
    </div>
    <br>
    <br>
    <b>SVGSerialization</b>
    <xmp id="svg">
    </xmp>


See also
========

* :ref:`dojox.gfx.utils.toJson <dojox/gfx/utils/toJson>`

  Serialize the passed surface object to JSON form
