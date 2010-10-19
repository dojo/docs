#format dojo_rst

dojox.grid.EnhancedGrid.plugins.Search
=========================================

:Project owner: Nathan Toone
:Available: since V.1.6

Search plugin provides a method to search the grid data by regular expressions or wildcard patterns.

.. contents::
   :depth: 2

============
Introduction
============

Search is a plugin for dojox.grid.EnhancedGrid. It provides a method to search the grid data by regular expressions or wildcard patterns.

=============
Configuration
=============

Prerequisites
-------------

This search plugin is only available for EnhancedGrid, so use the following statement in the head of your HTML file:

.. code-block :: javascript
  :linenos:

  dojo.require("dojox.grid.EnhancedGrid");
  dojo.require("dojox.grid.enhanced.plugins.Search");


Plugin Declaration
------------------

The declaration name of this plugin is ``search`` . It is declared in the ``plugins`` property of grid.

If your grid is created declaratively:

.. code-block :: javascript
  :linenos:

  <div id="grid" dojoType="dojox.grid.EnhancedGrid" 
    store="mystore" structure="mystructure" 
    plugins="{
      search: /* a Boolean value or an argument object */{}
  }" ></div>

If your grid is created in JavaScript:

.. code-block :: javascript
  :linenos:

  var grid = new dojox.grid.EnhancedGrid({
    id:"grid",
    store:"mystore",
    structure:"mystructure",
    plugins:{
      search: /* a Boolean value or an argument object */{}
    }
  });

As shown in the above code, you can simply set the ``search`` argument to true or false (disabled), or further configure it in an argument object.

The details of this argument is shown in the following table:

=============  ========  ===============  ==============================================================
Property       Type      Default Value    Description
=============  ========  ===============  ==============================================================
cacheSize      Integer   -1               Number of rows to fetch at one time. If <= 0, will fetch all. 
=============  ========  ===============  ==============================================================

=====
Usage
=====

This plugin exposes one method to the grid:

searchRow(searchArg, onSearched):
	Search the store of the grid for a regular expression, a wildcard pattern string, or a set of them for different columns.

==============  ==========================  ==========================  ========================================================================================================================
Arguments       Type                        Optional/Mandatory          Description
==============  ==========================  ==========================  ========================================================================================================================
searchArg       Object|RegExp|String        Mandatory                   If it is a regular expression or a wildcard pattern, the search will be performed for every column.
                                                                        If searchArgs is an object which consists of "store field": "regular expression" (can also be wildcard pattern) pairs,
                                                                        the search will be performed only for the identified columns.
onSearched      function(Integer, object)   Mandatory                   This callback function receives the row index and the data item if search is successful, -1 and null if not successful.
==============  ==========================  ==========================  ========================================================================================================================

Here is some examples on how to use this API:

.. code-block :: javascript
  :linenos:
  
  //Search on some specific columns.
  grid.searchRow({
    "Name":    /^[Jj]ohn/,
    "School":    "Ari*",
    "Score":    /^[AaBb]$/
  }, function(rowIndex, item){
    /* Do something interesting here... */
  });

  //Search the whole grid.
  grid.searchRow(/^[Jj]ohn/, function(rowIndex, item){
    /* Do something interesting here... */
  });
