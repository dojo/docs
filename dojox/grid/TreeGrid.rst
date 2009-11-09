#format dojo_rst

dojox.grid.TreeGrid
===================

:Status: Draft
:Version: 1.0
:Project owner: Nathan Toone
:Available: since V1.4

.. contents::
   :depth: 2

This is a stub help page for the new dojox.grid.TreeGrid which is still in progress. The information on this page may be out-of-date due to the fact that the API for the TreeGrid is still very much in flux.


============
Introduction
============

This Widget inherits from dojo.grid.DataGrid and hence all methods and properties pertaining to that Widget also apply here.

=====
Usage
=====

A tree grid can either be defined declaratively in HTML or programatically. For the most part, the TreeGrid follows the same structure and formatting as dojox.grid.DataGrid with the following exceptions:

  * TreeGrid can only contain a single view - and that view must only contain a single row
  * TreeGrid operates off the concept of "levels" - which are 0-based. That is, level 1 are the items that are children of a top-level item
  * TreeGrid structures can contain a "children" value for nesting (see "Structure Definition" below)
  * TreeGrid formatters receive a negative rowIndex on aggregate values to indicate what level they are on (see "Formatting" below)

You can also specify the following values on a TreeGrid:

  * defaultOpen: a boolean value that defines whether expandos default to open or closed (default is true)
  * openAtLevels: an array that will add a bit of logic to which values are open and closed.
  * treeModel: a dijit.tree.ForestStoreModel tree model that will be used for a "columnar tree" as opposed to an "expandable grid"

When defining openAtLevels, the index in the array correspond to the level that you are defining. The values in the array can either be
boolean (true/false) or an integer. If it is an integer, then it will be closed if there are more than that many children.

For example, setting openAtLevels to [true, false, 5] on a 4-level grid, top-level items will always be open, second-level items will always be closed, and third-level items will be open if they have 5 or fewer 4th-level items.

The getItem function on the grid has also been extended to accept an array in order to get an item based off a level path. For example, calling grid.getItem([2,1,5]) will return the 6th child (0-based index) of the 2nd child of the 3rd top-level item.

If you specify a treeModel, then defaultOpen will always be false, and openAtLevels will be ignored


====================
Structure Definition
====================

An example 2-level TreeGrid defined via HTMl would look like this:

.. code-block :: html

  <table dojoType="dojox.grid.TreeGrid" >
    <thead>
      <tr>
        <th field="field1" width="200px">Field 1</th>
        <th field="childAttr" aggregate="sum" itemAggregates="f1cnt,f2sum">
          <table>
            <thead>
              <tr>
                <th field="cField1" width="200px">Child Field 1</th>
                <th field="cField2" width="200px">Child Field 2</th>
              </tr>
            </thead>
          </table>
        </th>
      </tr>
    </thead>
  </table>

The equivalent javascript structure definition would be:

.. code-block :: javascript

  var structure = [
    {
      cells: [
        [
          { field: "field1", name: "Field 1", width: "200px" },
          { field: "childAttr"
            children: [
              { field: "cField1" name: "Child Field 1", width: "200px" },
              { field: "cField2" name: "Child Field 2", width: "200px" }
            ],
            aggregate: "sum",
            itemAggregates: [ "f1cnt", "f2sum" ]
        ]
      ]
    }
  ]

The grid can be any number of levels deep - though performance dramatically drops after about 3 or 4 levels, depending on your data.

The cell that contains nested data takes two additional (optional) attributes:

  * aggregate: the type of aggregation that you want to do - currently supported are "sum", "cnt", and "value" (no aggregation). Defaults to "sum". Labels are aggregate type "cnt".
  * itemAggregates: the fields in the parent item to read rather than calculating the aggregate based off the children

In order to support lazy loading of children, you can specify itemAggregates. These fields correlate by index to the nested children. In the example above, the top-level item would read its "f1cnt" value for the aggregate of the first column of its children, and it would read its "f2sum" value for the aggregate of the second column of its children. If itemAggregates are missing, then they will be calculated.

NOTE: itemAggregates are specified for *direct children* only - for example, in a 3-level TreeGrid, you would specify:

.. code-block :: html

  <table dojoType="dojox.grid.TreeGrid" >
    <thead>
      <tr>
        <th field="field1" width="200px">Field 1</th>
        <th field="childAttr" aggregate="sum" itemAggregates="f1cnt">
          <table>
            <thead>
              <tr>
                <th field="cField1" width="200px">Child Field 1</th>
                <th field="grandChildAttr" aggregate="sum" itemAggregates="gf1cnt,gf2sum">
                  <table>
                    <thead>
                      <tr>
                        <th field="gcField1" width="200px">Grandchild Field 1</th>
                        <th field="gcField2" width="200px">Grandchild Field 2</th>
                      </tr>
                    </thead>
                  </table>
                </th>
              </tr>
            </thead>
          </table>
        </th>
      </tr>
    </thead>
  </table>

Notice that f1cnt is the count of cField1 (at level 1) and gf1cnt and gf2sum are the count and sum of gcField1 and gcField2 (at level 2)


==========
Formatting
==========

Sometimes it is desirable to format the aggregations differently than the actual values. In order to facilitate this, the formatter is called with the row number for actual values, and a negative value for row number indicating the level (1-based, to avoid confusion with row index) the aggregation is happening at. For example, if you were to format gcField1 (in the example above) with the following formatter:

.. code-block :: javascript

  function fmt(value, rowIdx){
    if(rowIdx >= 0){
      return value;
    }
    if(rowIdx == -1){
      return "Total (" + value + " items)";
    }else{
      return value + " items";
    }
  }

Then the aggregate row for the top-level item would read "Total (x items)", and the aggregate row at each sub-level would read "y items".


========
Examples
========

For more examples, please see the files dojox/grid/tests/test_treegrid.html, dojox/grid/tests/test_treegrid_performance.html and dojox/grid/tests/test_treegrid_loading.html


========
See also
========

* `dojox.grid.DataGrid <dojox/grid/DataGrid>`_

  The base grid

* `dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>`_

  An enhanced version of the base grid, which extends it in numerous useful ways

* `dojox.grid.TreeGrid <dojox/grid/TreeGrid>`_

  This grid offers support for collapsable rows and model-based (`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`_) structure

* `Grid Plugin API <dojox/grid/pluginAPI>`_
