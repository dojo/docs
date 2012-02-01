.. _dojox/grid/EnhancedGrid/plugins/NestedSorting:

=============================================
dojox.grid.EnhancedGrid.plugins.NestedSorting
=============================================

:Authors: Evan Huang
:Project owner: Evan Huang
:since: V.1.6

.. contents ::
   :depth: 2

Introduction
==============

This feature enhances the single sorting feature of base DataGrid. Nested sorting allows users to sort on one or more columns concurrently and also control the sort direction and order. Finally, columns can be removed from the sort without disturbing the rest of the sort.

.. code-example::
  :toolbar: themes, versions, dir
  :width: 550
  :height: 330

  .. js ::

      dojo.require("dojox.grid.EnhancedGrid");
      dojo.require("dojo.data.ItemFileWriteStore");
      dojo.require("dojox.grid.enhanced.plugins.NestedSorting");
    
      dojo.ready(function(){
          /*set up data store*/
          var data = {
            identifier: 'id',
            items: []
          };
          var data_list = [
            { col1: "normal", col2: false, col3: 'But are not followed by two hexadecimal', col4: 29.91},
            { col1: "important", col2: false, col3: 'Because a % sign always indicates', col4: 9.33},
            { col1: "important", col2: false, col3: 'Signs can be selectively', col4: 19.34}
          ];
          var rows = 60;
          for(var i=0, l=data_list.length; i<rows; i++){
            data.items.push(dojo.mixin({ id: i+1 }, data_list[i%l]));
          }
          var store = new dojo.data.ItemFileWriteStore({data: data});

          /*set up layout*/
          var layout = [[
            {name: 'Column 1', field: 'id'},
            {name: 'Column 2', field: 'col2'},
            {name: 'Column 3', field: 'col3', width: "230px"},
            {name: 'Column 4', field: 'col4'}
          ]];

          /* create a new grid: */
          var grid = new dojox.grid.EnhancedGrid({
              id: 'grid',
              store: store,
              structure: layout,
              rowSelector: '20px',
              plugins : {nestedSorting: true}},
            document.createElement('div'));

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
    @import "{{baseUrl}}dojox/grid/enhanced/resources/claro/EnhancedGrid.css";
    @import "{{baseUrl}}dojox/grid/enhanced/resources/EnhancedGrid_rtl.css";

    /*Grid need a explicit width/height by default*/
    #grid {
        width: 43em;
        height: 20em;
    }


Usage
-----

Using the nested sorting feature is pretty simple as shown below:

* Declare nested sorting feature plugin

.. js ::

      dojo.require("dojox.grid.EnhancedGrid");
      dojo.require("dojox.grid.enhanced.plugins.NestedSorting");
      ...

* Use nested sorting feature

with HTML markup
    
.. html ::
  
  <div id="grid" store="store1" data-dojo-type="dojox.grid.EnhancedGrid" data-dojo-props="plugins:{nestedSorting: true}" >
  </div>

with JavaScript way
    
.. js ::

      var grid = new dojox.grid.EnhancedGrid({id: "grid", store: "store1", plugins: {nestedSorting: true}, ...}, dojo.byId("gridDiv"));

* Set default sorting order with sortFields
   
.. html ::
  
  var grid = new dojox.grid.EnhancedGrid({
      id: "grid",
      // default sorting order
      sortFields: [{attribute: 'col4', descending: false},{attribute: 'col7', descending: true}],
      plugins: {nestedSorting: true}
  }, div);
  grid.startup();

* Set new sorting order dynamically
   
.. html ::
  
  var newSortFields = [{attribute: 'col3', descending: true},{attribute: 'col1', descending: false}];
  grid.setSortIndex(newSortFields);

* Prevent column(s) from being sorted by canSort()
   
.. html ::
  
  var grid = new dojox.grid.EnhancedGrid({
      id: "grid",
      // prevent some columns from being sorted
      // column index 0 and column with field 'col6' are disabled for being sorted
      canSort: function(colIndex, field){
          return colIndex != 0 && field != 'col6';
      },
      plugins: {nestedSorting: true}
  }, div);
  grid.startup();
    
When nested sorting is enabled, you can also use comparatorMap for custom sorting; see :ref:`dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>` for more details.

Scenario
--------

The following are typical scenarios using nested sorts:

* When there is no sorting established, a unary (single) sort caret is shown when the mouse hovers over a column. The upward direction of the caret reflects that this will result in an ascending sort.

.. image :: ../../sort-1.new.png

* Once the sort choice is selected for the 'Genre' column, the grid rows will be sorted ascending based on by the values in Genre. Note that the keyboard focus moves to the sort choice in response to the mouse click. The graphical label of the sort choice is a downward caret since the function would be a descending sort.

.. image :: ../../sort-2.png

* Then the nested sort tip is shown when the mouse hovers over a other column headers.
* Clicking region "A" in the figure below will execute a nested sort, and the rows will be sorted by Artist in this example within Genre.
* Clicking region "B" will reset the sort, and the rows will be sorted by Artist alone.

.. image :: ../../nested-sort-1.new.png

* Once a column is sorted ascending, the sort choice changes to a sort descending choice.

.. image :: ../../descending-sort-1.png

* Once a column is sorted descending, the sort choice changes to a 'remove sort' function (see the figure below). When a column is removed from the sort, other columns in the sort will be adjusted to reflect the new sort order. For example, Year would become the second column in the sort if it had previously been the third.

.. image :: ../../remove-sort.png

To summarize, the sort choice cycles among sort-ascending, sort-descending, and remove sort functions.

There is no limit to the number of columns that may be in the sort.


Accessibility
-------------

Keyboard Support
~~~~~~~~~~~~~~~~


+-----------------------+----------------------------------------------------------------------------------+
| Key                   | Action                                                                           |
+=======================+==================================================================================+
| LEFT/RIGHT arrow keys | Moves the keyboard focus among column headers and regions within a column header |
+-----------------------+----------------------------------------------------------------------------------+
| SPACE key             | Chooses the sorting choice with the keyboard focus                               |
+-----------------------+----------------------------------------------------------------------------------+

  * The above keys are only effective when keyboard focus is within the column headers.

Screen Readers
~~~~~~~~~~~~~~

ARIA attributes "aria-label" and "aria-sort" are used for screen readers.

+--------------------+---------------------+----------------------------------------------------------------------------+
| Region             | ARIA Attribute      | ARIA Attribute Value                                                       |
+====================+=====================+============================================================================+
| Select region      | aria-label          | Column name                                                                |
+--------------------+---------------------+----------------------------------------------------------------------------+
| Unary sort choice  | aria-sort           | Sorting state, e.g. "descending"                                           |
+--------------------+---------------------+----------------------------------------------------------------------------+
|                    | aria-label          | - Normal sate - "Column 2 Genre single sort"                               |
|                    |                     | - Hovered - "Column 2 Genre - Press space to choose descending nested sort"|
+--------------------+---------------------+----------------------------------------------------------------------------+
| Nested sort choice | aria-sort           | Sorting state, e.g. "descending"                                           |
+--------------------+---------------------+----------------------------------------------------------------------------+
|                    | aria-label          | - Normal sate - "Column 2 Genre nested sort sort position 1"               |
|                    |                     | - Hovered - "Column 2 Genre - Press space to choose descending nested sort"|
+--------------------+---------------------+----------------------------------------------------------------------------+

Note: In Firefox v.3.5, JAWS10 doesn't announce all the above ARIA attributes appropriately. This will be addressed when newer JAWS and Firefox versions are released.


See Also
========

* :ref:`dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>` - The enhanced grid supporting plugins
* :ref:`dojox.grid.EnhancedGrid.plugins <dojox/grid/EnhancedGrid/plugins>` - Overview of the plugins of enhanced grid
