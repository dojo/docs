.. _dojox/grid/EnhancedGrid/plugins/Exporter:

========================================
dojox.grid.EnhancedGrid.plugins.Exporter
========================================

:Authors: Oliver Zhu
:Project owner: Evan Huang
:since: V.1.6

Exporter plugin provides functions to export the grid data into a given format.

.. contents ::
   :depth: 2

Introduction
============

Exporter is a plugin for dojox.grid.EnhancedGrid. It is designed as a framework to help implement various export formats for grid, e.g. CSV, HTML table, MS Excel, odt etc. The plugin itself does not export anything, it only goes through the grid row by row calling the implementation's interface. It's the implementation's responsibility to transform the grid content to some desired format.
The following of this document first describes how to use the export functions of some existing implementations. And then introduces the API of this framework in detail.

.. code-example::
  :toolbar: themes, versions, dir
  :width: 600
  :height: 550

  .. js ::

        dojo.require("dojox.grid.EnhancedGrid");
        dojo.require("dojo.data.ItemFileWriteStore");
        dojo.require("dojox.grid.enhanced.plugins.exporter.CSVWriter");

        var data = {
            identifier: 'id',
            label: 'id',
            items: []
        };
        var data_list = [
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Bette Midler", "Year":2003, "Album":"Bette Midler Sings the Rosemary Clooney Songbook", "Name":"Hey There", "Length":"03:31", "Track":4, "Composer":"Ross, Jerry 1926-1956 -w Adler, Richard 1921-", "Download Date":"1923/4/9", "Last Played":"04:32:49"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Jimi Hendrix", "Year":1993, "Album":"Are You Experienced", "Name":"Love Or Confusion", "Length":"03:15", "Track":4, "Composer":"Jimi Hendrix", "Download Date":"1947/12/6", "Last Played":"03:47:49"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Andy Narell", "Year":1992, "Album":"Down the Road", "Name":"Sugar Street", "Length":"07:00", "Track":8, "Composer":"Andy Narell", "Download Date":"1906/3/22", "Last Played":"21:56:15"},
            {"Heard": true, "Checked": "True", "Genre":"Progressive Rock", "Artist":"Emerson, Lake & Palmer", "Year":1992, "Album":"The Atlantic Years", "Name":"Tarkus", "Length":"20:40", "Track":5, "Composer":"Greg Lake/Keith Emerson", "Download Date":"1994/11/29", "Last Played":"03:25:19"},
            {"Heard": true, "Checked": "True", "Genre":"Rock", "Artist":"Blood, Sweat & Tears", "Year":1968, "Album":"Child Is Father To The Man", "Name":"Somethin' Goin' On", "Length":"08:00", "Track":9, "Composer":"", "Download Date":"1973/9/11", "Last Played":"19:49:41"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Andy Narell", "Year":1989, "Album":"Little Secrets", "Name":"Armchair Psychology", "Length":"08:20", "Track":5, "Composer":"Andy Narell", "Download Date":"2010/4/15", "Last Played":"01:13:08"},
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Frank Sinatra", "Year":1991, "Album":"Sinatra Reprise: The Very Good Years", "Name":"Luck Be A Lady", "Length":"05:16", "Track":4, "Composer":"F. Loesser", "Download Date":"2035/4/12", "Last Played":"06:16:53"},
            {"Heard": true, "Checked": "True", "Genre":"Progressive Rock", "Artist":"Dixie dregs", "Year":1977, "Album":"Free Fall", "Name":"Sleep", "Length":"01:58", "Track":6, "Composer":"Steve Morse", "Download Date":"2032/11/21", "Last Played":"08:23:26"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Black Sabbath", "Year":2004, "Album":"Master of Reality", "Name":"Sweet Leaf", "Length":"05:04", "Track":1, "Composer":"Bill Ward/Geezer Butler/Ozzy Osbourne/Tony Iommi", "Download Date":"2036/5/26", "Last Played":"22:10:19"},
            {"Heard": true, "Checked": "True", "Genre":"Blues", "Artist":"Buddy Guy", "Year":1991, "Album":"Damn Right, I've Got The Blues", "Name":"Five Long Years", "Length":"08:27", "Track":3, "Composer":"Eddie Boyd/John Lee Hooker", "Download Date":"1904/4/4", "Last Played":"18:28:08"},
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Frank Sinatra", "Year":1991, "Album":"Sinatra Reprise: The Very Good Years", "Name":"The Way You Look Tonight", "Length":"03:23", "Track":5, "Composer":"D. Fields/J. Kern", "Download Date":"1902/10/12", "Last Played":"23:09:23"}];

        var i, len;
        for(i=0, len = data_list.length; i < len; ++i){
            data.items.push(dojo.mixin({'id': i + 1 }, data_list[i % len]));
        }

        function exportAll(){
            dijit.byId("grid").exportGrid("csv", function(str){
                dojo.byId("output").value = str;
            });
        };
        function exportSelected(){
            var str = dijit.byId("grid").exportSelected("csv");
            dojo.byId("output").value = str;
        };

        dojo.ready(function(){

            var store = new dojo.data.ItemFileWriteStore({data: data});

            var layout = [
                { field: "id"},
                { field: "Genre"},
                { field: "Artist"},
                { field: "Album"},
                { field: "Name"},
                { field: "Track"},
                { field: "Download Date"},
                { field: "Last Played"}
            ];

            var grid = new dojox.grid.EnhancedGrid({
                id: 'grid',
                store: store,
                structure: layout,
                plugins: {
                    exporter: true
                }
            });
            grid.placeAt('gridContainer');
            grid.startup();
        });

  .. html ::

    <div id="gridContainer"></div>
    <br />
    <button onclick="exportAll()">Export all to CSV</button>
    <button onclick="exportSelected()">Export Selected Rows to CSV</button>
    <br />
    <textarea id="output"></textarea>

  .. css ::

    @import "{{baseUrl}}dojo/resources/dojo.css";
    @import "{{baseUrl}}dijit/themes/claro/claro.css";
    @import "{{baseUrl}}dijit/themes/claro/document.css";
    @import "{{baseUrl}}dojox/grid/enhanced/resources/claro/EnhancedGrid.css";
    @import "{{baseUrl}}dojox/grid/enhanced/resources/EnhancedGrid_rtl.css";

    #output {
        width: 100%;
        height: 150px;
    }
    #gridContainer {
        width: 100%;
        height: 250px;
    }


Configuration
=============

Prerequisites
-------------

This exporter plugin is only available for EnhancedGrid. So require the EnhancedGrid first:

.. js ::
    
  dojo.require("dojox.grid.EnhancedGrid");

Unlike other grid plugins, you don't need to ``require`` this plugins directly. Instead, you should ``require`` the specific implementations (i.e. writers). For example, if a CSV format implementation is available, then:

.. js ::
    
  dojo.require("dojox.grid.enhanced.plugins.exporter.CSVWriter");

This statement will automatically require "dojox.grid.enhanced.plugins.Exporter".

Plugin Declaration
------------------

The declaration name of this plugin is ``exporter`` . It is declared in the ``plugins`` property of grid.

If your grid is created declaratively:

.. html ::
  
  <div id="grid" data-dojo-type="dojox.grid.EnhancedGrid"
    data-dojo-props="store:mystore, structure:'mystructure',
    plugins:{
      exporter: true
  }" ></div>

If your grid is created in JavaScript:

.. js ::
  
  var grid = new dojox.grid.EnhancedGrid({
    id:"grid",
    store:"mystore",
    structure:"mystructure",
    plugins:{
      exporter: true
    }
  });

This plugin does not have any arguments.

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
                                                                writerArgs is some arguments for the current writer.
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

.. js ::
    
  // Export the whole grid to CSV format, with separator of ":".
  grid.exportGrid("csv", {writerArgs: {separator:":"}}, function(str){
    // do something interesting with str
  });
  // Export the first 10 rows to CSV format.
  grid.exportGrid("csv", {fetchArgs: {start: 0, count: 10}}, function(str){
    // do something interesting with str
  });
  // Only export the selected rows to CSV format.
  var str = grid.exportSelected("csv", {separator:":"});

Create Export Writer -- A Framework for Grid Export
===================================================

To create your own exporter, you should use this export framework by extending an abstract class: _ExportWriter.

_ExportWriter – The Base Class
------------------------------

This is an abstract class for all of the writers used in the Exporter plugin. It applies the strategy pattern to break the export work into several stages, and provides interfaces for all of them. Implementations might choose to override some of the functions in this class thus providing their own functionality. The Exporter will go through the grid row by row. In every row, all the Views will be reached and the header row is only handled once. The APIs exposed by this class to implementers is shown below. You can implement them by extending "dojox.grid.enhanced.plugins.exporter._ExportWriter".

beforeHeader(grid):
    We are going to start moving through the grid. Is there anything we should do now?

=========  ========================  ==============================================================
Arguments  Type                      Description
=========  ========================  ==============================================================
grid       dojox.grid.EnhancedGrid   The grid widget.
[return]   Boolean                   true: go on handling the header row and then call afterHeader.
                                     false: skip the header row, won't call afterHeader.
=========  ========================  ==============================================================

afterHeader():
    The header has been handled.

beforeContent(items):
    We are ready to go through all the contents(items).

=========  ========================  ==============================================================
Arguments  Type                      Description
=========  ========================  ==============================================================
items      Array                     All the items fetched from the store.
[return]   Boolean                   true: go on handling the contents and then call afterContent.
                                     false: skip all the contents, won't call afterContent.
=========  ========================  ==============================================================

afterContent():
    We have finished the entire grid travel. Do some clean up work if you need to.

beforeContentRow(argObj):
    Before handling a line of data (not a header).

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row,rowIdx, spCols }
[return]   Boolean                   true: go on handling the current data row and then call afterContentRow.
                                     false: skip the current data row, won't call afterContentRow.
=========  ========================  =========================================================================

afterContentRow(argObj):
    After handling a line of data (not header).

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row,rowIdx, spCols }
=========  ========================  =========================================================================

beforeView(argObj):
    Before handling a view.

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row, rowIdx, spCols }
[return]   Boolean                   true: go on handling the current view and then call afterView.
                                     false: skip the current view, won't call afterView.
=========  ========================  =========================================================================

afterView(argObj):
    After handling a view.

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                      { grid, isHeader, row, rowIdx, spCols }
=========  ========================  =========================================================================

beforeSubrow(argObj):
    Before handling a subrow (defined in the grid structure as "rows").

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row, rowIdx, view, viewIdx, subrow, subrowIdx, spCols }
[return]   Boolean                   true: go on handling the current subrow and then call afterSubrow.
                                     false: skip the current subrow, won't call afterSubrow.
=========  ========================  =========================================================================

afterSubrow(argObj):
    After handling a subrow (defined in the grid structure as "rows").

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row, rowIdx, view, viewIdx, subrow, subrowIdx, spCols }
=========  ========================  =========================================================================

handleCell(argObj):
    Handle a header cell or data cell.

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row, rowIdx, view, viewIdx, subrow,subrowIdx,
                                     cell, cellIdx, spCols, colOffset }
=========  ========================  =========================================================================

toString():
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
                                       afterSubrow                  A subrow describing the inner structure of a row in a view, it's an array of cells
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

.. js ::
    
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

.. js ::
  
  // First declare your class.
  dojo.provide("dojox.grid.enhanced.plugins.exporter.CSVWriter");

  // Require the base class.
  dojo.require("dojox.grid.enhanced.plugins.exporter._ExportWriter");

  // Register the CSV format name.
  dojox.grid.enhanced.plugins.Exporter.registerWriter("csv",
    "dojox.grid.enhanced.plugins.exporter.CSVWriter");

  // Extend from the base class.
  dojo.declare("dojox.grid.enhanced.plugins.exporter.CSVWriter",
  dojox.grid.enhanced.plugins.exporter._ExportWriter,{
    // Separator is the only argument.
    _separator: ',',

    constructor: function(/* object? */ writerArgs){
      // Handle arguments (separator in this case), and do some initialization here.
    },

    _formatCSVCell: function(/*string*/ cellValue){
      // Format cell value to follow CSV standard.
      // See: http://en.wikipedia.org/wiki/Comma-separated_values
    },

    beforeContentRow: function(/*object*/ argObj){
      // Overridden from _ExportWriter
      // For each column,
      //    get the cell data of the current row, and format them with _formatCSVCell
      // Join these cell data together with the separator.
      // Save the result.
      // return false, because we don't need to go into the row. Thus improves the performance.
    },

    handleCell: function(/*object*/ arg_obj){
      // summary:
      //        Overridden from _ExportWriter
      // Check if arg_obj.isHeader is true. We have already handled content cells in the above function,
      // here we only need to deal with the header cells.
      // You can get the header name by arg_obj.cell.name.
    },

    toString: function(){
      // Overridden from _ExportWriter
      // Join all the saved result together and return.
    }
  });

See Also
========

* :ref:`dojox.grid.DataGrid <dojox/grid/DataGrid>` - The base grid
* :ref:`dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>` - The enhanced grid supporting plugins
* :ref:`dojox.grid.EnhancedGrid.plugins <dojox/grid/EnhancedGrid/plugins>` - Overview of the plugins of enhanced grid
* :ref:`dojox.grid.TreeGrid <dojox/grid/TreeGrid>` - Grid with collapsible rows and model-based (:ref:`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`) structure
