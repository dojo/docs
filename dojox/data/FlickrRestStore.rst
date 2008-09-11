#format dojo_rst

dojox.data.FlickrRestStore
==========================

.. contents::
  :depth: 3

FlickrRestStore is an implementation of the dojo.data API provides access to the Flickr photo sharing site's REST API. Many advanced features are available, including tag search, sorting on numerous attributes, full text search, support for simultaneous clients, result caching and more.

Dojo has several examples of browser in-memory stores, such as dojo.data.ItemFileReadStore, dojox.data.CsvStore, and dojox.data.OmplStore. While these stores are useful and great examples of how data stores can be used to wrapper accessing data, they are not the only way data is served and processed. In many cases, data stores can wrapper external services. It is those services that perform the querying and filtering of data, and then provide only that as a subset back to the data store for presentation as items.

FlickrRestStore is one such store. The purpose of FlickrRestStore is to wrapper the public photo feed of the Flickr service. Then by simply using the FlickrRestStore store, as you would any data store in Dojo, you now have access to querying the vast repository of public photos made available by others on the Web. Look at http://archive.dojotoolkit.org/nightly/dojotoolkit/dojox/data/demos/demo... to see it in action, or look here for some example usages.

The following dojo.data APIs are implemented by FlickrRestStore

* dojo.data.api.Read

FlickrRestStore is built upon `FlickrStore <dojox/data/FlickrStore>`_, a store which reads from Flickr's more simplistic public API. However, FlickrRestStore provides many more features:

* Build on Flickr REST API. The Flickr REST API, a much more flexible API than the one used by FlickrStore. This opens up the possibility of having a very comprehensive data store that can have a very rich querying interface.
* Results caching. If a request is repeated, or a subset of one or more previous requests is requested, it is returned immediately.
* Supports multiple simultaneous clients. If an identical request is received before the first request has completed, a second remote request is not made. Instead, the second caller is notified when the first request completes. An example of this would be two widgets sharing the same FlickrRestStore, and individually paging through the photos.
* Result sorting. The available sort attributes are date-taken, date-published and interestingness. See the examples below for their usage.
* Full text search. The Flickr API supports full text searching, which you can do by passing a text parameter to the request query. See the examples below for its usage.
* Filter by Photo Set. By specifying a setid parameter on the query, you can retrieve photos only from a single set. Due to limitations of the Flickr API, using this parameter negates the use of the full text search.
* Tag search. Passing a tags parameter to the request query searches by the given tags. This parameter can be either a comma separated string, or an array of strings. See the examples below.

Flickr Terms and Conditions

Note: While this store wraps making calls to the Flickr service, as a user, you should still verify that you agree to the terms and conditions by which you are using the public Flickr photo service. Review their terms and conditions, and the API terms and conditions, `here <http://www.flickr.com/services/api/tos/>`_.
