#format dojo_rst

dojox.widget.RollingList
========================

:Status: Draft
:Version: 1.2
:Project owner: Nathan Toone
:Available: since V1.3

.. contents::
   :depth: 1

A rolling list that can be tied to a data store with children


============
Introduction
============

The rolling list provides a structured scrolling view into a data store and its children.  It is similar to how many pane-based file browsing widgets behave.

Since the rolling list leverages dijit.Menu, it is mostly accessible.  However, full accessibility testing has not yet been performed on this widget.

=====
Usage
=====

Creating a rolling list is very simple - at the very minimum, just requiring a valid dojo.data.api.Read datastore.  It also supports the dojo.data.api.Notification api - so changes to the store will be reflected in the rolling widget.

Other options that you may find useful:
 * **onChange** function will get fired when the value of the widget changes
 * **store** the store to get data from
 * **query** the query to use when fetching data
 * **queryOptions** any query options you want to pass on as well when fetching
 * **childrenAttrs** an array of attributes to use as "children" nodes
 * **parentAttr** an optional attribute to use as a pointer to the parent of a node.  If this is not specified, then the parent will be determined by finding the first element whose children attribute contains the node in question.
 * ``New in 1.3`` **preloadItems** either a boolean (true/false) or a number indicating the number of items that we are willing to preload.  This exists to make it easier to load items with large numbers of children lazily.
 * ``New in 1.3`` **executeOnDblClick** set to true (the default) to call onExecute() when the user double-clicks an item.  Set to false if your popup will call onExecute() on its own.
 * ``New in 1.3`` **showButtons** set to true to show "OK" and "Cancel" button that call onExecute and onCancel, respectively (default false)
 * ``New in 1.3`` **okButtonLabel** and **cancelButtonLabel** set to a string you want the ok (or cancel) button to use.  By default, the localized "OK" and "Cancel" strings will be used.
 * ``New in 1.3`` **minPaneWidth** the minimum width (in pixels) that each pane must be.  The panes are expanded to be this width if they are any narrower than it


==========
Panes
==========

``TODOC`` You can extend the rolling list by creating different panes.  All panes must extend dojox.widget._RollingListPane.

========
Examples
========

A simple rolling list pulling data from a read store
---------------------------------------------------------

.. cv-compound ::

  .. cv :: javascript

    <script>
      dojo.require("dojo.data.ItemFileWriteStore");
      dojo.require("dojox.widget.RollingList");
      dojo.ready(function(){

          dojo.declare("dojox.widget.RollingStore", dojo.data.ItemFileWriteStore, {
              getLabel: function(item){
                  return this.inherited(arguments) + " (" + this.getValue(item, "type") + ")";
              }
          });
      });
    </script>

  .. cv :: html
  
    <div dojoType="dojox.widget.RollingStore" jsId="continentStore"
        url="{{dataUrl}}dijit/tests/_data/countries.json"></div>
    <div dojoType="dojox.widget.RollingList" jsId="myList" id="myList" store="continentStore"
        query="{type:'continent'}" style="height:150px;"></div>

  .. cv:: css

    <style type="text/css">
      @import "{{baseUrl}}dojox/widget/RollingList/RollingList.css";
    </style>
