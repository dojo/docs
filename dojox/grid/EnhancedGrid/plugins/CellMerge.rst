#format dojo_rst

dojox.grid.EnhancedGrid.plugins.CellMerge
=========================================

:Authors: Oliver Zhu
:Project owner: Evan Huang
:Available: since V.1.6

CellMerge plugin provides functions to merge cells within a row.

.. contents::
   :depth: 2

============
Introduction
============

CellMerge is a plugin for dojox.grid.EnhancedGrid. It provides functions to merge(un-merge) adjacent cells within one row.

.. code-example::
  :toolbar: themes, versions, dir
  :width: 600
  :height: 500

  .. javascript::

	<script type="text/javascript">
		dojo.require("dojo.data.ItemFileWriteStore");
		dojo.require("dojox.grid.EnhancedGrid");
		dojo.require("dojox.grid.enhanced.plugins.CellMerge");

		var data = {
			identifier: 'id',
			label: 'id',
			items: []
		};
		var data_list = [
			{"Heard": true, "Checked": "True", "Genre":"Easy Listening",	"Artist":"Bette Midler",	"Year":2003,	"Album":"Bette Midler Sings the Rosemary Clooney Songbook",	"Name":"Hey There",	"Length":"03:31",	"Track":4,	"Composer":"Ross, Jerry 1926-1956 -w Adler, Richard 1921-",	"Download Date":"1923/4/9",	"Last Played":"04:32:49"},
			{"Heard": true, "Checked": "True", "Genre":"Classic Rock",	"Artist":"Jimi Hendrix",	"Year":1993,	"Album":"Are You Experienced",	"Name":"Love Or Confusion",	"Length":"03:15",	"Track":4,	"Composer":"Jimi Hendrix",	"Download Date":"1947/12/6",	"Last Played":"03:47:49"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Andy Narell",	"Year":1992,	"Album":"Down the Road",	"Name":"Sugar Street",	"Length":"07:00",	"Track":8,	"Composer":"Andy Narell",	"Download Date":"1906/3/22",	"Last Played":"21:56:15"},
			{"Heard": true, "Checked": "True", "Genre":"Progressive Rock",	"Artist":"Emerson, Lake & Palmer",	"Year":1992,	"Album":"The Atlantic Years",	"Name":"Tarkus",	"Length":"20:40",	"Track":5,	"Composer":"Greg Lake/Keith Emerson",	"Download Date":"1994/11/29",	"Last Played":"03:25:19"},
			{"Heard": true, "Checked": "True", "Genre":"Rock",	"Artist":"Blood, Sweat & Tears",	"Year":1968,	"Album":"Child Is Father To The Man",	"Name":"Somethin' Goin' On",	"Length":"08:00",	"Track":9,	"Composer":"",	"Download Date":"1973/9/11",	"Last Played":"19:49:41"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Andy Narell",	"Year":1989,	"Album":"Little Secrets",	"Name":"Armchair Psychology",	"Length":"08:20",	"Track":5,	"Composer":"Andy Narell",	"Download Date":"2010/4/15",	"Last Played":"01:13:08"},
			{"Heard": true, "Checked": "True", "Genre":"Easy Listening",	"Artist":"Frank Sinatra",	"Year":1991,	"Album":"Sinatra Reprise: The Very Good Years",	"Name":"Luck Be A Lady",	"Length":"05:16",	"Track":4,	"Composer":"F. Loesser",	"Download Date":"2035/4/12",	"Last Played":"06:16:53"},
			{"Heard": true, "Checked": "True", "Genre":"Progressive Rock",	"Artist":"Dixie dregs",	"Year":1977,	"Album":"Free Fall",	"Name":"Sleep",	"Length":"01:58",	"Track":6,	"Composer":"Steve Morse",	"Download Date":"2032/11/21",	"Last Played":"08:23:26"},
			{"Heard": true, "Checked": "True", "Genre":"Classic Rock",	"Artist":"Black Sabbath",	"Year":2004,	"Album":"Master of Reality",	"Name":"Sweet Leaf",	"Length":"05:04",	"Track":1,	"Composer":"Bill Ward/Geezer Butler/Ozzy Osbourne/Tony Iommi",	"Download Date":"2036/5/26",	"Last Played":"22:10:19"},
			{"Heard": true, "Checked": "True", "Genre":"Blues",	"Artist":"Buddy Guy",	"Year":1991,	"Album":"Damn Right, I've Got The Blues",	"Name":"Five Long Years",	"Length":"08:27",	"Track":3,	"Composer":"Eddie Boyd/John Lee Hooker",	"Download Date":"1904/4/4",	"Last Played":"18:28:08"},
			{"Heard": true, "Checked": "True", "Genre":"Easy Listening",	"Artist":"Frank Sinatra",	"Year":1991,	"Album":"Sinatra Reprise: The Very Good Years",	"Name":"The Way You Look Tonight",	"Length":"03:23",	"Track":5,	"Composer":"D. Fields/J. Kern",	"Download Date":"1902/10/12",	"Last Played":"23:09:23"},
			{"Heard": true, "Checked": "True", "Genre":"World",	"Artist":"Andy Statman & David Grisman",	"Year":1995,	"Album":"Songs Of Our Fathers",	"Name":"Chassidic Medley: Adir Hu / Moshe Emes",	"Length":"04:14",	"Track":2,	"Composer":"Shlomo Carlebach; Trad.",	"Download Date":"2035/2/9",	"Last Played":"00:11:15"},
			{"Heard": true, "Checked": "True", "Genre":"Classic Rock",	"Artist":"Jimi Hendrix",	"Year":1968,	"Album":"Electric Ladyland",	"Name":"Long Hot Summer Night",	"Length":"03:27",	"Track":6,	"Composer":"Jimi Hendrix",	"Download Date":"1902/4/7",	"Last Played":"16:58:08"}];

		var i, len;
		for(i=0, len = data_list.length; i < len; ++i){
			data.items.push(dojo.mixin({'id': i + 1 }, data_list[i % len]));
		}
			
		var layout = [{
			cells: [
				{ field: "id", name:"Identity", datatype:"number", width: 4, editable: false},
				{ field: "Genre", name:"Genre", datatype:"string", width: 10},
				{ field: "Artist", name:"Artist", datatype:"string", width: 10},
				{ field: "Year", name:"Year", datatype:"string", width: 2.5},
				{ field: "Album", name:"Album", datatype:"string", width: 10},
				{ field: "Name", name:"Name", datatype:"string", width: 8},
				{ field: "Length", name:"Length", datatype:"string", width: 4},
				{ field: "Track", name:"Track", datatype:"number", width: 3},
				{ field: "Composer", name:"Composer", datatype:"string", width: 12},
				{ field: "Download Date", name:"Download Date", datatype:"date", width: 12},
				{ field: "Last Played", name:"Last Played", datatype:"time", width: 6},
				{ field: "Heard", name: "Checked", datatype:"boolean", width: 6}
			]
		}];
		
		function mergeCells(){
			var rowIndex = parseInt(dojo.byId("inputRow").value, 10);
			var start = parseInt(dojo.byId("inputStart").value, 10);
			var end = parseInt(dojo.byId("inputEnd").value, 10);
			var major = parseInt(dojo.byId("inputMajor").value, 10);
			var grid = dijit.byId("grid");
			grid.mergeCells(rowIndex, start, end, major);
		};
		dojo.ready(function(){
			var store = new dojo.data.ItemFileWriteStore({data: data});

			var grid = new dojox.grid.EnhancedGrid({
				id: 'grid',
				store: store,
				structure: layout,
				plugins: {
					cellMerge: {
						mergedCells: [
							{row: 0, start: 0, end: 5, major: 2},
							{row: 2, start: 2, end: 4, major: 3},
							{row: 3, start: 1, end: 6, major: 1}
						]
					}
				}
			});

			grid.placeAt('gridContainer');
			grid.startup();
		});	
	</script>

  .. html::

	<div id="gridContainer"></div>
	<br />
	<div class="container">
		<table>
			<tr>
				<td>At row (0 based)</td>
				<td><input id="inputRow" type="text" value="5" size="3"/></td>
			</tr>
			<tr>
				<td>From column</td>
				<td><select id="inputStart">
					<option value="0">1</option>
					<option value="1">2</option>
					<option value="2" selected="true">3</option>
					<option value="3">4</option>
					<option value="4">5</option>
					<option value="5">6</option>
					<option value="6">7</option>
					<option value="7">8</option>
					<option value="8">9</option>
					<option value="9">10</option>
					<option value="10">11</option>
				</select></td>
				<td>To column</td>
				<td><select id="inputEnd">
					<option value="0">1</option>
					<option value="1">2</option>
					<option value="2">3</option>
					<option value="3">4</option>
					<option value="4">5</option>
					<option value="5">6</option>
					<option value="6">7</option>
					<option value="7" selected="true">8</option>
					<option value="8">9</option>
					<option value="9">10</option>
					<option value="10">11</option>
				</select></td>
			</tr>
			<tr>
				<td>Use data of column</td>
				<td><select id="inputMajor">
					<option value="0">1</option>
					<option value="1">2</option>
					<option value="2">3</option>
					<option value="3" selected="true">4</option>
					<option value="4">5</option>
					<option value="5">6</option>
					<option value="6">7</option>
					<option value="7">8</option>
					<option value="8">9</option>
					<option value="9">10</option>
					<option value="10">11</option>
					<option value="">(Use Default)</option>
				</select></td>
			</tr>
			<tr>
				<td colspan="2"><button onclick="mergeCells()">Merge Cells by Index</button></td>
			</tr>
		</table>
	</div>

  .. css::

    <style type="text/css">
    @import "{{ baseUrl }}dojo/resources/dojo.css";
    @import "{{ baseUrl }}dijit/themes/{{ theme }}/{{ theme }}.css";
    @import "{{ baseUrl }}dijit/themes/{{ theme }}/document.css";
    @import "{{ baseUrl }}dojox/grid/enhanced/resources/{{ theme }}/EnhancedGrid.css";
    @import "{{ baseUrl }}dojox/grid/enhanced/resources/EnhancedGrid_rtl.css";
	
	#gridContainer {
		width: 100%;
		height: 300px;
	}
    </style>



=============
Configuration
=============

Prerequisites
-------------

This CellMerge plugin is only available for EnhancedGrid, so use the following statement in the head of your HTML file:

.. code-block :: javascript
  :linenos:

  dojo.require("dojox.grid.EnhancedGrid");
  dojo.require("dojox.grid.enhanced.plugins.CellMerge");


Plugin Declaration
------------------

The declaration name of this plugin is ``cellMerge`` . It is declared in the ``plugins`` property of grid.

If your grid is created declaratively:

.. code-block :: html
  :linenos:

  <div id="grid" data-dojo-type="dojox.grid.EnhancedGrid" 
    data-dojo-props="store:mystore, structure:'mystructure',
    plugins:{
      cellMerge: /* a Boolean value or an argument object */{}
  }" ></div>

If your grid is created in JavaScript:

.. code-block :: javascript
  :linenos:

  var grid = new dojox.grid.EnhancedGrid({
    id:"grid",
    store:"mystore",
    structure:"mystructure",
    plugins:{
      cellMerge: /* a Boolean value or an argument object */{}
    }
  });

As shown in the above code, you can simply set the ``cellMerge`` property to true or false (disabled), or further configure it in an argument object.

=========================  ========  ===============  =================================================================================================
Property                   Type      Default Value    Description
=========================  ========  ===============  =================================================================================================
mergedCells                Array     []               Used to define pre-merged cells. For the structure of the objects in this array please see below.
=========================  ========  ===============  =================================================================================================

Merged cell object structure:

===========  ============================  =====================  =============================================================================================================
Property     Type                          Optional/Mandatory     Description
===========  ============================  =====================  =============================================================================================================
row          Integer|function(Integer)     Mandatory              If it's an Integer, it's the index of the row which have cells to be merged.
                                                                  If it's a function, it's a predicate to decide which rows are to be merged. 
                                                                  It takes an integer (the row index), and should return true or false;        
start        Integer                       Mandatory              The column index of the left most cell that shall be merged.
end          Integer                       Mandatory              The column index of the right most cell that shall be merged.
major        Integer                       Optional               The column index of the cell whose content should be used as the content of the merged cell.
                                                                  It must be larger than or equal to the startColumnIndex, and less than or equal to the endColumnIndex.
                                                                  If it is omitted, the content of the leading edge (left-most for ltr, right most for rtl) cell will be used.
handle                                                            If a "merged cell" structure is returned from getMergedCells/getMergedCellsByRow, this field is valid, so it
                                                                  can be used to unmerge the cells.
===========  ============================  =====================  =============================================================================================================

=====
Usage
=====

This plugin exposes the following methods to the grid:

mergeCells(rowTester, start, end, major):
	Merge cells from startColumnIndex to endColumnIndex at rows that make rowTester return true, using the content of the cell at majorColumnIndex.
	Returns a merge handler, used to unmerge the cells.
	Please refer to "Merge cell object structure" for the detail of the arguments.

unmergeCells(mergeHandler)
	Unmerge the cells that are merged by the **mergeHandler**, which represents a call to the function mergeCells.

getMergedCells()
	Returns an array of records of all merged-cells.

getMergedCellsByRow(rowIndex)
	Returns an array of records of currently merged cells at the given row.

Here is some examples on how to use this API:

.. code-block :: javascript
  :linenos:

  //Merge cells of column 2, column 3 and column 4 on the second row, using the content of the cell on column 3 for the merged cell. 
  var handle1 = grid.mergeCells(1, 2, 4, 3); 

  //Merge cells of column 2, column 3 and column 4 on every third row, using the content of column 3 for the merged cells. 
  var handle2 = grid.mergeCells(function(rowIndex){
    return !((rowIndex + 1) % 3);
  }, 2, 4);

  //Unmerge some merged cells
  grid.unmergeCells(handle1);

  //Unmerge all merged cells.
  dojo.forEach(grid.getMergedCells(), function(item){
    grid.unmergeCells(item.handle);
  });

And here is the effect of merged cells:

.. image:: cellmerge.png

========
See Also
========

* `dojox.grid.DataGrid <dojox/grid/DataGrid>`_ - The base grid
* `dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>`_ - The enhanced grid supporting plugins
* `dojox.grid.EnhancedGrid.plugins <dojox/grid/EnhancedGrid/plugins>`_ - Overview of the plugins of enhanced grid
* `dojox.grid.TreeGrid <dojox/grid/TreeGrid>`_ - Grid with collapsable rows and model-based (`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`_) structure
