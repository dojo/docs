#format dojo_rst

dojox.image.Gallery
===================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since 1.0

.. contents::
   :depth: 2


============
Introduction
============

dojox.image.Gallery is a widget that displays a series of thumbnail sized images, for quick browsing and selection, and a single large image. It provides a number of navigation controls for moving between images, and for playing an automated slideshow.

The Gallery works as a wrapper around two other widgets, dojox.image.ThumbnailPicker and dojox.image.SlideShow. It provides the following features:

    * A row of thumbnail sized images. Clicking on a thumbnail image shows a large version of that picture in the main image pane. Navigation controls are placed to the left and right of the thumbnails, to move between them.
    * A large image pane, displaying one image at a time. Navigation controls when the mouse pointer is over the image pane, allowing the user to move backwards and forwards between the images, and to start an automated slideshow. The size of the image pane is configurable using the imageWidth and imageHeight attributes.
    * Reads image data from an implementation of the dojo.data.api.Read interface. This means it is completely decoupled from any particular data source, and can be used with any data source at all as long as it is a valid dojo.data store. For example, the Gallery can display images based on data in a simple text file using dojo.data.ItemFileReadStore, can show Flickr images using dojox.data.FlickrRestStore, or images from Picasa Web Albums using dojox.data.PicasaStore.
    * Displays the title of each image, using a template that can be simply overridden.
    * Links an image to a URL, so that clicking the image navigates to a specified web address. This is optional.


=====
Usage
=====

Creating a Gallery and setting a simple data source

.. code-block :: javascript
 :linenos:

  <script type="text/javascript">
  //Define the attribute names used to access the items in the data store
  var itemNameMap = {imageThumbAttr: "thumb", imageLargeAttr: "large"};

  //Define the request, with no query, and a count of 20, so 20 items will be 
  //requested with each request
  var request = {query: {}, count: 20};
  dijit.byId('gallery1').setDataStore(imageItemStore, request, itemNameMap);
  </script>

  <div id="gallery1" dojoType="dojox.image.Gallery"></div>
  <div jsId="imageItemStore" dojoType="dojo.data.ItemFileReadStore" url="images.json"></div>


Creating a Gallery with a FlickrRestStore

.. code-block :: javascript
 :linenos:

  <script type="text/javascript">
  //Declare a FlickrRestStore data store.  This is used to access images from the 
  //Flickr (www.flickr.com) photo sharing website.
  var flickrRestStore = new dojox.data.FlickrRestStore();

  //Define the request, with a count of 20, so 20 items will be requested with 
  //each request. The query specifies information used to access Flickr, 
  //including a user ID (optional) and API key (required).  
  //You can also specify a sort order, tags to search for, and the matching 
  //mode for the tags, which can be "any" or "all", which equate to boolean "or" 
  //and a boolean "and" respectively
  var request = {
        query: {
            userid: "44153025@N00",//The Flickr user id to use
            apikey: "8c6803164dbc395fb7131c9d54843627",//An API key is required.
            sort: [{
                    descending: true //Use descending sort order, ascending is default.
                }
		],
                tags: ["superhorse", "redbones", "beachvolleyball","dublin","croatia"],
		tag_mode: "any" //Match any of the tags
         },
         count: 20
  };
  
  dijit.byId('gallery1').setDataStore(flickrRestStore, request, itemNameMap);
  </script>
  <div id="gallery1" dojoType="dojox.image.Gallery"></div>


Setting the image width and height

.. code-block :: javascript
 :linenos:

  <div id="gallery1" dojoType="dojox.image.Gallery" imageHeight="400" imageWidth="600"></div


Setting Page Size and AutoLoad

It is possible to define how many images are requested from the data store with each request.
This affects the performance. The larger the page size, the slower a request may be, but 
there will be fewer requests. The smaller the page size, the quicker a request may be, but
there will be more requests. It is specified by altering the pageSize attribute.

By default, the Gallery will preload one page of images at a time. This gives a better user
experience, as the user will have to wait less time to view an image. However, it may
download more images than the user wishes to view. The autoloading of images can be disabled
by setting the autoLoad attribute to "false". 



.. code-block :: javascript
 :linenos:

  <div id="gallery1" dojoType="dojox.image.Gallery" pageSize="50" autoLoad="false" ></div>

Changing the time interval in a SlideShow

The images in the large pane of the Gallery can be made to run a slide show by clicking 
its "Play" button. The amount of time between changing images can be configured by setting
the slideshowInterval attribute to the number of seconds required.


.. code-block :: javascript
 :linenos:   

  <div id="gallery1" dojoType="dojox.image.Gallery" slideshowInterval="5"></div>
