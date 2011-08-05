#format dojo_rst

dijit.form.DataList
===================

:Status: Draft
:Version: 1.0
:Authors: Doug Hays
:Developers: Doug Hays
:Available: since V1.7

.. contents::
    :depth: 2

DataList is a read-only data store that processes inline OPTION tags as data items.  This store implements the new `Dojo Object Store API <dojo/store>`_.  The DataList store is also a synchronous store. All the functions directly return results, so you don't have to use asynchronous callbacks in your code.


========
Examples
========

HTML5 markup
------------

.. code-block :: html

  <select data-dojo-type="dijit.form.DataList" data-dojo-props='id:"fruit"' >
        <option value="A">Apples</option>
        <option value="B">Bananas</option>
        <option value="O">Oranges</option>
  </select>
