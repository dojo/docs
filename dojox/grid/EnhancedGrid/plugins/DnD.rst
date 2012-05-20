.. _dojox/grid/EnhancedGrid/plugins/DnD:

===================================
dojox.grid.EnhancedGrid.plugins.DnD
===================================

:Authors: Oliver Zhu
:Project owner: Evan Huang
:since: V.1.6

DnD plugin supports drag-and-drop of grid rows/column/cells.

.. contents ::
   :depth: 2

Introduction
============

DnD is a plugin for dojox.grid.EnhancedGrid. It provides supports for drag-and-drop grid rows/column/cells. Users can not only move rows/columns/cells within a grid by dragging them, but also drag them out of grid to other widgets (can be another grid).

.. code-example::
  :toolbar: themes, versions, dir
  :width: 650
  :height: 600

  .. js ::

        dojo.require("dojo.data.ItemFileWriteStore");
        dojo.require("dijit.form.CheckBox");
        dojo.require("dojox.grid.EnhancedGrid");
        dojo.require("dojox.grid.enhanced.plugins.DnD");

        var data = {
            identifier: 'id',
            label: 'id',
            items: []
        };
        var cols = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
        var data_list = [];
        var i, row, j;
        for(i = 0; i < 100; ++i){
            row = {};
            for(j = 0; j < cols.length; ++j){
                row[cols[j]] = (i + 1) + cols[j];
            }
            data_list.push(row);
        }
        var len = data_list.length;
        for(i = 0; i < len ; ++i){
            data.items.push(dojo.mixin({ 'id': i + 1 }, data_list[i]));
        }
        var data1 = dojo.clone(data);

        var layout1 = [{
            defaultCell: {width: 3},
            rows: [
                {field: "A"},
                {field: "B"},
                {field: "C"},
                {field: "D"},
                {field: "E"},
                {field: "F"},
                {field: "G"},
                {field: "H"},
                {field: "I"},
                {field: "J"},
                {field: "K"},
                {field: "L"},
                {field: "M"}
            ]
        }];

        var layout2 = [{
            defaultCell: {width: 3},
            rows: [
                {field: "N"},
                {field: "O"},
                {field: "P"},
                {field: "Q"},
                {field: "R"},
                {field: "S"},
                {field: "T"},
                {field: "U"},
                {field: "V"},
                {field: "W"},
                {field: "X"},
                {field: "Y"},
                {field: "Z"}
            ]
        }];

        function setIdentifierForNewItem(item, store, index){
            var attrs = store.getIdentityAttributes(item);
            for(var i = attrs.length - 1; i >= 0; --i){
                item[attrs[i]] = index + (new Date()).getTime();
            }
            return item;
        }
        function setDnDConfig(gridId, type, mode, selected){
            var config = {};
            config[type] = {};
            config[type][mode] = selected;
            dijit.byId(gridId).setupDnDConfig(config);
        }
        function setCopyOnly(gridId, selected){
            dijit.byId(gridId).dndCopyOnly(selected);
        }
        dojo.ready(function(){
            var store1 = new dojo.data.ItemFileWriteStore({data: data});
            var store2 = new dojo.data.ItemFileWriteStore({data: data1});

            var grid1 = new dojox.grid.EnhancedGrid({
                id: 'grid1',
                store: store1,
                structure: layout1,
                rowSelector: '20px',
                canSort: function(){return false;},
                plugins: {
                    dnd: {
                        setIdentifierForNewItem: setIdentifierForNewItem,
                        dndConfig: {}
                    }
                }
            });
            grid1.placeAt('gridContainer1');
            grid1.startup();

            var grid2 = new dojox.grid.EnhancedGrid({
                id: 'grid2',
                store: store2,
                structure: layout2,
                rowSelector: '20px',
                canSort: function(){return false;},
                plugins: {
                    dnd: {
                        setIdentifierForNewItem: setIdentifierForNewItem,
                        dndConfig: {}
                    }
                }
            });
            grid2.placeAt('gridContainer2');
            grid2.startup();

            dojo.query("input.cfgbox").forEach(function(cb){
                cb.checked = true;
            });
            dojo.query("input.copyonlyCBox").forEach(function(cb){
                cb.checked = false;
            });
        });

  .. html ::

    <div class="myblock">
        <h3>Grid 1</h3>
        <div id="gridContainer1"></div>
    </div>
    <div class="myblock">
        <h3>Grid 2</h3>
        <div id="gridContainer2"></div>
    </div>
    <div class="myblock">
        <h3>Grid 1 Configuration</h3>
        <label style="font-weight: bolder;">Copy Only</label><input class="copyonlyCBox" type="checkbox" onchange="setCopyOnly('grid1', this.checked)" />
        <table class="cfgtable" border="1">
            <thead>
                <tr>
                    <th>Drag</th>
                    <th>Within</th>
                    <th>In</th>
                    <th>Out</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Rows</td>
                    <td><input type="checkbox" class="cfgbox" onchange="setDnDConfig('grid1', 'row', 'within', this.checked)"/></td>
                    <td><input type="checkbox" class="cfgbox" onchange="setDnDConfig('grid1', 'row', 'in', this.checked)"/></td>
                    <td><input type="checkbox" class="cfgbox" onchange="setDnDConfig('grid1', 'row', 'out', this.checked)"/></td>
                </tr>
                <tr>
                    <td>Columns</td>
                    <td><input type="checkbox" class="cfgbox" onchange="setDnDConfig('grid1', 'col', 'within', this.checked)"/></td>
                    <td>Not implemented</td>
                    <td><input type="checkbox" class="cfgbox" onchange="setDnDConfig('grid1', 'col', 'out', this.checked)"/></td>
                </tr>
                <tr>
                    <td>Cells</td>
                    <td><input type="checkbox" class="cfgbox" onchange="setDnDConfig('grid1', 'cell', 'within', this.checked)"/></td>
                    <td><input type="checkbox" class="cfgbox" onchange="setDnDConfig('grid1', 'cell', 'in', this.checked)"/></td>
                    <td><input type="checkbox" class="cfgbox" onchange="setDnDConfig('grid1', 'cell', 'out', this.checked)"/></td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="myblock">
        <h3>Grid 2 Configuration</h3>
        <label style="font-weight: bolder;">Copy Only</label><input class="copyonlyCBox" type="checkbox" onchange="setCopyOnly('grid2', this.checked)" />
        <table class="cfgtable" border="1">
            <thead>
                <tr>
                    <th>Drag</th>
                    <th>Within</th>
                    <th>In</th>
                    <th>Out</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Rows</td>
                    <td><input type="checkbox" class="cfgbox" onchange="setDnDConfig('grid2', 'row', 'within', this.checked)"/></td>
                    <td><input type="checkbox" class="cfgbox" onchange="setDnDConfig('grid2', 'row', 'in', this.checked)"/></td>
                    <td><input type="checkbox" class="cfgbox" onchange="setDnDConfig('grid2', 'row', 'out', this.checked)"/></td>
                </tr>
                <tr>
                    <td>Columns</td>
                    <td><input type="checkbox" class="cfgbox" onchange="setDnDConfig('grid2', 'col', 'within', this.checked)"/></td>
                    <td>Not implemented</td>
                    <td><input type="checkbox" class="cfgbox" onchange="setDnDConfig('grid2', 'col', 'out', this.checked)"/></td>
                </tr>
                <tr>
                    <td>Cells</td>
                    <td><input type="checkbox" class="cfgbox" onchange="setDnDConfig('grid2', 'cell', 'within', this.checked)"/></td>
                    <td><input type="checkbox" class="cfgbox" onchange="setDnDConfig('grid2', 'cell', 'in', this.checked)"/></td>
                    <td><input type="checkbox" class="cfgbox" onchange="setDnDConfig('grid2', 'cell', 'out', this.checked)"/></td>
                </tr>
            </tbody>
        </table>
    </div>

  .. css ::

    @import "{{baseUrl}}dojo/resources/dojo.css";
    @import "{{baseUrl}}dijit/themes/claro/claro.css";
    @import "{{baseUrl}}dijit/themes/claro/document.css";
    @import "{{baseUrl}}dojox/grid/enhanced/resources/claro/EnhancedGrid.css";
    @import "{{baseUrl}}dojox/grid/enhanced/resources/EnhancedGrid_rtl.css";

    .myblock{
        float: left;
        margin: 5px;
        margin-top: 0;
    }
    .cfgtable th,
    .cfgtable td{
        font-weight: bolder;
        padding: 3px;
    }
    h3{
        margin: 0;
    }
    #gridContainer1, #gridContainer2{
        margin-bottom: 0px;
        width: 300px;
        height: 300px;
    }

Configuration
=============

Prerequisites
-------------

This DnD plugin is only available for EnhancedGrid, so use the following statement in the head of your HTML file:

.. js ::
  
  dojo.require("dojox.grid.EnhancedGrid");
  dojo.require("dojox.grid.enhanced.plugins.DnD");

Note that this DnD plugin is based on the Selector plugin, so there's no need to "require" the Selector plugin anymore if you'd like to use the its functions.

Plugin Declaration
------------------

The declaration name of this plugin is ``dnd`` . It is declared in the ``plugins`` property of grid.

If your grid is created declaratively:

.. js ::
  
  <div id="grid" data-dojo-type="dojox.grid.EnhancedGrid"
    store="mystore" structure="mystructure"
    plugins="{
      dnd: /* a Boolean value or an argument object */{}
  }" ></div>

If your grid is created in JavaScript:

.. js ::
  
  var grid = new dojox.grid.EnhancedGrid({
    id:"grid",
    store:"mystore",
    structure:"mystructure",
    plugins:{
      dnd: /* a Boolean value or an argument object */{}
    }
  });

As shown in the above code, you can simply set the ``dnd`` property to true or false (disabled), or further configure it in an argument object.

The argument object can accept the following properties:

=================  ========  ===============  ===================================================================================================================================================
Property           Type      Default Value    Description
=================  ========  ===============  ===================================================================================================================================================
copyOnly           Boolean   false            Set whether dragging from this grid means moving or copying.
dndConfig          Object    {}               Enable/disable dnd for every draggable objects ("row", "col", and "cell") in every kind of circumstance (drag "within", "in" to, or "out" of grid).
                                              These draggable objects and circumstances are configured in a hierarchical manner.
                                              You can set either "row"/"col"/"cell" or "within"/"in"/"out" at the first level, and configure the other group at the second level.
                                              Or simply disable/enable a whole set of situations directly at the first level.
                                              Note:
                                              1. Circumstance (within/in/out) has higher priority than objects (row/col/cell).
                                              2. Default value is "true"(enabled) if anything is omitted.
=================  ========  ===============  ===================================================================================================================================================

Here is an example on how to set dndConfig:

.. js ::
    
  GridDnD: {
    dndConfig: {
      // Configure in a hierarchical manner.
      row: {
        out: false, // This rule has lower priority, it'll be overwritten.
        within: false
      },
      // Both orders are correct.
      out: {
        row: true, // This rule has higher priority, it'll be valid.
        cell: false
      },
      // Set a whole group of situations
      in: false
    }
  }

Currently, the following situations are supported:

======  ==============  =============  ==========
DnD     within          in             out
======  ==============  =============  ==========
col     supported       not supported  supported
row     supported       supported      supported
cell    supported       supported      supported
======  ==============  =============  ==========

Note:
    1. Dragging columns into a grid is NOT supported currently.
    2. Only cells forming a rectangle are draggable (do NOT support other shapes).

Usage
=====

This section shows how to DnD.

Note:

   1. If using Selector plugin only, the "drag" operation will start a new selection, and "drag" while pressing and holding CTRL key will start deselection.
   2. If using this GridDnD plugin, only drag AFTER pressing and holding CTRL key will start deselection. If you press the CTRL key DURING dragging process, it means COPY instead of MOVE.

DnD within Grid
---------------

If enabled, selected rows/columns/cells can be dragged within grid.

Dragging Columns

.. image :: dnd-within-cols-1.gif

Dragging Rows

.. image :: dnd-within-rows-1.gif

Dragging Cells

.. image :: dnd-within-cells-1.gif



DnD across Grids
----------------

If both grids are EnhancedGrid with this GridDnD plugin, and one has enabled dragging "out" while the other enabled dragging "in", data can be dragged across grids.
Note: Dragging columns across grids is not supported.

Moving rows across grids

.. image :: dnd-togrid-rows-1.gif

Copy rows across grids

.. image :: dnd-togrid-rows-copy-1.gif

Moving cells across grids

.. image :: dnd-togrid-cells-1.gif

Copy cells across grids

.. image :: dnd-togrid-cells-copy-1.gif

If selected cells do not form a rectangle, they can not be dragged:

.. image :: dnd-cannotdndshape-1.png

Because the grid lazy loads store data, and extended selection is supported, it is possible to select rows or cells that are not loaded to the client side yet. If this situation occurs, it's not allowed to "drop" these unloaded objects to another grid:

.. image :: dnd-unloadedrows-1.gif

DnD from Grid to Other Widgets
------------------------------

Other widgets/dom nodes can accept dragged data from a grid by extending dojox.grid.enhanced.plugins.GridSource instead of dojo.dnd.Source.

GridSource extends dojo.dnd.Source. Its "accept" property can support "grid/cols", "grid/rows", and "grid/cells".

GridSource provides the following events to handle grid related dnd:

onDropGridColumns(grid, columnIndexes):
    When a set of grid columns is dragged to this source.

==============  ========================  ==================================
Arguments       Type                      Description
==============  ========================  ==================================
grid            dojox.grid.EnhancedGrid   The source grid.
columnIndexes   Integer[]                 The indexes of the dragged columns
==============  ========================  ==================================

onDropGridRows(grid, rowIndexes):
    When a set of grid rows is dragged to this source.

==============  ========================  ==================================
Arguments       Type                      Description
==============  ========================  ==================================
grid            dojox.grid.EnhancedGrid   The source grid.
rowIndexes      Integer[]                 The indexes of the dragged rows
==============  ========================  ==================================

onDropGridCells(grid, leftTopPoint, rightBottomPoint):
    When a block of grid cells is dragged to this source.

================  ========================  ==============================================================================
Arguments         Type                      Description
================  ========================  ==============================================================================
grid              dojox.grid.EnhancedGrid   The source grid.
leftTopPoint      Object(__SelectCellItem)  The left-top cell of the selected cells. (For RTL, it's the right-top cell)
rightBottomPoint  Object(__SelectCellItem)  The right-bottom cell of the selected cells. (For RTL, it's the left-top cell)
================  ========================  ==============================================================================

The following example shows how to use these events to drag a grid row to a form.

The HTML is:

.. html ::
    
  <div id="grid" data-dojo-type="dojox.grid.EnhancedGrid" store="test_store" structure="layout" rowSelector="20px"
    plugins="{
      dnd: {copyOnly: true}
    }"
  ></div>
  <form id="songForm" class="container">
    <table>
      <tr>
        <td><label for="inputName">Song name</label></td>
        <td><input id="inputName" type="text" /></td>
      </tr>
      <tr>
        <td><label for="inputAuthor">Artist</label></td>
        <td><input id="inputAuthor" type="text" /></td>
      </tr>
      <tr>
        <td><label for="inputAlbum">Album</label></td>
        <td><input id="inputAlbum" type="text" /></td>
      </tr>
    </table>
  </form>

The JavaScript code is:

.. js ::
  
    dojo.require("dojox.grid.enhanced.plugins.GridSource");

    dojo.ready(function(){
      var formTarget = new dojox.grid.enhanced.plugins.GridSource(dojo.byId("songForm"),{
        isSource: false,
        insertNodesForGrid: false
      });
      dojo.connect(formTarget, "onDropGridRows", function(grid, rowIndexes){
        var s = grid.store,
            row = rowIndexes[0];
        dojo.attr(dojo.byId("inputName"), "value", s.getValue(grid.getItem(row), "Name"));
        dojo.attr(dojo.byId("inputAuthor"), "value", s.getValue(grid.getItem(row), "Artist"));
        dojo.attr(dojo.byId("inputAlbum"), "value", s.getValue(grid.getItem(row), "Album"));
      });
    });

And here is the effect:

.. image :: dnd-tootherwidget-1.gif

Public Methods
--------------

copyOnly(isCopyOnly):
    Get/set function of the copyOnly property in the argument object.

==============  ==================  ===============================  ==================================================================================
Arguments       Type                Optional/Mandatory               Description
==============  ==================  ===============================  ==================================================================================
isCopyOnly      Boolean             Optional(default to undefined)   Whether DnD is a copy operation or a move operation. If omitted, this is a getter.
[return]        Boolean|Undefined                                    If isCopyOnly is undefined, return the copyOnly property of this plugin.
==============  ==================  ===============================  ==================================================================================

setupConfig(config):
    Change the dndConfig property in the argument object.

==============  ==================  ===============================  ===================
Arguments       Type                Optional/Mandatory               Description
==============  ==================  ===============================  ===================
config          Object              Mandatory                        Same as dndConfig.
==============  ==================  ===============================  ===================

Known Limitations
=================

* Multiple row layout is not supported by this DnD plugin.
* Please be careful when dragging a numeric cell to a string cell (or vice versa), since sorting will have problems after that. This is because comparing string value and number value always returns false.


See Also
========

* :ref:`dojox.grid.DataGrid <dojox/grid/DataGrid>` - The base grid
* :ref:`dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>` - The enhanced grid supporting plugins
* :ref:`dojox.grid.EnhancedGrid.plugins <dojox/grid/EnhancedGrid/plugins>` - Overview of the plugins of enhanced grid
* :ref:`dojox.grid.EnhancedGrid.plugins.Selector <dojox/grid/EnhancedGrid/plugins>` - The selector plugin of enhanced grid
* :ref:`dojox.grid.TreeGrid <dojox/grid/TreeGrid>` - Grid with collapsible rows and model-based (:ref:`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`) structure
