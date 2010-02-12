#format dojo_rst

dojox.json.query
================

:Author: Kris Zyp
:Project owner: Kris Zyp
:Available: since V1.2

.. contents::
    :depth: 3

**dojox.json.query** implements JSONQuery to provide comprehensive data querying capabilities.


============
Introduction
============

JSONQuery is an extended version of JSONPath with additional features for security, ease of use, and a comprehensive set of data querying tools including filtering, recursive search, sorting, mapping, range selection, and flexible expressions with wildcard string comparisons and various operators.

JSONQuery provides safe evaluation with language agnostic expressions that prevents arbitrary code execution. It also uses intuitive result-based evaluation that allows successive query operations. Furthermore, the new JSONQuery module provides significant performance improvements, with 20-100x faster execution with the common filter operation on large arrays than the JSONPath module. JSONQuery generally supersets the functionality of JSONPath and provides syntax that matches and behaves like JavaScript where the syntax intersects for maximum ease of use.

=====
Usage
=====

A JSONQuery can be executed with the following call:

.. code-block :: javascript

 results = dojox.json.query(query,object);

Where query is the JSONPath query to execute and object is the root object or array to query. You can also create a “compiled” evaluation function that can be reused for multiple evaluations by only passing a query string:

.. code-block :: javascript

 evaluator = dojox.json.query(query);

The evaluator function can be then be performed on a query on data by calling it with the data as a parameter:

.. code-block :: javascript

 results = evaluator(object);

In situations where a single query may be executed multiple times, doing a single parse/compilation with dojox.json.query(query) and reusing the returned evaluation function will provide better performance. It is worth noting that dojox.json.query(query,object) is functionally equivalent to dojox.json.query(query)(object).

============
Query Syntax
============

JSONQuery evaluations begin with the provided object, which can referenced within queries with $. From the starting object, various operators can be successively applied, each operating on the result of the last operation. You may explicitly begin your query with $, but this is implicitly auto-inserted, so it is not necessary. This allows you to start queries with operators. JSONQuery uses syntax that is similar to JavaScript (with a number of extra operators), so a simple query could be performed like:

.. code-block :: javascript

 data = {foo:"bar"};
 results = dojox.json.query("$.foo",data);
 results -> "bar"

==================
Query Capabilities
==================

JSONQuery provides all the functionality of JSONPath, and additional query capabilities. By analogy, JSONQuery is to JSONPath, as XQuery is to XPath. In particular, JSONQuery provides the expressive equivalence of XQuery FLOWR expressions for mapping, sorting, and filtering object data. Several of the fundamental operators of JSONQuery follow the same syntax as JavaScript, as well behaving exactly as with JavaScript evaluation:

    * .property - This will return the provided property of the object
    * [expression] - This returns the property name/index defined by the evaluation of the provided expression

For example, the following JSONQuery will find the foo property of the 2nd item in the provided array (the $ is omitted):

.. code-block :: javascript

 [1].foo

The following operators are new in JSONQuery:

    * [?expression] - This will perform a filter operation on an array, returning all the items in an array that match the provided expression. This operator does not need to be in brackets, you can simply use ?expression, but since it does not have any containment, no operators can be used afterward when used without brackets. The following JSONQuery will find all the array items that have a price less than 15:

      [?price < 15]

      And to add a condition for the rating property to be greater than 3 (and omit the brackets):

      ?price < 15 & rating > 3

    * [/expression], [\expression], [/expression, /expression] - This performs a sort operation on an array, with sort based on the provide expression. Multiple comma delimited sort expressions can be provided for multiple sort orders (first being highest priority). / indicates ascending order and \ indicates descending order. For example to sort an array by lastName first and then firstName as the second priority:

      [/lastName,/firstName]

    * [=expression] - This performs a map operation on an array, creating a new array with each item being the evaluation of the expression for each item in the source array. For example, to create a list of the price value from an array of objects, we could use the query:

      [=price]

      You can also use object literals and and create a new array of objects that with a name and price properties generated from the source array:

      [={price:price,name:firstName + " " + lastName}]

    * expr = expr - Performs a comparison (like JavaScript’s ==). When comparing to a string, the comparison string may contain wildcards * (matches any number of characters) and ? (matches any single character). For example to find all objects in an array where the name starts with “Mr”, one could use the query:

      [?name='Mr*']

    * expr ~ expr - Performs a string comparison with case insensitivity. For example to find all objects in an array with the word “the” in the description regardless of case:

      [?description~'*the*']

    * ..[?expression] - This will perform a deep search filter operation on all the objects and subobjects of the current data. Rather than only searching an array, this will search property values, arrays, and their children.
    * $1, $2, $3... - This can be used to reference additional parameters passed to the query call. For example:

      results = dojox.json.query("[?firstName=$1&amp;lastName=$2]",
      					myData,"John","Doe");

      or it can be applied to the evaluator function:

      evaluator = dojox.json.query("[?firstName=$1&amp;lastName=$2]");
      results = evaluator(myData,"John","Doe");

The following operators from JSONPath are also supported:

    * [start:end:step] - This performs an array slice/range operation, returning the elements from the optional start index to the optional end index, stepping by the optional step parameters. For example to get the first ten items in an array:

      [0:10]

    * [expr,expr] - The union operator returns an array of all the property/index values from the evaluation of the comma delimited expressions.
    * .* or [*] - Returns the values of all the properties of the current object.
    * $ - This is the root object.
    * @ - This is the current object in filter, sort, and map expressions. Note that names are auto-converted to property references of the current object in expressions, but @ can be used for index access on the current object. The following queries are identical:

      [?name='Fred']
      [?@.name='Fred']
      [?@['name']='Fred']

    * ..property - Performs a recursive search for the given property name, returning an array of all values with such a property name in the current object and any subobjects.
    * +, -, /, \*, &, \|, %, (, ), <, >, < =, > =, ! = - These operators behave just as they do in JavaScript.

Multiple operators can be used successively to create complex queries. For example, to find all the objects from the array in the products property that have a price under 15 and then sort them by descending order of rating and show the first twenty items from the resultant list, we could query:

.. code-block :: javascript

 $.products[?price < 15][\rating][0:20]

Queries can use the regular operators to form general expressions based on more complex query operations. For example, to find the difference between the lowest priced item and the highest priced item in an array:

.. code-block :: javascript

 $.store.book[\price][0].price - $.store.book[/price][0].price

=======
Summary
=======

The new Dojo JSONQuery module provides a powerful tool for general purpose data querying, and can be used in variety of situations. The JSONQuery module is already used by Persevere to parse and execute queries in it’s server side JavaScript object storage environment. JSONQuery is a flexible and complete query format for handling large JSON/object data structures with an intuitive JavaScript-like syntax.
