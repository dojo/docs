#format dojo_rst

dojo.data.PicasaStore
=====================

.. contents::
  :depth: 3

Dojo has several examples of browser in-memory stores, such as `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_, `dojox.data.CsvStore <dojox/data/CsvStore>`_, and `dojox.data.OpmlStore <dojox/data/OpmlStore>`_. While these stores are useful and great examples of how data stores can be used to wrapper accessing data, they are not the only way data is served and processed. In many cases, data stores can wrapper external services. It is those services that perform the querying and filtering of data, and then provide only that as a subset back to the data store for presentation as items.

PicasaStore is one such store. The purpose of PicasaStore is to wrapper the public photo feed of the Picasa service. Then by simply using the PicasaStore store, as you would any data store in Dojo, you now have access to querying the vast repository of public photos made available by others on the Web.

**Note: While this store wraps making calls to the Picasa service, as a user, you should still verify that you agree to the terms and conditions by which you are using the public picasa photo service. Review their terms and conditions, and the API terms and conditions.**

The Picasa service provides its data back in a wide variety of formats (for example, ATOM, RSS, and JSON) but PicasaStore only makes use of the JSON format. The following example shows a query that PicasaStore processes and the response:

=============================
Brief intro to the Picasa API
=============================

Query
-----

Query (all pictures with tags animals, foxes, and cute):

.. code-block :: javascript
  
  http://picasaweb.google.com/data/feed/api/all?alt=jsonm&pp=1&psc=G&start-index=1&q=animals%2Cfoxes%2Ccute&max-results=5&callback=dojo.io.script.jsonp_dojoIoScript2._jsonpCallback

Response
--------

.. code-block :: javascript 

  jsonPicasaFeed({
		"title": "Photos from everyone tagged animals, foxes and cute",
		"link": "http://www.flickr.com/photos/",
		"description": "",
		"modified": "2007-05-24T09:35:27Z",
		"generator": "http://www.flickr.com/",
		"items": [
	   {
			"title": "Ceramic Figures",
			"link": "http://www.flickr.com/photos/36362445@N00/511998141/",
			"media": {"m":"http://farm1.static.flickr.com/228/511998141_7b8398c3eb_m.jpg"},
			"date_taken": "2006-04-04T10:21:43-08:00",
			"description": "<p><a href="http://www.flickr.com/people/36362445@N00/">travellingcharl</a> posted a photo:</p> <p><a href="http://www.flickr.com/photos/36362445@N00/511998141/" title="Ceramic Figures"><img src="http://farm1.static.flickr.com/228/511998141_7b8398c3eb_m.jpg" width="240" height="180" alt="Ceramic Figures" /></a></p> <p>Ceramic figurines inside the Shinto shrine.</p>",
			"published": "2007-05-24T09:35:27Z",
			"author": "nobody@flickr.com (travellingcharl)",
			"tags": "cute animals japan ceramic geocaching coins toyko foxes naritatbstation3"
	   },
	   {
			"title": "Red Fox pup",
			"link": "http://www.flickr.com/photos/norwick/301289990/",
			"media": {"m":"http://farm1.static.flickr.com/104/301289990_da7413890b_m.jpg"},
			"date_taken": "2005-06-09T16:17:49-08:00",
			"description": "<p><a href="http://www.flickr.com/people/norwick/">bluebird's</a> posted a photo:</p> <p><a href="http://www.flickr.com/photos/norwick/301289990/" title="Red Fox pup"><img src="http://farm1.static.flickr.com/104/301289990_da7413890b_m.jpg" width="240" height="180" alt="Red Fox pup" /></a></p> <p>Are you sure it's save to come out!</p>",
			"published": "2006-11-19T22:14:47Z",
			"author": "nobody@flickr.com (bluebird's)",
			"tags": "wild summer canada cute nature beauty field animals landscape tiere scenery jung wilde sommer wildlife natur young feld felder adorable peaceful canadian alberta summertime prairie aussicht prairies landschaft foxes alert tier countrylife predators kanada redfox perky okotoks junger rotfuchs kanadische foxpups roterfuchs"
	   }
        ]
  })

===========
PicasaStore
===========

PicasaStore's role is to process the query parameters passed to the dojo.data.api.Read API and generate the appropriate service URL. It then processes the response from the service and handles accessing the items returned from the query. It also provides simple attribute access to all the values.

Constructor Parameters
----------------------

+---------------------------+--------------------------------------------------------------------+---------------------+
|**Attribute**              |**Description**                                                     |Since                |
+---------------------------+--------------------------------------------------------------------+---------------------+
|label                      |The item attribute to use as the label of the Picasa item.          |Dojo 1.1             |
|                           |Defaults to 'title'                                                 |                     |
+---------------------------+--------------------------------------------------------------------+---------------------+
|urlPreventCache            |Flag controlling whether preventCache of dojo.io.script is used to  |Dojo 1.4             |
|                           |prevent browser caching.  Default is true.                          |                     |
+---------------------------+--------------------------------------------------------------------+---------------------+

Item Attributes
---------------
All items returned from PicasaStore have the following attributes that can be accessed using the dojo.data.api.Read API to retrieve data about the item:

+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| title         |The title of the photo.                                                                                                      |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| author        |The person who published the photo to Picasa.                                                                                |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| description   |A description of the photo. This will generally contain HTML formatted text.                                                 |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| dateTaken     |A JavaScript date object representing the date the photo was taken.                                                          |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| datePublished |A JavaScript date object representing the date the photo was published to Picasa.                                            |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| tags          |The tags that are assigned to this photo. flickrStore.getValue(item, "tags") returns the first tag,                          |
|               |flickrStore.getValues(item, "tags") returns all tags.                                                                        |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| imageUrl      |A URL to the full resolution photo image.                                                                                    |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| imageUrlSmall |A URL to the small (icon sized) resolution photo image.                                                                      |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| imageUrlMedium|A URL to the mid resolution photo image.                                                                                     |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| link          |A URL linking to the Picasa page displaying the image.                                                                       |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+

Query Syntax
------------

The fetch method query syntax for PicasaStore is simple and straightforward. It allows the following attributes to be queried against:

+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| id            |Picasa userid to use to narrow the search scope. This is optional.                                                           |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| ids           |A comma separated list of IDs used to narrow search scope. This is optional.                                                 |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| tags          |A comma separated list of tags to search for matches on. This is optional.                                                   |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| tagmode       |Indicates whether all tags must match from the list or any can match from the list. Valid values are all or any and the      |
|               |default is any.                                                                                                              |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| lang          |Specifies the language to return the results in. This is optional.                                                           |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+

**Note:** Unlike all the other example stores, the PicasaStore store cannot do wild-card matching of the attributes. This is because the Picasa public photo feed service cannot do it. In an ideal service implementation, the Picasa service would provide a mechanism by with to pass in wild cards as part of its query parameters. Also, the Picasa public feed API limits the number of returned photos to a maximum of twenty.

========
Examples
========

Sample 1:  Listing nature pictures
----------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.data.PicasaStore");
      dojo.require("dijit.form.Button");

      //This function performs some basic dojo initialization.  In this case it connects the button
      //onClick to a function which invokes the fetch().  The fetch function queries for all items 
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
             
           //Fetch the images.  
           flickrStore.fetch({query:{ tags: "nature"}, onBegin: clearOldList, onComplete: gotItems, onError: fetchFailed});
         }
         //Link the click event of the button to driving the fetch.
         dojo.connect(button, "onClick", getAllItems);
      }
      //Set the init function to run when dojo loading and page parsing has completed.
      dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <div dojoType="dojox.data.PicasaStore" jsId="flickrStore"></div>
    <div dojoType="dijit.form.Button" jsId="button">Find nature pictures!</div>
    <br>
    <br>
    <span id="list">
    </span>
