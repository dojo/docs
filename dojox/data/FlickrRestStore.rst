#format dojo_rst

dojox.data.FlickrRestStore
==========================

.. contents::
  :depth: 3

FlickrRestStore is an implementation of the dojo.data API provides access to the Flickr photo sharing site's REST API. Many advanced features are available, including tag search, sorting on numerous attributes, full text search, support for simultaneous clients, result caching and more.

Dojo has several examples of browser in-memory stores, such as dojo.data.ItemFileReadStore, dojox.data.CsvStore, and dojox.data.OmplStore. While these stores are useful and great examples of how data stores can be used to wrapper accessing data, they are not the only way data is served and processed. In many cases, data stores can wrapper external services. It is those services that perform the querying and filtering of data, and then provide only that as a subset back to the data store for presentation as items.

FlickrRestStore is one such store. The purpose of FlickrRestStore is to wrapper the public photo feed of the Flickr service. Then by simply using the FlickrRestStore store, as you would any data store in Dojo, you now have access to querying the vast repository of public photos made available by others on the Web. Look at this `demo <http://archive.dojotoolkit.org/nightly/dojotoolkit/dojox/data/demos/demo_FlickrRestStore.html>`_ to see it in action, or look here for some example usages.

The following dojo.data APIs are implemented by FlickrRestStore

* `dojo.data.api.Read <dojo/data/api/Read>`_
 
FlickrRestStore is built upon `FlickrStore <dojox/data/FlickrStore>`_, a store which reads from Flickr's more simplistic public API. However, FlickrRestStore provides many more features:

========
Features
========

* Build on Flickr REST API. The Flickr REST API, a much more flexible API than the one used by FlickrStore. This opens up the possibility of having a very comprehensive data store that can have a very rich querying interface.
* Results caching. If a request is repeated, or a subset of one or more previous requests is requested, it is returned immediately.
* Supports multiple simultaneous clients. If an identical request is received before the first request has completed, a second remote request is not made. Instead, the second caller is notified when the first request completes. An example of this would be two widgets sharing the same FlickrRestStore, and individually paging through the photos.
* Result sorting. The available sort attributes are date-taken, date-published and interestingness. See the examples below for their usage.
* Full text search. The Flickr API supports full text searching, which you can do by passing a text parameter to the request query. See the examples below for its usage.
* Filter by Photo Set. By specifying a setid parameter on the query, you can retrieve photos only from a single set. Due to limitations of the Flickr API, using this parameter negates the use of the full text search.
* Tag search. Passing a tags parameter to the request query searches by the given tags. This parameter can be either a comma separated string, or an array of strings. See the examples below.

===========================
Flickr Terms and Conditions
===========================

Note: While this store wraps making calls to the Flickr service, as a user, you should still verify that you agree to the terms and conditions by which you are using the public Flickr photo service. Review their terms and conditions, and the API terms and conditions, `here <http://www.flickr.com/services/api/tos/>`_.

=======
API Key
=======

Another difference between FlickrRestStore and FlickrStore is that, due to the fact that FlickrRestStore works with the Flickr REST APIs, you will need to get a free API key from Flickr. You can do so at http://www.flickr.com/services/api/keys/apply/.

The Flickr service provides its data back in a wide variety of formats (for example, ATOM, RSS, and JSON) but FlickrRestStore only makes use of the JSON format. The following example shows a query that FlickrRestStore processes and the response:
Example

Query the first three photos from a user:

==================
Flickr API Example
==================

Query the first three photos from a user
----------------------------------------

**URL:** http://www.flickr.com/services/rest/?format=json&method=flickr.people.getPublicPhotos&api_key=8c6803164dbc395fb7131c9d54843627&user_id=44153025%40N00&per_page=3

**Response:**

.. code-block :: javascript

  jsonFlickrApi({
    "photos":{
      "page":1, 
      "pages":98, 
      "perpage":3,
      "total":"489", 
      "photo":[
         {
           "id":"1352049918", 
           "owner":"44153025@N00", 
           "secret":"5636009306", 
           "server":"1111", 
           "farm":2, 
           "title":"The Liffey Panorama", 
           "ispublic":1, 
           "isfriend":0, 
           "isfamily":0
         }, 
         {
           "id":"1351120079", 
           "owner":"44153025@N00", 
           "secret":"880bf6a003", 
           "server":"1027", 
           "farm":2, 
           "title":"Many Hands make pretty flowers", 
           "ispublic":1, 
           "isfriend":0, 
           "isfamily":0
         }, 
         {
           "id":"1322051485", 
           "owner":"44153025@N00", 
           "secret":"b7c529335d", 
           "server":"1110", 
           "farm":2, 
           "title":"Wok'n'Roll baby!", 
           "ispublic":1, 
           "isfriend":0, 
           "isfamily":0
         }
       ]
    }, 
    "stat":"ok"}
  )

FlickrRestStore's role is to process the query parameters passed to the dojo.data.api.Read API and generate the appropriate service URL. It then processes the response from the service and handles accessing the items returned from the query. It also provides simple attribute access to all the values.

======================
Constructor Parameters
======================

+---------------------------+--------------------------------------------------------------------+---------------------+
|**Attribute**              |**Description**                                                     |Since                |
+---------------------------+--------------------------------------------------------------------+---------------------+
|label                      |The item attribute to use as the label of the Flickr item.          |Dojo 1.1             |
|                           |Defaults to 'title'                                                 |                     |
+---------------------------+--------------------------------------------------------------------+---------------------+
|urlPreventCache            |Flag controlling whether preventCache of dojo.io.script is used to  |Dojo 1.4             |
|                           |prevent browser caching.  Default is true.                          |                     |
+---------------------------+--------------------------------------------------------------------+---------------------+
|apiKey                     |Your Flickr service API key.                                        |Dojo 1.1             |
+---------------------------+--------------------------------------------------------------------+---------------------+



===============
Item Attributes
===============

+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| title         |The title of the photo.                                                                                                      |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| author        |The person who published the photo to Flickr.                                                                                |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| dateTaken     |A JavaScript date object representing the date the photo was taken.                                                          |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| datePublished |A JavaScript date object representing the date the photo was published to Flickr.                                            |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| imageUrl      |A URL to the full resolution photo image.                                                                                    |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| imageUrlSmall |A URL to the small (icon sized) resolution photo image.                                                                      |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| imageUrlMedium|A URL to the mid resolution photo image.                                                                                     |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| imageUrlThumb |A URL to the thumbnail sized resolution photo image.                                                                         |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| link          |A URL linking to the Flickr page displaying the image.                                                                       |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+

============
Query Syntax
============

The fetch method query syntax for FlickrRestStore is simple and straightforward. It allows the following attributes to be set and queried against:

userid
    A Flickr userid to use to narrow the search scope, e.g. '44153025@N00'. This is required.
apikey
    A Flickr API key. Flickr requires clients of their REST APIs to register for an API key. This is free, and can be done at http://www.flickr.com/services/api/keys/apply/. Note: do not reuse the API key used in Dojo examples, register your own. This is required.
setid
  The id of a photo set to use to narrow the result data. This is optional. If not specified,
  photos from the users primary stream are returned.
page
  Specifies the page of results to use. If not used, then the standard start parameter is used. This is optional.
lang
  Specifies the language to return the results in. This is optional.
tags
  Specifies the tags to search for. This can be either a comma separated list, or an array of strings. This is optional.
text
  The text to use in a full text search. This matches any text in the title or description of a photo. This is optional.
sort
  The order to sort the results in. This is a JSON object with two fields, as specified by the dojo.data API.

  * attribute: This specifies the name of the attribute to sort on. The supported attribute names are

    * date-posted

    * date-taken

    * interestingness

  If an attribute is not specified, the default is date-posted  

  * descending: If set to true, the photos are sorted in descending order. If set to false, or not specified, the photos are sorted in ascending order.

**Note:** Unlike many of the other example stores, the FlickrRestStore store cannot do wild-card matching of the attributes. This is because the Flickr public photo feed service cannot do it. In an ideal service implementation, the Flickr service would provide a mechanism by with to pass in wild cards as part of its query parameters. 

==============
Usage Examples
==============

Listing nature pictures
-----------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.data.FlickrRestStore");
      dojo.require("dijit.form.Button");

      //This function performs some basic dojo initialization. In this case it connects the button
      //onClick to a function which invokes the fetch(). The fetch function queries for all items 
      //and provides callbacks to use for completion of data retrieval or reporting of errors.
      function init () {
         //Function to perform a fetch on the datastore when a button is clicked
         function getAllItems () {

           //Callback to perform an action when the data items are starting to be returned:
           function clearOldList(size, request) {
             var list = dojo.byId("list");
             if (list) { 
               while (list.firstChild) {
                 list.removeChild(list.firstChild);
               }
             }
           }
  
           //Callback for processing a returned list of items.
           function gotItems(items, request) {
             var list = dojo.byId("list");
             if (list) { 
               var i;
               for (i = 0; i < items.length; i++) {
                 var item = items[i];
                 var image = document.createElement("img");
                 list.appendChild(image);
                 image.setAttribute("src", flickrStore.getValue(item, "imageUrlMedium"));
                 list.appendChild(document.createElement("br"));
               }
             }
           }
          
           //Callback for if the lookup fails.
           function fetchFailed(error, request) {
             alert("lookup failed.");
           }
             
           //Fetch the images. Note the API key used is not for general usage. It's here to demo the store, ONLY.
           flickrStore.fetch({query:{ tags: "nature", apikey: "8c6803164dbc395fb7131c9d54843627"}, onBegin: clearOldList, onComplete: gotItems, onError: fetchFailed});
         }
         //Link the click event of the button to driving the fetch.
         dojo.connect(button, "onClick", getAllItems);
      }
      //Set the init function to run when dojo loading and page parsing has completed.
      dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <div dojoType="dojox.data.FlickrRestStore" jsId="flickrStore"></div>
    <div dojoType="dijit.form.Button" jsId="button">Find nature pictures!</div>
    <br>
    <br>
    <span id="list">
    </span>
