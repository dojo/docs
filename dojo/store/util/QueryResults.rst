.. _dojo/store/util/QueryResults:

============================
dojo/store/util/QueryResults
============================

:Authors: Kris Zyp
:Project owner: Kris Zyp
:since: V1.6

.. contents ::
  :depth: 2

Introduction
============

The QueryResults utility function provides convenient wrapping of arrays and promises as valid result sets. The QueryResults can be called with a plain array or a promise that will resolve to an array. The function will return a result set that has the required forEach, filter, and map methods.

Examples
========

.. js ::

  require(["dojo/store/util/QueryResults"],
      function(QueryResults){
          var someData = [
              {id:1, name:"One"},
              {id:2, name:"Two"}
          ];
          var results = new QueryResults(someData);
          results.forEach(objectHandler); // works in all browsers
  });
