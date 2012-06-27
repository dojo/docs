.. _dojox/mobile/SearchBox:

======================
dojox.mobile.SearchBox
======================

:Authors: Doug Hays
:Developers: Doug Hays
:since: V1.8

.. contents ::
    :depth: 2

SearchBox is a non-templated widget associated with an INPUT element with type="search".
It is a subclass of dojox/mobile/TextBox that adds search capabilities.

If you specify a data provider through the ``store`` attribute, the store will be searched for items matching what the user typed,
and the onSearch function of the SearchBox will be called with the matching items.

The ``searchAttr`` attribute specifies which property of the items will be matched against the input value.
The ``queryExpr`` attribute lets you specify how matching is done. For example, ``"${0}*"`` matches items starting with the input value,
``"*${0}"`` matches items ending with the input value, ``"*${0}*"`` matches all items containing the input value.

Search results can be paged using the ``pageSize`` attribute. For example, if ``pageSize`` is set to 5 and there are 14 search results,
the ``onSearch`` function will be called with 3 parameters:

* ``results``: An object containing an array of search results from the store (with ``length`` = 5 in this example) and also contains the ``nextPage`` function as well as the ``total`` number of search results (14 in this example),

* ``query``: A copy of the originating query property (useful for multiple query environments),

* ``options``: Additional parameters sent to the store, including: start=0, count=5, queryOptions.

If the remaining results need to be retrieved, then the results.nextPage() function can be invoked which will call the ``onSearch`` function
again with the next set of results.  This is useful when there are potentially many search results, to allow the application to display results progressively
without blocking the UI.

Note that SearchBox does not have support for displaying the search results by itself; this must be done in your application
(for example, using a RoundRectList).

Constructor Parameters
======================

Relative attributes inherited from dojox.mobile.TextBox
-------------------------------------------------------

+--------------+----------+-------------------------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default                  |Description                                                                                                |
+--------------+----------+-------------------------+-----------------------------------------------------------------------------------------------------------+
|baseClass     |String    | mblTextBox mblSearchBox |Default CSS class name used to render the search box.                                                      |
+--------------+----------+-------------------------+-----------------------------------------------------------------------------------------------------------+
|class         |String    |                         |Additional CSS class names to add to baseClass.                                                            |
+--------------+----------+-------------------------+-----------------------------------------------------------------------------------------------------------+
|maxLength     |Number    | (no limit)              |Maximum number of characters that can be entered in the INPUT box.                                         |
+--------------+----------+-------------------------+-----------------------------------------------------------------------------------------------------------+
|placeHolder   |String    |                         |Prompt text to display inside the INPUT when it would otherwise be empty (requires browser support).       |
+--------------+----------+-------------------------+-----------------------------------------------------------------------------------------------------------+
|onChange      |Function  |                         |An event handler used for INPUT change notifications.                                                      |
+--------------+----------+-------------------------+-----------------------------------------------------------------------------------------------------------+
|trim          |Boolean   | false                   |Remove leading and trailing spaces.                                                                        |
+--------------+----------+-------------------------+-----------------------------------------------------------------------------------------------------------+

Inherited from dijit.form._SearchMixin
--------------------------------------

+----------------+---------------------+--------------+-----------------------------------------------------------------------------------------------------------+
|Parameter       |Type                 |Default       |Description                                                                                                |
+----------------+---------------------+--------------+-----------------------------------------------------------------------------------------------------------+
|pageSize        |Integer              | Infinity     |Maximum number of search results to return per query.                                                      |
+----------------+---------------------+--------------+-----------------------------------------------------------------------------------------------------------+
|store           |dojo.store.api.Store | null         |Data provider object used by this SearchBox.                                                               |
+----------------+---------------------+--------------+-----------------------------------------------------------------------------------------------------------+
|fetchProperties |Object               | {}           |Mixin to the store's fetch, for example: { sort: [{attribute:"name",descending: true}] }                   |
+----------------+---------------------+--------------+-----------------------------------------------------------------------------------------------------------+
|query           |Object               | {}           |A query that can be passed to store to initially filter the items.                                         |
+----------------+---------------------+--------------+-----------------------------------------------------------------------------------------------------------+
|searchDelay     |Integer              | 200          |Delay in milliseconds between when user types something and we start searching based on that value.        |
+----------------+---------------------+--------------+-----------------------------------------------------------------------------------------------------------+
|searchAttr      |String               | "name"       |Search for items in the data store where this attribute (in the item) matches what the user typed.         |
+----------------+---------------------+--------------+-----------------------------------------------------------------------------------------------------------+
|queryExpr       |String               | "${0}*"      |Specifies what query is sent to the data store, based on what the user has typed.                          |
+----------------+---------------------+--------------+-----------------------------------------------------------------------------------------------------------+
|ignoreCase      |Boolean              | true         |Ignore case when matching possible items.                                                                  |
+----------------+---------------------+--------------+-----------------------------------------------------------------------------------------------------------+
|list            |String               | undefined    |The id of a dijit/form/DataList, used instead of the store to provide search items for HTML5 compatibility.|
+----------------+---------------------+--------------+-----------------------------------------------------------------------------------------------------------+

Attributes from this widget
---------------------------

+--------------+----------+-------------------------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default                  |Description                                                                                                |
+--------------+----------+-------------------------+-----------------------------------------------------------------------------------------------------------+
|incremental   |Boolean   | true                    |If true, search on every key. If false, only search after pressing ENTER or cancel.                        |
+--------------+----------+-------------------------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Using a dojo.store and nextPage function
----------------------------------------

.. js ::
 
  // JavaScript
  require([
    "dojo/_base/array",
    "dojo/ready",
    "dojox/mobile/parser",
    "dojox/mobile",
    "dojo/store/Memory",
    "dojox/mobile/ListItem",
    "dojox/mobile/RoundRectList",
    "dojox/mobile/SearchBox",
    "dojox/mobile/deviceTheme"
  ], function(array, ready, parser, mobile, MemoryStore, ListItem){

    store = new MemoryStore({data: [ 
      {label: "Alabama"},
      {label: "Alaska"},
      {label: "American Samoa"},
      {label: "Arizona"},
      {label: "Arkansas"},
      {label: "Kansas"},
      {label: "Kentucky"}
    ]});

    onSearch = function(results, query, options){
      if(options.start == 0){
        list.destroyDescendants();
      }
      list.addChild(new ListItem({label: 'Page '+(options.start/options.count+1)+
        ' of '+Math.ceil(results.total/options.count), header:true }));
      array.forEach(results, function(item){
        list.addChild(new ListItem({label: item.label})); 
      });
      if((options.start+results.length) < results.total){
        results.nextPage();
      }
    };
  });

.. html ::

  <input data-dojo-type="dojox/mobile/SearchBox" type="search" placeHolder="Search"
    data-dojo-props='store:store, searchAttr: "label", ignoreCase: true, onSearch:onSearch, pageSize:2'>
  <ul data-dojo-type="dojox/mobile/RoundRectList" jsId="list"></ul>

.. image :: SearchBoxPaged.png

Using inline OPTION tags
------------------------

.. js ::
 
  // JavaScript
  require([
      "dojo/_base/array",
      "dojo/ready",
      "dojox/mobile/parser",
      "dojox/mobile",
      "dojox/mobile/ListItem",
      "dojox/mobile/SearchBox",
      "dijit/form/DataList",
      "dojox/mobile/deviceTheme"
  ], function(array, ready, parser, mobile, ListItem){
  
       onSearch = function(results, query, options){
          list.destroyDescendants();
          array.forEach(results, function(item){
              list.addChild(new ListItem({label: item.name})); 
          });
      };
  });

.. html ::

  <select data-dojo-type="dijit.form.DataList" data-dojo-props='id:"dataList"' >
    <option>Alabama</option>
    <option>Alaska</option>
    <option>American Samoa</option>
    <option>Arizona</option>
    <option>Arkansas</option>
  </select>
  <input data-dojo-type="dojox.mobile.SearchBox" type="search" placeHolder="Search"
    data-dojo-props='list:"dataList", ignoreCase: true, onSearch:onSearch'>
  <ul data-dojo-type="dojox.mobile.RoundRectList" jsId="list"></ul>

.. image :: SearchBox.png