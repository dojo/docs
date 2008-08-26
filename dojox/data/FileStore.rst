#format dojo_rst

dojox.data.FileStore
====================

:Status: Contributed, Draft
:Version: 1.0
:Author: Jared Jurkiewicz

The dojox.data.FileStore is a lightweight javascript implementation for accessing details about a remote FileSystem.  This includes being able to search the filesystem to locate file names, display path information, file sizes, if it’s a directory or not, and if a directory, what children files are contained within it.   The dojox.data.FileStore is also an excellent example of how DataStores can do lazy-loading.   

The datastore implementation and its example PHP back-end by default do not inflate the child file objects of a DataStore file item.  This allows it to quickly return information about a file without having to return everything, while at the same time providing hooks that allow for the extra information to be gathered on-demand.  

**Features**
------------

1. The client javascript and example server php script implement the following dojo.data APIs:  dojo.data.api.Read, dojo.data.api.Identity.
2. A deliberately simple client side implementation for use as a reference when implementing other server side stores that wish to provide lazy-loading as defined by the dojo.data.api.Read spec.  The client code is deliberately small to make it easy to understand.
3. The ability to search across a variety of attributes, such as name, path, parentDir, lastModified, etc.   It also allows for matching on multiple fields, such as all files with parentDir of ‘foo’, that have filename: ‘bar*.js’.
4. The datastore can do shallow searching (root dir only), or recursive searching (scan the entire file system for matches across the parameters).
5. The client store can directly access information about a specific about a file through RESTlike patterns that work well with servlets that allow mapping of a context root to a servlet, and the servlet’s ability to get extra path information.  It can also work with back-end services like PHP that do not provide a mechanism to do URL path based queries by converting the path into a query param, ‘path’.   This is enabled by setting pathAsQueryParam  to true on the store instance.
6. Support for all normal query options as defined by the dojo.data.api.Read specification.  Deep provides recursive tree searching, ignoreCase provides the ability to ignore the case sensitivity of attributes when matching, and so on.
7. An example implementation of the back end service in PHP.  The example is documented cleanly and is less than five hundred lines of code, making it relatively easy to dissect and understand.
8. Works directly with all current data bound widgets in dijit, including dijit.Tree, dijit.form.ComboBox, and well as dojox.grid.

**Item structure:**
-------------------
All items returned by a query to the FileStore and will generally have the following attributes accessible via FileStore.getValue(item, attribute) and FileStore.getValues(item, attribute):

+-------------+---------------------------------------------------------------------------------------------------------+----------+
|**Attribute**|**Description**                                                                                          |**Type**  |
+-------------+---------------------------------------------------------------------------------------------------------+----------+
|name         |The name of the file.  This does not include any path information.                                       |string    |
+-------------+---------------------------------------------------------------------------------------------------------+----------+
|path         |The full path to the file, including its name.  **Note:  This is the identifier**                        |string    |
+-------------+---------------------------------------------------------------------------------------------------------+----------+
|parentDir    |The parent directory name.                                                                               |string    |
+-------------+---------------------------------------------------------------------------------------------------------+----------+
|size         |The size of the file, in bytes.                                                                          |integer   |
+-------------+---------------------------------------------------------------------------------------------------------+----------+
|directory    |A Boolean value indicating if the file referenced is a directory or not.                                 |boolean   |
+-------------+---------------------------------------------------------------------------------------------------------+----------+
|modified     |If it is a directory, then children is an array of child files contained within the directory.  By       |integer   |
|             |default these will be uninflated datastore items.  Meaning isItem() returns true, but isItemLoaded()     |          |
|             |returns false.  To load the item, it is a call to the FileStore.loadItem() api with the appropriate      |          |
|             |callbacks.   By not inflating child files by default the store performance is greatly improved, as if you|          |
|             |don’t care about its children, you don’t have to load them.                                              |          |
+-------------+---------------------------------------------------------------------------------------------------------+----------+
|children     |An array of datastore items representing children files contained within the directory represented by the|array     |
|             |containing file item .  Should be accessed using the multivalue accessor: FileStore.getValues(item,      |          |
|             |"children");                                                                                             |          |
+-------------+---------------------------------------------------------------------------------------------------------+----------+


**Query Structure**
-------------------

The dojox.data.FileStore query structure follows that of dojo.data.ItemFileReadStore.  It is an object-based query structure where the store queries for file items using patterns defined for the attributes to be matched.  For example a query object of:

.. code-block :: javascript

  {  
    name: "foo*.txt"
  }


would return all files that have the name foo at the start of the name and end with the extension .txt.  

Please note that the store is a hierarchical store and if you wish to query the entire file system (not just the root of it), for a file name, you must set the standard dojo.data.api.Read queryOption 'deep' to the value true.  A complete code example of querying the entire filesystem scanned by the FileStore is below:


.. code-block :: javascript

  var fileStore = new dojox.data.FileStore({url: "myService.php"});
    function searchDone(items, request){
      if (items) {
        var i;
          for (i = 0; i < items.length; i++) {
            console.log("Found file: " + fileStore.getValue(items[i], "name") + " in directory: " + fileStore.getValue(items[i], "parentDir"));
          }
      }
    }
    fileStore.fetch({query: {name:"foo*.txt"}, onComplete: searchDone, queryOptions: {deep:true}});
  }

Attaching it as the datastore for a widget works the same as it would for any widget.  For example, using it to front a dijit Tree is shown below. In the following example, dijit.Tree is being rooted so that it displays the entire dojo source tree:

.. codeviewer::

  <script>
    dojo.require("dijit.Tree");
    dojo.require("dojox.data.FileStore");
  </script>
  <div class="tundra">
    <div dojoType="dojox.data.FileStore" url="/moin_static163/js/dojo/trunk/release/dojo/dojox/data/demos/stores/filestore_dojotree.php" pathAsQueryParam="true" jsId="dojoFiles"></div>
    <div dojoType="dijit.tree.ForestStoreModel" jsId="fileModel" store="dojoFiles" query="{}" rootId="DojoFiles" rootLabel="Dojo Files" childrenAttrs="children"></div>
    <div id="tree" dojoType="dijit.Tree" model="fileModel" ></div>  
  </div>

**Technical/Protocol Details**
==============================
This section is not necessary to fully understand how to just use the existing dojox.data.FileStore back end implementation, it is intended for people who wish to implement their own back end service in another language, such as python or java.   


**Protocol**
------------
The protocol used by dojox.data.FileStore to communicate with a server back end is simple.  It is effectively a  direct psuh of the client query information to the server in JSON encoding.   The protocol consists of two main flows a query flow for implementing the dojo.data.api.Read, and a n individual item lookup for implementing the dojo.data.api.Identity.  Each of these are covered in detail below:

**dojo.data.api.Read query protocol**
All query information is passed as query parameters.  The list below of the query parameters and what is generally supported is defined below in the following table:

+-------------------+---------------------------------------------------------------------------------------------------------+--------------------+
|**Query Parameter**|**Description**                                                                                          |**Type**            |
+-------------------+---------------------------------------------------------------------------------------------------------+--------------------+
|query              |The query to run in the file store.  This is a JSON encoded javascript object of name/value pairs to     |JSON encoded object |
|                   |match against.  For example:  {"name":"foo*.txt"} will match all files that start with the name foo and  |                    |
|                   |end with .txt.   Please note that unless the queryOption deep is set true, the match only scans the root |                    |
|                   |directory.                                                                                               |                    |
+-------------------+---------------------------------------------------------------------------------------------------------+--------------------+
|queryOptions       |The options used to modify the query.  The example implementation supports the two defined dojo.data     |JSON encoded object |
|                   |query modifiers: *deep* and *ignoreCase*                                                                 |                    |
+-------------------+---------------------------------------------------------------------------------------------------------+--------------------+
|start              |Where in the list of matches to start returning file items.  For example a value of 10 means start       |integer             |
|                   | returning items beginning at the tenth file item match.                                                 |                    |
+-------------------+---------------------------------------------------------------------------------------------------------+--------------------+
|count              |How many file items to return.                                                                           |integer             |
+-------------------+---------------------------------------------------------------------------------------------------------+--------------------+

Example query (Return the first ten files in the file tree that begin with foo and end with .txt):
  http://<remotehost>/myFileService?query={"name":"foo*.txt"}&queryOptions={"deep":true,"ignoreCase":false}&start=0&count=10

**Example return:**
*(Note that the protocol returns a 'total' property, which informs the store of how many matches were found, regardless of what start and count was.  This is so that onBegin of the store can be properly informed how many total matches occurred.)*

.. code-block :: javascript

  {
    "total": 2496,
    "items": [
       {"name": "foo0.txt", "parentDir": "some/dir0", "size": 1234, "modified": 1234567, "directory": false, "path": "some/dir0/foo.txt"},
       {"name": "foo1.txt", "parentDir": "some/dir1", "size": 1234, "modified": 1234567, "directory": false, "path": "some/dir1/foo1.txt"},
       {"name": "foo2.txt", "parentDir": "some/dir2", "size": 1234, "modified": 1234567, "directory": false, "path": "some/dir2/foo2.txt"},
       {"name": "foo3.txt", "parentDir": "some/dir3", "size": 1234, "modified": 1234567, "directory": false, "path": "some/dir3/foo3.txt"},
       {"name": "foo4.txt", "parentDir": "some/dir4", "size": 1234, "modified": 1234567, "directory": false, "path": "some/dir4/foo4.txt"},
       {"name": "foo5.txt", "parentDir": "some/dir5", "size": 1234, "modified": 1234567, "directory": false, "path": "some/dir5/foo5.txt"},
       {"name": "foo6.txt", "parentDir": "some/dir6", "size": 1234, "modified": 1234567, "directory": false, "path": "some/dir6/foo6.txt"},
       {"name": "foo7.txt", "parentDir": "some/dir7", "size": 1234, "modified": 1234567, "directory": false, "path": "some/dir7/foo7.txt"},
       {"name": "foofiles.txt", "parentDir": "some/dir8", "size": 1234, "modified": 1234567, "directory": true, "path": "some/dir8/foofiles.txt", "children": ["tmp1","tmp2","tmp3"]},
       {"name": "foo9.txt", "parentDir": "some/dir9", "size": 1234, "modified": 1234567, "directory": false, "path": "some/dir9/foo9.txt"},
    ]
  }
