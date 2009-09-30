#format dojo_rst

dojox.image.LightboxNano
========================

:Status: Draft
:Version: 1.0
:Project owner: Chris Barber
:Available: since V1.3

.. contents::
   :depth: 2

A simple "nano" version of the lightbox.

============
Introduction
============

The LightboxNano is a very lightweight lightbox which only displays a larger image. There is no support for a caption or description. The lightbox can be closed by clicking any where or pressing any key. It is not a dijit._Widget, but behaves similar to a dijit._Widget.

After the LightboxNano loads, it waits preloadDelay (default of 5000ms) before caching the larger image. When the user clicks the thumbnail image to launch the LightboxNano, hopefully the larger image will be downloaded and the animation will play smoothly. If the user clicks the thumbnail image before the larger version could be preloaded, a loading indicator is displayed prior to the animation beginning. Subsequent clicking of the larger image is instant since the larger image is already cached.

For being so small, it packs a handful of features:

* Automatically resizes large images to fit in browser window.
* Preloads the larger image to make loading faster.
* Keyboard accessible.
* Instantly makes your website awesome.

=====
Usage
=====

============  ======  ======================================================================
Parameter     Type    Description
============  ======  ======================================================================
href          String  URL to the large image to show in the lightbox.
duration      int     The delay in milliseconds of the LighboxNano open and close animation.
preloadDelay  int     The delay in milliseconds after the LightboxNano is created before preloading the larger image.
============  ======  ======================================================================

The LightboxNano is intended to be used on <a> and <img> tags. Upon creation, if the domNode is <img> tag, then it is wrapped in an <a> tag. It will also add two <div> tags inside the <a> tag: one to display a enlarge icon and another to show a loading icon. To style the enlarge icon and the loading icon, you need to create some CSS that looks like the following:

.. code-block :: css
 :linenos:

 a:hover .dojoxEnlarge {
     display: block !important;
 }
 .dojoxEnlarge {
     background: url(images/enlarge.png) no-repeat 0 0;
     top: -5px;
     left: -5px;
     margin: 0 !important;
     width: 16px;
     height: 16px;
 }
 .dojoxLoading {
     background: #333 url(images/loading-dark.gif) no-repeat center center;
     border-radius: 5px;
     -moz-border-radius: 5px;
     -webkit-border-radius: 5px;
     border: 2px solid #000;
     height: 24px;
     opacity: 0.8;
     filter: alpha(opacity=80);
     padding: 6px;
     width: 24px;
 }


========
Examples
========

Programmatic example
--------------------

Create the LightboxNano on an <img> element:

.. code-block :: javascript
  :linenos:

  <script src="/path/to/dojo.js" type="text/javascript"></script>
  <script type="text/javascript">
      dojo.require("dojox.image.LightboxNano");
    
      dojo.addOnLoad(function(){
          new LightboxNano({
              href: "/path/to/large/image.jpg"
          }, "myImg");
      });
  </script>
 
  <img id="myImg" src="/path/to/small/image.jpg">

Create the LightboxNano on an <a> element:

.. code-block :: javascript
  :linenos:

  <script src="/path/to/dojo.js" type="text/javascript"></script>
  <script type="text/javascript">
      dojo.require("dojox.image.LightboxNano");
    
      dojo.addOnLoad(function(){
          new LightboxNano({}, "myLink");
      });
  </script>
 
  <a id="myLink" href="/path/to/large/image.jpg">
      <img src="/path/to/small/image.jpg">
  </a>

Declarative example
-------------------

Standard way to declaratively create the LightboxNano

.. code-block :: javascript
 :linenos:
 
 <script src="/path/to/dojo.js" type="text/javascript"></script>
 <script type="text/javascript">
     dojo.require("dojo.parser");
     dojo.require("dojox.image.LightboxNano");
 </script>
 
 <a dojoType="dojox.image.LightboxNano" href="/path/to/large/image.jpg">
     <img src="/path/to/small/image.jpg">
 </a>

Should you want to destroy the LightboxNano, you'll need to use the jsid. You can view more info about using the jsid on http://dojocampus.org/content/2008/05/06/jsid-dijitbyid-and-dojobyid/.

.. code-block :: javascript
 :linenos:
 
 <script src="/path/to/dojo.js" type="text/javascript"></script>
 <script type="text/javascript">
     dojo.require("dojo.parser");
     dojo.require("dojox.image.LightboxNano");
 </script>
 
 <a dojoType="dojox.image.LightboxNano" jsid="myLightboxNano" href="/path/to/large/image.jpg">
     <img src="/path/to/small/image.jpg">
 </a>

 <button onclick="myLightboxNano.destroy();">Destroy the LightboxNano</button>

==========
File Sizes
==========

The LightboxNano is pretty small, but it relies on several other core Dojo components. If you do a custom Dojo build containing the LightboxNano and dojo.parser, the dojo.js is 96KB. If you enable HTTP compression on the web server, you can get that down to a nice 32KB.

===========
Limitations
===========

* The LightboxNano does not reposition itself when the browser window is resize or scrolled.
* In IE6, drop down select lists bleed through the LighboxNano layer. This can be fixed with an iframe shim. This was skipped to keep the size down and because we all want IE6 to just go away.

===================
Future Improvements
===================

There's always things that can be done to improve the LightboxNano. Here's a couple ideas and you're welcome to make suggestions in the comments.

* Add support for displaying a caption.
* Add support for dojox.embed to play Flash or Quicktime movies.

======================
Additional Information
======================

Further information can be found here: http://www.cb1inc.com/category/general/lightboxnano

The test file can be found here: http://www.cb1inc.com/dojo-1.2/dojox/image/tests/test_LightboxNano.html
