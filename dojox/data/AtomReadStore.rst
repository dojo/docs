#format dojo_rst

dojox.data.AtomReadStore
==========================

:Status: Contributed, Draft
:Version: 1.0
:Author: Shane O'Sullivan
:Available: since V1.2

.. contents::
  :depth: 3


The AtomReadStore is a store designed to provide read-only access to `Atom XML <http://en.wikipedia.org/wiki/Atom_(standard)>`_ documents. Atom XML is a common document format for web feeds providing lists of data. It is similar in many respects to RSS, but provides much more flexibility.

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
|url          |The url to a service or an XML document that represents the store                         |string                | 
+-------------+------------------------------------------------------------------------------------------+----------------------+
|sendQuery    |A boolean indicate to add a query string to the service URL.                              | string               |
+-------------+------------------------------------------------------------------------------------------+----------------------+
|unescapeHTML |A boolean to specify whether or not to unescape HTML text.                                | string               |
+-------------+------------------------------------------------------------------------------------------+----------------------+

===============
Item Attributes
===============

The following attributes are available on items returned from the AtomReadStore:

+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|**Attribute**    |**Description**                                                                                                                                                                                                                                                                             |
+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|title            |The feed entry title.                                                                                                                                                                                                                                                                       |
+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|link             |The URL for the HTML version of the feed entry.                                                                                                                                                                                                                                             |
+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|content          |The full content of the blog post. If unescapeHTML is true, this is returned in HTML. Otherwise it is returned in plain  text.                                                                                                                                                              |
+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|summary          |A snippet of information about the feed entry. If unescapeHTML is true, this is returned in HTML. Otherwise it is returned in plain text.                                                                                                                                                   |
+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|published        |The string date on which the entry was published.                                                                                                                                                                                                                                           |
+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|category         |An array of tags for the entry. Each category is a JSON object containing two values, 'scheme' and 'term'. E.g. '''store.getValue(item, 'category').term''' gives the category, or tag, value.                                                                                              |
+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|author           |A JSON object containing one or two elements, '''name''' and '''uri'''. The former is the name of the author, the latter is the authors personal uri, or web page. E.g. '''var author = store.getValue(item, 'author'); alert("Name is " + author.name + " and homepage is " + author.uri); |
+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

============
Query Syntax
============

The query syntax for this store is simple. If the data source is a static url, e.g. an XML file, then no query syntax is used. The store simply reads the URL specified in the constructor. If the URL must have some parameters added to it, e.g. ''feed.php?user=1234'', then these parameters can be added in the query.

Query Example With One Parameter
--------------------------------

.. code-block :: javascript

  {
    user: '1234'
  }

====================================================
Examples in Dojo Explorer
====================================================
Many examples are available in Dojo Explorer, at http://dojocampus.org/explorer/#Dojo_Data_AtomReadStore


====================================================
Example Usage of using AtomReadStore with a DataGrid
====================================================

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dijit.form.TextBox");
      dojo.require("dijit.layout.TabContainer");
      dojo.require("dijit.layout.ContentPane");
      dojo.require("dojox.data.AtomReadStore");
      dojo.require("dojox.grid.DataGrid");

      function hrefFormatter(value) {
        return "<a href=\"" + value["href"] + "\" target=\"_blank\">Link</a>";
      };
			function textFormatter(value) {
				return value["text"];
			}

      var layoutResults = [
        [
          { field: "title", name: "Title", width: 20 , formatter: textFormatter},
          { field: "link", name: "URL", width: 5, formatter: hrefFormatter},
          { field: "summary", name: "Summary", width: 'auto' , formatter: textFormatter}
        ]
      ];
    </script>

  .. cv :: html 

    <div dojoType="dojox.data.AtomReadStore" jsId="feedStore" url="/moin_static163/js/dojo/trunk/release/dojo/dojox/data/tests/stores/atom1.xml"></div>
    <div id="feedGrid" 
      jsId="feedGrid"
      style="width: 750px; height: 300px;"
      dojoType="dojox.grid.DataGrid" 
      store="feedStore" 
      structure="layoutResults" 
      query="{}"   
      rowsPerPage="40">
    </div>

  .. cv:: css

    <style type="text/css">
      @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/resources/Grid.css";
      @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/resources/nihiloGrid.css";

      .dojoxGrid table {
        margin: 0;
      }
    </style>
