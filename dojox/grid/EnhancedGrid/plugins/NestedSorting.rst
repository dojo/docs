#format dojo_rst

dojox.grid.EnhancedGrid.plugins.NestedSorting
=============================================

:Authors: Evan Huang
:Project owner: Evan Huang
:Available: since V.1.6

.. contents::
   :depth: 2

==============
Introduction
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
	dojo.require("dojox.grid.enhanced.plugins.NestedSorting");
        dojo.require("dojox.data.CsvStore");
    
        dojo.addOnLoad(function(){
          // our test data store for this example:
          var store = new dojox.data.CsvStore({ url: '{{ dataUrl }}dojox/grid/tests/support/movies.csv' });

          // set the layout structure:
          var layout = [
              { field: 'Title', name: 'Title of Movie', width: '200px' },
              { field: 'Year', name: 'Year', width: '50px' },
              { field: 'Producer', name: 'Producer', width: 'auto' }
          ];

          // create a new grid:
          var grid = new dojox.grid.EnhancedGrid({
              query: { Title: '*' },
              store: store,
              clientSort: true,
              rowSelector: '20px',
              structure: layout,
              plugins : {nestedSorting: true}
          }, document.createElement('div'));

          // append the new grid to the div "gridContainer4":
          dojo.byId("gridDiv").appendChild(grid.domNode);

          // Call startup, in order to render the grid:
          grid.startup();
        });
    </script>

  .. html::

    <div id="gridDiv" style="width: 100%; height: 100%;"></div>

  .. css::

    <style type="text/css">
        @import "{{ baseUrl }}dojox/grid/enhanced/resources/{{ theme }}/EnhancedGrid.css";
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

...with HTML markup
    
.. code-block :: html
  :linenos:

  <div id="grid" store="store1" dojoType="dojox.grid.EnhancedGrid" plugins="{nestedSorting: true}" >
  </div>

...with JavaScript
    
.. code-block :: javascript
  :linenos:

  <script>
      var grid = new dojox.grid.EnhancedGrid({id: "grid", store: "store1", plugins: {nestedSorting: true}, ...}, dojo.byId("gridDiv"));
  </script>
    
When nested sorting is enabled, you can also use comparatorMap for custom sorting; see `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_ on DojoCampus.org for more details.

Scenario
--------

The following are typical scenarios using nested sorts:

* When there is no sorting established, a unary (single) sort caret is shown when the mouse hovers over a column. The upward direction of the caret reflects that this will result in an ascending sort.

.. image:: ../../sort-1.new.png

* Once the sort choice is selected for the 'Genre' column, the grid rows will be sorted ascending based on by the values in Genre. Note that the keyboard focus moves to the sort choice in response to the mouse click. The graphical label of the sort choice is a downward caret since the function would be a descending sort.

.. image:: sort-2.png

* Then the nested sort tip is shown when the mouse hovers over a other column headers.
* Clicking region "A" in the figure below will execute a nested sort, and the rows will be sorted by Artist in this example within Genre.
* Clicking region "B" will reset the sort, and the rows will be sorted by Artist alone.

.. image:: nested-sort-1.new.png

* Once a column is sorted ascending, the sort choice changes to a sort descending choice.

.. image:: descending-sort-1.png

* Once a column is sorted descending, the sort choice changes to a 'remove sort' function (see the figure below). When a column is removed from the sort, other columns in the sort will be adjusted to reflect the new sort order. For example, Year would become the second column in the sort if it had previously been the third.

.. image:: remove-sort.png

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


========
See Also
========

* `dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>`_ - The enhanced grid supporting plugins
* `dojox.grid.EnhancedGrid.plugins <dojox/grid/EnhancedGrid/plugins>`_ - Overview of the plugins of enhanced grid
