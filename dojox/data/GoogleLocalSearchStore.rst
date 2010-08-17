#format dojo_rst

dojox.data.GoogleLocalSearchStore
=================================

:Status: Draft
:Version: 1.0
:Project owner: Shane O'Sullivan
:Available: since 1.2?

.. contents::
   :depth: 2

dojox.data.GoogleLocalSearchStore is a data store that can be used to search Google.

============
Introduction
============

dojox.data.GoogleLocalSearchStore is a read only data store that can be used to search Google.  It implements the 'dojo.data.api.Read API <dojo/data/api/Read>'_, which you should refer to for general usage.

=====
Usage
=====

The pattern of using the GoogleLocalSearchStore is
 * Instantiate the class, passing in whatever variables required, all of which are optional.  These include:

  * **label** The argument to use as the label.  This is used when the **getLabel** function is called to retrieve the correct part of the data item.  You generally shouldn't set this.
  * **key** Your Google API key.  This is optional, and should only be used if you for some reason want Google to track the number of requests made by your code (for analytical purposes maybe)
  * **lang** The language you want the results returned in.  This defaults to the browsers' language.
  * **urlPreventCache** Specifies whether or not to forcibly prevent caching of results.  This defaults to true.

 * Call the **fetch** method, passing it the search query and the function to call when the query is completed.  The query can accept up to three attributes

  * **text** The text to search for.
  * **centerLatLong** Comma-separated lat & long for the center of the search (e.g. "48.8565,2.3509")
  * **searchSpan** Comma-separated lat & long degrees indicating the size of the desired search area (e.g. "0.065165,0.194149")

 * Iterate over the results, calling the **getValue** function to retrieve values from each result item.  The pieces of data in each result item are

  * **title** The page title in HTML format
  * **titleNoFormatting** The page title in plain text. This is the default field used as the label.
  * **content** A snippet of information about the page
  * **url** The URL for the item.
  * **lat** The latitude for the place.
  * **lng** The longitude for the place.
  * **streetAddress** The street address
  * **city** The city in which the place is located.
  * **region** The region in which the place is located.
  * **country** The country in which the place is located.
  * **phoneNumbers** Phone numbers associated with this address. Can be one or more.
  * **ddUrl** A URL that can be used to provide driving directions from the center of the search results to this search results
  * **ddUrlToHere** A URL that can be used to provide driving directions from this search result to a user specified location
  * **staticMapUrl** A URL to a static image showing the location of the place on a map
  * **viewport** Recommended viewport for the query results (same for all results in a query).  This contains the following

   * **center** contains lat, lng properties
   * **span** lat, lng properties for the viewport span
   * **ne, sw** lat, lng properties for the viewport corners

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
  dojo.require("dojox.data.GoogleSearchStore"); 
  var store = new dojox.data.GoogleLocalSearchStore();

  var query = {text: "central park, new york"};

  var callbackFunction = function(items /* Array */) {
    
    console.log("Successfully retrieved " + items.length + " items for the query '" + query.text + "'");
    dojo.forEach(items, function(item){
      console.log ("Title is " + store.getValue(item, "title"));
      console.log ("Url is " + store.getValue(item, "unescapedUrl"));
      console.log ("Directions are at  " + store.getValue(item, "ddUrl"));
      console.log ("Static map available at " + store.getValue(item, "staticMapUrl"));
    })
  };

  var onErrorFunction = function() {
    console.log("An error occurred getting Google Search data");
  }

  store.fetch({
    query: query,
    count: 20,
    start: 0,
    onComplete: callbackFunction,
    onError: onErrorFunction
  });
 </script>



========
Examples
========

Programmatic example
--------------------

.. code-example::

  .. javascript::

    <script type="text/javascript">
    dojo.require("dojox.data.GoogleSearchStore"); 

    function doSearch() {

      var store = new dojox.data.GoogleLocalSearchStore();

      var query = {text: dojo.byId("searchInput").value};

      var callbackFunction = function(items /* Array */) {

        var table = dojo.byId("resultTable");
        var tableBody = table.tBodies[0];
        dojo.empty(tableBody);

        // Show the table
        dojo.style(table, "display", "");
      
        for(var index in items){
          
          var item = items[index];
          var row = dojo.create("tr", {}, tableBody);
  
          var numberCell = dojo.create("td", {innerHTML: index}, row);

          var titleCell = dojo.create("td", {innerHTML: store.getValue(item, "titleNoFormatting")}, row);

          var urlCell = dojo.create("td", {}, row);
          dojo.create("a", {
                             href: store.getValue(item, "ddUrl"),
                             innerHTML: "Directions",
                             target: "_blank"
                           }, urlCell);


          var mapCell = dojo.create("td", {}, row);
          var mapLink = dojo.create("a", {
                             href: store.getValue(item, "url"),                             
                             target: "_blank"
                           }, mapCell );
          dojo.create("img", {
                             src: store.getValue(item, "staticMapUrl")
                           }, mapLink );
          
        }
      };

      var onErrorFunction = function() {
        console.log("An error occurred getting Google Search data");
      }

      store.fetch({
        query: query,
        count: 20,
        start: 0,
        onComplete: callbackFunction,
        onError: onErrorFunction
      });
      console.log("called fetch with query", query);

    }
    </script>

  .. html::

    <div>
      <span>Enter Search Text</span>
      <input type="text" value="Central Park, New York" id="searchInput">
      <button onclick="doSearch()">Search</button>
    </div>

    <table id="resultTable" style="border: 1px solid black; display: none;">
      <thead>
        <th>#</th>
        <th>Title</th>
        <th>URL</th>
      </thead>
      <tbody>
      </tbody>
    </table>

========
See also
========

* TODO: links to other related articles
