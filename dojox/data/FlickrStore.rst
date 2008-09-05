#format dojo_rst

dojo.data.FlickrStore
=====================

.. contents::
  :depth: 3

Dojo has several examples of browser in-memory stores, such as `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_, `dojox.data.CsvStore <dojox/data/CsvStore>`_, and `dojox.data.OmplStore <dojox/data/OpmlStore>`_. While these stores are useful and great examples of how data stores can be used to wrapper accessing data, they are not the only way data is served and processed. In many cases, data stores can wrapper external services. It is those services that perform the querying and filtering of data, and then provide only that as a subset back to the data store for presentation as items.

FlickrStore is one such store. The purpose of FlickrStore is to wrapper the public photo feed of the Flickr service. Then by simply using the FlickrStore store, as you would any data store in Dojo, you now have access to querying the vast repository of public photos made available by others on the Web.

Note: While this store wraps making calls to the Flickr service, as a user, you should still verify that you agree to the terms and conditions by which you are using the public flickr photo service. Review their terms and conditions, and the API terms and conditions.

The Flickr service provides its data back in a wide variety of formats (for example, ATOM, RSS, and JSON) but FlickrStore only makes use of the JSON format. The following example shows a query that FlickrStore processes and the response:

=============================
Brief intro to the Flickr API
=============================

Query
-----

Query (all pictures with tags animals, foxes, and cute):

.. code-block :: javascript
  
  http://api.flickr.com/services/feeds/photos_public.gne?tags=animals,bats,cute&format=json&tagmode=all

Response
--------

.. code-block :: javascript 

  jsonFlickrFeed({
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
FlickrStore
===========

FlickrStore's role is to process the query parameters passed to the dojo.data.api.Read API and generate the appropriate service URL. It then processes the response from the service and handles accessing the items returned from the query. It also provides simple attribute access to all the values.

Constructor Parameters
----------------------
  FlickrStore does not have any constructor parameters.

Item Attributes
---------------
All items returned from FlickrStore have the following attributes that can be accessed using the dojo.data.api.Read API to retrieve data about the item:

+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| title         |The title of the photo.                                                                                                      |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| author        |The person who published the photo to Flickr.                                                                                |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| description   |A description of the photo. This will generally contain HTML formatted text.                                                 |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| dateTaken     |A JavaScript date object representing the date the photo was taken.                                                          |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| datePublished |A JavaScript date object representing the date the photo was published to Flickr.                                            |
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
| link          |A URL linking to the Flickr page displaying the image.                                                                       |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+

Query Syntax
------------

The fetch method query syntax for FlickrStore is simple and straightforward. It allows the following attributes to be queried against:

+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| id            |Flickr userid to use to narrow the search scope. This is optional.                                                           |
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

**Note:** Unlike all the other example stores, the FlickrStore store cannot do wild-card matching of the attributes. This is because the Flickr public photo feed service cannot do it. In an ideal service implementation, the Flickr service would provide a mechanism by with to pass in wild cards as part of its query parameters. Also, the Flickr public feed API limits the number of returned photos to a maximum of twenty.
