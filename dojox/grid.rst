## page was renamed from 1.2/dojox/grid
#format dojo_rst

dojox.grid
==========

:Status: Draft
:Version: 1.0
:Project owners: Scott J. Miles, Steve Orvell, Bryan Forbes
:Available: since V1.2

.. contents::
   :depth: 2

Grids are familiar in the client/server development world. Basically a grid is a kind of mini spreadsheet, commonly used to display details on master-detail forms. From HTML terms, a grid is a "super-table" with its own scrollable viewport.


============
Introduction
============

TODO: introduce the component/class/method
A structure is an array of views and a view is an array of cells.

This Widget inherits from dojo.grid._Grid and hence all methods and properties pertaining to that Widget also apply here.

Grid 1.2 Changes
----------------

``TODOC``


=====
Usage
=====

At a high level, a DataGrid can be defined either delcaratively in HTML markup or programatically in JavaScript.  In markup, the following high level structure is defined:

.. code-block :: html

  <table dojoType="dojox.grid.DataGrid" >
    <thead>
      <tr>
        <th field="fieldName" width="200px">Column Name</th>
        <th field="fieldName" width="200px">Column Name</th>
      </tr>
    </thead>
  </table>

The ``<table>`` tag defines that a DataGrid is being created.  The nested ``<th>`` tags define the columns on the table.

*note:* the ``<thead>`` element is *required* in order for the DataGrid to read this markup as the layout. 

In the ``<th>`` tag in a declarative definition of a DataGrid, the following attributes are permitted

field
  The name of the field in the store data
width
  The width of the column
cellType
  The type of cell in the column.  Allowable cell types include

* ``dojox.grid.cells.Bool``
* ``dojox.grid.cells.Select``


options
  Used when cellType is ``dojox.grid.cells.Select`` to name the allowable options
editable
  A boolean value that declares whether or not the cell is editable
formatter
  A JavaScript function that is called which returns the value to be shown in the cell.  The value from the data store is passed as a parameter to the function.  The returned value that is inserted into the page can be any legal HTML.  It should *not* be a dijit Widget as that is not parsed.
get
  A JavaScript function that is called which returns the value to be shown in the cell.  The function is passed two parameters.  The first is the row index in the DataGrid.  The second is the DataStore record/item.  Given these two parameters, the function is expected to know what to return.  It should *not* be a dijit Widget as that is not parsed.  Care should be taken that the ``item`` parameter is not null.  Tests have shown that the function may be called more often than it should be and this is highlighted with an ``item = null``.
hidden
  This boolean property can be used to hide a column in the table.  If its value is ``true`` the column is hidden.  If ``false`` the column is displayed.

The value of the text between a ``<th>`` and ``</th>`` is used as the header label for the column.

The structure of the table can also be set programatically.  The ``<table>`` attribute called ``structure`` can name an object that defines the cell structure.

Event handling
--------------
Event handlers can be associated with the DataGrid.  Many of these events are expected to be handled by the DataGrid itself.  Grabbing these events without passing the event on to the grid can cause unexpected results.  As such, it is wise to add an event handler as opposed to replace the event handler.   Consider using `dojo.connect() <dojo/connect>`_.

The following handlers are defined:

onStyleRow(inRow)
   TBD
onMouseOver(e)
   Fired when the mouse is over the grid.  The event contains references to the grid, cell and rowIndex.
onMouseOut(e)
   Fired when the mouse is leaves the grid.  The event contains references to the grid, cell and rowIndex.
onRowClick(e)
   Fired when a row is clicked.  The event contains references to the grid, cell and rowIndex.
onRowDblClick(e)
   Fired when a row is double clicked.  The event contains references to the grid, cell and rowIndex.

And many more ...

For the above, an event contains the normal DOM Events plus

cell
  TBD
cellIndex
  TBD
cellNode
  TBD
grid
  The DataGrid that caused the event
rowIndex
  The row index in the grid
rowNode
  TBD
sourceView
  TBD



DataGrid options
----------------
In addition to the options for the columns, there are also options available for the DataGrid itself.

jsid
  The name of a JavaScript variable that will be created that will hold the grid object.  This can then be referenced in scripts.
store
  The name of JavaScript variable that holds the store object used to get data for the grid.
rowSelector
  Specifying this table option adds a selection area on the left of the table to make row selection easier.  The value of this option is a width to be used for the selector.
selectionMode
  This option defines how row selection is handled.  Available options are:

* none - No row selection.
* single - Only single row selection.
* multiple - Multiple explicit row selection.  A single click selects a row a second single click deselects the row.
* extended - Multiple row selection including ranges (default).

columnReordering
  This boolean property allows columns to be dynamically reordered.  When enabled, a column header can be dragged and dropped at a new location causing the column to be moved.
headerMenu
  A menu can be associated with a header.  This attribute names a ``dijit.Menu`` which is displayed when the header is clicked.
autoHeight
  A value that defines the height of the table in rows.
singleClickEdit
  A boolean value that defines whether a single or double click is needed to enter cell editing mode.
loadingMessage
  The message to show while the content of the grid is loading.
errorMessage
  The message to show if an error has occurred loading the data.

Editing cells
-------------
A cell can be defined as editable by setting its ``editable`` flag to be ``true``.  In the markup, this is achieved by adding the attribute ``editable="true"`` to the ``<th>`` definition.

If a cell is editable and no ``cellType`` is supplied, then double clicking on the cell will provide an in-place text editor to change its value.

If the type of the cell is a boolean, then its value is displayed as either the string ``true`` or ``false``.  If a check box is desired, setting the ``cellType`` to be ``dojox.grid.cells.Bool`` and marking it as editable will make a checkbox appear.

If the cell type is defined to be ``dojox.grid.cells.Select`` then a combo-box/pulldown is available showing allowable options.

.. Question: How to make a checkbox appear when we don't want the cell to be editable?

Data for the grid
-----------------
Data for the grid comes from a data store.  The data can be specified declaratively using the ``store="name"`` attribute where ``name`` is the name of a global JavaScript object that represents a DataStore.  This could previously have been created as follows:

.. code-block :: html

  <span dojoType="dojo.data.ItemFileWriteStore" 
     jsId="myStore" url="/myData.json">
  </span>

Programatically, a store can be assigned to a DataGrid with the ``setStore(myStore)`` method call.


Locking columns from horizontal scrolling
-----------------------------------------
A set of columns can be *locked* to prevent them from scrolling horizontally while allows other columns to continue to scroll.  To achieve this, the ``<colgroup>`` tags can be inserted before the ``<thead>`` tag.  For example, if a DataGrid has four columns, the following will lock the first column but allow the remaining columns the ability to scroll horizontally:

.. code-block :: html

  <colgroup span="1" noscroll="true"></colgroup>
  <colgroup span="3"></colgroup>

Multi-rowed *rows*
------------------
We are used to a row in a table being a single line of data.  DataGrid provides the ability for a single logical row to contain multiple lines of data.  This can be achieved by adding additional ``<tr>`` tags into the DataGrid declaration.

For example:

.. code-block :: javascript

  <table dojoType="dojox.grid.DataGrid" store="myTestStore" style="width: 800px; height: 300px;">
    <thead>
      <tr>
        <th field="A" width="200px">Col1</th>
        <th field="B" width="200px">Col2</th>
        <th field="C" width="200px">Col3</th>
      </tr>
      <tr>
        <th field="D" colspan="3">Col4</th>
      </tr>
    </thead>
  </table>

Results in a grid with columns A, B and C and a fourth *column* called D which exists on the same row of data.

Required CSS
------------
Some style sheets supplied with the Dojo distribution are required:

.. code-block :: html

  <style type="text/css">
    @import "/dojox/grid/resources/Grid.css";
    @import "/dojox/grid/resources/tundraGrid.css";

    .dojoxGrid table {
      margin: 0;
    }
  </style>


DataGrid object functions
-------------------------

getItem(idx)
  Returns the store ``item`` at the given row index.
getItemIndex(item)
  Returns the row index for the given store ``item``.
setStore
  TBD
setQuery
  TBD
setItems
  TBD
filter
  TBD
sort
  TBD
canSort
  TBD
getSortProps
  TBD
removeSelectedRows
  TBD


Unknown at this time
--------------------
Here are some undocumented (here) components:

* elasticView - An attribute on the table
* rowsPerPage - An attribute on the table
* query - An attribute on the table
* clientSort - An attribute on the table




Getting a value from a row knowing the row index
------------------------------------------------
Assume that you know the row index and the name of the column whos value you wish to retrieve, you can obtain that value using the following snippet:

.. code-block :: javascript

  var value = grid.store.getValue(grid.getItem(rowIndex), name);

====
Tips
====

Creating a grid in a node with display: none
--------------------------------------------

It is not possible to create a grid as a child of a node which is set to be not displayed (display: none).
If you need to do this though for some reason you can set the grids visibility to "hidden" and its position offscreen 

Hiding the Headers of a Grid
----------------------------

You can hide the columns of a Grid by using normal css:

.. code-block :: html

  .dojoxGrid-header { display:none; }


Refreshing the content of a grid
--------------------------------
There are times when you may wish to update the content of the grid.  For example, a button on the screen may cause an xhrGet to retrieve a new set of information that you want to display in the table.  The following code snippet can be used to update the grid:

.. code-block :: javascript

  var newStore = new dojo.data.ItemFileReadStore({data: {... some data ...});
  var grid = dijit.byId("gridId");
  grid.setStore(newStore);

========
See also
========
Here is a set of related links to other Dojo Grid pages on the Web:

* `Introducing the 1.2 DataGrid <http://www.sitepen.com/blog/2008/07/14/dojo-12-grid/>`_
* `New Features in Dojo Grid 1.2 <http://www.sitepen.com/blog/2008/10/22/new-features-in-dojo-grid-12/>`_
* `Dojo Grids: Diving Deeper <http://www.sitepen.com/blog/2007/11/13/dojo-grids-diving-deeper/>`_
* `Simple Dojo Grids <http://www.sitepen.com/blog/2007/11/06/simple-dojo-grids/>`_
* `Dojo Grid Widget Updated. Data Integration and Editing Improvements. <http://ajaxian.com/archives/dojo-grid-widget-updated-data-integration-and-editing-improvements>`_

========
Examples
========

The following examples are for the new Grid 1.2.

* `A Simple Grid <dojox/grid/example_simple_grid>`_
* `Programmatically creating a DataGrid <dojox/grid/example_Programmatically_creating_a_DataGrid>`_
* `Working with selections <dojox/grid/example_Working_with_selections>`_
* `Editing data <dojox/grid/example_Editing_data>`_
* `Adding and deleteing data <dojox/grid/example_Adding_and_deleting_data>`_
* `Filtering data <dojox/grid/example_Filtering_data>`_
* `Grid styling : Rows <dojox/grid/example_grid_styling_rows>`_
