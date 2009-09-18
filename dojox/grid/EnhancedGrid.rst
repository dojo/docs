#format dojo_rst

dojo.modulename
===============

:Status: Draft
:Version: 1.0
:Project owner: Nathan Toone
:Available: since V1.4

.. contents::
   :depth: 2

Enhanced DataGrid adds numerous useful features to dojox.grid.

'''Contents'''
<<TableOfContents(3)>>

============
Introduction
============

EnhancedGrid (dojox.grid.EnhancedGrid) provides a rich set of features that enhance the capabilities of base DataGrid. The following enhancements are implemented in Dojo 1.4:

* Nested Sorting
* Built-in support for Indirect Selection (radio buttons and check boxes)
* Declarative context menu
* Selecting rows or columns by swiping
* Moving multiple rows or columns with drag-n-drop

There is currently a project to implement a [[/dojox/grid/pluginAPI|Grid plugin architecture]]. To be compatible with this work, EnhancedGrid features are implemented as plugins which can be loaded on demand. As a result, the required features must first declared before they can be used.

=====
Usage
=====

The following steps show a typical usage of EnhancedGrid:

.. code-example::
  :type: inline
  :toolbar: themes, versions, dir
  :version: local
  :width: 480
  :height: 300

  .. javascript::

    <style type="text/css">
        @import "../../../../dijit/themes/tundra/tundra.css";
        @import "../../enhanced/resources/tundraEnhancedGrid.css";
        ...
    </style>


2. Declare required feature plugins 

.. code-example::
  :type: inline
  :toolbar: themes, versions, dir
  :version: local
  :width: 480
  :height: 300

  .. javascript::

    <script type="text/javascript">
        dojo.require("dojox.grid.EnhancedGrid");                          // Required for all Enhanced features
        dojo.require("dojox.grid.enhanced.plugins.DnD");                  // Row/Column drag-drop feature
        dojo.require("dojox.grid.enhanced.plugins.Menu");                 // Declarative pop-up menu feature
        dojo.require("dojox.grid.enhanced.plugins.NestedSorting");        // Nested sorting feature
        dojo.require("dojox.grid.enhanced.plugins.IndirectSelection");    // Indirect selection (checkbox/radio button selection) feature
        ...
    </script>

3. Use features:

.. code-example::
  :type: inline
  :toolbar: themes, versions, dir
  :version: local
  :width: 480
  :height: 300

  .. javascript::

    <div id="grid" dojoType="dojox.grid.EnhancedGrid" 
        plugins="{nestedSorting: true, dnd: true, indirectSelection: true,  // Each required feature must be turned on
        menus:{
        headerMenu:'headerMenu',  //References menus defined declaratively below
        rowMenu:'rowMenu',
        cellMenu:'cellMenu',
        selectedRegionMenu:'selectedRegionMenu'}}"
        ...>
    </div>

[TODO - Add a live EDG demo here on Dojo Campus page]

== Nested Sorting ==

This feature enhances the single sorting feature of base DataGrid. Nested sorting allows users to sort on one or more columns concurrently and also control the sort direction and order.

=== Usage ===

Using the nested sorting feature is pretty simple as shown below:

* Declare nested sorting feature plugin

.. code-example::
  :type: inline
  :toolbar: themes, versions, dir
  :version: local
  :width: 480
  :height: 300

  .. html::

    <script type="text/javascript">
        dojo.require("dojox.grid.EnhancedGrid");
        dojo.require("dojox.grid.enhanced.plugins.NestedSorting");
        ...
    </script>

* Use nested sorting feature

    ... with HTML markup
    
.. code-example::
  :type: inline
  :toolbar: themes, versions, dir
  :version: local
  :width: 480
  :height: 300

  .. html::

    <div id="grid" store="store1" dojoType="dojox.grid.EnhancedGrid" plugins="{nestedSorting: true}" ... ></div>

    ... with JavaScript  <<< '''This isn't code. Not sure how to fix'''
    
.. code-example::
  :type: inline
  :toolbar: themes, versions, dir
  :version: local
  :width: 480
  :height: 300

  .. javascript::

    var grid = new dojox.grid.EnhancedGrid({id: "grid", store: "store1", plugins: {nestedSorting: true}, ...}, dojo.byId("gridDiv"));
    
When nested sorting is enabled, you can also use comparatorMap for custom sorting; see [[http://docs.dojocampus.org/dojo/data/ItemFileReadStore|dojo.data.ItemFileReadStore]] on DojoCampus.org for more details.

=== Scenario ===

The followings are typical scenario of nested sorting:

* When there is no sorting established, a unary (single) sort caret is shown when the mouse hovers over a column. The upward direction of the caret reflects that this will result in an ascending sort.

{{sort-1.png}}

========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
