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

The most basic application of a Lightbox is to convert links containing ``title`` and ``href`` attributes into a widget, preserving the Dom structure and adding basic click-handling to the links. The Link content can be anything: text, images, etc, so the styling is up to you:

.. codeviewer::
  
  <style type="text/css">
    @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/image/resources/Lightbox.css"; 
  </style>
  <script type="text/javascript">
    dojo.require("dojox.image.Lightbox");
  </script>

  <div id="lb-one">
     <a dojoType="dojox.image.Lightbox" title="foo" href="foo.png">Show Foo</a> 
     <a dojoType="dojox.image.Lightbox" title="bar" href="bar.png">Show Bar</a> 
  </div>

You'll notice Lightbox's built in 404-handling, displaying a warning icon for images which fail to load. 

Any dojox.image.Lightbox-es on the same page share an instance of a dojox.image.LightboxDialog (in versions prior to 1.2, LightboxDialog was named _LightboxDialog. It was made public for 1.2). This allows for easy grouping. Simply add a group attribute to your Lightbox instances, and they will appear in the lightbox, and enable keyboard and icon navigation through the group:

.. codeviewer::
  
  <div id="lb-one">
     <a dojoType="dojox.image.Lightbox" group="grouped" title="foo" href="foo.png">Show Foo</a> 
     <a dojoType="dojox.image.Lightbox" group="grouped" title="bar" href="bar.png">Show Bar</a> 
  </div>


