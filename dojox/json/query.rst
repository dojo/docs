#format dojo_rst

dojox.json.query
==============

:Status: Draft
:Version: 1.0
:Authors: Kris Zyp
:Developers: Kris Zyp
:Available: since V1.2

.. contents::
    :depth: 3

**dojox.json.query** implements JSONQuery to provide comprehensive data querying capabilities.

============
Introduction
============

JSONQuery is an extended version of JSONPath with additional features for security, ease of use, and comprehensive querying capabilities including sorting, mapping, and well-defined expressions. JSONQuery is described in more detail here: <http://www.sitepen.com/blog/2008/07/16/jsonquery-data-querying-beyond-jsonpath/>

=====
Usage
=====

The basic usage of dojox.json.query to query data is:

.. code-block :: javascript

 dojox.json.query("$[?price<10]",[{name:"one",price:5},{name:"two",price:15}]);
