.. _dojox/data/QueryReadStore/example:

=========================
dojox.data.QueryReadStore
=========================

.. contents ::
  :depth: 2

The following example illustrates a client implementation of a QueryReadStore extension. It uses the QueryReadStore.php found in dojox/data/tests/stores/ as server-side data provider, and is a simplified version of the dojox/data/tests/QueryReadStore.html.

In order for it to work, place the following HTML in a file (call it qrs.html) on a web server that has PHP 5.2 or greater.

The directory structure should look like this when you are done:

--qrs.html

--dojo/

--dijit/

--dojox/

----data/

------tests/

--------stores/

----------QueryReadStore.php


Here is the content of the html file, including the QueryReadStore extension code.

**Example HTML**

.. html ::
 
  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
  <html>
  <head>
	<style type="text/css">
		@import "./dojo/resources/dojo.css";
		@import "./dijit/themes/tundra/tundra.css";
	</style>

	<title>Query read store</title>

	<script type="text/javascript" src="./dojo/dojo.js" data-dojo-config="async:1, isDebug: true, parseOnLoad: true"></script>
	<script type="text/javascript">
	
		require([
			"dojo/_base/declare", 
			"dojox/data/QueryReadStore",			
			"dojo/parser",
			"dijit/form/FilteringSelect"], 
			
			function(declare, QueryReadStore){
			
				declare("ComboBoxReadStore", QueryReadStore, {
					fetch:function(request) {
						// Copy the GET/POST parameters (request.query) we need into
						// request.serverQuery. We actually want to have
						// the query added to the URL like so:  /url.php?q=<searchString>
						// The data in "queryOptions" are useless for our backend,
						// we ignore them, they are not sent to the server.
						// The combobox puts this into the request-parameter:
						//      {
						//          query: {name:<searchString>},
						//          queryOptions: {ignoreCase:true, deep:true},
						//          ...
						//      }
						// We generate request.serverQuery to be this, since those values will
						// be sent to the server.
						//      {
						//          q:<searchString>}
						//      }
						// This results in a xhr request to the following URL (in case of GET):
						//      /url.php?q=<searchString>
						request.serverQuery = {q:request.query.name};
						return this.inherited("fetch", arguments);
					}
				});			
				
			}
		);
	</script>
  </head>
  <body class="tundra">
	<div data-dojo-type="ComboBoxReadStore" data-dojo-id="store" data-dojo-props="url:'dojox/data/tests/stores/QueryReadStore.php', requestMethod:'get'"></div>
	<input id="fs" data-dojo-type="dijit.form.FilteringSelect" data-dojo-props="store:store, pageSize:5" />
  </body>
  </html>
