.. _dijit/form/DataList:

===================
dijit/form/DataList
===================

:Authors: Doug Hays
:Developers: Doug Hays
:since: V1.7

.. contents ::
    :depth: 2

DataList is a read-only data store that processes inline OPTION tags as data items.
This store implements the new :ref:`Dojo Object Store API <dojo/store>`.
The DataList store is also a synchronous store.
All the functions directly return results, so you don't have to use asynchronous callbacks in your code.


Examples
========

HTML5 markup
------------

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/parser", "dijit/form/DataList", "dijit/registry", "dojo/domReady!"],
    function(parser, DataList, registry){
        parser.parse();
        var store = registry.byId('fruit');
        alert('fruit that start with "B" = ' + store.query({name:/^B.*/}).map(function(option){ return option.name; }));
    });

  .. html ::

    <select data-dojo-type="dijit/form/DataList" id="fruit">
        <option value="Ap">Apples</option>
        <option value="Ba">Bananas</option>
        <option value="Bl">Blueberries</option>
        <option value="Or">Oranges</option>
    </select>

.. image :: DataList.png
