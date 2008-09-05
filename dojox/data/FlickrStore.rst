#format dojo_rst

dojo.data.FlickrStore
=====================

.. contents::
  :depth: 3

Dojo has several examples of browser in-memory stores, such as dojo.data.ItemFileReadStore, dojox.data.CsvStore, and dojox.data.OmplStore. While these stores are useful and great examples of how data stores can be used to wrapper accessing data, they are not the only way data is served and processed. In many cases, data stores can wrapper external services. It is those services that perform the querying and filtering of data, and then provide only that as a subset back to the data store for presentation as items.

FlickrStore is one such store. The purpose of FlickrStore is to wrapper the public photo feed of the Flickr service. Then by simply using the FlickrStore store, as you would any data store in Dojo, you now have access to querying the vast repository of public photos made available by others on the Web.

Note: While this store wraps making calls to the Flickr service, as a user, you should still verify that you agree to the terms and conditions by which you are using the public flickr photo service. Review their terms and conditions, and the API terms and conditions.

The Flickr service provides its data back in a wide variety of formats (for example, ATOM, RSS, and JSON) but FlickrStore only makes use of the JSON format. The following example shows a query that FlickrStore processes and the response:

Query (all pictures with tags animals, foxes, and cute):

.. code-block :: javascript
  
  http://api.flickr.com/services/feeds/photos_public.gne?tags=animals,bats,cute&format=json&tagmode=all
