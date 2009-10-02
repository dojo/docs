#format dojo_rst

dojox.widget.DataPresentation
=============================

:Status: Draft
:Version: Experimental
:Project owner: Dean Williams
:Available: since V.1.4

DataPresentation provides ...

.. contents::
   :depth: 2

============
Introduction
============

DataPresentation provides a rich set of features that ...

* feature 1
* feature 2
* feature 3

=====
Usage
=====

The following steps show a typical usage of DataPresentation:

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
      dojo.require("dojox.grid.EnhancedGrid");                          // Required for all Enhanced features
      dojo.require("dojox.grid.enhanced.plugins.DnD");                  // Row/Column drag-drop feature
      dojo.require("dojox.grid.enhanced.plugins.Menu");                 // Declarative pop-up menu feature
      dojo.require("dojox.grid.enhanced.plugins.NestedSorting");        // Nested sorting feature
      dojo.require("dojox.grid.enhanced.plugins.IndirectSelection");    // Indirect selection
                                                                        // (checkbox/radio button selection) feature
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

=========
Feature 1
=========

This feature enhances the ...

Usage
-----

Using the nested sorting feature is pretty simple as shown below:

* Declare nested sorting feature plugin

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
      dojo.require("dojox.grid.EnhancedGrid");
      dojo.require("dojox.grid.enhanced.plugins.NestedSorting");
      ...
  </script>

* Use nested sorting feature

    ... with HTML markup
    
.. code-block :: javascript
  :linenos:

  <div id="grid" store="store1" dojoType="dojox.grid.EnhancedGrid" plugins="{nestedSorting: true}" ... >
  </div>

    ... with JavaScript  <<< '''This isn't code. Not sure how to fix'''
    
.. code-block :: javascript
  :linenos:

  <script>
      var grid = new dojox.grid.EnhancedGrid({id: "grid", store: "store1", plugins: {nestedSorting: true}, ...}, dojo.byId("gridDiv"));
  </script>
    
When nested sorting is enabled, you can also use comparatorMap for custom sorting; see `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_ on DojoCampus.org for more details.
