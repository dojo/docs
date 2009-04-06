#format dojo_rst

dojox.image.ThumbnailPicker
===========================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since 1.0

.. contents::
   :depth: 2

A `dojo.data-powered <dojo/data>`_ ThumbnailPicker.


============
Introduction
============


The ThumbnailPicker is a widget that displays a series of images either horizontally or vertically, with controls to page through the images. It reads its image data from data stores, that is, implementations of the dojo.data.api.Read API.

When an image is clicked by the user, information regarding that image is published to a dojo topic, which can be used to integrate the ThumbnailPicker with other objects on the page.

The ThumbnailPicker can be configured in a number of ways:

    * Number of visible images
    * Data source
    * Can be horizontal or vertical
    * Enabling/disabling following hyperlinks when an image is selected
    * Notification of load status for images 

========
Examples
========

Number of Visible Images
------------------------

To set the number of visible images, and thereby the width or height of horizontal and vertical widgets respectively,
set the <b>numberThumbs</b> attribute, e.g.


.. code-block :: javascript
 :linenos:
 
  <div dojoType="dojox.image.ThumbnailPicker" id="picker1" numberThumbs="4"> </div>



Setting the Data Source
-----------------------

To set the data source for the ThumnailPicker widget, first create one of the available data stores, such 
as the dojo.data.ItemFileReadStore or dojox.data.FlickrRestStore. Next, create a request object, which 
optionally contains a query. e.g.

.. code-block :: javascript
 :linenos:
 
  <div dojoType="dojox.image.ThumbnailPicker" id="picker1" > </div>
  <div jsId="imageItemStore" dojoType="dojo.data.ItemFileReadStore" url="images.json"></div>
  <script type="text/javascript">
     dojo.addOnLoad(function() {
     //Define the request, saying that 20 records should be fetched at a time, 
     //and to start at record 0
     
     var request= {count:20, start:0};
     //Tell the widget to request the "thumb" parameter, as different 
     //stores may use different parameter names
     var itemNameMap = {imageThumbAttr: "thumb"};

     dijit.byId('picker1').setDataStore(imageItemStore, request, itemNameMap);
   });

  </script>


Using a Vertical Layout
-----------------------

To make the ThumbnailPicker display itself vertically, set the isHorizontal attribute to "false". To leave it as
horizontal, either omit the isHorizontal attribute, or set it to "true", e.g.


.. code-block :: javascript
 :linenos:

  <div dojoType="dojox.image.ThumbnailPicker" id="picker1" isHorizontal="false"> </div>


Enabling/disabling following hyperlinks
---------------------------------------

To enable following a hyperlink when a thumbnail image is clicked, set the useHyperlink attribute to "true".
By default it is false. When hyperlinks are enabled, by default the URL is opened is a new window. To open 
the link in the current window, set the hyperlinkTarget attribute to "this". e.g.


.. code-block :: javascript
 :linenos:

  <div dojoType="dojox.image.ThumbnailPicker" id="picker1" useHyperlink="true" hyperlinkTarget="this"> </div>

Notification of load status for images
--------------------------------------

The ThumbnailPicker can display a notification for each image stating whether another version of it has loaded
or not, for example when it is combined with the dojox.image.Slideshow widget. When this is enabled, the
ThumbnailPicker relies on other code calling it's markImageLoaded method to change the notification from
its loading state to loaded state.

To enable the load state notifier, set the useLoadNotifier to "true". By default, it is disabled, since it only
really makes sense to use it in combination with other widgets or elements on a page. e.g.


.. code-block :: javascript
 :linenos:

  <div dojoType="dojox.image.ThumbnailPicker" id="picker1" useLoadNotifier="true"> </div>


Full Example
------------

This example will put a horizontal and a vertical dojox.image.ThumbnailPicker widget on a page, with a variety
of settings, and using separate data stores.



.. code-block :: javascript
 :linenos:

        function initFlickrWidget() {
         //Create a new FlickrRestStore
         var flickrRestStore = new dojox.data.FlickrRestStore();
         
         //Create a request object, containing a query with the 
         //userid, apikey and (optional) sort data.
         //Extra query parameters 'tags' and 'tag_mode' are also 
         //used to further filter the results
         var req = {
             query: {
                 userid: "44153025@N00",//The Flickr user id to use
                 apikey: "8c6803164dbc395fb7131c9d54843627",//An API key is required.
                 sort: [
                       {
                           descending: true //Use descending sort order, ascending is default.
                       }
                       ],
                 tags: ["superhorse", "redbones", "beachvolleyball","dublin","croatia"],
                 tag_mode: "any" //Match any of the tags
             },
             start: 0, //start at record 0
             count: 20 //request 20 records each time a request is made
         };
         
         //Set the flickr data store on two of the dojox.image.ThumbnailPicker widgets
         dijit.byId('thumbPicker1').setDataStore(flickrRestStore, req);
     }

     /*
       Initializes the second ThumbnailPicker widget with a data store that
       reads information from a JSON URL.  This also tells the ThumbnailPicker
       the name of the JSON attributes to read from each data item retrieved
       from the JSON URL.
     */
     function initItemStoreWidget(){
         var itemRequest = {
             query: {},
             count: 20
         };
         var itemNameMap = {
             imageThumbAttr: "thumb",
             imageLargeAttr: "large"
         };
         
         //Set the dojo.data.ItemFileReadStore on two of the dojox.image.ThumbnailPicker widgets
         //Note the use of the 'itemNameMap', which tells the widget what attributes to
         //read from the store.  Look in the 'images.json' file in the same folder as this
         //file to see the data being read by the widget.
         dijit.byId('thumbPicker2').setDataStore(imageItemStore, itemRequest, itemNameMap);
     }

     //Subscribe to clicks on the thumbnails, and print out the information provided
     function doSubscribe(){
         function updateDiv(packet){
             alert("You selected the thumbnail:"
                   + "Index: " + packet.index
                   + "Url: " + packet.url
                   + "Large Url: " + packet.largeUrl
                   + "Title: " + packet.title
                   + "Link: " + packet.link)
             ;
         }
         
         //When an image in the ThumbnailPicker is clicked on, it publishes
         //information on the image to a topic, whose name is found by calling
         //the 'getClickTopicName' function on the widget.
         dojo.subscribe(dijit.byId('thumbPicker1').getClickTopicName(), updateDiv);
         dojo.subscribe(dijit.byId('thumbPicker2').getClickTopicName(), updateDiv);
     }



     dojo.addOnLoad(initFlickrWidget);
     dojo.addOnLoad(initItemStoreWidget);
     dojo.addOnLoad(doSubscribe);
     </script>
     </head>
     <body>
     <h2>From FlickrRestStore:</h2>
     This ThumbnailPicker should have 8 thumbnails, witheach of them linking
     to a URL when clicked on, changing the current page.  The cursor should also change when over an image.
     The widget is laid out in the default horizontal layout.
     <div id="thumbPicker1" dojoType="dojox.image.ThumbnailPicker" numberThumbs="8" useHyperlink="true" 
     hyperlinkTarget="this"></div>

     <h2>From ItemFileReadStore:</h2>
     This ThumbnailPicker should have 5 thumbnails. Clicking on a thumbnail should NOT
     open a URL, and the cursor should not change when over an image that is not an arrow.
     The widget is laid out in a vertical layout.

     <div id="thumbPicker2" dojoType="dojox.image.ThumbnailPicker" numberThumbs="5" isClickable="false"
     isHorizontal="false"></div>
                  
     Create an ItemFileReadStore that reads data from the file "images.json".  This is used by the ThumbnailPicker "thumbPicker2"
     <div jsId="imageItemStore" dojoType="dojo.data.ItemFileReadStore" url="images.json"></div>

     </body>
     </html>

 
========
See also
========

* http://archive.dojotoolkit.org/nightly/dojotoolkit/dojox/image/tests/test_ThumbnailPicker.html
