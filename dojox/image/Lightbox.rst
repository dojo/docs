#format dojo_rst

dojox.image.Lightbox
====================

:Status: Draft
:Version: 1.4
:Project owner: Peter Higgins
:Available: since V1.1

.. contents::
   :depth: 2

The Lightbox is a nice way to show images centered on the screen. It works in a variety of ways: programmatic, from dojo.data, or inline. The Lightbox is currently labeled *experimental*, and may change to become a more consistent API.

============
Introduction
============

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


=====
Usage
=====

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

With JavaScript disabled using this method, natural links well be followed, showing the Image directly. This will also occur if the user clicks on the link before the `parser <dojo/parser>`_ runs. 

A Lightbox instance has a .show() method, which tells the shared 'MasterDialog' to show a the image defined by the Lightbox that triggered the event.

.. code-block :: javascript

  dojo.addOnLoad(function(){
      // create and start the lightboxes:
      var lb = new dojox.image.Lightbox({ title:"One", group:"group2", href:"foo.png" });
      var lb2 = new dojox.image.Lightbox({ title:"Two", group:"group2", href:"bar.png" });
      lb.startup();
      lb2.startup();
      setTimeout(function(){
         lb.show();
      },2000);
  });

Here, the two images will be added in the same group, and the first image will be visible. Should you call lb2.show(), the same group of images would be displayed, though starting with the second.

**new in 1.4** is a modal:Boolean parameter, which will allow you to enable/disable the behavior where clicking on the underlay will hide the dialog.

==================
The LightboxDialog
==================

While the basic Lightbox works in simple cases and progressively, you may want to simply display arbitrary images. If there are existing Lightbox'es on a page, there will likely be a MasterDialog available to use, Or you can simply create one:

.. code-block :: javascript

  var dialog = new dojox.image.LightboxDialog({});
  dialog.startup();
  dialog.show({ title:"Some Image", href:"foo.png" });

With existing Lightbox instances on a page, you can show by reusing the shared dialog:

.. code-block :: javascript

  var dialog = dijit.byId("dojoxLightboxDialog"); 
  if(dialog && dialog.show){
     dialog.show({ title:"Some Image", href:"foo.png" });
  }

Additionally, you can add groups of images to a LightboxDialog, and show them as a group:

.. code-block :: javascript

  var dialog = dijit.byId("dojoxLightboxDialog");
  if(dialog){
    dialog.addImage({ title:"One", href:"foo.png" }, "group3");
    dialog.addImage{{ title:"Two", href:"bar.png" }, "group3");
    dialog.show({ group:"group3", href:"foo.png" });
  }

To close a dialog programatically, simply call .hide()

.. code-block :: javascript

  dijit.byId("dojoxLightboxDialog").hide();


=======================
Lightbox from dojo.data
=======================

``TODOC``


==================
Styling The Dialog
==================

LightboxDialog extends `dijit.Dialog <dijit/Dialog>`_, so the same 'rule' applies concerning the underlay. The Widget used to block the background page while the Dialog is visible receives an ``id`` based on the Dialog itself. For instance, the MasterDialog used has an id of ``dojoxLightboxDialog``, causing the underlay id to become ``dojoxLightboxDialog_underlay``. You can use plain CSS targeting that id:

.. code-block :: html

    <style type="text/css">
    #dojoxLightboxDialog_underlay { background-color:blue }
    </style>

The part ``_underlay`` is added to whatever id the LightboxDialog is created with, so if you create an additional LightboxDialog (not reusing the 'Master'), you can color it by using the id you define.


====
a11y
====

Lightbox and LightboxDialog are not fully accessible, though provide basic keyboard navigation. 

* Escape - close the dialog
* Right, Up - go to the next image in the group
* Left, Down - go to the previous image in the group


=============
Tips & Tricks
=============

By using a 'private' method, you can programatically control the LightboxDialog when displaying groups of images. The functions are named _nextImage(), and _prevImage(), though may later become public as .next() and .prev().  

.. code-block :: javascript

  setInterval(function(){
      // loop through the images  
      dijit.byId("dojoxLightboxDialog")._nextImage();
  }, 10000);
