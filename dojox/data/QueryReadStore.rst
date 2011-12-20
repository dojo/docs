.. _dojox/data/QueryReadStore:

==========================
dojox.data.QueryReadStore
==========================

:Author: Wolfram Kriesing
:since: V1.0

.. contents ::
  :depth: 2


QueryReadStore is very similar to :ref:`ItemFileReadStore <dojo/data/ItemFileReadStore>`. They both use JSON as their exchange format. The difference is in the way they query data. ItemFileReadStore makes one fetch from the server, and handles all sorting and filtering in the client. That's fine for hundreds of records, even thousands. But for hundreds of thousands of records or slow Internet connections, that's less feasible.

Supported APIs
==============

The following dojo.data APIs are implemented by QueryReadStore

* :ref:`dojo.data.api.Read <dojo/data/api/Read>`
* :ref:`dojo.data.api.Identity <dojo/data/api/Identity>` -


How it works
============

QueryReadStore makes a request to the server for each sorting or query. This makes it ideal for large datasets with small windows of data, as in dijit.FilteringSelect.

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
    fetch:function(request){
      request.serverQuery = {q:request.query.name};
      // Call superclasses' fetch
      return this.inherited("fetch", arguments);
    }
  });

We can place this file into a folder "custom" at the same level as the dojo, dijit and dojox directories of the distribution. (See Creating Your Own Modules for a discussion and alternatives.

Server Side implementation
==========================

The server side is where all the heavy work of QueryReadStore occurs. Specifically all query matching and sorting should happen here and only the items that match the parameters should be returned to the server. To help you in development of your own remote service, dojo includes a demonstration PHP file that implements a basic version of the QueryReadStore server component. You can find this basic implementation at: *dojox/data/tests/stores/QueryReadStore.php*. The server portion hands over a portion of the states that fits the query.

Your implementation could be similar to the sample php, or it could translate your queries to run against a database via SQL. That decision is entirely up to you. Another good example store to help understand how to develop server backed datastores is :ref:`dojox.data/FileStore <dojox/data/FileStore>`


Example Client Implementation
=============================

For a fully functional example extension of QueryReadStore, please follow this :ref:`link <dojox/data/QueryReadStore/example>`


Functional Examples
===================

Connecting QueryReadStore to dijit.form.ComboBox
------------------------------------------------

**Note:** You can watch the xhr requests to the service through firebug.

.. code-example ::
  
  .. js ::

      dojo.require("dojox.data.QueryReadStore");
      dojo.require("dijit.form.ComboBox");

  .. html ::

    <b>Combo lookup of states through QueryReadStore</b><br>
    <div data-dojo-type="dojox.data.QueryReadStore" data-dojo-props="url:'{{dataUrl}}dojox/data/tests/stores/QueryReadStore.php'" data-dojo-id="comboStore"></div>
    <div data-dojo-type="dijit.form.ComboBox" data-dojo-props="store:comboStore, searchAttr:'name', pageSize:100"></div>


Connecting QueryReadStore to dijit.form.FilteringSelect
-------------------------------------------------------

**Note:** You can watch the xhr requests to the service through firebug.

.. code-example ::
  
  .. js ::

      dojo.require("dojox.data.QueryReadStore");
      dojo.require("dijit.form.FilteringSelect");

  .. html ::

    <b>FilteringSelect lookup of states through QueryReadStore</b><br>
    <div data-dojo-type="dojox.data.QueryReadStore" data-dojo-props="url:'{{dataUrl}}dojox/data/tests/stores/QueryReadStore.php'" data-dojo-id="comboStore2"></div>
    <div data-dojo-type="dijit.form.FilteringSelect" data-dojo-props="store:comboStore2, searchAttr:'name', pageSize:100"></div>
