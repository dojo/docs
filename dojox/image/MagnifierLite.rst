#format dojo_rst

dojox.image.MagnifierLite
=========================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

A simple hover behavior for images, showing a zoomed version of a size image.


============
Introduction
============

dojox.image.MagnifierLite offers an unobtrusive way to add an unstyled overlay above the srcNode image element. The overlay/glass is a scaled version of the src image (so larger images sized down are clearer).

The logic behind requiring the src image to be large is “it’s going to be downloaded, anyway” so this method avoids having to make thumbnails and two http requests among other things.

This is the base class for `dojox.image.Magnifier <dojox/image/Magnifier>`_, a dojox.gfx-based extension this portion does not require the dojox.gfx package, but is limited to CSS-based styling. 


=====
Usage
=====

TODO: how to use the component/class/method

=========  ====  ===========
Parameter  Type  Description
=========  ====  ===========
TODOC      ---   ---
=========  ====  ===========


========
Examples
========

Declarative example
-------------------

.. cv-compound::

  .. cv:: javascript

       <script type="text/javascript">
         dojo.require("dijit.form.Button"); 	 
         dojo.require("dojox.image.MagnifierLite");                
       </script>
       
  .. cv:: html

       <p>Programatic: (destroy() removes this.domNode)<br></p>	
		
       <img id="foobar" style="width:585px; height:201px" scale="7" glassSize="185" 
                 dojoType="dojox.image.MagnifierLite"
                      src="http://www.zelda-infinite.com/games/zelda1/overworld.png" /> 

                <button dojoType="dijit.form.Button" id="foob">
			Make It
			<script type="dojo/method" event="onClick">
				this.setAttribute("disabled",true);
				dijit.byId("foobd").setAttribute("disabled",false);
				new dojox.image.MagnifierLite({ scale:4.2, glassSize:200 },"foobar1");
			</script>
		</button>

		<button dojoType="dijit.form.Button" id="foobd" disabled="disabled">
			Destroy It
			<script type="dojo/method" event="onClick">
				dijit.byId("foob").setAttribute("disabled",false);
				this.setAttribute("disabled",true);
				dijit.byId("foobar").destroy(true);
			</script>
		</button>
		
		          
  .. cv:: css

   <style>
    @import "{{baseUrl}}dojox/image/resources/image.css";   
   </style>


========
See also
========

* `dojox.image.Magnifier <dojox/image/Magnifier>`_
