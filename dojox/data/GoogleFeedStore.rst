#format dojo_rst

dojox.data.GoogleFeedStore
==========================

:Status: Contributed, Draft
:Version: 1.0
:Author: Shane O'Sullivan
:Available: since V1.2

.. contents::
  :depth: 3


The GoogleFeedStore is a store designed to work against Google's feed reading AJAX API. This store is an extension of GoogleSearchStore.


**Note:**  These stores make use of Google's `AJAX search and feed services. <http://code.google.com/apis/ajaxsearch/>`_  In order to use them in your web-sites, please make sure to read `Google's terms and conditions <http://code.google.com/apis/ajaxsearch/terms.html>`_ and agree to them before using these stores.

===========
API Support
===========

* `dojo.data.api.Read <dojo/data/api/Read>`_

==================
Constructor Params
==================

The following parameters are supported by the GoogleFeedStore implementation.

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

The following attributes are available on items returned from the GoogleFeedStore

+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|**Attribute**    |**Description**                                                                                                              |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|title            |The feed entry title.                                                                                                        |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|link             |The URL for the HTML version of the feed entry.                                                                              |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|content          |The full content of the blog post, in HTML format                                                                            |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|summary          |A snippet of information about the feed entry, in plain text                                                                 |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|published        |The string date on which the entry was published.                                                                            |
|                 |  You can parse the date with new Date(store.getValue(item, "published").                                                    |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+
|categories       |An array of string tags for the entry                                                                                        |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------+

============
Query Syntax
============

The query syntax for this store is simple. It takes a single object with the attribute 'url', where the value of the feed to retrieve

Query Example
-------------
::

  {
    "url" : "http://news.google.com/nwshp?hl=en&tab=wn&output=atom"
  }

=============
Example Usage
=============

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dijit.form.TextBox");
      dojo.require("dijit.layout.TabContainer");
      dojo.require("dijit.layout.ContentPane");
      dojo.require("dojox.data.GoogleFeedStore");
      dojo.require("dojox.grid.DataGrid");

      function hrefFormatter(value) {
        value = unescape(value);
        return "<a href=\"" + value + "\" target=\"_blank\">Link</a>";
      };

      var layoutResults = [
        [
          { field: "title", name: "Title", width: 20 },
          { field: "link", name: "URL", width: 5, formatter: hrefFormatter},
          { field: "summary", name: "Summary", width: 'auto' }
        ]
      ];

      function init() {
         function search() {
            var text = dijit.byId("urlText").getValue();
            text = dojo.trim(text);
            if (text !== "" ) {
              var query = { url: text };
              dijit.byId("feedGrid").setQuery(query);           
            }
         }
         dojo.connect(dijit.byId("searchButton"), "onClick", search);
      }
      dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <b>Input feed URL here:</b>
    <br>
    <br>
    <input dojoType="dijit.form.TextBox" style="width:50em;" id="urlText" value="http://news.google.com/nwshp?hl=en&amp;tab=wn&amp;output=atom"></input>
    <br>
    <div dojoType="dijit.form.Button" id="searchButton">Search!</div>
    <div dojoType="dojox.data.GoogleFeedStore" jsId="feedStore"></div>
    <br>
    <br>
    <div style="width: 750px; height: 300px;">
      <div id="feedGrid" 
        dojoType="dojox.grid.DataGrid" 
        store="feedStore" 
        structure="layoutResults" 
        query="{url:'http://news.google.com/nwshp?hl=en&tab=wn&output=atom'}"   
        rowsPerPage="40">
      </div>
    </div> 

  .. cv:: css

    <style type="text/css">
      @import "{{baseUrl}}dojox/grid/resources/Grid.css";
      @import "{{baseUrl}}dojox/grid/resources/nihiloGrid.css";

      .dojoxGrid table {
        margin: 0;
      }
    </style>


The following example shows wiring the GoogleFeedStore to dojox.data.DataGrid.
