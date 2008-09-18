#format dojo_rst

dojox.data.QueryReadStore
==========================

:Status: Contributed, Draft
:Version: 1.0
:Author: Wolfram Kriesing
:Available: since V1.0

.. contents::
  :depth: 2


QueryReadStore is very similar to ItemReadStore. They both use JSON as their exchange format. The difference is in the way they query data. ItemReadStore makes one fetch from the server, and handles all sorting and filtering in the client. That's fine for hundreds of records, even thousands. But for hundreds of thousands of records or slow Internet connections, that's less feasible.

==============
Supported APIs
==============

The following dojo.data APIs are implemented by QueryReadStore

* `dojo.data.api.Read <dojo/data/api/Read>`_
* `dojo.data.api.Identity <dojo/data/api/Identity>`_ - 


============
How it works
============

QueryReadStore makes a request to the server for each sorting or query. This makes it ideal for large datasets with small windows of data, as in dijit.FilteringSelect.

-----------------
Query Translation
-----------------
  A dojo.data request follows a specific JSON format. As an example, suppose we have a FilteringSelect which looks up states. When the user presses "A", the dojo.data request is:

::
    {
      query: {name: "A*"},
      queryOptions: {ignoreCase: true},
      sort: [{attribute:"name", descending:false}],
      start: 0,
      count: 10
    }

  Now we want to hand this off to the server. Odds are, your server doesn't recognize incoming JSON, and asking it to do so is too restrictive. Instead, most server queries follow a REST pattern like this:

::

    states.php?q=A*

  Fortunately, it's easy to translate between the two and you can quickly customize the translation by extending the class. You simply subclass QueryReadStore like this:

::
    dojo.provide("custom.ComboBoxReadStore");

    dojo.require("dojox.data.QueryReadStore");

    dojo.declare("custom.ComboBoxReadStore", dojox.data.QueryReadStore, {
      fetch:function(request) {
        request.serverQuery = {q:request.query.name};
        // Call superclasses' fetch
        return this.inherited("fetch", arguments);
      }
    });

We can place this file into a folder "custom" at the same level as the dojo, dijit and dojox directories of the distribution. (See Creating Your Own Modules for a discussion and alternatives.

You can download QueryReadStore.php below (it's also in /dojox/data/tests/stores/QueryReadStore.php) to run this example on a PHP server. The server portion hands over a portion of the states that fits the query. 
