#format dojo_rst

dojox.data.HtmlTableStore
=========================

**NOTE:**   This store is deprecated.  Please use `dojox.data.HtmlStore <dojox/data/HtmlStore>`_.

.. contents::
  :depth: 3


HtmlTableStore is a simple read-only store provided by Dojo and contained in the DojoX project. HtmlTableStore is a read interface to work with HTML tables with a generally set format. HTML tables are common ways for Web data to be displayed and they can be extremely useful as an alternate representation of data that is displayed in a charting or gauge widget. This store was created so that widgets, that can use dojo.data data stores, can read their input from HTML table data islands in the current page or in a remote page URL. This store implements both dojo.data.api.Read and dojo.data.api.Identity.

The following example shows an HTML table that this store can read:

::

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

**Note:** The table rows in the <tbody> tag are the items.  The <thead> tag is used for defining the attribute name for each column in the table row for an item.</p>

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

============
Query Syntax
============

The query syntax is identical to `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_.   Please refer to it for the format of the queries.

========
Examples
========

------------------------------------------------------------
Example 1:  Connecting HtmlTableStore to dijit.form.ComboBox
------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.data.HtmlTableStore");
      dojo.require("dijit.form.ComboBox");
    </script>

  .. cv :: html 

    <table id="myData" style="display: hidden;">
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
    <div dojoType="dojox.data.HtmlTableStore" tableId="myData" jsId="comboStore"></div>
    <div dojoType="dijit.form.ComboBox" store="comboStore" searchAttr="isbn"></div>
