#format dojo_rst

dojox.data.GoogleSearchStore
============================

:Status: Contributed, Draft
:Version: 1.0
:Available: since V1.2

.. contents::
  :depth: 3


The GoogleFeedStore is a store designed to work against Google's feed AJAX API.  This store is an extension of GoogleSearchStore.


**Note:**  These stores make use of Google's `AJAX search services. <http://code.google.com/apis/ajaxsearch/>`_.  In order to use them in your web-sites, please make sure to read `Google's terms and conditions <http://code.google.com/apis/ajaxsearch/terms.html>`_ and agree to them before using these stores.

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
|label        |The attribute of the search returns to use as the item's label.  Defaults to              |string                | 
|             |titleNoFormatting.                                                                        |                      |
+-------------+------------------------------------------------------------------------------------------+----------------------+
|key          |Your Google API key (optional)                                                            | string               |
+-------------+------------------------------------------------------------------------------------------+----------------------+
|lang         |The language locale to use. Defaults to the browser locale.                               | string               |
+-------------+------------------------------------------------------------------------------------------+----------------------+

===============
Item Attributes
===============

Depending on which of the search stores you instantiate, the supported list of item attributes changes.  This is because each search service exposes different information, since each type of search by its nature deems specific information the key information to return.  Below you will find a list of expected attribute names for each search service and what they are:

----------------------------
dojox.data.GoogleFeedStore
----------------------------

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

-------------
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
         //Link button to search, where search text is drawn from the input box.
 
         dojo.connect(dijit.byId("tabSearch"), "selectChild", resizeGrids);

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
    <div dojoType="dijit.form.TextBox" width="50" id="searchText" value="http://news.google.com/nwshp?hl=en&amp;tab=wn&amp;output=atom"></div>
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
      @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/resources/Grid.css";
      @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/resources/nihiloGrid.css";

      .dojoxGrid table {
        margin: 0;
      }
    </style>


The following example shows wiring the GoogleFeedStore to dojox.data.DataGrid.
