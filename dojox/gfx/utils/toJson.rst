.. _dojox/gfx/utils/toJson:

======================
dojox.gfx.utils.toJson
======================

:Authors: Eugene Lazutkin, Jared Jurkiewicz
:since: V1.0

.. contents ::
  :depth: 2

The *dojox.gfx.utils.toJson* is a helper function designed to serialize a dojox.gfx.Surface object into a JSON representation for a variety of scenarios, such as sending it across the wire to save, using it to copy a surface, and so on. The function itself is simple to use.


Usage
=====

If you wish to use this function, then your code must do a *dojo.require("dojox.gfx.utils");* to load it.

The function signature is:
   *dojox.gfx.utils.toJson(/*dojox.gfx.Surface*/ surface);

So basic usage is:

.. js ::

  var json = dojox.gfx.utils.toJson(mySurface);


Examples
========

Programmatic example
--------------------

.. code-example ::
  
  .. js ::

      dojo.require("dojox.gfx");
      dojo.require("dojox.gfx.utils");
      dojo.require("dijit.form.Button");
   
      // Set the init function to run when dojo loading and page parsing has completed.
      dojo.ready(function(){
 
         // Create our surface.
         var node = dojo.byId("gfxObject");
         var drawing = dojox.gfx.createSurface(node, 200, 200);
         drawing.createRect({
           width:  100,
           height: 100,
           x: 50,
           y: 50
         }).setFill("blue").setStroke("black");

         dojo.connect(dijit.byId("button"), "onClick", function(){
            var json = dojox.gfx.utils.toJson(drawing);
            // Try to make it pretty-print
            dojo.byId("json").innerHTML = dojo.toJson(dojo.fromJson(json), true);
         });
      });

  .. html ::

    <div id="gfxObject"></div>
    <div data-dojo-type="dijit.form.Button" id="button">Click me to serialize the GFX object to JSON!</div>
    <br>
    <br>
    <b>JSON Serialization</b>
    <pre id="json">
    </pre>


See also
========

* :ref:`dojox.gfx.utils.fromJson <dojox/gfx/utils/fromJson>`

  Rebuild the dojox.gfx.Surface object from the provided JSON
