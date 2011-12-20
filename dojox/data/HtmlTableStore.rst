.. _dojox/data/HtmlTableStore:

=========================
dojox.data.HtmlTableStore
=========================

**NOTE:**   This store is deprecated. Please use :ref:`dojox.data.HtmlStore <dojox/data/HtmlStore>`.

:Author: Jared Jurkiewicz
:since: V1.0

.. contents ::
  :depth: 3


HtmlTableStore is a simple read-only store provided by Dojo and contained in the DojoX project. HtmlTableStore is a read interface to work with HTML tables with a generally set format. HTML tables are common ways for Web data to be displayed and they can be extremely useful as an alternate representation of data that is displayed in a charting or gauge widget. This store was created so that widgets, that can use dojo.data data stores, can read their input from HTML table data islands in the current page or in a remote page URL. This store implements both dojo.data.api.Read and dojo.data.api.Identity.

The following example shows an HTML table that this store can read:

.. html ::
 
  <html>
  <head>
    <title>Books2.html</title>
  </head>
  <body>
  <table id="books2">
    <thead>
        <tr>
            <th>isbn</th>
            <th>title</th>
            <th>author</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>A9B57C</td>
            <td>Title of 1</td>
            <td>Author of 1</td>
        </tr>
        <tr>
            <td>A9B57F</td>
            <td>Title of 2</td>
            <td>Author of 2</td>
        </tr>
        <tr>
            <td>A9B577</td>
            <td>Title of 3</td>
            <td>Author of 3</td>
        </tr>
        <tr>
            <td>A9B574</td>
            <td>Title of 4</td>
            <td>Author of 4</td>
        </tr>
        <tr>
            <td>A9B5CC</td>
            <td>Title of 5</td>
            <td>Author of 5</td>
        </tr>
    </tbody>
  </table>
  </body>
  </html>

**Note:** The table rows in the <tbody> tag are the items. The <thead> tag is used for defining the attribute name for each column in the table row for an item.

Constructor params
==================

The constructor for HtmlTableStore takes the following possible parameters in its keyword arguments:

+-------------+------------------------------------------------------------------------------------------+----------------------+
| **name**    | **description**                                                                          | **type**             |
+-------------+------------------------------------------------------------------------------------------+----------------------+
|url          |The URL from which to load the HTML file containing the HTML table. This is optional.     | string               |
+-------------+------------------------------------------------------------------------------------------+----------------------+
|tableId      |The id of the HTML tag that contains the table to read from, in either a remote page (if  | string               |
|             |the URL was passed) or in the current HTML DOM if the url parameter is null. This is      |                      |
|             |required.                                                                                 |                      |
+-------------+------------------------------------------------------------------------------------------+----------------------+

Item Attributes
===============
The item attributes are defined by the <thead>  tag of the referenced table. Each column name becomes the attribute name for that column when generating the data store view of the data.


Query Syntax
============

The query syntax is identical to :ref:`dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`. Please refer to it for the format of the queries.

Examples
========

Connecting HtmlTableStore to dijit.form.ComboBox
------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dojox.data.HtmlTableStore");
      dojo.require("dijit.form.ComboBox");

  .. html ::

    <table id="myData" style="display: none;">
    <thead>
        <tr>
            <th>isbn</th>
            <th>title</th>
            <th>author</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>A9B57C</td>
            <td>Title of 1</td>
            <td>Author of 1</td>
        </tr>
        <tr>
            <td>A9B57F</td>
            <td>Title of 2</td>
            <td>Author of 2</td>
        </tr>
        <tr>
            <td>A9B577</td>
            <td>Title of 3</td>
            <td>Author of 3</td>
        </tr>
        <tr>
            <td>A9B574</td>
            <td>Title of 4</td>
            <td>Author of 4</td>
        </tr>
        <tr>
            <td>A9B5CC</td>
            <td>Title of 5</td>
            <td>Author of 5</td>
        </tr>
    </tbody>
    </table>

    <b>Combo lookup of isbn</b><br>
    <div data-dojo-type="dojox.data.HtmlTableStore" data-dojo-props="tableId:'myData'" data-dojo-id="comboStore"></div>
    <div data-dojo-type="dijit.form.ComboBox" data-dojo-props="store:comboStore, searchAttr:'isbn'"></div>


Connecting HtmlTableStore to dojox.grid.DataGrid
------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dojox.data.HtmlTableStore");
      dojo.require("dojox.grid.DataGrid");

      var layoutBooks = [
        [
          { field: "isbn", name: "ISBN", width: 10 },
          { field: "author", name: "Author", width: 10 },
          { field: "title", name: "Title", width: 'auto' }
        ]
      ];


  .. html ::

    <b>Standard HTML table:</b><br>
    <table id="myData2">
    <thead>
        <tr>
            <th>isbn</th>
            <th>title</th>
            <th>author</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>A9B57C</td>
            <td>Title of 1</td>
            <td>Author of 1</td>
        </tr>
        <tr>
            <td>A9B57F</td>
            <td>Title of 2</td>
            <td>Author of 2</td>
        </tr>
        <tr>
            <td>A9B577</td>
            <td>Title of 3</td>
            <td>Author of 3</td>
        </tr>
        <tr>
            <td>A9B574</td>
            <td>Title of 4</td>
            <td>Author of 4</td>
        </tr>
        <tr>
            <td>A9B5CC</td>
            <td>Title of 5</td>
            <td>Author of 5</td>
        </tr>
    </tbody>
    </table>
    <br>
    <br>

    <b>dojox.grid.DataGrid connected to the above table:</b><br>
    <div data-dojo-type="dojox.data.HtmlTableStore" data-dojo-props="tableId:'myData2'" data-dojo-id="gridStore"></div>
    <div style="width: 400px; height: 200px;">
      <div id="grid"
        data-dojo-type="dojox.grid.DataGrid"
        data-dojo-props="store:gridStore,
        structure:'layoutBooks',
        query:{},
        rowsPerPage:40">
      </div>
    </div>

  .. css ::

      @import "{{baseUrl}}dojox/grid/resources/Grid.css";
      @import "{{baseUrl}}dojox/grid/resources/nihiloGrid.css";

      .dojoxGrid table {
        margin: 0;
      }
