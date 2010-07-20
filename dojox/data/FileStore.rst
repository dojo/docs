#format dojo_rst

dojox.data.FileStore
====================

:Status: Contributed, Draft
:Version: 1.0
:Author: Jared Jurkiewicz
:Available: since V1.2

.. contents::
    :depth: 3

The dojox.data.FileStore is a lightweight javascript implementation for accessing details about a remote FileSystem. This includes being able to search the filesystem to locate file names, display path information, file sizes, if it’s a directory or not, and if a directory, what children files are contained within it. The dojox.data.FileStore is also an excellent example of how DataStores can do lazy-loading.

The datastore implementation and its example PHP back-end by default do not inflate the child file objects of a DataStore file item. This allows it to quickly return information about a file without having to return everything, while at the same time providing hooks that allow for the extra information to be gathered on-demand.


========
Features
========

1. The client javascript and example server php script implement the following dojo.data APIs:

   - `dojo.data.api.Read <dojo/data/api/Read>`_ and
   - `dojo.data.api.Identity <dojo/data/api/Identity>`_.

2. A deliberately simple client side implementation for use as a reference when implementing other server side stores that wish to provide lazy-loading as defined by the dojo.data.api.Read spec. The client code is deliberately small to make it easy to understand.

3. The ability to search across a variety of attributes, such as name, path, parentDir, lastModified, etc. It also allows for matching on multiple fields, such as all files with parentDir of ‘foo’, that have filename: ‘bar*.js’.

4. The datastore can do shallow searching (root dir only), or recursive searching (scan the entire file system for matches across the parameters).

5. The client store can directly access information about a specific about a file through RESTlike patterns that work well with servlets that allow mapping of a context root to a servlet, and the servlet’s ability to get extra path information. It can also work with back-end services like PHP that do not provide a mechanism to do URL path based queries by converting the path into a query param, ‘path’. This is enabled by setting pathAsQueryParam  to true on the store instance.

6. Support for all normal query options as defined by the dojo.data.api.Read specification. Deep provides recursive tree searching, ignoreCase provides the ability to ignore the case sensitivity of attributes when matching, and so on.

7. An example implementation of the back end service in PHP. The example is documented cleanly and is less than five hundred lines of code, making it relatively easy to dissect and understand.

8. Works directly with all current data bound widgets in dijit, including `dijit.Tree <dijit/Tree>`_, `dijit.form.ComboBox <dijit/form/ComboBox>`_, and as well `dojox.grid <dojox/grid>`_.


==============
Item structure
==============

All items returned by a query to the FileStore and will generally have the following attributes accessible via FileStore.getValue(item, attribute) and FileStore.getValues(item, attribute):

+-------------+---------------------------------------------------------------------------------------------------------+----------+
|**Attribute**|**Description**                                                                                          |**Type**  |
+-------------+---------------------------------------------------------------------------------------------------------+----------+
|name         |The name of the file. This does not include any path information.                                        |string    |
+-------------+---------------------------------------------------------------------------------------------------------+----------+
|path         |The full path to the file, including its name.                                                           |string    |
|             |**Note:  In the context of dojo.data.api.Identity, this is the identifier**                              |          |
+-------------+---------------------------------------------------------------------------------------------------------+----------+
|parentDir    |The parent directory name.                                                                               |string    |
+-------------+---------------------------------------------------------------------------------------------------------+----------+
|size         |The size of the file, in bytes.                                                                          |integer   |
+-------------+---------------------------------------------------------------------------------------------------------+----------+
|directory    |A Boolean value indicating if the file referenced is a directory or not.                                 |boolean   |
+-------------+---------------------------------------------------------------------------------------------------------+----------+
|children     |If it is a directory, then children is an array of child files contained within the directory. By        |array     |
|             |default these will be uninflated datastore items. Meaning isItem() returns true, but isItemLoaded()      |          |
|             |returns false. To load the item, it is a call to the FileStore.loadItem() api with the appropriate       |          |
|             |callbacks. By not inflating child files by default the store performance is greatly improved, as if you  |          |
|             |don’t care about its children, you don’t have to load them.  Should be accessed by the multivalue        |          |
|             |*getValues()* accessor.                                                                                  |          |
+-------------+---------------------------------------------------------------------------------------------------------+----------+
|modified     |An integer indicating the last modified date.  This is the file timestamp from the system                |integer   |          
+-------------+---------------------------------------------------------------------------------------------------------+----------+


===============
Query Structure
===============

The dojox.data.FileStore query structure follows that of dojo.data.ItemFileReadStore. It is an object-based query structure where the store queries for file items using patterns defined for the attributes to be matched. For example a query object of:

.. code-block :: javascript

  {  
    name: "foo*.txt"
  }


would return all files that have the name foo at the start of the name and end with the extension .txt.

Please note that the store is a hierarchical store and if you wish to query the entire file system (not just the root of it), for a file name, you must set the standard dojo.data.api.Read queryOption 'deep' to the value true.


========
Examples
========

Using the dojox.dataFileStore is generally simple. The store takes three possible constructor options which can also be declared in markup. These options configure the store and its operating behavior. The options are defined below in a table.

+---------------------+-----------------------------------------------------------------------------------------------+--------------------+
|**Constructor param**|**Description**                                                                                |**Type**            |
+---------------------+-----------------------------------------------------------------------------------------------+--------------------+
|url                  |The URL of the service that provides the server-side implementation that processes the queries |string              |
|                     |returns the results. Note that because of the same origin policy of the browser, the service   |                    |
|                     |must reside in the same domain as the loaded page. To access urls outside of the domain, you   |                    | 
|                     |must use a proxy. **This parameter is required**                                               |                    | 
+---------------------+-----------------------------------------------------------------------------------------------+--------------------+
|pathAsQueryParam     |This parameter alters the behavior of the dojo.data.api.Identity functions. By default it is   |boolean             |
|                     |false. When it is false, any request for the information of a single file theough a            |                    |
|                     |fetchItemByIdentity call (and internally by loadItem), the url used is restful. This means the |                    |
|                     |url request will look like:                                                                    |                    |
|                     |                                                                                               |                    |
|                     |                                                                                               |                    |
|                     |*http://<server>/<service>/some/file*.                                                         |                    |
|                     |                                                                                               |                    |
|                     |                                                                                               |                    |
|                     |It is effectively url-pathing to represent the file.                                           |                    |
|                     |                                                                                               |                    |
|                     |                                                                                               |                    |
|                     |This is convenient for services implemented in a java servlet. For implementations that are    |                    |
|                     |not convenient to work this way, such as php, you would want to set the option to true. When   |                    |
|                     |is set to true, the path to the file becomes a query parameter. An example is:                 |                    |
|                     |                                                                                               |                    |
|                     |                                                                                               |                    |
|                     |*http://<server>/<service>?path=some/file*                                                     |                    |
+---------------------+-----------------------------------------------------------------------------------------------+--------------------+
|options              |This is a comma separated list of options that dojox.data.FileStore will pass to the service as|string              |
|                     |a JSON encoded string array. These options can be used to configure certain behaviors of the   |                    |
|                     |dojox.data.FileStore. The example PHP implementation provided in demos supports the following  |                    | 
|                     |                                                                                               |                    |
|                     |**expand**: This option instructs the store to inflate all child files of a directory so that  |                    |
|                     |lazy-loading through isItemLoaded() and loadItem() is not necessary. This options is           |                    |
|                     |expensive to use and not recommended. For large file systems, using this option can generate   |                    |
|                     |huge returns. This option is not recommended for use, but is provided as convenience           |                    |
|                     |for small file systems and debug purposes.                                                     |                    |
|                     |                                                                                               |                    |
|                     |**showHiddenFiles**: This option enables returning information about hidden files. By default  |                    |
|                     |the example implementation does not display hidden files. Note that a hidden file follows UNIX |                    |
|                     |of starting with a '.' character.                                                              |                    |
|                     |                                                                                               |                    |
|                     |**dirsOnly**: Only return file entries that are directories. This option is useful for         |                    |
|                     |a directory tree display.                                                                      |                    |
+---------------------+-----------------------------------------------------------------------------------------------+--------------------+
|urlPreventCache      |Flag to denote if preventCache should be appended to underlying xhrGet calls.  Default is true | boolean            |
|                     |**New in Dojo 1.4**                                                                            |                    |
+---------------------+-----------------------------------------------------------------------------------------------+--------------------+


Some usage examples for using the service in code as well as declarative markup attaching it to a widget such as dijit.Tree, dijit.form.ComboBox, and dojox.grid.DataGrid are shown below.

Simple programmatic usage
-------------------------

A complete code example of querying the entire filesystem for a wildcard matched file:

:: 

  var fileStore = new dojox.data.FileStore({url: "myService.php", pathAsQueryParam: true});
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


Attaching it as the datastore for a widget works the same as it would for any widget. For example, using it to front a dijit Tree is shown below. In the following example, dijit.Tree is being rooted so that it displays the entire dojo source tree:

Attaching the FileStore to dijit.Tree declaratively
---------------------------------------------------

.. cv-compound ::

  .. cv :: javascript

    <script>
      dojo.require("dijit.Tree");
      dojo.require("dojox.data.FileStore");
    </script>

  .. cv :: html
  
    <div>
      <div dojoType="dojox.data.FileStore" url="{{dataUrl}}dojox/data/demos/stores/filestore_dojotree.php" pathAsQueryParam="true" jsId="dojoFiles"></div>
      <div dojoType="dijit.tree.ForestStoreModel" jsId="fileModel" store="dojoFiles" query="{}" rootId="DojoFiles" rootLabel="Dojo Files" childrenAttrs="children"></div>
      <div id="tree" dojoType="dijit.Tree" model="fileModel" ></div>  
    </div>

Attaching the FileStore to dijit.form.ComboBox declaratively
------------------------------------------------------------

.. cv-compound ::

  .. cv :: javascript

    <script>
      dojo.require("dijit.form.ComboBox");
      dojo.require("dojox.data.FileStore");
    </script>

  .. cv :: html

    <div>
      <div dojoType="dojox.data.FileStore" url="{{dataUrl}}dojox/data/demos/stores/filestore_dojoxdata.php" pathAsQueryParam="true" jsId="comboStore"></div>
      <div dojoType="dijit.form.ComboBox"  store="comboStore" searchAttr="path" value="./demos"></div> 
    </div>

Attaching the FileStore to dojox.grid.DataGrid declaratively
------------------------------------------------------------

.. cv-compound ::

  .. cv :: javascript

    <script type="text/javascript">
      dojo.require("dojox.grid.DataGrid");
      dojo.require("dojox.data.FileStore");
    </script>

  .. cv :: html

    <span dojoType="dojox.data.FileStore" 
      jsId="fileStore3" 
      url="{{dataUrl}}dojox/data/demos/stores/filestore_dojoxdata.php" 
      pathAsQueryParam="true">
    </span>

    <table dojoType="dojox.grid.DataGrid"
        store="fileStore3"
        query="{}"
        queryOptions="{deep:true}"
        sortFields="[{'attribute':'path', 'descending': false}]"
        clientSort="true"
        style="width: 400px; height: 200px;">
      <thead>
        <tr>
          <th width="100px" field="name">Filename</th>
          <th width="100px" field="size">File Size</th>
          <th width="100px" field="directory">Is Directory</th>
          <th width="100px" field="path">Path</th>
        </tr>
      </thead>
    </table>

  .. cv:: css

    <style type="text/css">
      @import "{{baseUrl}}dojox/grid/resources/Grid.css";
      @import "{{baseUrl}}dojox/grid/resources/nihiloGrid.css";

      .dojoxGrid table {
        margin: 0;
      }
    </style>


==========================
Technical/Protocol Details
==========================

The following section is not necessary to fully understand how to just use the existing dojox.data.FileStore back end implementation, it is intended for people who wish to implement their own back end service in another language, such as python or java.   

`Protocol Information <dojox/data/FileStore/protocol>`_
