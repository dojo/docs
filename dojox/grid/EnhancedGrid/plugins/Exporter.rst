#format dojo_rst

dojox.grid.EnhancedGrid
=======================

:Project owner: Nathan Toone
:Available: since V.1.6

Enhanced DataGrid adds numerous useful features to dojox.grid.

.. contents::
   :depth: 2

============
Introduction
============

Exporter is a plugin for dojox.grid.EnhancedGrid. It is designed as a framework to help implement various export formats for grid, e.g. CSV, HTML table, MS Excel, odt etc. The plugin itself does not export anything, it only goes through the grid row by row calling the implementation's interface. It's the implementation's responsibility to transform the grid content to some desired format.
The following of this document first describes how to use the export functions of some existing implementations. And then introduces the API of this framework in detail.

=============
Configuration
=============

Prerequisites
-------------

This exporter plugin is only available for EnhancedGrid. So require the EnhancedGrid first:

.. code-block :: javascript
  :linenos:
  
  dojo.require("dojox.grid.EnhancedGrid");

Unlike other grid plugins, you don't need to ``require`` this plugins directly. Instead, you should ``require`` the specific implementations (i.e. writers). For example, if a CSV format implementation is available, then:

.. code-block :: javascript
  :linenos:
  
  dojo.require("dojox.grid.enhanced.plugins.exporter.CSVWriter");

This statement will automatically require "dojox.grid.enhanced.plugins.Exporter".

Plugin Declaration
------------------

The declaration name of this plugin is ``exporter`` . It is declared in the ``plugins`` property of grid.

If your grid is created declaratively:

.. code-block :: javascript
  :linenos:

  <div id="grid" dojoType="dojox.grid.EnhancedGrid" 
    store="mystore" structure="mystructure" 
    plugins="{
      exporter: true
    }" ></div>

If your grid is created in JavaScript:

.. code-block :: javascript
  :linenos:

  var grid = new dojox.grid.EnhancedGrid({
    id:"grid",
    store:"mystore",
    structure:"mystructure",
    plugins:{
      exporter: true
    }
  });

This plugin does not have any arguments.

=====
Usage
=====

When this plugin is enabled, the following 2 methods are available for a grid widget:

exportGrid(type, args, onExported):
	Export required rows(args.fetchArgs) to a kind of format(type), using the corresponding writer with given arguments(args.writerArgs), then pass the exported text to a given function(onExported).

==============  ==================  ==========================  ===========================================================
Arguments       Type                Optional/Mandatory          Description
==============  ==================  ==========================  ===========================================================
type            String              Mandatory                   A registered export format name.
args            Object              Optional(default to {})     An argument to define fetchArgs and writerArgs like:
                                                                { fetchArgs: {...}, writerArgs: {...} }
                                                                fetchArgs is some arguments for store.fetch.
                                                                writerArgs is some arguments for the current wirter.
onExported      function(string)    Mandatory                   Call back function when export result is ready.
==============  ==================  ==========================  ===========================================================

exportSelected(type, writerArgs):
	Export only the selected rows of a grid to the specified format. Returns the exported string.

==============  ==================  ==========================  =======================================
Arguments       Type                Optional/Mandatory          Description
==============  ==================  ==========================  =======================================
type            String              Mandatory                   A registered export format name.
writerArgs      Object              Optional(default to {})     Some arguments for the current wirter.
==============  ==================  ==========================  =======================================

For example:

.. code-block :: javascript
  :linenos:
  
  //Export the whole grid to CSV format, with separator of ":".
  grid.exportGrid("csv", {writerArgs: {separator:":"}}, function(str){
    // do something interesting with str
  });
  //Export the first 10 rows to CSV format.
  grid.exportGrid("csv", {fetchArgs: {start: 0, count: 10}}, function(str){
    // do something interesting with str
  });
  //Only export the selected rows to CSV format.
  var str = grid.exportSelected("csv", {separator:":"});

===================================================
Create Export Writer -- A Framework for Grid Export
===================================================

To create your own exporter, you should use this export framework by extending an abstract class: _ExportWriter.

_ExportWriter – The Base Class
------------------------------

This is an abstract class for all of the writers used in the Exporter plugin. It applies the strategy pattern to break the export work into several stages, and provides interfaces for all of them. Implementations might choose to override some of the functions in this class thus providing their own functionality. The Exporter will go through the grid row by row. In every row, all the Views will be reached and the header row is only handled once. The APIs exposed by this class to implementors is shown below. You can implement them by extending "dojox.grid.enhanced.plugins.exporter._ExportWriter".

beforeHeader
	We are going to start moving through the grid. Is there anything we should do now?

=========  ========================  ==============================================================
Arguments  Type                      Description
=========  ========================  ==============================================================
grid       dojox.grid.EnhancedGrid   The grid widget.
[return]   Boolean                   true: go on handling the header row and then call afterHeader.
                                     false: skip the header row, won't call afterHeader.
=========  ========================  ==============================================================

afterHeader
	The header has been handled.

beforeContent
	We are ready to go through all the contents(items).
	
=========  ========================  ==============================================================
Arguments  Type                      Description
=========  ========================  ==============================================================
items      Array                     All the items fetched from the store.
[return]   Boolean                   true: go on handling the contents and then call afterContent.
                                     false: skip all the contents, won't call afterContent.
=========  ========================  ==============================================================

afterContent
	We have finished the entire grid travel. Do some clean up work if you need to.
	
beforeContentRow
	Before handling a line of data (not a header).

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row,rowIdx, spCols }
[return]   Boolean                   true: go on handling the current data row and then call afterContentRow.
                                     false: skip the current data row, won't call afterContentRow.
=========  ========================  =========================================================================

afterContentRow
	After handling a line of data (not header).

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row,rowIdx, spCols }
=========  ========================  =========================================================================

beforeView
	Before handling a view.

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row, rowIdx, spCols }
[return]   Boolean                   true: go on handling the current view and then call afterView.
                                     false: skip the current view, won't call afterView.
=========  ========================  =========================================================================

afterView
	After handling a view.

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                      { grid, isHeader, row, rowIdx, spCols }
=========  ========================  =========================================================================

beforeSubrow
	Before handling a subrow (defined in the grid structure as "rows").

=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row, rowIdx, view, viewIdx, subrow, subrowIdx, spCols }
[return]   Boolean                   true: go on handling the current subrow and then call afterSubrow.
                                     false: skip the current subrow, won't call afterSubrow.
=========  ========================  =========================================================================

afterSubrow
	After handling a subrow (defined in the grid structure as "rows").

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row, rowIdx, view, viewIdx, subrow, subrowIdx, spCols }
=========  ========================  =========================================================================

handleCell
	Handle a header cell or data cell.

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row, rowIdx, view, viewIdx, subrow,subrowIdx, 
                                     cell, cellIdx, spCols, colOffset }
=========  ========================  =========================================================================

toString
	Export to a string.
	
=========  ========================  ===========================
Arguments  Type                      Description
=========  ========================  ===========================
[return]   String                    The exported result string.
=========  ========================  ===========================

The argument ``argObj`` represents the context of each function when they are called and may have the following properties:

===========  ========================  ===========================  ==========================================================================================================================
Name         Data Type                 When Available               Description
===========  ========================  ===========================  ==========================================================================================================================
grid         dojox.grid.EnhancedGrid   Always                       The grid widget we are now handling.
isHeader     Boolean                   Always                       Indicating which context we're handling, header or content.
view         dojox.grid._View          beforeView                   Reference to the current _View object.
                                       afterView
                                       beforeSubrow
                                       afterSubrow
                                       handleCell
viewIdx      Integer                   beforeView                   The index of the current _View object in the views array.
                                       afterView                    If the grid does not have any rowselector view, it conforms to the index in the _ViewManager.views.
                                       beforeSubrow
                                       afterSubrow
                                       handleCell
row          data item                 beforeContentRow             The current row of data (logically), a.k.a.: current item.
                                       afterContentRow
                                       beforeSubrow
                                       afterSubrow
                                       handleCell
rowIdx       Integer                   beforeContentRow             The index of the current row (item).
                                       afterContentRow
                                       beforeSubrow
                                       afterSubrow
                                       handleCell
subrow       dojox.grid.cells._base[]  beforeSubrow                 Reference to the current subrow.
                                       afterSubrow                  A subrow describe the innter structure of a row in a view, it's an array of cells
                                       handleCell
subrowIdx    Integer                   beforeSubrow                 The index of the current subrow in the subrow array: _View.structure.cells.
                                       afterSubrow
                                       handleCell
cell         dojox.grid.cells._base    handleCell                   Reference to the current cell.
cellIdx      Integer                   handleCell                   The index of the current cell in the current subrow.
                                                                    It's different from cell.index, which is the index in the whole line.
spCols       Integer[]                 beforeContentRow             The header line has been handled. An array of special column indexes(flat,not regarding structure).
                                       afterContentRow              Special columns are typically attached to grid as a kind of UI facility by the grid widget, instead of some real data.
                                       beforeView                   For example: indirect selectors and row indexers.
                                       afterView                    Users can choose to export it or not.
                                       beforeSubrow
                                       afterSubrow
                                       handleCell
colOffset    Integer                   handleCell                   If the grid has a _RowSelector view or something else, this view will NOT be passed to the user in argObj. 
                                                                    So the column index (cell.index) will appear shifted (start from 1 instead of 0). 
                                                                    This colOffset is provided to remove this shift.
===========  ========================  ===========================  ==========================================================================================================================

Register Your Own Writer
------------------------

Once you have implemented your own export writer, tell the framework about the name of your format. For the "CSV" case, you should write the following line in your implementation file:

.. code-block :: javascript
  :linenos:
  
  dojox.grid.enhanced.plugins.Exporter.registerWriter("csv", "dojox.grid.enhanced.plugins.exporter.CSVWriter");

Available Export Writers
------------------------

The following writers are currently available in the dojox/grid/enhanced/plugins/exporter package: 

===============  ==============  =====================
Writer Class     Format Name     Writer Argument
===============  ==============  =====================
CSVWriter        "csv"           "separator"
TableWriter      "table"         HTML table attributes
===============  ==============  =====================

Example
-------

Here is the structure of the implementation file of the CSVWriter, demonstrating how to write an export writer. It only implements 3 interfaces. 

.. code-block :: javascript
  :linenos:

  //First delcare your class.
  dojo.provide("dojox.grid.enhanced.plugins.exporter.CSVWriter");

  //Require the base class.
  dojo.require("dojox.grid.enhanced.plugins.exporter._ExportWriter");

  //Register the CSV format name.
  dojox.grid.enhanced.plugins.Exporter.registerWriter("csv",
    "dojox.grid.enhanced.plugins.exporter.CSVWriter");

  //Extend from the base class.
  dojo.declare("dojox.grid.enhanced.plugins.exporter.CSVWriter",
  dojox.grid.enhanced.plugins.exporter._ExportWriter,{
    //Separator is the only argument.
    _separator: ',',

    constructor: function(/* object? */writerArgs){
      //Handle arguments (separator in this case), and do some initialization here.
    },

    _formatCSVCell: function(/* string */cellValue){
      //Format cell value to follow CSV standard.
      //See: http://en.wikipedia.org/wiki/Comma-separated_values
    },

    beforeContentRow: function(/* object */argObj){
      //Overrided from _ExportWriter
      //For each column,
      //	get the cell data of the current row, and format them with _formatCSVCell
      //Join these cell data together with the separater.
      //Save the result.
      //return false, because we don't need to go into the row. Thus improves the performance.
    },

    handleCell: function(/* object */arg_obj){
      // summary:
      //		Overrided from _ExportWriter
      //Check if arg_obj.isHeader is true. We have already handled content cells in the above function, 
      //here we only need to deal with the header cells.
      //You can get the header name by arg_obj.cell.name.
    },

    toString: function(){
      //Overrided from _ExportWriter
      //Join all the saved result together and return.
    }
  });
