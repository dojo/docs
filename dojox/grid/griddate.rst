#format dojo_rst

Grid Demos - Cells with DateTextBox
===================================

:Authors: Zhu Xiao Wen
:Project owner: Nathan Toone
:Available: since V.1.6


=============================================
Editable Date Field with Date Object in Store
=============================================

.. code-example::
  :toolbar: themes, versions, dir
  :version: local
  :width: 200
  :height: 150

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

============================================
Editable Date Field with ISO Format in Store
============================================

.. code-example::
  :toolbar: themes, versions, dir
  :version: local
  :width: 200
  :height: 150

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
					{id: 1, date: '2010-01-01'},
					{id: 2, date: '2011-03-04'},
					{id: 3, date: '2011-03-08'},
					{id: 4, date: '2007-02-14'},
					{id: 5, date: '2008-12-26'}
				]
			}
		});

		function getDate(){
			return dojo.date.stamp.toISOString(this.widget.get('value'), {selector: 'date'});
		}
		
		var layout = [
			{name: 'Index', field: 'id'},
			{name: 'Date', field: 'date', editable: true, width: 10,
				type: dojox.grid.cells.DateTextBox, 
				//Override the default getValue function
				getValue: getDate,
				constraint: {formatLength: 'long', selector: "date"}
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

===============================================
Editable Date Field with Custom Format in Store
===============================================

.. code-example::
  :toolbar: themes, versions, dir
  :version: local
  :width: 200
  :height: 150

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
					{id: 1, date: '2010/1/1'},
					{id: 2, date: '2011/3/4'},
					{id: 3, date: '2011/3/8'},
					{id: 4, date: '2007/2/14'},
					{id: 5, date: '2008/12/26'}
				]
			}
		});
		
		var storePattern =  'yyyy/M/d';
		var displayPattern = 'MMMM dd, yyyy';
		
		function formatDate(datum){
			var d = dojo.date.locale.parse(datum, {selector: 'date', datePattern: storePattern});
			return dojo.date.locale.format(d, {selector: 'date', datePattern: displayPattern});
		}
		
		function getDate(){
			return dojo.date.locale.format(this.widget.get('value'), {selector: 'date', datePattern: displayPattern});
		}
		
		var layout = [
			{name: 'Index', field: 'id'},
			{name: 'Date', field: 'date', editable: true, width: 10,
				type: dojox.grid.cells.DateTextBox, 
				formater: formatDate,
				//Override the default getValue function
				getValue: getDate,
				constraint: {formatLength: 'long', selector: "date"}
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

======================================
Dijit Date Field with Integer in Store
======================================

.. code-example::
  :toolbar: themes, versions, dir
  :version: local
  :width: 300
  :height: 150

  .. javascript::

	<script type="text/javascript">
		dojo.require("dojo.data.ItemFileWriteStore");
		dojo.require("dojox.grid.DataGrid");
		dojo.require("dijit.form.DateTextBox");
		dojo.require("dojox.grid.cells.dijit");
		
		var store = new dojo.data.ItemFileWriteStore({
			data: {
				identifier: "id",
				items: [
					{id: 1, date: 1262275200000},
					{id: 2, date: 1299168000000},
					{id: 3, date: 1299513600000},
					{id: 4, date: 1171382400000},
					{id: 5, date: 1230220800000}
				]
			}
		});

		function dijitDate(inDatum){
			return new dijit.form.DateTextBox({
				value: new Date(inDatum)
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


========
See Also
========

* `dojox.grid.DataGrid <dojox/grid/DataGrid>`_ - The base grid
* `dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>`_ - The enhanced grid supporting plugins
* `dojox.grid.TreeGrid <dojox/grid/TreeGrid>`_ - Grid with collapsable rows and model-based (`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`_) structure
