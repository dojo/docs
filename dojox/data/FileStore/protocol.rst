.. _dojox/data/FileStore/protocol:

dojox.data.FileStore: Technical/Protocol Details
================================================

:Status: Draft
:Author: Jared Jurkiewicz
:Version: 1.2

.. contents::
    :depth: 2

The following section is not necessary to fully understand how to just use the existing dojox.data.FileStore back end implementation, it is intended for people who wish to implement their own back end service in another language, such as python or java.

========
Protocol
========

The protocol used by dojox.data.FileStore to communicate with a server back end is simple. It is effectively a  direct push of the client query information to the server in JSON encoding. The protocol consists of two main flows a query flow for implementing the dojo.data.api.Read, and a n individual item lookup for implementing the dojo.data.api.Identity. Each of these are covered in detail below:

dojo.data.api.Read query protocol
---------------------------------

All query information is passed as query parameters. The list below of the query parameters and what is generally supported is defined below in the following table:

+-------------------+---------------------------------------------------------------------------------------------------------+--------------------+
|**Query Parameter**|**Description**                                                                                          |**Type**            |
+-------------------+---------------------------------------------------------------------------------------------------------+--------------------+
|query              |The query to run in the file store. This is a JSON encoded javascript object of name/value pairs to      |JSON encoded object |
|                   |match against. For example:  {"name":"foo*.txt"} will match all files that start with the name foo and   |                    |
|                   |end with .txt. Please note that unless the queryOption deep is set true, the match only scans the root   |                    |
|                   |directory.                                                                                               |                    |
+-------------------+---------------------------------------------------------------------------------------------------------+--------------------+
|queryOptions       |The options used to modify the query. The example implementation supports the two defined dojo.data      |JSON encoded object |
|                   |query modifiers: *deep* and *ignoreCase*                                                                 |                    |
+-------------------+---------------------------------------------------------------------------------------------------------+--------------------+
|start              |Where in the list of matches to start returning file items. For example a value of 10 means start        |integer             |
|                   |returning items beginning at the tenth file item match.                                                  |                    |
+-------------------+---------------------------------------------------------------------------------------------------------+--------------------+
|count              |How many file items to return.                                                                           |integer             |
+-------------------+---------------------------------------------------------------------------------------------------------+--------------------+

Example query (Return the first ten files in the file tree that begin with foo and end with .txt):
  http://<remotehost>/myFileService?query={"name":"foo*.txt"}&queryOptions={"deep":true,"ignoreCase":false}&start=0&count=10

Example return:
~~~~~~~~~~~~~~~

*(Note that the protocol returns a 'total' property, which informs the store of how many matches were found, regardless of what start and count was. This is so that onBegin of the store can be properly informed how many total matches occurred. start and count controlled how many of that total was returned. Those parameters act as the paging mechanism as defined by dojo.data)*

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


dojo.data.api.Identity protocol
-------------------------------

The Identity protocol is very simple and is the same protocol used by loadItem() of the dojo.data.api.Read. The identity of Files in the filestore is the 'path' attribute. So when a url calling to a specific path is seen by the back-end FileStore service, the service knows it is a single file identity lookup and operates according. The way the path is sent varies depending on the pathAsQueryParam option. Examples are below:


pathAsQueryParam: false:
  http://<server>/<service>/some/file

  When the option is false, the path is sent as part of the url.


pathAsQueryParam: true:
  http://<server>/<service>?path=some/file

  When the option is true, the path is sent as a query parameter named 'path'.


In either of the above cases, the expected return is a single item in JSON encoded format. An example is below:

For identity lookup for directory *some/dir8/foofiles.txt*, the url queried would be:

*http://<server>/<service>/some/dir8/foofiles.txt*


The return is expected to be like be:

.. code-block :: javascript

  {
    "name": "foofiles.txt", 
    "parentDir": "some/dir8", 
    "size": 1234, 
    "modified": 1234567, 
    "directory": true, 
    "path": "some/dir8/foofiles.txt", 
    "children": ["tmp1","tmp2","tmp3"]
  }
