#format dojo_rst

dojox.grid.EnhancedGrid.plugins.CellFromatter
=============================================

:Project owner: Nathan Toone
:Available: since V.1.6

CellFromatter plugin provides convenient ways to format date/time/number/currency data in the grid.

.. contents::
   :depth: 2

============
Introduction
============

CellFormatter is a plugin for dojox.grid.EnhancedGrid. It wraps column's "get" function to provide an easy way to transform data of type "date", "time", "number", or "currency". It uses dojo.date.parse/format, dojo.number.parse/format and dojo.currency.parse/format to do the transformation.

=============
Configuration
=============

Prerequisites
-------------

This CellFormatter plugin is only available for EnhancedGrid, so use the following statement in the head of your HTML file:

.. code-block :: javascript
  :linenos:

  dojo.require("dojox.grid.EnhancedGrid");
  dojo.require("dojox.grid.enhanced.plugins.CellFormatter");


Plugin Declaration
------------------

The declaration name of this plugin is ``cellFormatter`` . It is declared in the ``plugins`` property of grid.

If your grid is created declaratively:

.. code-block :: html
  :linenos:

  <div id="grid" dojoType="dojox.grid.EnhancedGrid" 
    store="mystore" structure="mystructure" 
    plugins="{
      cellFormatter: true
  }" ></div>

If your grid is created in JavaScript:

.. code-block :: javascript
  :linenos:

  var grid = new dojox.grid.EnhancedGrid({
    id:"grid",
    store:"mystore",
    structure:"mystructure",
    plugins:{
      cellFormatter: true
    }
  });

This plugin does not require any arguments.

=====
Usage
=====

The Most Typical Usage
----------------------

To transform the data of a column (for example, it's of type date), just set the cellFormatter property as the following:

.. code-block :: javascript
  :linenos:

  var layout = [{
    cells: [
      {field: "workingDate", cellFormatter: { 
        selector: "date",
        parse: { datePattern: "yyyy-MM-dd" }    //The pattern in the store
        format: { datePattern: "MMMM d, yyyy" }    //The pattern to be shown in grid
      }}
    ]
  }];

This will first **parse** the data in the "workingDate" column using the pattern "yyyy-MM-dd", then **format** it to pattern "MMMM d, yyyy" for the grid to show.

Here the ``selector`` property accepts one of **"date", "time", "number", and "currency"**.

When type is **"date"** or **"time"**, the parse property is a ``dojo.date.locale.__FormatOptions`` object. It tells grid how to understand the data in the store.

And the ``format`` property is also a ``dojo.date.locale.__FormatOptions`` object. It tells grid what pattern should be shown to the end user.

When ``selector`` is **"number"**, the ``parse/format`` property is a ``dojo.number.__FormatOptions`` object.

When ``selector`` is **"currency"**, the ``parse/format`` property is a ``dojo.currency.__FormatOptions`` object

When something is omitted
-------------------------

Anything in cellFormatter is omittable except the type property.

If ``parse`` is omitted, grid will parse the data in store without any pattern (default pattern).

If ``format`` is omitted, grid will format the data with default pattern.

If both ``parse`` and ``format`` are omitted, the whole cellFormatter object is regarded as a format property.

.. code-block :: javascript
  :linenos:

  var layout = [{
    cells: [
      {field: "some field", cellFormatter: {
        selector: "date",
        timePattern: "yyyy-MM-dd" //Format to this pattern.
      }}
    ]
  }];

When dojo's Default parse/format Can Not Meed Your Requirements
---------------------------------------------------------------

If standard parse/format arguments can not meet your requirements, you can implement you own parse/format functions. Like this in the cell declaration:

.. code-block :: javascript
  :linenos:

  var layout = [{
    cells: [
      {field: "some field", cellFormatter: {
        selector: "date",
        parse: function(datum, args, rowIndex, cell){  
          //args is just the whole cellFormatter object
          return anything;
        }, 
        format: function(returnByParse, args, rowIndex, cell){  
          //args is just the whole cellFormatter object
        return "some string";
        }
      }}
    ]
  }];


More Examples
-------------

Sometimes, the type of data in store is not what you want to show. For example, number format in data store, but you'd like it to be shown as currency in grid

.. code-block :: javascript
  :linenos:

  var layout = [{
    cells: [
      {field: "number-to-currency", cellFormatter: {
        selector: "number",
        parse: { 
          //No need to declare selector, it is already stated in cellFormatter.
          pattern: "###0.000" 
        },
        format: { 
          //Explicitly declare the format type.
          selector: "currency", 
          pattern: "$#,#00.00" 
        }
      }}
    ]
  }];

Long integer in data store, shown as formatted date string:

.. code-block :: javascript
  :linenos:

  var layout = [{
    cells: [
      {field: "long-to-date", cellFormatter: {
        selector: "date",
        parse: function(datum){ 
          //We know datum is an integer here.
          return new Date(parseInt(datum));
        },
        format: {
          datePattern: "MMMM d, yyyy"
        }
      }}
    ]
  }];
