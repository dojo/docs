#format dojo_rst

dojox.image.Lightbox
====================

The Lightbox is a nice way to show images centered on the screen. It works in a variety of ways: programmatic, from dojo.data, or inline.

Being a subclass of dijit.Dialog, you will need to include the relevant dijit-css, and the Lightbox CSS. For example:

.. code-block :: html

    <style type="text/css">
     @import "/moin_static163/js/dojo/trunk/release/dojo/dijit/themes/tundra/tundra.css";
     @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/image/resources/Lightbox.css";
    </style>
    <body class="tundra">
        ...
    </body>

All the rules for Lightbox are located in ``Lightbox.css``

You also need to require the Lightbox module:

.. code-block :: javascript

  dojo.require("dojox.image.Lightbox");

This provides both Lightbox and LightboxDialog, the latter being the widget to actually *display* the image, the former being a lightweight wrapper for anchor tags, converting links into Lightboxes progressively. 

Using Lightbox
--------------

.. codeviewer::
  
  <style type="text/css">
    @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/image/resources/Lightbox.css"; 
  </style>
  <script type="text/javascript">
    dojo.require("dojox.image.Lightbox");
    dojo.addOnLoad(function(){
        dojo.query("a[rel^='lightbox']").instantiate(dojox.image.Lightbox);
    });
  </script>

  <div id="lb-one">
     <a rel="lightbox" href="foo.png"><img src="foo.png"></a> <a rel="lightbox" href="bar.png"><img src="bar.png"></a> 
  </div>
