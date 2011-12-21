.. _dojox/grid/griddate:

===================================
Grid Demos - Cells with DateTextBox
===================================

:Authors: Zhu Xiao Wen
:Project owner: Nathan Toone
:since: V.1.6


Localized Date Field
=============================================================

.. code-example::
  :toolbar: themes, versions, dir

  .. js ::

        dojo.require("dojo.data.ItemFileReadStore");
        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojo.date.stamp");
        dojo.require("dojo.date.locale");

        var store = new dojo.data.ItemFileReadStore({
            data: {
                identifier: "id",
                items: [
                    {id: 1, date: '2010-01-01'},
                    {id: 2, date: '2011-03-04'},
                    {id: 3, date: '2011-03-08'},
                    {id: 4, date: '2007-02-14'},
                    {id: 5, date: '2008-12-26'}
                ]
            }
        });

        function formatDate(datum){
            // Format the value in store, so as to be displayed.
            var d = dojo.date.stamp.fromISOString(datum);
            return dojo.date.locale.format(d, {selector: 'date', formatLength: 'long'});
        }

        var layout = [
            {name: 'Index', field: 'id'},
            {name: 'Date', field: 'date', width: 10,
                formatter: formatDate    // Custom format, change the format in store.
            }
        ];

  .. html ::

   <div id="grid" data-dojo-type="dojox.grid.DataGrid" data-dojo-props="store:store, structure:'layout'"></div>

  .. css ::

    @import "{{ baseUrl }}/dojo/resources/dojo.css";
    @import "{{ baseUrl }}/dijit/themes/{{ theme }}/{{ theme }}.css";
    @import "{{ baseUrl }}/dojox/grid/resources/{{ theme }}Grid.css";

    #grid{
        width: 100%;
        height: 100%;
    }

Editable Localized Date Field
========================================================

Note: In editing mode, the text box will show the data in store, which is ISO format in this case; and no validation is provided.

.. code-example::
  :toolbar: themes, versions, dir

  .. js ::

        dojo.require("dojo.data.ItemFileWriteStore");
        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojo.date.stamp");
        dojo.require("dojo.date.locale");

        var store = new dojo.data.ItemFileWriteStore({
            data: {
                identifier: "id",
                items: [
                    {id: 1, date: '2010-01-01'},
                    {id: 2, date: '2011-03-04'},
                    {id: 3, date: '2011-03-08'},
                    {id: 4, date: '2007-02-14'},
                    {id: 5, date: '2008-12-26'}
                ]
            }
        });

        function formatDate(datum){
            // Format the value in store, so as to be displayed.
            var d = dojo.date.stamp.fromISOString(datum);
            return dojo.date.locale.format(d, {selector: 'date', formatLength: 'long'});
        }

        var layout = [
            {name: 'Index', field: 'id'},
            {name: 'Date', field: 'date', width: 10,
                formatter: formatDate,    // Custom format, change the format in store.
                editable: true            // Editable cell, will show ISO format in a text box
            }
        ];

  .. html ::

   <div id="grid" data-dojo-type="dojox.grid.DataGrid" data-dojo-props="store:store, structure:'layout'"></div>

  .. css ::

    @import "{{ baseUrl }}/dojo/resources/dojo.css";
    @import "{{ baseUrl }}/dijit/themes/{{ theme }}/{{ theme }}.css";
    @import "{{ baseUrl }}/dojox/grid/resources/{{ theme }}Grid.css";

    #grid{
        width: 100%;
        height: 100%;
    }


Editable Localized Date Field - use DateTextBox when editing
===============================================================

.. code-example::
  :toolbar: themes, versions, dir

  .. js ::

        dojo.require("dojo.data.ItemFileWriteStore");
        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojox.grid.cells.dijit");
        dojo.require("dojo.date.stamp");
        dojo.require("dojo.date.locale");

        var store = new dojo.data.ItemFileWriteStore({
            data: {
                identifier: "id",
                items: [
                    {id: 1, date: '2010-01-01'},
                    {id: 2, date: '2011-03-04'},
                    {id: 3, date: '2011-03-08'},
                    {id: 4, date: '2007-02-14'},
                    {id: 5, date: '2008-12-26'}
                ]
            }
        });

        function formatDate(datum){
            // Format the value in store, so as to be displayed.
            var d = dojo.date.stamp.fromISOString(datum);
            return dojo.date.locale.format(d, {selector: 'date', formatLength: 'long'});
        }

        function getDateValue(){
            // Override the default getValue function for dojox.grid.cells.DateTextBox
            return dojo.date.stamp.toISOString(this.widget.get('value'));
        }

        var layout = [
            {name: 'Index', field: 'id'},
            {name: 'Date', field: 'date', width: 10,
                formatter: formatDate,                // Custom format, change the format in store.
                editable: true,                       // Editable cell
                type: dojox.grid.cells.DateTextBox,   // Use DateTextBox in editing mode
                getValue: getDateValue,               // Translate the value of DateTextBox to something the store can understand.
                constraint: {formatLength: 'long'}    // Format the date value shown in DateTextBox
            }
        ];

  .. html ::

   <div id="grid" data-dojo-type="dojox.grid.DataGrid" data-dojo-props="store:store, structure:'layout'"></div>

  .. css ::

    @import "{{ baseUrl }}/dojo/resources/dojo.css";
    @import "{{ baseUrl }}/dijit/themes/{{ theme }}/{{ theme }}.css";
    @import "{{ baseUrl }}/dojox/grid/resources/{{ theme }}Grid.css";

    #grid{
        width: 100%;
        height: 100%;
    }

Editable Custom Format Date Field - use DateTextBox when editing
================================================================

.. code-example::
  :toolbar: themes, versions, dir

  .. js ::

        dojo.require("dojo.data.ItemFileWriteStore");
        dojo.require("dojox.grid.DataGrid");
        dojo.require("dojox.grid.cells.dijit");
        dojo.require("dojo.date.locale");

        var store = new dojo.data.ItemFileWriteStore({
            data: {
                identifier: "id",
                items: [
                    // Not ISO format in store
                    {id: 1, date: '2010/01/01'},
                    {id: 2, date: '2011/03/04'},
                    {id: 3, date: '2011/03/08'},
                    {id: 4, date: '2007/02/14'},
                    {id: 5, date: '2008/12/26'}
                ]
            }
        });

        var storePattern = 'yyyy/MM/dd';
        var displayPattern = 'yyyy, MMMM, d';

        function formatDate(datum){
            // Format the value in store, so as to be displayed.
            var d = dojo.date.locale.parse(datum, {selector: 'date', datePattern: storePattern});
            return dojo.date.locale.format(d, {selector: 'date', datePattern: displayPattern});
        }

        function getDateValue(){
            // Override the default getValue function for dojox.grid.cells.DateTextBox
            return dojo.date.locale.format(this.widget.get('value'), {selector: 'date', datePattern: storePattern});
        }

        var layout = [
            {name: 'Index', field: 'id'},
            {name: 'Date', field: 'date', width: 10,
                formatter: formatDate,                        // Custom format, change the format in store.
                editable: true,                               // Editable cell
                type: dojox.grid.cells.DateTextBox,           // Use DateTextBox in editing mode
                getValue: getDateValue,                       // Translate the value of DateTextBox to something the store can understand.
                constraint: {datePattern: displayPattern}     // Format the date value shown in DateTextBox
            }
        ];

  .. html ::

   <div id="grid" data-dojo-type="dojox.grid.DataGrid" data-dojo-props="store:store, structure:'layout'"></div>

  .. css ::

    @import "{{ baseUrl }}/dojo/resources/dojo.css";
    @import "{{ baseUrl }}/dijit/themes/{{ theme }}/{{ theme }}.css";
    @import "{{ baseUrl }}/dojox/grid/resources/{{ theme }}Grid.css";

    #grid{
        width: 100%;
        height: 100%;
    }

See Also
========

* :ref:`dojox.grid.DataGrid <dojox/grid/DataGrid>` - The base grid
* :ref:`dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>` - The enhanced grid supporting plugins
* :ref:`dojox.grid.TreeGrid <dojox/grid/TreeGrid>` - Grid with collapsible rows and model-based (:ref:`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`) structure
