.. _dojox/grid/EnhancedGrid/plugins/Printer:

=======================================
dojox.grid.EnhancedGrid.plugins.Printer
=======================================

:Authors: Oliver Zhu
:Project owner: Evan Huang
:since: V.1.6

Printer plugin provides some convenient methods to print the grid data.

.. contents ::
   :depth: 2

Introduction
============

This plugin is based on the Exporter plugin. Actually, an export writer, TableWriter, is used to transfer the grid data to HTML tables. This simple plugin decorates these HTML tables with customized CSS styles and table properties, and forms a complete HTML page for printing.

.. code-example::
  :toolbar: themes, versions, dir
  :width: 400
  :height: 400

  .. js ::

        dojo.require("dojox.grid.EnhancedGrid");
        dojo.require("dojo.data.ItemFileWriteStore");
        dojo.require("dojox.grid.enhanced.plugins.Printer");

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
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Frank Sinatra", "Year":1991, "Album":"Sinatra Reprise: The Very Good Years", "Name":"The Way You Look Tonight", "Length":"03:23", "Track":5, "Composer":"D. Fields/J. Kern", "Download Date":"1902/10/12", "Last Played":"23:09:23"},
            {"Heard": true, "Checked": "True", "Genre":"World", "Artist":"Andy Statman & David Grisman", "Year":1995, "Album":"Songs Of Our Fathers", "Name":"Chassidic Medley: Adir Hu / Moshe Emes", "Length":"04:14", "Track":2, "Composer":"Shlomo Carlebach; Trad.", "Download Date":"2035/2/9", "Last Played":"00:11:15"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Jimi Hendrix", "Year":1968, "Album":"Electric Ladyland", "Name":"Long Hot Summer Night", "Length":"03:27", "Track":6, "Composer":"Jimi Hendrix", "Download Date":"1902/4/7", "Last Played":"16:58:08"},
            {"Heard": true, "Checked": "True", "Genre":"Classical", "Artist":"Andres Segovia", "Year":2004, "Album":"The Best Of Andres Segovia", "Name":"Asturias (Suite Espanola, Op. 47)", "Length":"06:25", "Track":6, "Composer":"Isaac Albeniz", "Download Date":"1904/10/25", "Last Played":"06:59:04"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Andy Narell", "Year":1989, "Album":"Little Secrets", "Name":"We Kinda Music", "Length":"08:22", "Track":3, "Composer":"Andy Narell", "Download Date":"1905/5/22", "Last Played":"23:43:08"},
            {"Heard": true, "Checked": "True", "Genre":"Pop and R&B", "Artist":"Joni Mitchell", "Year":2000, "Album":"Both Sides Now", "Name":"Comes Love", "Length":"04:29", "Track":3, "Composer":"Charles Tobias/Sammy Stept/Lew Brown", "Download Date":"1927/11/19", "Last Played":"02:34:41"}];

        var i, len;
        for(i=0, len = data_list.length; i < len; ++i){
            data.items.push(dojo.mixin({'id': i + 1 }, data_list[i % len]));
        }

        var cssFiles = [
            "{{ baseUrl }}dojox/grid/tests/enhanced/support/print_style1.css",
            "{{ baseUrl }}dojox/grid/tests/enhanced/support/print_style2.css"
        ];
        function printAll(){
            dijit.byId("grid").printGrid({
                title: "Music Store - All",
                cssFiles: cssFiles
            });
        }
        function printSelected(){
            dijit.byId("grid").printSelected({
                title: "Music Store - Selected",
                cssFiles: cssFiles
            });
        }
        function printCustomized(){
            dijit.byId("grid").printGrid({
                title: "Music Store - Customized",
                cssFiles: cssFiles,
                fetchArgs: {
                    start: 0,
                    count: 10
                }
            });
        }
        function preview(str){
            var win = window.open();
            win.document.open();
            win.document.write(str);
            /*Adjust row height/view width for multi-view grid*/
            dijit.byId("grid").normalizePrintedGrid(win.document);
            win.document.close();
        }
        function previewAll(){
            dijit.byId("grid").exportToHTML({
                title: "Music Store - All",
                cssFiles: cssFiles
            }, preview);
        }
        function previewSelected(){
            preview(dijit.byId("grid").exportSelectedToHTML({
                title: "Music Store - Selected",
                cssFiles: cssFiles
            }));
        }
        function previewCustomized(){
            dijit.byId("grid").exportToHTML({
                title: "Music Store - Customized",
                cssFiles: cssFiles,
                fetchArgs: {
                    start: 0,
                    count: 10
                }
            }, preview);
        }

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
                    printer: true
                }
            });
            grid.placeAt('gridContainer');
            grid.startup();
        });

  .. html ::

    <div id="gridContainer"></div>
    <button onclick="printAll()">Print All</button>
    <button onclick="printSelected()">Print Selected</button>
    <button onclick="printCustomized()">Print First 10 Rows</button>
    <button onclick="previewAll()">Preview All</button>
    <button onclick="previewSelected()">Preview Selected</button>
    <button onclick="previewCustomized()">Preview First 10 Rows</button>

  .. css ::

    @import "{{baseUrl}}dojo/resources/dojo.css";
    @import "{{baseUrl}}dijit/themes/claro/claro.css";
    @import "{{baseUrl}}dijit/themes/claro/document.css";
    @import "{{baseUrl}}dojox/grid/enhanced/resources/claro/EnhancedGrid.css";
    @import "{{baseUrl}}dojox/grid/enhanced/resources/EnhancedGrid_rtl.css";

    #gridContainer{
        width: 100%;
        height: 250px;
    }

Configuration
=============

Prerequisites
-------------

This printer plugin is only available for EnhancedGrid, so use the following statement in the head of your HTML file:

.. js ::
  
  dojo.require("dojox.grid.EnhancedGrid");
  dojo.require("dojox.grid.enhanced.plugins.Printer");

Note that this Printer plugin is based on the Exporter plugin, so there's no need to "require" the Exporter plugin anymore if you'd like to use the Export functions.

Plugin Declaration
------------------

The declaration name of this plugin is ``printer`` . It is declared in the ``plugins`` property of grid.

If your grid is created declaratively:

.. html ::
  
  <div id="grid" data-dojo-type="dojox.grid.EnhancedGrid"
    data-dojo-props="store:mystore, structure:'mystructure',
    plugins:{
      printer: true
  }" ></div>

If your grid is created in JavaScript:

.. js ::
  
  var grid = new dojox.grid.EnhancedGrid({
    id:"grid",
    store:"mystore",
    structure:"mystructure",
    plugins:{
      printer: true
    }
  });

This plugin does not have any arguments.

Usage
=====

When this plugin is enabled, the following methods are available in a grid widget:

printGrid
    Print desired rows in the grid (by ``fetchArgs``), using ``title`` as a title, decorating generated html by ``cssFiles``, using ``writerArgs`` (tagName:"attributeList" pairs) to control html tags in the generated html string.

==============  ==================  ==========================  ====================================================
Arguments       Type                Optional/Mandatory          Description
==============  ==================  ==========================  ====================================================
args            Object              Optional(default to {})     Including title, cssFiles, fetchArgs and writerArgs
==============  ==================  ==========================  ====================================================

printSelected
    Print selected rows.

==============  ==================  ==========================  ====================================================
Arguments       Type                Optional/Mandatory          Description
==============  ==================  ==========================  ====================================================
args            Object              Optional(default to {})     Including title, cssFiles and writerArgs
==============  ==================  ==========================  ====================================================

exportToHTML
    Export to HTML string, but do NOT print. Users can use this to implement print preview.
    When exporting multi-view grid, the proper width of each view and the height of each row won't be valid until the exported string is put into a document. So in this case, you will need to call grid.normalizePrintedGrid(doc):

.. js ::
  
  grid.exportToHTML({
    ...
  }, function(str){
    // Preview the printed grid in a separate window.
    var win = window.open();
    win.document.open();
    win.document.write(str);
    // Normalize the printed grid, so the width and height of each view and row are correct.
    grid.normalizePrintedGrid(win.document);
    win.document.close();
  });

==============  ==================  ==========================  =======================================================
Arguments       Type                Optional/Mandatory          Description
==============  ==================  ==========================  =======================================================
args            Object              Optional(default to {})     Including title, cssFiles, fetchArgs and writerArgs
onExported      function(string)    Mandatory                   Callback function, do something with the result string.
==============  ==================  ==========================  =======================================================

exportSelectedToHTML
    Export selected rows to HTML string, but do NOT print. Users can use this to implement print preview.
    You'll also probably need to call grid.normalizePrintedGrid(doc), see the above explanation.

==============  ==================  ==========================  ====================================================
Arguments       Type                Optional/Mandatory          Description
==============  ==================  ==========================  ====================================================
args            Object              Optional(default to {})     Including title, cssFiles and writerArgs
==============  ==================  ==========================  ====================================================

The content of the args parameter for the above functions is:

===========  ==========  ======================================================================================================
Parameter    Type        Description
===========  ==========  ======================================================================================================
title        String      A title of the printed page can be specified. Optional.
                         If given, it's shown in an <h1> tag at the top of the page.
cssFiles     String[]    CSS file paths. Used to customize the style of grid. See the next section for detailed configurations.
writerArgs   Object      Arguments for TableWriter (html properties for <table> element)
===========  ==========  ======================================================================================================

Customize the Style of the Printed Grid
=======================================

The CSS classes predefined in the generated HTML tables are also an important part of the APIs. Here's the complete list:

=======================  ======================================================================================  ==============
CSS class                Meaning                                                                                 For HTML tags
=======================  ======================================================================================  ==============
grid_col_${col-index}    Available for every column. ${col-index} is the index of column, starting from 1.       <th>,<td>
grid_row_${row-index}    Available for every row. ${row-index} is the index of row, starting from 1.             <tbody>
grid_odd_col             Available for columns with odd indexes.                                                 <th>,<td>
grid_odd_row             Available for rows with odd indexes                                                     <tbody>
grid_even_col            Available for columns with even indexes.                                                <th>,<td>
grid_even_row            Available for rows with even indexes                                                    <tbody>
grid_header              Available only for the header row                                                       <thead>
grid_row                 Available for all grid content rows                                                     <tbody>
=======================  ======================================================================================  ==============

You can use these classes directly in your CSS files, and pass them to the cssFiles argument mentioned above.
But you cannot define your own CSS classes.

See Also
========

* :ref:`dojox.grid.DataGrid <dojox/grid/DataGrid>` - The base grid
* :ref:`dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>` - The enhanced grid supporting plugins
* :ref:`dojox.grid.EnhancedGrid.plugins <dojox/grid/EnhancedGrid/plugins>` - Overview of the plugins of enhanced grid
* :ref:`dojox.grid.EnhancedGrid.plugins.Exporter <dojox/grid/EnhancedGrid/plugins/Exporter>` - The Exporter plugin
* :ref:`dojox.grid.TreeGrid <dojox/grid/TreeGrid>` - Grid with collapsible rows and model-based (:ref:`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`) structure
