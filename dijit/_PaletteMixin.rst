.. _dijit/_PaletteMixin:

===================
dijit._PaletteMixin
===================

:Authors: Bill Keese
:since: V1.5

.. contents ::
    :depth: 2

Introduction
============

_PaletteMixin is a base class for widgets like :ref:`dijit/ColorPalette <dijit/ColorPalette>`
and :ref:`dojox/editor/plugins/InsertEntity <dojox/editor/plugins/InsertEntity>`.

It provides a keyboard accessible way to display a grid of items (colors, emoticons, etc.) and let the user
select one.

The subclass must call _preparePalette() with the nested array of labels/id's for the grid nodes,
and a non-nested array listing the tooltips for each cell.

In addition, dyeClass must be set as a lightweight class to represent each cell of the grid;
the class must implement the the dijit/_PaletteMixin.__Dye interface.

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

    .. js ::

        require([
            "dojo/_base/declare", "dojo/dom-construct",
            "dijit/_WidgetBase", "dijit/_PaletteMixin", "dojo/domReady!"
        ], function(declare, domConstruct, _WidgetBase, _PaletteMixin){

            MyPalette = declare([_WidgetBase, _PaletteMixin], {
                // summary:
                //      A palette of numbers from 1.1 to 3.3

                 //	Interface for the JS Object associated with a palette cell (i.e. DOMNode)
                dyeClass: declare(null, {
                    constructor: function(alias, row, col){
                        this.label = alias;
                    },
                    getValue: function(){
                        return this.label;
                    },
                    fillCell: function(cell, blankGif){
                        cell.innerHTML = this.label;
                    }
                }),

                buildRendering: function(){
                    // Subclass must define this.gridNode as a <table> element.   Usually done in the template.
                    this.domNode = this.gridNode = domConstruct.create("table");
                },

                postCreate: function(){
                    // Create the grid
                    this._preparePalette([
                        [1.1, 1.2, 1.3],
                        [2.1, 2.2, 2.3],
                        [3.1, 3.2, 3.3]
                    ],
                    [
                        "one point one", "one point two", "one point three", "two point one", "two point two",
                        "two point three", "three point one", "three point two", "three point three"
                    ]);
                    this.inherited(arguments);
                }
            });

            var myPalette = new MyPalette({
                onChange: function(val){
                    console.log("selected: " + val);
                }
            });
            myPalette.placeAt(document.body);
        });


See also
========
* :ref:`dijit/ColorPalette <dijit/ColorPalette>`
* :ref:`dojox/editor/plugins/InsertEntity <dojox/editor/plugins/InsertEntity>`
