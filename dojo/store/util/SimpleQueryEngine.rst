.. _dojo/store/util/SimpleQueryEngine:

=================================
dojo/store/util/SimpleQueryEngine
=================================

:Authors: Kris Zyp
:Project owner: Kris Zyp
:since: V1.6

.. contents ::
  :depth: 2

Introduction
============

The SimpleQueryEngine utility provides basic querying functionality for JavaScript objects. The main export of SimpleQueryEngine is a function that can be called with a query (and options optionally) and returns another function that will execute queries against an array. The query can be an object in which case the results are filtered to objects with properties that match the name value pairs provided by the query object. The query can be a function in which case the results are filtered to objects that when passed to the provided function return a truthy value. The query can also be a string, in which case the string is used to lookup up a method on the store that acts as the filter function.

Options
=======

The SimpleQueryEngine also handles sorting and paging per the dojo/store API. The query options argument (the second argument) may be an object with the following properties:

* start - The start offset of the results
* count - The (maximum) number of objects to return in the results
* sort - An array of sort objects (that have an "attribute" and "descending" property) to describe the sort order. Alternately this may be a function that can be passed to the standard Array.prototype.sort() method.

Examples
========

.. js ::

  require(["dojo/store/util/SimpleQueryEngine"],
      function(SimpleQueryEngine){
          var someData = [
              {id:1, name:"One"},
              {id:2, name:"Two"}
          ];
          SimpleQueryEngine({name:"One"})(someData) -> // Returns an array with just the first object

          SimpleQueryEngine(function(object){
          return object.id > 1;
  })(someData) // Returns an array with just the first object

See Also
========

The dojo/store/Memory store uses the SimpleQueryEngine for querying. SimpleQueryEngine can also be used with JsonRest store to make it Observable.

:ref:`dojo/store/Memory <dojo/store/Memory>`
