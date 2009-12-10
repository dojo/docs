#format dojo_rst

dojox.grid.EnhancedGrid
=======================

:Status: Draft
:Version: Experimental
:Project owner: Nathan Toone
:Available: since V.1.4

Enhanced DataGrid adds numerous useful features to dojox.grid.

.. contents::
   :depth: 2

============
Introduction
============

EnhancedGrid (dojox.grid.EnhancedGrid) provides a rich set of features that enhance the capabilities of base DataGrid. The following accessible enhancements are implemented in Dojo 1.4:

* Nested Sorting
* Built-in support for Indirect Selection (radio buttons and check boxes)
* Declarative context menus
* Selecting multiple rows or columns by swiping
* Moving multiple rows or columns with drag-n-drop

EnhancedGrid features are implemented as plugins which can be loaded on demand. As a result, the required features must first declared before they can be used.

.. code-example::
  :toolbar: themes, versions, dir
  :version: local
  :width: 480
  :height: 300

  .. javascript::

    <script type="text/javascript" src="{{ baseUrl }}dojo/dojo.js.uncompressed.js"></script>
    <script type="text/javascript">
		dojo.require("dojox.grid.cells.dijit");
    </script>

  .. html::

    <div id="gridDiv" style="width: 100%; height: 100%;"></div>

  .. css::

    <style type="text/css">
        @import "{{ baseUrl }}dojox/grid/resources/Grid.css";
        @import "{{ baseUrl }}dojox/grid/resources/{{ theme }}Grid.css";
		@import "{{ baseUrl }}dojox/grid/enhanced/resources/{{ theme }}EnhancedGrid.css";
		@import "{{ baseUrl }}dojox/grid/enhanced/resources/EnhancedGrid_rtl.css";

        .dojoxGrid table {
            margin: 0;
        }

        html, body {
            width: 100%;
            height: 100%;
            margin: 0;
        }
    </style>

=====
Usage
=====

The following steps show a typical usage of EnhancedGrid:

1. Import related CSS

.. code-block :: javascript
  :linenos:

  <style type="text/css">
      @import "../../../../dijit/themes/tundra/tundra.css";
      @import "../../enhanced/resources/tundraEnhancedGrid.css";
      ...
  </style>


2. Declare required feature plugins 

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
      // Required for all Enhanced features
      dojo.require("dojox.grid.EnhancedGrid");
      // Row/Column drag-drop feature
      dojo.require("dojox.grid.enhanced.plugins.DnD"); 
      // Declarative pop-up menu feature
      dojo.require("dojox.grid.enhanced.plugins.Menu");
      // Nested sorting feature
      dojo.require("dojox.grid.enhanced.plugins.NestedSorting");
      // Indirect selection(check box/radio button selection) feature
      dojo.require("dojox.grid.enhanced.plugins.IndirectSelection");
      ...
  </script>

3. Use features:

.. code-block :: javascript
  :linenos:

  <div id="grid" dojoType="dojox.grid.EnhancedGrid" 
      plugins="{nestedSorting: true, dnd: true, indirectSelection: true,  // Each required feature must be turned on
      menus:{
      headerMenu:'headerMenu',  //References menus defined declaratively below
      rowMenu:'rowMenu',
      cellMenu:'cellMenu',
      selectedRegionMenu:'selectedRegionMenu'}}"
      ...>
  </div>

TODO:  Add a live EDG demo here

==============
Nested Sorting
==============

This feature enhances the single sorting feature of base DataGrid. Nested sorting allows users to sort on one or more columns concurrently and also control the sort direction and order. Finally, columns can be removed from the sort without disturbing the rest of the sort.

.. code-example::
  :toolbar: themes, versions, dir
  :version: local
  :width: 480
  :height: 300

  .. javascript::

    <script type="text/javascript">
		dojo.require("dojox.grid.EnhancedGrid");
		dojo.require("dojox.grid.enhanced.plugins.DnD");
		dojo.require("dojox.grid.enhanced.plugins.Menu");
		dojo.require("dojox.grid.enhanced.plugins.NestedSorting");
		// dojo.require("dojox.grid.enhanced.plugins.IndirectSelection");
        dojo.require("dojox.data.CsvStore");
    
        dojo.addOnLoad(function(){
          // our 
