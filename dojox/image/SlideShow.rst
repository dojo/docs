#format dojo_rst

dojox.image.SlideShow
=====================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

============
Introduction
============

The dojox.image.SlideShow widget displays a series of images, one at a time. It provides controls to move from image to the next or the previous image. It can also run an automated slideshow, moving from one image to the next every specified number of seconds.
Features

The Slideshow widget has the following features.

    * Displays a single image at a time
    * Provides navigation controls to move between images, and to start/stop the automated slideshow.
    * Can optionally pre-load images in the background so that there is no visible delay when viewing images. While this uses more bandwidth, it provides a far better user experience.
    * Links an image to a URL, so that clicking the image navigates to a specified web address. This is optional.
    * Reads image data from an implementation of the dojo.data.api.Read interface. This means it is completely decoupled from any particular data source, and can be used with any data source at all as long as it is a valid dojo.data store. For example, the Slideshow can display images based on data in a simple text file using dojo.data.ItemFileReadStore, can show Flickr images using dojox.data.FlickrRestStore, or images from Picasa Web Albums using dojox.data.PicasaStore.
    * Displays the title of each image, using a template that can be simply overridden.


========
Examples
========


Setting the Display Interval
----------------------------

It is possible to define the number of seconds between image transitions when running an automated slideshow. To do this,
set the slideshowInterval attribute. For example, to set a three second interval between changing the displayed image, 
use the code below

.. code-block :: javascript
 :linenos:

  <div dojoType="dojox.image.SlideShow" id="slideshow1" slideshowInterval="3"> </div>


Overriding the Title Template
-----------------------------

The Slideshow widget has a default title template that is used to display the title of the current image, as well as it's relative position. To override the title template, set the titleTemplate attribute. The supported place holders are :

    * **@title** - The title of the image is placed here
    * **@current** - The current index of the image is placed here
    * **@total** - The total number of images is placed here.

For example:


.. code-block :: javascript
 :linenos:
 
  <div dojoType="dojox.image.SlideShow" id="slideshow1" 
     titleTemplate="My title is '@title', this is image @current out of @total">
  </div>


Setting the Maximum Image Dimensions
------------------------------------

To override the default height and width of the widget, set the imageHeight and imageWidth attributes. 
Images are automatically scaled to fit either the max height or width, depending on which of their 
dimensions is greater. 



.. code-block :: javascript
 :linenos:
 
  <div dojoType="dojox.image.SlideShow" id="slideshow1" 
     imageWidth="600" imageHeight="300">
  </div>


Disabling the AutoLoad
----------------------

The Slideshow widget automatically preloads a number of images in the background. While this generally provides a
better user experience, it uses more bandwidth, so some users may want to disable it. To do so, set the autoLoad
parameter to "false". e.g.

.. code-block :: javascript
 :linenos:

  <div dojoType="dojox.image.SlideShow" id="slideshow1" autoLoad="false">
  </div>


This causes a delay when the user attempts to view an image, since it must wait to be loaded.

Disabling Resizing to Fit the Image
-----------------------------------

By default, if an image is less tall than the Slideshow widget, the widget resizes itself to fit to the
image. In some circumstances this may be undesirable, such as when using an inflexible, fixed page
layout. To disable this resizing behavior, set the fixedHeight attribute to "true", e.g.

.. code-block :: javascript
 :linenos:
 
   <div dojoType="dojox.image.SlideShow" id="slideshow1" fixedHeight="true">
   </div>


Setting the Data Store on the Slideshow
---------------------------------------

The Slideshow widget reads the image information from dojo.data objects. To set the data source for the Slideshow
widget, first create one of the available data stores, such as the dojo.data.ItemFileReadStore or 
dojox.data.FlickrRestStore. Next, create a request object, which optionally contains a query.

.. code-block :: javascript
 :linenos:
 
   <div dojoType="dojox.image.SlideShow" id="slideshow1" > </div>
   <div jsId="imageItemStore" dojoType="dojo.data.ItemFileReadStore" url="images.json"></div>
   <script type="text/javascript">
      dojo.addOnLoad(function() {
         //Define the request, saying that 20 records should be fetched at a time, 
         //and to start at record 0
      var request= {count:20, start:0};

      //Tell the widget to request the "large" parameter, as different 
      //stores may use different parameter names
      var itemNameMap = {imageLargeAttr: "large"};

      //Call the setDataStore function, passing it the data store, the request object, 
      //and the name map.
      dijit.byId('slideshow1').setDataStore(imageItemStore, request, itemNameMap);
   });

   </script>


Subscribing to Slideshow Events
-------------------------------

The Slideshow publishes information about its state, that can be subscribed to using Dojo's Publish/Subscribe system. Two pieces of information are published to a named topic:

* Current image - whenever the displayed image changes, a JSON object with the following attributes:

  +-----------------+------------------------------------------------------------------------------------+
  | **Attribute**   | **Description**                                                                    |
  +-----------------+------------------------------------------------------------------------------------+
  | **index**       | The current numeric index of the image, that is, it's index in the data store      |
  +-----------------+------------------------------------------------------------------------------------+
  | **title**       | The string title of the image, if any.                                             |
  +-----------------+------------------------------------------------------------------------------------+
  | **url**         | The URL of the image                                                               |
  +-----------------+------------------------------------------------------------------------------------+
          
The name of the topic is retrieved by calling the getShowTopicName method on the widget

.. code-block :: javascript
 :linenos:

  dojo.subscribe(
     dijit.byId('slideshow1').getShowTopicName(), 
     function(packet) {
     alert("Got index: " + packet.index 
           + ", url: " + packet.url 
           + ", and title: " + packet.title);
  });


* Loaded Image - when an image finishes loading, whether in the background, or the currently displayed image, information is published about it. The name of the topic is retrieved by calling the getLoadTopicName on the widget. A Number is published, which is the index of the image in the data store.


.. code-block :: javascript
 :linenos:

  dojo.subscribe(
     dijit.byId('slideshow1').getLoadTopicName(), 
     function(index) {
        alert("Got index: " +index);
  });


.. cv-compound::

  .. cv:: javascript

  	<script type="text/javascript">
		dojo.require("dojox.image.SlideShow");
		dojo.require("dojox.data.FlickrRestStore");		
			
		dojo.addOnLoad(function(){		
			
			//INitialize the store with a FlickrRestStore
			var flickrRestStore = new dojox.data.FlickrRestStore();
			var req = {
				query: {
					userid: "44153025@N00",
					apikey: "8c6803164dbc395fb7131c9d54843627"
				},
				count: 20
			};
			dijit.byId('slideshow2').setDataStore(flickrRestStore, req);
		});
			
	</script>

  .. cv:: html

    <h2>from dojox.data.FlickrRestStore</h2>
    This SlideShow should display five photos, and not loop. It should also not
    open a URL when the image is clicked.  AutoLoading of images is also disabled.
    The time between images in a SlideShow is 1 second.  The widget should not resize to fit the image
    <div id="slideshow2" dojoType="dojox.image.SlideShow" noLink="true" loop="false" autoLoad="false" slideshowInterval="1" fixedHeight="true"> </div>

  .. cv:: css
	
   @import "moin_static163/js/dojo/trunk/release/dojo/dijit/themes/tundra/tundra.css";
   @import "moin_static163/js/dojo/trunk/release/dojo/dojox/image/resources/image.css";




==========
See Also
==========
For a full example of the Slideshow, see the test file at
http://archive.dojotoolkit.org/nightly/dojotoolkit/dojox/image/tests/tes...
