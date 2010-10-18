#format dojo_rst

dojox.grid.EnhancedGrid.plugins.Printer
=======================================

:Project owner: Nathan Toone
:Available: since V.1.6

Printer plugins provides some convenient methods to print the grid data.

.. contents::
   :depth: 2

============
Introduction
============

This plugin is based on the Exporter plugin. Actually, an export writer, TableWriter, is used to transfer the grid data to HTML tables. This simple plugin decorates these HTML tables with customized CSS styles and table properties, and forms a complete HTML page for printing.

=============
Configuration
=============

Prerequisites
-------------

This printer plugin is only available for EnhancedGrid, so use the following statement in the head of your HTML file:

.. code-block :: javascript
  :linenos:

  dojo.require("dojox.grid.EnhancedGrid");
  dojo.require("dojox.grid.enhanced.plugins.Printer");

Note that this Printer plugin is based on the Exporter plugin, so there's no need to "require" the Exporter plugin anymore if you'd like to use the Export functions.

Plugin Declaration
------------------

The declaration name of this plugin is ``printer`` . It is declared in the ``plugins`` property of grid.

If your grid is created declaratively:

.. code-block :: javascript
  :linenos:

  <div id="grid" dojoType="dojox.grid.EnhancedGrid" 
    store="mystore" structure="mystructure" 
    plugins="{
      printer: true
    }" ></div>

If your grid is created in JavaScript:

.. code-block :: javascript
  :linenos:

  var grid = new dojox.grid.EnhancedGrid({
    id:"grid",
    store:"mystore",
    structure:"mystructure",
    plugins:{
      printer: true
    }
  });

This plugin does not have any arguments.

=====
Usage
=====

When this plugin is enabled, the following methods are available in a grid widget:

printGrid
	Print desired rows in the grid (by ``fetchArgs``), using ``title`` as a title, decorating generated html by ``cssFiles``, using ``writerArgs`` (tagName:"attrbuteList" pairs) to control html tags in the generated html string.

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

==============  ==================  ==========================  =======================================================
Arguments       Type                Optional/Mandatory          Description
==============  ==================  ==========================  =======================================================
args            Object              Optional(default to {})     Including title, cssFiles, fetchArgs and writerArgs
onExported      function(string)    Mandatory                   Callback function, do something with the result string.
==============  ==================  ==========================  =======================================================

exportSelectedToHTML
	Export selected rows to HTML string, but do NOT print. Users can use this to implement print preview.

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

=======================================
Customize the Style of the Printed Grid
=======================================

The CSS classes predefined in the generated HTML tables are also an important part of the APIs. Here's the complete list:

=======================  ======================================================================================  ==============
CSS class                Meaning                                                                                 For HTML tags
=======================  ======================================================================================  ==============
grid_col_${col-index}    Available for every column. ${col-index} is the index of column, starting from 1.  	 <th>,<td>
grid_row_${row-index}    Available for every row. ${row-index} is the index of row, starting from 1. 	         <tbody>
grid_odd_col             Available for columns with odd indexes.                                                 <th>,<td>
grid_odd_row             Available for rows with odd indexes                                                     <tbody>
grid_even_col            Available for columns with even indexes.                                                <th>,<td>
grid_even_row            Available for rows with even indexes                                                    <tbody>
grid_header              Available only for the header row                                                       <thead>
grid_row                 Available for all grid content rows                                                     <tbody>
=======================  ======================================================================================  ==============

You can use these classes directly in your CSS files, and pass them to the cssFiles argument mentioned above.
But you cannot define your own CSS classes.
