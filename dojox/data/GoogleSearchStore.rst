#format dojo_rst

dojox.data.GoogleSearchStore
============================

:Status: Contributed, Draft
:Version: 1.0
:Author: Shane O'Sullivan
:Available: since V1.2

.. contents::
  :depth: 3


The GoogleSearchStore is actually a collection of stores designed to work with Google's Ajax search services. GoogleSearchStore is the base class  that all subclasses of GoogleSearchStore extend from. It provides all the basics of working with Google's search API in a dojo.data compliant implementation. The following stores are avaialble for use after dojo.require() is used to load dojox.data.GoogleSearchStore:

* **dojox.data.GoogleSearchStore** - The basic search store that all more fine-grained searches inherit from. This store defaults to querying Google's Web-search Ajax calls.
* **dojox.data.GoogleWebSearchStore** - A store configured to search specifically against Google's Web search Ajax calls.
* **dojox.data.GoogleBlogSearchStore** - A store configured to search specifically against Google's Blog (Web log) search Ajax calls.
* **dojox.data.GoogleLocalSearchStore** - A store configured to search specifically against Google's Location related search Ajax calls.
* **dojox.data.GoogleVideoSearchStore** - A store configured to search specifically against Google's Video search Ajax calls.
* **dojox.data.GoogleBookSearchStore** - A store configured to search specifically against Google's Book search Ajax calls.
* **dojox.data.GoogleImageSearchStore** - A store configured to search specifically against Google's Image search Ajax calls.

**Note:**  These stores make use of Google's `AJAX search services. <http://code.google.com/apis/ajaxsearch/>`_. In order to use them in your web-sites, please make sure to read `Google's terms and conditions <http://code.google.com/apis/ajaxsearch/terms.html>`_ and agree to them before using these stores.

===========
API Support
===========

* `dojo.data.api.Read <dojo/data/api/Read>`_

==================
Constructor Params
==================

The following parameters are supported by all Google store implementations.

+-------------+------------------------------------------------------------------------------------------+----------------------+
| **name**    | **description**                                                                          | **type**             |
+-------------+------------------------------------------------------------------------------------------+----------------------+
|label        |The attribute of the search returns to use as the item's label. Defaults to               |string                | 
|             |titleNoFormatting.                                                                        |                      |
+-------------+------------------------------------------------------------------------------------------+----------------------+
|key          |Your Google API key (optional)                                                            | string               |
+-------------+------------------------------------------------------------------------------------------+----------------------+
|lang         |The language locale to use. Defaults to the browser locale.                               | string               |
+-------------+------------------------------------------------------------------------------------------+----------------------+

===============
Item Attributes
===============

Depending on which of the search stores you instantiate, the supported list of item attributes changes. This is because each search service exposes different information, since each type of search by its nature deems specific information the key information to return. Below you will find a list of expected attribute names for each search service and what they are:


dojox.data.GoogleSearchStore
----------------------------

+--------------------+--------------------------------------------------------------------------------------------------------------------------+
|**Attribute**       |**Description**                                                                                                           |
+--------------------+--------------------------------------------------------------------------------------------------------------------------+
|url                 |The URL for the item returned by the search                                                                               |
+--------------------+--------------------------------------------------------------------------------------------------------------------------+
|unescapedUrl        |The URL for the item, without URL escaping. This is often more readable.                                                  |
+--------------------+--------------------------------------------------------------------------------------------------------------------------+
|visibleUrl          |The URL with no protocol specified.                                                                                       |
+--------------------+--------------------------------------------------------------------------------------------------------------------------+
|cacheUrl            |The URL to the copy of the document cached by Google                                                                      |
+--------------------+--------------------------------------------------------------------------------------------------------------------------+
|title               |The page title in HTML mat.                                                                                               |
+--------------------+--------------------------------------------------------------------------------------------------------------------------+
|titleNoFormatting   |The page title in plain text                                                                                              |
+--------------------+--------------------------------------------------------------------------------------------------------------------------+
|content             |A snippet of information about the e.                                                                                     |
+--------------------+--------------------------------------------------------------------------------------------------------------------------+
|estimatedResultCount|The estimated number of results from the query  *(New in 1.4!)*                                                           |
+--------------------+--------------------------------------------------------------------------------------------------------------------------+


dojox.data.GoogleWebSearchStore
-------------------------------

+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|**Attribute**    |**Description**                                                                                                              |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|title            |The page title in HTML format.                                                                                               |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|titleNoFormatting|The page title in plain text                                                                                                 |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|content          |A snippet of information about the page.                                                                                     |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|blogUrl          |The URL for the blog                                                                                                         |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|postUrl          |The URL for the single blog post                                                                                             |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|visibleUrl       |The URL with no protocol specified.                                                                                          |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|cacheUrl         |The URL to the copy of the document cached by Google                                                                         |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|author           |The author of the blog post                                                                                                  |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|publishedDate    |The published date, in RFC-822 format                                                                                        |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+


dojox.data.GoogleBlogSearchStore
--------------------------------

+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|**Attribute**    |**Description**                                                                                                              |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|url              |The URL for the item returned by the search                                                                                  |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|unescapedUrl     |The URL for the item, without URL escaping. This is often more readable.                                                     |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|visibleUrl       |The URL with no protocol specified.                                                                                          |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|cacheUrl         |The URL to the copy of the document cached by Google                                                                         |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|title            |The page title in HTML format.                                                                                               |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|titleNoFormatting|The page title in plain text                                                                                                 |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|content          |A snippet of information about the page.                                                                                     |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+


dojox.data.GoogleLocalSearchStore
---------------------------------

+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|**Attribute**    |**Description**                                                                                                              |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|title            |The page title in HTML format.                                                                                               |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|titleNoFormatting|The page title in plain text                                                                                                 |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|content          |A snippet of information about the page.                                                                                     |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|url              |The URL for the item returned by the search                                                                                  |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|lat              |The latitude of the item in question.                                                                                        |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|lng              |The longitude of the item in question.                                                                                       |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|streetAddress    |The street address of the item                                                                                               |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|city             |The city of the item                                                                                                         |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|region           |The region of the item                                                                                                       |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|country          |The country of the item                                                                                                      |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|phoneNumbers     |The phone numbers associated with this address. Can be one or more.                                                          |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|ddUrl            |A URL that can be used to provide driving directions from the center of the search results to this search results            |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|ddUrlToHere      |A URL that can be used to provide driving directions from this search result to a user specified location.                   |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|staticMapUrl     |Link to the map for the item.                                                                                                |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|viewport         |Recommended viewport for the query results (same for all results in a query).  This is a JavaScript Object.                  |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+


dojox.data.GoogleVideoSearchStore
---------------------------------

+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|**Attribute**    |**Description**                                                                                                              |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|title            |The page title in HTML format.                                                                                               |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|titleNoFormatting|The page title in plain text                                                                                                 |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|content          |A snippet of information about the page.                                                                                     |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|url              |The URL for the item returned by the search                                                                                  |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|published        |The published date, in RFC-822 format.                                                                                       |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|publisher        |The name of the publisher.                                                                                                   |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|duration         |The approximate duration, in seconds, of the video.                                                                          |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|tbWidth          |The width in pixels of the video.                                                                                            |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|tbHeight         |The height in pixels of the video                                                                                            |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|tbUrl            |The URL to a thumbnail representation of the video.                                                                          |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|playUrl          |If present, supplies the url of the flash version of the video that can be played inline on your page. To play this video    |
|                 |simply create and <embed> element on your page using this value as the src attribute and using application/x-shockwave-flash |
|                 |as the type attribute. If you want the video to play right away, make sure to append &autoPlay=true to the url.              |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+


dojox.data.GoogleNewsSearchStore
--------------------------------

+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|**Attribute**    |**Description**                                                                                                              |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|title            |The page title in HTML format.                                                                                               |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|titleNoFormatting|The page title in plain text                                                                                                 |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|content          |A snippet of information about the page.                                                                                     |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|url              |The URL for the item returned by the search                                                                                  |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|unescapedUrl     |The URL for the item, without URL escaping. This is often more readable.                                                     |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|publisher        |The name of the publisher.                                                                                                   |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|clusterUrl       |A URL pointing to a page listing related stories.                                                                            |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|location         |The location of the news story.                                                                                              |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|relatedStories   |An optional array of objects specifying related stories. Each object has the following subset of properties:                 |
|                 |"title", "titleNoFormatting", "url", "unescapedUrl", "publisher", "location", "publishedDate".                               |              
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+


dojox.data.GoogleBookSearchStore
--------------------------------

+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|**Attribute**    |**Description**                                                                                                              |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|title            |The book title in HTML format.                                                                                               |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|titleNoFormatting|The book title in plain text                                                                                                 |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|authors          |An array of authors                                                                                                          |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|url              |The URL for the item returned by the search                                                                                  |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|unescapedUrl     |The URL for the item, without URL escaping. This is often more readable.                                                     |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|bookId           |An identifier for the book, usually an ISBN.                                                                                 |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|pageCount        |The number of pages in the book.                                                                                             |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|publishedYear    |The year of publication.                                                                                                     |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+


dojox.data.GoogleImageSearchStore
---------------------------------

+-------------------+---------------------------------------------------------------------------------------------------------------------+
|**Attribute**      |**Description**                                                                                                      |
+-------------------+---------------------------------------------------------------------------------------------------------------------+
|title              |The book title in HTML format.                                                                                       |
+-------------------+---------------------------------------------------------------------------------------------------------------------+
|titleNoFormatting  |The book title in plain text                                                                                         |
+-------------------+---------------------------------------------------------------------------------------------------------------------+
|url                |The URL for the item returned by the search                                                                          |
+-------------------+---------------------------------------------------------------------------------------------------------------------+
|tbUrl              |The URL for the image thumbnail                                                                                      |
+-------------------+---------------------------------------------------------------------------------------------------------------------+
|visibleUrl         |A shortened version of the URL associated with the result, stripped of a protocol and path.                          |
+-------------------+---------------------------------------------------------------------------------------------------------------------+
|originalContextUrl |The URL of the page containing the image.                                                                            |
+-------------------+---------------------------------------------------------------------------------------------------------------------+
|width              |The width of the image in pixels.                                                                                    |
+-------------------+---------------------------------------------------------------------------------------------------------------------+
|height             |The height of the image in pixels.                                                                                   |
+-------------------+---------------------------------------------------------------------------------------------------------------------+
|tbWidth            |The width of the thumbnail in pixels.                                                                                |
+-------------------+---------------------------------------------------------------------------------------------------------------------+
|tbHeight           |The height of the thumbnail in pixels.                                                                               |
+-------------------+---------------------------------------------------------------------------------------------------------------------+
|content            |A snippet of information about the image, in HTML format                                                             |
+-------------------+---------------------------------------------------------------------------------------------------------------------+
|contentNoFormatting|A snippet of information about the image, in plain text.                                                             |
+-------------------+---------------------------------------------------------------------------------------------------------------------+

============
Query Syntax
============

The query syntax for all stores is simple. Most only take a single object with the attribute 'text', where the value is what text to search for.

Query Example
-------------

.. code-block :: javascript 
 
  {
    "text" : "Find me"
  }

Query Syntax for GoogleLocalSearchStore
---------------------------------------

New to Dojo 1.4, the GoogleLocalSearchStore allows for a few extra options when searching, its allowed syntax is:

.. code-block :: javascript 
 
  {
    "text" : "Find me"
    "centerLatLong" : "48.8565,2.3509" //Comma-separated lat & long for the center of the search
    "searchSpan" : "0.065165,0.194149" //Comma-separated lat & long degrees indicating the size of the desired search area
  }


=============
Example Usage
=============

The following example shows wiring Various GoogleSearchStores to dojox.data.DataGrids. You can type in a search string in the search box and hit search. The datagrids will then be populated with the results of the searches.


Searching multiple Google services at once
------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dijit.form.TextBox");
      dojo.require("dijit.layout.TabContainer");
      dojo.require("dijit.layout.ContentPane");
      dojo.require("dojox.data.GoogleSearchStore");
      dojo.require("dojox.grid.DataGrid");

      function hrefFormatter(value) {
        value = unescape(value);
        return "<a href=\"" + value + "\" target=\"_blank\">Link</a>";
      };

      var layoutResults = [
        [
          { field: "title", name: "Title", width: 20 },
          { field: "url", name: "URL", width: 5, formatter: hrefFormatter},
          { field: "content", name: "Content", width: 'auto' }
        ]
      ];

      function init() {
         //Link button to search, where search text is drawn from the input box.
 
         //Had to resize the grids on selection of tabs, otherwise they wouldn't always display.
         function resizeGrids() {
           dijit.byId("webGrid").resize();
           dijit.byId("newsGrid").resize();
           dijit.byId("imageGrid").resize();
         }
         dojo.connect(dijit.byId("tabSearch"), "selectChild", resizeGrids);

         function search() {
            var text = dijit.byId("searchText").getValue();
            text = dojo.trim(text);
            if (text !== "" ) {
              var query = { text: text };
              dijit.byId("webGrid").setQuery(query);           
              dijit.byId("newsGrid").setQuery(query);
              dijit.byId("imageGrid").setQuery(query); 
            }
         }
         dojo.connect(dijit.byId("searchButton"), "onClick", search);
      }
      dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <b>Input search text:</b>
    <br>
    <br>
    <div dojoType="dijit.form.TextBox" width="50" id="searchText" value="Dojo"></div>
    <br>
    <div dojoType="dijit.form.Button" id="searchButton">Search!</div>
    <div dojoType="dojox.data.GoogleWebSearchStore" jsId="webStore"></div>
    <div dojoType="dojox.data.GoogleImageSearchStore" jsId="imageStore"></div>    
    <div dojoType="dojox.data.GoogleNewsSearchStore" jsId="newsStore"></div>
    <br>
    <br>
    <div dojoType="dijit.layout.TabContainer" style="width: 800px; height: 350px;" id="tabSearch">
      <div id="tab1" title="GoogleWebSearchStore" dojoType="dijit.layout.ContentPane">
        <div id="webGrid" 
          style="width: 750px; height: 300px;"
          dojoType="dojox.grid.DataGrid" 
          store="webStore" 
          structure="layoutResults"
          query="{text:'Dojo'}" 
          rowsPerPage="40">
        </div>
      </div>
      <div id="tab2" title="GoogleImageSearchStore" dojoType="dijit.layout.ContentPane">
        <div style="width: 750px; height: 300px;">
          <div id="imageGrid" 
            dojoType="dojox.grid.DataGrid" 
            store="imageStore" 
            structure="layoutResults" 
            query="{text:'Dojo'}"   
            rowsPerPage="40">
          </div>
        </div> 
      </div>
      <div id="tab3" title="GoogleNewsSearchStore" dojoType="dijit.layout.ContentPane">
        <div id="newsGrid" 
          style="width: 750px; height: 300px;"
          dojoType="dojox.grid.DataGrid" 
          store="newsStore" 
          structure="layoutResults" 
          query="{text:'Dojo'}" 
          rowsPerPage="40">
        </div>
      </div>
    </div>

  .. cv:: css

    <style type="text/css">
      @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/resources/Grid.css";
      @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/resources/nihiloGrid.css";

      .dojoxGrid table {
        margin: 0;
      }
    </style>
