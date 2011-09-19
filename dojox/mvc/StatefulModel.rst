#format dojo_rst

dojox.mvc.StatefulModel
=========

:Status: Draft
:Version: 0.1
:Authors: Rahul Akolkar, Ed Chatelain
:Developers: Rahul Akolkar, Ed Chatelain
:Available: since V1.7


.. contents::
   :depth: 2

The first-class native JavaScript data model based on dojo.Stateful
that wraps any data structure(s) that may be relevant for a view,
a view portion, a dijit or any custom view layer component.



=====
Usage
=====

A data model is effectively instantiated with a plain JavaScript
object which specifies the initial data structure for the model.

.. code-block :: javascript
  :linenos:

		 var struct = {
		 		 order		 : "abc123",
		 		 shipto		 : {
		 		 		 address		 : "123 Example St, New York, NY",
		 		 		 phone		 : "212-000-0000"
		 		 },
		 		 items : [
		 		 		 { part : "x12345", num : 1 },
		 		 		 { part : "n09876", num : 3 }
		 		 ]
		 };

		 var model = dojox.mvc.newStatefulModel({ data : struct });

The simple example above shows an inline plain JavaScript object
illustrating the data structure to prime the model with, however
the underlying data may be made available by other means, such as
from the results of a dojo.store or dojo.data query.

To deal with stores providing immediate values or Promises, a
factory method for model instantiation is provided. This method
will either return an immediate model or a model Promise depending
on the nature of the store.
