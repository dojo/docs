.. _dojox/grid/EnhancedGrid/plugins/Pagination:

==========================================
dojox.grid.EnhancedGrid.plugins.Pagination
==========================================

:Authors: Wang Qiang
:Project owner: Evan Huang
:since: V.1.6

Pagination plugin provides paging functionality for grid.

.. contents ::
    :depth: 2

Introduction
============

Pagination is a plugin for dojox.grid.EnhancedGrid. It's designed to allow the user to navigate within the grid data by page. It provides page navigation and page length choices. The following documentation describes how to use the pagination plugin and its public API.

.. code-example::
  :toolbar: themes, versions, dir
  :width: 550
  :height: 350

  .. js ::

      dojo.require("dojox.grid.EnhancedGrid");
      dojo.require("dojox.grid.enhanced.plugins.Pagination");
      dojo.require("dojo.data.ItemFileWriteStore");

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
          var rows = 200;
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

          /*create a new grid:*/
          var grid = new dojox.grid.EnhancedGrid({
              id: 'grid',
              store: store,
              structure: layout,
              rowSelector: '20px',
              plugins: {
                pagination: {
                    pageSizes: ["25", "50", "100", "All"],
                    description: true,
                    sizeSwitch: true,
                    pageStepper: true,
                    gotoButton: true,
                            /*page step to be displayed*/
                    maxPageStep: 4,
                            /*position of the pagination bar*/
                    position: "bottom"
                }
              }
          }, document.createElement('div'));

          /*append the new grid to the div*/
          dojo.byId("gridDiv").appendChild(grid.domNode);

          /*Call startup() to render the grid*/
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

Configuration
=============

Prerequisites
-------------

The pagination plugin is only available for EnhancedGrid. Please use the following statement at first:

.. js ::
  
  dojo.require("dojox.grid.EnhancedGrid");
  dojo.require("dojox.grid.enhanced.plugins.Pagination");
  
Plugin Declaration
------------------

The declaration name of this plugin is ``pagination``. It is declared in the ``plugins`` property of grid.

If your grid is created declaratively:

.. html ::
    
    <div id="grid" data-dojo-type="dojox.grid.EnhancedGrid"
      data-dojo-props="store:mystore, structure:'mystructure',
      plugins:{
        pagination: /* a Boolean value or an configuration object */{}
    }" ></div>

If your grid is created programmatically:

.. js ::
  
  var grid = new dojox.grid.EnhancedGrid({
    id:"grid",
    store:"mystore",
    structure:"mystructure",
    plugins:{
      pagination: /* a Boolean value or an configuration object */{}
    }
  });

As shown in the above code, you can simply set the ``pagination`` property to ``true`` (enabled) or ``false`` (disabled), or further configure it in an argument object. The available pagination configuration arguments are described in Table 1 with reference to Figure 1.

Below is all of pagination configuration arguments:

=========================  =======================  ===============  ================================================================================================================
Property                   Type                     Default Value    Description
=========================  =======================  ===============  ================================================================================================================
description                Boolean                  true             Indicates whether or not display the current position display. Default is true (display).
sizeSwitch                 Boolean                  true             Indicates whether or not display the page length menu. Default is true (display).
pageStepper                Boolean                  true             Indicates whether or not display the page navigation choices. Default is true (display).
gotoButton                 Boolean                  false            Indicates whether or not the go to page button. Default is false (not display).
position                   String                   "bottom"         Indicates the pagination control bar's position.
                                                                     There are two options: top (place the pagination bar top of the grid); bottom (place the pagination bar bottom
                                                                     of the grid).
pageSizes                  Array                    [10, 25, 50,     Customize the page length menu options. The element of the array should be an integer, and any other value which
                                                    100, Infinity]   can not be parsed to an integer will be treated as "All" option.
maxPageStep                integer                  7                Indicates how many page navigation choices will be displayed (Suggested that the value should be less than 10).
defaultPageSize            integer                  pageSizes[0]     The default rows size per page when grid initialized.
defaultPage                integer                  1 (first page)   Which page will be displayed when grid initialized.
=========================  =======================  ===============  ================================================================================================================

Usage
=====

User Interface
--------------

The pagination bar has one main element and three optional elements: *paging navigation choices* (main element), *current position display*, *page length menu* and *go to page button*.

The following image is an overview of pagination's UI.

.. image :: pagination_ui_overview.bmp

The *page navigation choices* is the main element of the pagination. The *paging navigation choices* including two main parts: 1) the relative (first, previous, next, last) and specific page choices and 2) the go to page button.

.. image :: pagination_pagestep.bmp

The go to page button is an optional element. A go to page dialog will show when the *Go to page* button was fired. The grid will go to the specified page after the user enters a vaild page number and clicks the "go" button or presses ENTER. This process can be canceled by clicking the "Cancel" button or pressing ESC.

.. image :: pagination_gotopage.jpg

The *current position display* includes information like total number of items and item range of current page. The current position display can be omitted by setting ``showDescription`` to ``false``. Also, the user can specify the string to use to display the type of item.

.. image :: pagination_currentposition.jpg

The user can change the number of items displayed on each page by clicking the *page length choice*. It can be omitted by setting ``showSizeSwitch`` to ``false``. The page length menu choices can be specified through the ``pageSizeArr`` parameter.

.. image :: pagination_pagingsize.jpg

Accessibility
-------------

Below is a summary of all supported keyboard operators.

==============================================  ===============================================================
Key                                             Action
==============================================  ===============================================================
Tab/shift + Tab from outside of pagination bar  The element (one of the page length menu or page navigation
                                                choices) of the pagination bar will receive the focus.
Tab/shift + Tab from inside of pagination bar   The focus will switch among the elements of the pagination bar.
arrow key                                       The focus will move the specific direction in current element
                                                area.
==============================================  ===============================================================

Public API
==========

All available methods of the pagination are listed below:

==================  =====================================  =====================  =======================================================
Name                Parameters                             Return                 Description
==================  =====================================  =====================  =======================================================
currentPage         page index: integer                    current page index     Function to handle shifting to the specific page,
                                                                                  and return the current page index. Only return the
                                                                                  current page index if an invalid parameter passed
                                                                                  in.
currentPageSize     page size: integer                     current page size      Function to handle setting the rows per page, and
                                                                                  return the current page size. If an invalid parameter
                                                                                  passed in, only return the current page size.
nextPage            N/A                                    N/A                    Function to handle shifting to the next page
prevPage            N/A                                    N/A                    Function to handle shifting to the previous page
firstPage           N/A                                    N/A                    Jump to first page.
lastPage            N/A                                    N/A                    Jump to last page.
getTotalPageNum     N/A                                    The total page number  A getter to gain the total page number.
getTotalRowCount    N/A                                    The total rows count   A getter to gain the total rows count.
scrollToRow         rowIndex: integer                      N/A                    Override the grid.ScrollToRow().
                                                                                  Scroll to give row automatically, if the given
                                                                                  row is not in this page, will jump to the right
                                                                                  page and scroll to the row.
showGotoPageButton  flag: boolean                          N/A                    Function to show/hide the Goto page button dynamically.
gotoPage            pageIdx: integer                       N/A                    Deprecated, please use *currentPage* method instead.
changePageSize      size: integer                          N/A                    Deprecated, please use *currentPageSize* method instead.
gotoNextPage        N/A                                    N/A                    Deprecated, please use *nextPage* method instead.
gotoPrevPage        N/A                                    N/A                    Deprecated, please use *prevPage* method instead.
gotoFirstPage       N/A                                    N/A                    Deprecated, please use *firstPage* method instead.
gotoLastPage        N/A                                    N/A                    Deprecated, please use *lastPage* method instead.
==================  =====================================  =====================  =======================================================


See Also
========

* :ref:`dojox.grid.DataGrid <dojox/grid/DataGrid>` - The base grid
* :ref:`dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>` - The enhanced grid supporting plugins
* :ref:`dojox.grid.EnhancedGrid.plugins <dojox/grid/EnhancedGrid/plugins>` - Overview of the plugins of enhanced grid
