#format dojo_rst

Grid Demos - Cells with DateTextBox
===================================

:Authors: Zhu Xiao Wen
:Project owner: Nathan Toone
:Available: since V.1.6


=============================================================
Editable Date Field in Custom Format with ISO Format in Store
=============================================================

.. code-example::
  :toolbar: themes, versions, dir
  :version: local
  :width: 200
  :height: 200

  .. javascript::

	<script type="text/javascript">
		dojo.require("dojo.data.ItemFileWriteStore");
		dojo.require("dojox.grid.DataGrid");
		dojo.require("dojox.grid.cells.dijit");
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

		var storePattern = 'yyyy-MM-dd';
		var displayPattern = 'yyyy, MMMM, d';
		
		function formatDate(datum){
			var d = dojo.date.locale.parse(datum, {selector: 'date', datePattern: storePattern});
			return dojo.date.locale.format(d, {selector: 'date', datePattern: displayPattern});
		}
		
		function getDate(){
			return dojo.date.locale.format(this.widget.get('value'), {selector: 'date', datePattern: storePattern});
		}
		
		var layout = [
			{name: 'Index', field: 'id'},
			{name: 'Date', field: 'date', editable: true, width: 10,
				type: dojox.grid.cells.DateTextBox,
				formatter: formatDate, 
				//Override the default getValue function
				getValue: getDate,
				constraint: {datePattern: displayPattern}
			}
		];
	</script>

  .. html::

   <div id="grid" dojoType="dojox.grid.DataGrid" store="store" structure="layout"></div>

  .. css::

    <style type="text/css">
    @import "{{ baseUrl }}/dojo/resources/dojo.css";
    @import "{{ baseUrl }}/dijit/themes/{{ theme }}/{{ theme }}.css";	
    @import "{{ baseUrl }}/dojox/grid/resources/{{ theme }}Grid.css";
	
	#grid{
		width: 100%;
		height: 100%;
	}
    </style>

========================================================
Date Field in DateTextBox dijit with ISO Format in Store
========================================================

.. code-example::
  :toolbar: themes, versions, dir
  :version: local
  :width: 300
  :height: 200

  .. javascript::

	<script type="text/javascript">
		dojo.require("dojo.data.ItemFileWriteStore");
		dojo.require("dojox.grid.DataGrid");
		dojo.require("dojox.grid.cells.dijit");
		dojo.require("dojo.date.locale");
		dojo.require("dijit.form.DateTextBox");
		
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

		var storePattern = 'yyyy-MM-dd';
		var displayPattern = 'yyyy, MMMM, d';
		
		function dijitDate(datum){
			return new dijit.form.DateTextBox({
				value: dojo.date.locale.parse(datum, {selector: 'date', datePattern: storePattern}),
				constraints: {datePattern: displayPattern}
			});
		}
		
		var layout = [
			{name: 'Index', field: 'id'},
			{name: 'Date', field: 'date', width: 16,
				formatter: dijitDate
			}
		];
	</script>

  .. html::

   <div id="grid" dojoType="dojox.grid.DataGrid" store="store" structure="layout"></div>

  .. css::

    <style type="text/css">
    @import "{{ baseUrl }}/dojo/resources/dojo.css";
    @import "{{ baseUrl }}/dijit/themes/{{ theme }}/{{ theme }}.css";	
    @import "{{ baseUrl }}/dojox/grid/resources/{{ theme }}Grid.css";
	
	#grid{
		width: 100%;
		height: 100%;
	}
    </style>


===============================================================
Editable Date Field in Custom Format with Date Objects in Store
===============================================================

.. code-example::
  :toolbar: themes, versions, dir
  :version: local
  :width: 200
  :height: 200

  .. javascript::

	<script type="text/javascript">
		dojo.require("dojo.data.ItemFileWriteStore");
		dojo.require("dojox.grid.DataGrid");
		dojo.require("dojox.grid.cells.dijit");
		dojo.require("dojo.date.stamp");
		
		var store = new dojo.data.ItemFileWriteStore({
			data: {
				identifier: "id",
				items: [
					{id: 1, date: new Date(1262275200000)},
					{id: 2, date: new Date(1299168000000)},
					{id: 3, date: new Date(1299513600000)},
					{id: 4, date: new Date(1171382400000)},
					{id: 5, date: new Date(1230220800000)}
				]
			}
		});

		function formatDate(inDatum){
			return dojo.date.stamp.toISOString(inDatum, {selector: 'date'});
		}
		
		var layout = [
			{name: 'Index', field: 'id'},
			{name: 'Date', field: 'date', editable: true, width: 10,
				type: dojox.grid.cells.DateTextBox, 
				formatter: formatDate,
				constraint: {formatLength: 'long', selector: 'date'}
			}
		];
	</script>

  .. html::

   <div id="grid" dojoType="dojox.grid.DataGrid" store="store" structure="layout"></div>

  .. css::

    <style type="text/css">
    @import "{{ baseUrl }}/dojo/resources/dojo.css";
    @import "{{ baseUrl }}/dijit/themes/{{ theme }}/{{ theme }}.css";	
    @import "{{ baseUrl }}/dojox/grid/resources/{{ theme }}Grid.css";
	
	#grid{
		width: 100%;
		height: 100%;
	}
    </style>

========
See Also
========

* `dojox.grid.DataGrid <dojox/grid/DataGrid>`_ - The base grid
* `dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>`_ - The enhanced grid supporting plugins
* `dojox.grid.TreeGrid <dojox/grid/TreeGrid>`_ - Grid with collapsable rows and model-based (`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`_) structure
