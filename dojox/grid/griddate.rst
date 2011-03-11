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
  :width: 480
  :height: 300

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

============================================
Editable Date Field with ISO Format in Store
============================================

===============================================
Editable Date Field with Custom Format in Store
===============================================

======================================
Dijit Date Field with Integer in Store
======================================



========
See Also
========

* `dojox.grid.DataGrid <dojox/grid/DataGrid>`_ - The base grid
* `dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>`_ - The enhanced grid supporting plugins
* `dojox.grid.TreeGrid <dojox/grid/TreeGrid>`_ - Grid with collapsable rows and model-based (`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`_) structure
