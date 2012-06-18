.. _dojox/grid/LazyTreeGrid:

=======================
dojox.grid.LazyTreeGrid
=======================

:Authors: Wang Qiang
:Project owner: Evan Huang
:since: V1.6

.. contents ::
   :depth: 2

This is a stub help page for the new dojox.grid.LazyTreeGrid which is still in progress. The information on this page may be out-of-date due to the fact that the API for the LazyTreeGrid is still very much in flux.

Introduction
============

The Lazy-loading-TreeGrid(dojox.grid.LazyTreeGrid) is an extension of dojox.grid.TreeGrid, it is specifically designed for data store with huge nested-level rows. For the reason of the original TreeGrid can only do lazy-load on the 1st-level items, it doesn't work well with large number of nested-level items. The Lazy-loading-TreeGrid renders each data item as an independent row no matter which level it is, and reuse the virtual scrolling model of DataGrid for paging of either top/nested level rows. This Widget inherits from dojo.grid.TreeGrid, hence all methods and properties pertaining to that Widget are also applicable.

.. code-example::
  :toolbar: themes, versions, dir
  :width: 550
  :height: 330

  .. js ::

      dojo.require("dojox.grid.LazyTreeGrid");
      dojo.require("dijit.tree.ForestStoreModel");
      dojo.require("dojo.data.ItemFileWriteStore");
    
      dojo.ready(function(){
          /* set up data store */
          var data = { identifier: 'name',
              label: 'name',
              items: [
                { name:'Africa', type:'continent', children:[
                { name:'Egypt', type:'country' },
                { name:'Kenya', type:'country', children:[
                { name:'Nairobi', type:'city', adults: 70400, popnum: 2940911 },
                { name:'Mombasa', type:'city', adults: 294091, popnum: 707400 } ]
                },
                { name:'Sudan', type:'country', children:
                { name:'Khartoum', type:'city', adults: 480293, popnum: 1200394 }
                } ]
                },
                { name:'Asia', type:'continent', children:[
                    { name:'China', type:'country' },
                    { name:'India', type:'country' },
                    { name:'Russia', type:'country' },
                    { name:'Mongolia', type:'country' } ]
                },
                { name:'Australia', type:'continent', population:'21 million', children:
                { name:'Commonwealth of Australia', type:'country', population:'21 million'}
                },
                { name:'Europe', type:'continent', children:[
                { name:'Germany', type:'country' },
                { name:'France', type:'country' },
                { name:'Spain', type:'country' },
                { name:'Italy', type:'country' } ]
                },
                { name:'North America', type:'continent', children:[
                { name:'Mexico', type:'country',  population:'108 million', area:'1,972,550 sq km', children:[
                    { name:'Mexico City', type:'city', adults: 120394, popnum: 19394839, population:'19 million', timezone:'-6 UTC'},
                    { name:'Guadalajara', type:'city', adults: 1934839, popnum: 4830293, population:'4 million', timezone:'-6 UTC' } ]
                },
                { name:'Canada', type:'country',  population:'33 million', area:'9,984,670 sq km', children:[
                    { name:'Ottawa', type:'city', adults: 230493, popnum: 9382019, population:'0.9 million', timezone:'-5 UTC'},
                    { name:'Toronto', type:'city', adults: 932019, popnum: 2530493, population:'2.5 million', timezone:'-5 UTC' }]
                },
                { name:'United States of America', type:'country' } ]
                },
                { name:'South America', type:'continent', children:[
                { name:'Brazil', type:'country', population:'186 million' },
                { name:'Argentina', type:'country', population:'40 million' } ]
                } ]
          };
          var store = new dojo.data.ItemFileWriteStore({data: data});
              var model = new dijit.tree.ForestStoreModel({store: store, childrenAttrs: ['children']});
        
          /* set up layout */
          var layout = [
            {name: 'Name', field: 'name', width: '30%'},
            {name: 'Type', field: 'type', width: '30%'},
            {name: 'Population', field: 'population', width: '20%'},
            {name: 'Area', field: 'area', width: '20%'}
          ];

          /* create a new grid: */
          var grid = new dojox.grid.LazyTreeGrid({
              id: 'grid',
              treeModel: model,
              structure: layout,
              rowSelector: '20px'
            }, document.createElement('div'));

          /* append the new grid to the div */
          dojo.byId("gridDiv").appendChild(grid.domNode);

          /* Call startup() to render the grid */
          grid.startup();
      });

  .. html ::

    <div id="gridDiv"></div>

  .. css ::

    @import "{{baseUrl}}dojo/resources/dojo.css";
    @import "{{baseUrl}}dijit/themes/claro/claro.css";
    @import "{{baseUrl}}dojox/grid/resources/Grid.css";
    @import "{{baseUrl}}dojox/grid/resources/claroGrid.css";

    /* Grid need a explicit width/height by default */
    #grid {
        width: 43em;
        height: 20em;
    }

Supported Data Structure
------------------------

For the reason of lazy loading children items, the dojox.grid.LazyTreeGrid could accept the flatted data. For example:

.. js ::
  
  data = {
    identifier: 'id',
    label: 'name',
    items: [
      {id: 'AF', name:'Africa', children: true},
      {id: 'EG', name:'Egypt', children: false},
      {id: 'KE', name:'Kenya', children: true},
      ......
    ]}
  }

In this case, the "children" attribute would be a flag rather than an actual value. (The name of "children" attribute would be specified by the TreeModel)

Also, the nested data structure is available in normally case (small data or data is stored at client side). For example:

.. js ::
    
  data = {
    identifier: 'id',
    label: 'name',
    items: [
      {id: 'AF', name:'Africa',
        children:[
          {id: 'EG', name:'Egypt' },
          {id: 'KE', name:'Kenya',
            children:[
              {id: 'Nairobi', name:'Nairobi', type:'city' },
              {id: 'Mombasa', name:'Mombasa', type:'city' }
            ]
          },
          ...
        ]
      },
    ...
    ]
  }
  
Even more, for the situations where there are many children of some items as well as there are very few children of other items, you could use the following data structure:

.. js ::
  
  data = {
    identifier: 'id',
    label: 'name',
    items: [
      {id: 'AF', name:'Africa', children: true},
      {id: 'EG', name:'Egypt' , children: false},
      {id: 'KE', name:'Kenya',
        children:[
          {id: 'Nairobi', name:'Nairobi', type:'city'},
          {id: 'Mombasa', name:'Mombasa', type:'city'}
        ]
      },
      ...
    ]
  }

Please note the flatted data structure (case 1&3) could be used only when using a dojox.grid.LazyTreeGridStoreModel, and if you want to use a dijit.tree.ForestStoreModel in your page, please make sure the returned data is nested structure. (For more details, please see TreeModel below)

The Mechanism of Rendering
--------------------------

For dojox.grid.TreeGrid, the root item and all of its children/sub-children would be rendered in a single row:

.. image :: ltg1.jpg

This might case performance issue when there are huge children item, because all of them will be rendered at a single time.

Regarding dojox.grid.LazyTreeGrid, each item would be rendered in a single row:

.. image :: ltg2.jpg

Usage
=====

Prerequisites
-------------

The dojox.grid.LazyTreeGrid can either be defined declaratively in HTML or programmatically. For the most part, the dojox.grid.LazyTreeGrid follows the same structure and formatting as dojox.grid.TreeGrid with the following exceptions:

  * LazyTreeGrid must have a TreeModel, the TreeModel could be the dijit.tree.ForestStoreModel/dojox.grid.LazyTreeGridStoreModel, or a custom TreeModel that inherited from them.
  * LazyTreeGrid structures does not contain “children” values for nested level rows.(See dojox.grid.TreeGrid - Structure Definition)
  * LazyTreeGrid does not contain an aggregate row, and its formatters don’t handle negative rowIndex values.
  * LazyTreeGrid formatters receive a level parameter. (See "Formatting" below)
  * defaultOpen/openAtLevels/aggregate/itemAggregates do not be available any more.
  * The getItem function only accept a row index.
  
The following parameters are supported in the dojox.grid.LazyTreeGrid:

====================================  ===================================  ========================================  ============================================================================================
Parameter                             Type                                 Default Value                             Description
====================================  ===================================  ========================================  ============================================================================================
rowsPerPage                           Integer                              25                                        Number of rows to render at a time
autoWidth                             Boolean                              false                                     If autoWidth is true, grid width is automatically set to fit the data
autoHeight                            Boolean/Integer                      ""                                        Boolean: If autoHeight is true, grid height is automatically set to fit the data.
                                                                                                                     Integer: The height will be set to show that many rows as specified; but if there are fewer
                                                                                                                     rows than that specified number, the grid height will be automatically set to fit the data.
defaultHeight                         String                               "15em"                                    Default height of the grid, measured in any valid css unit.
height                                String                               ""                                        Explicit height of the grid, measured in any valid css unit. This will be populated
                                                                                                                     (and overridden) if the height: css attribute exists on the source node
selectionMode                         String                               "extended"                                Set the selection mode of grid's Selection (select row by click row or rowSelector). Value
                                                                                                                     must be 'single', 'multiple' or 'extended'. (assume there is no indirect selection being used)
rowSelector                           String/Boolean                       ""                                        If set to true, will add a row selector view to this grid. If set to a CSS width, will add a
                                                                                                                     row selector of that width to this grid
headerMenu                            dijit.Menu                           null                                      If set to a dijit.Menu, will use this as a context menu for the grid headers
selectable                            Boolean                              false                                     Set to true if you want the user to be able to select the text within the grid
structure                             dojox.grid.__ViewDef                 null                                      Layout definition
query                                 Object                               null                                      The query may be optional in some data store implementations. Each different data store
                                                                                                                     implementation may have its own notion of what a query should look like. In general for
                                                                                                                     query objects that accept strings as attribute value matches, the store should also support
                                                                                                                     basic filtering capability, such as * (match any character) and ? (match single character).
                                                                                                                     An example query that is a query object would be like: { attrFoo: "value*"}. Which generally
                                                                                                                     means match all items where they have an attribute named attrFoo, with a value that starts
                                                                                                                     with 'value'. It is more like a simple filter because that only be used to compare items'
                                                                                                                     attribute and query object attribute are equal or not.
treeModel                             dijit.tree.ForestStoreModel          null                                      This parameter is used instead of using aggregates in dojox.grid.TreeGrid. Its mainly role
                                      /dojox.grid.LazyTreeGridStoreModel                                             in Lazy-loading-TreeGrid is to indicate the children attribute name of data item.
colSpans                              Object                               null                                      A Json object that flexibly defines detail column spans for all levels. This is a new
                                                                                                                     parameter in Lazy-loading-TreeGrid
====================================  ===================================  ========================================  ============================================================================================

TreeModel
---------

LazyTreeGrid must have a TreeModel, the TreeModel could be the dijit.tree.ForestStoreModel/dojox.grid.LazyTreeGridStoreModel, or a custom TreeModel that inherited from them.

The dojox.grid.LazyTreeGridStoreModel is designed for lazy loading children items, it will call store.fetch() with a query object {parentId: value} and start index, count number when LazyTreeGrid ask for sub-rows and these sub-items are not be loaded. There is a attribute called "serverStore" of LazyTreeGridStoreModel, this attribute indicate whether or not the data with flatted data structure is stored in server side (the data structure SHOULD BE nested when data is stored in client side since lazy loading would not be needed in that case), default is false.

When using a dijit.tree.ForestStoreModel, or using dojox.grid.LazyTreeGridStoreModel with setting parameter "serverStore" to false, the children items won't be lazy loaded but all of the root rows and sub rows would still be lazy rendered. This is more applicable to the situation small data or data stored on client side.

An example LazyTreeGridStoreModel definition would look like this:

.. js ::
    
  // programmatic
  var treeModel = new dojox.grid.LazyTreeGridStoreModel({
    store: queryReadStore,
    serverStore: true
  });
  
  // declarative
  <span data-dojo-type="dojox.grid.LazyTreeGridStoreModel"
    data-dojo-props="store:queryReadStore, serverStore:true" >
  </span>
  
Structure Definition
--------------------

LazyTreeGrid does not support nested structure, as well as aggregate and itemAggregates. The following example is a LazyTreeGrid defined via HTML, just like the :ref:`dojox.grid.DataGrid <dojox/grid/DataGrid>`:

.. js ::
    
  <table data-dojo-id="grid" data-dojo-type="dojox.grid.LazyTreeGrid" data-dojo-props="rowsPerPage:25
      rowSelector:'20px', treeModel:'forestStoreModel'">
    <thead>
      <tr>
        <th field="name" width="150px" formatter="fmtName">Name</th>
        <th field="id" width="30px">ID</th>
        <th field="status" width="40px" formatter="fmtStatus">Status</th>
        <th field="capacity" width="80px" formatter="fmtCapacity">Capacity</th>
        <th field="uid" width="auto">UID</th>
      </tr>
    </thead>
  </table>
  
Formatting
----------

In order to the users can format content freely for cells in different levels, the LazyTreeGrid formatters receives a "level" parameter,which is 0-based. But LazyTreeGrid formatters won't be able to handle a negative value for row nubmer parameter since there is no aggregation for the LazyTreeGrid. Below is a simply example of the formatter:

.. js ::
  
  var fmt = function(value, idx, level){
    if(level == 0){
      return value == "true" ? "online" : offline";
    }else{
      return"online";
    }
  }
  
Cells Merging
-------------

In order to display better for different levels, user could do cells merge based on different level via "colSpans" attribute. The value of "colSpans" is a JSON object, an example colSpans definition would look like this:

.. js ::
  
  colSpans = {
    0: [
      {start: 0, end: 1, primary: 0},
      {start: 2, end: 4, primary: 3}
    ],
    1: [
      {start: 0, end: 3, primary: 1}
    ]
  };
  
The attributes of "colSpans" object (0, 1, 2, ...) indicate what level it is. The level is 0-based. The value of these attributes would be a JSON object array, each element of these array would indicate the detail of column span, the start indicate the start column index of colspan, end is end column index of colspan, and the primary is index of column which content will be displayed (start value by default).

Public API
==========

Available public methods of the LazyTreeGrid are listed below:

=========  =====================================  =====================  =======================================================
Name       Parameters                             Return                 Description
=========  =====================================  =====================  =======================================================
setModel   treeModel                              N/A                    Change the LazyTreeGrid's treeModel.

expand     itemId: string?                        N/A                    Function to handle expanding the row with item matching
                                                                         the given item id.
collapse   itemId: string?                        N/A                    Function to handle collapsing the row which item matching
                                                                         the given item id.
refresh    keepState: boolean                     N/A                    Function to refresh the grid content with or
                                                                         without keeping the folding state.
=========  =====================================  =====================  =======================================================

Examples
========

For example of the LazyTreeGrid with a ForestStoreModel and client side data source, please see the file dojox/grid/tests/test_treegrid_lazyloading.html.

Accessibility
=============

LazyTreeGrid provides the same a11y support level as :ref:`DataGrid <dojox/grid/DataGrid>` .

And summary attribute can be added in a similar way as `DataGrid <http://livedocs.dojotoolkit.org/dojox/grid/DataGrid#add-summary-attribute>`_.

See Also
========

* :ref:`dojox.grid.DataGrid <dojox/grid/DataGrid>`

  The base grid

* :ref:`dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>`

  An enhanced version of the base grid, which extends it in numerous useful ways

* :ref:`dojox.grid.TreeGrid <dojox/grid/TreeGrid>`

  This grid offers support for collapsible rows and model-based (:ref:`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`) structure
