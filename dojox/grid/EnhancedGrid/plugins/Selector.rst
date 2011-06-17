#format dojo_rst

dojox.grid.EnhancedGrid.plugins.Selector
========================================

:Authors: Zhu Xiao Wen
:Project owner: Nathan Toone
:Available: since V.1.6

Selector plugin provides extended selection for columns, rows and cells.

.. contents::
   :depth: 2

============
Introduction
============

Selector is a plugin for dojox.grid.EnhancedGrid. It supports extended selection for columns, rows, and cells.

.. code-example::
  :toolbar: themes, versions, dir
  :width: 640
  :height: 610

  .. javascript::

	<script type="text/javascript">
		dojo.require("dojo.data.ItemFileWriteStore");
		dojo.require("dojox.grid.EnhancedGrid");
		dojo.require("dojox.grid.enhanced.plugins.Selector");

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
		for(i=0; i < len ; ++i){
			data.items.push(dojo.mixin({ 'id': i+1 }, data_list[i]));
		}	

		var layout = [{
			defaultCell: {width: 3},
			rows: [
				{field: "A"},
				{field: "B"},
				{field: "C"},
				{field: "D"},
				{field: "E"},
				{field: "F"},
				{field: "G", hidden: true},
				{field: "H", hidden: true},
				{field: "I", hidden: true},
				{field: "J"},
				{field: "K"},
				{field: "L"},
				{field: "M"},
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
		function setSelectConfig(type, mode, selected){
			if(selected){
				var config = {};
				config[type] = mode;
				dijit.byId('grid').setupSelectorConfig(config);
