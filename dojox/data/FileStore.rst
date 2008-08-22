#format dojo_rst

dojox.data.FilStore
===================

:Status: Contributed, Draft
:Version: 1.0
:Author: Jared Jurkiewicz

The dojox.data.FileStore is a lightweight javascript implementation for accessing details about a remote FileSystem.  This includes being able to search the filesystem to locate file names, display path information, file sizes, if it’s a directory or not, and if a directory, what children files are contained within it.   The dojox.data.FileStore is also an excellent example of how DataStores can do lazy-loading.   

The datastore implementation and its example PHP back-end by default do not inflate the child file objects of a DataStore file item.  This allows it to quickly return information about a file without having to return everything, while at the same time providing hooks that allow for the extra information to be gathered on-demand.  

**Features**

1. The client javascript and example server php script implement the following dojo.data APIs:  dojo.data.api.Read, dojo.data.api.Identity.
2. A deliberately simple client side implementation for use as a reference when implementing other server side stores that wish to provide lazy-loading as defined by the dojo.data.api.Read spec.  The client code is deliberately small to make it easy to understand.
3. The ability to search across a variety of attributes, such as name, path, parentDir, lastModified, etc.   It also allows for matching on multiple fields, such as all files with parentDir of ‘foo’, that have filename: ‘bar*.js’.
4. The datastore can do shallow searching (root dir only), or recursive searching (scan the entire file system for matches across the parameters).
5. The client store can directly access information about a specific about a file through RESTlike patterns that work well with servlets that allow mapping of a context root to a servlet, and the servlet’s ability to get extra path information.  It can also work with back-end services like PHP that do not provide a mechanism to do URL path based queries by converting the path into a query param, ‘path’.   This is enabled by setting pathAsQueryParam  to true on the store instance.
6. Support for all normal query options as defined by the dojo.data.api.Read specification.  Deep provides recursive tree searching, ignoreCase provides the ability to ignore the case sensitivity of attributes when matching, and so on.
7. An example implementation of the back end service in PHP.  The example is documented cleanly and is less than five hundred lines of code, making it relatively easy to dissect and understand.
8. Works directly with all current data bound widgets in dijit, including dijit.Tree, dijit.form.ComboBox, and well as dojox.grid.
