.. _dojox/image/MagnifierLite:

=========================
dojox.image.MagnifierLite
=========================

:Project owner: ?--
:since: V?

.. contents ::
   :depth: 2

A simple hover behavior for images, showing a zoomed version of a size image.


Introduction
============

dojox.image.MagnifierLite offers an unobtrusive way to add an unstyled overlay above the srcNode image element. The overlay/glass is a scaled version of the src image (so larger images sized down are clearer).

The logic behind requiring the src image to be large is “it’s going to be downloaded, anyway” so this method avoids having to make thumbnails and two http requests among other things.

This is the base class for :ref:`dojox.image.Magnifier <dojox/image/Magnifier>`, a dojox.gfx-based extension this portion does not require the dojox.gfx package, but is limited to CSS-based styling.


Usage
=====

TODO: how to use the component/class/method

=========  ====  ===========
Parameter  Type  Description
=========  ====  ===========
TODOC      ---   ---
=========  ====  ===========


Examples
========

Declarative example
-------------------

.. code-example ::

  .. js ::

         dojo.require("dijit.form.Button");
         dojo.require("dojox.image.MagnifierLite");
       
  .. html ::

       <p>Programmatic: (destroy() removes this.domNode)<br></p>

       <img id="foobar" style="width:585px; height:201px" scale="7" glassSize="185"
                 data-dojo-type="dojox.image.MagnifierLite"
                      src="http://www.zelda-infinite.com/games/zelda1/overworld.png" />

                <button data-dojo-type="dijit.form.Button" id="foob">
            Make It
            <script type="dojo/method" data-dojo-event="onClick">
                this.setAttribute("disabled", true);
                dijit.byId("foobd").setAttribute("disabled", false);
                new dojox.image.MagnifierLite({ scale:4.2, glassSize:200 }, "foobar");
            </script>
        </button>

        <button data-dojo-type="dijit.form.Button" id="foobd" disabled="disabled">
            Destroy It
            <script type="dojo/method" data-dojo-event="onClick">
                dijit.byId("foob").setAttribute("disabled", false);
                this.setAttribute("disabled", true);
                dijit.byId("foobar").destroy(true);
            </script>
        </button>


  .. css ::

    @import "{{baseUrl}}dojox/image/resources/image.css";


See also
========

* :ref:`dojox.image.Magnifier <dojox/image/Magnifier>`
