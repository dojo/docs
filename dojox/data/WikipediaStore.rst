.. _dojox/data/WikipediaStore:

dojox.data.WikipediaStore
=========================

:Status: Contributed, Draft
:Version: 1.0
:Available: since V1.2
 
.. contents::
  :depth: 3

The Wikipedia store is a datastore that extends :ref:`dojox.data.ServiceStore <dojox/data/ServiceStore>`.  Its putpose is to expose the Wikipedia search service SMD in a datastore format.  This store is fairly simplistic in what it allows searching on, such as full title, or searching title and body text for certain keywords.  It doesn't provide facilities for doing wildcar searching, unfortunately, which does not make it terribly useful for widgets such as dijit.form.ComboBox.

==============
Supported APIs
==============

The following dojo.data APIs are implemented by XmlStore

* :ref:`dojo.data.api.Read <dojo/data/api/Read>`


===============
Item Attributes
===============

All items returned from a Wikipedia search provide the following attributes you can access for additional details about the located articles.

+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| title         |The title of the article identified that matched the search criteria                                                         |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+

============
Query Syntax
============

The query syntax for this store is extremely basic.  It takes a query object that allows you to search for text in the title or in the body of articles.  An example query is shown below:

-------------------
Search article text
-------------------

.. code-block :: javascript

  query: {
    action: "query",
    text: "Dojo Toolkit"
  },


---------------------
Load article by title
---------------------

.. code-block :: javascript

  query: {
    title: "Dojo Toolkit"
  },

---------------------------
Search article text (paged)
---------------------------

.. code-block :: javascript

  query: {
    action: "query",
    text: "Dojo Toolkit"
    start: 10,
    count: 50
  },


========
Examples
========

-----------------------------------
Simple Demo usage of WikipediaStore
-----------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dijit.form.TextBox");
      dojo.require("dojox.data.WikipediaStore");
      var store = new dojox.data.WikipediaStore();

      function doSearch(){
        var outNode = dojo.byId("output");
        outNode.innerHTML = "Searching...";	

        function loadArticle(e, article){
          e.preventDefault();
          e.stopPropagation();
          var request = {
            query: {
            title: article
            },
            onItem: function(item, req){
              //We're loading all the content into an iFrame.  This is for two reasons:
              //One is security.  No rogue script in the content will affect anything outside of the iframe
              //Second is that it keeps docs.dojocampus.org CSS from altering the default view of the data.
              var title = store.getValue(item, "title");
              var text = store.getValue(item, "text")["*"];
              var wikiOut = dojo.byId("wikipediaContent");
              wikiOut.contentDocument.body.innerHTML = "<h1>" + title + "</h1>" + text;
            }
          };
          store.fetch(request);
        }

        var request = {
          query: {
            action: "query", 
            text: dijit.byId("searchText").getValue()
          },
          count: dijit.byId("count").getValue(),
          onBegin: function(count){
            outNode.innerHTML += " found " + count + " results.<br>Click one to load the article.";
          },
          onItem: function(item, req){
            var node = document.createElement("a");
            node.href = "#";
            node.onclick = function(e){
              loadArticle(e, this.innerHTML);
            };
            node.style.padding = "6px";
            node.style.display = "block";
            node.innerHTML = store.getValue(item, "title");
            outNode.appendChild(node);
          }
	};
        store.fetch(request);
      }
    </script>

  .. cv :: html

    <form action="#">
      <p>
        Text: <input id="searchText" dojoType="dijit.form.TextBox" type="text" value="dojo toolkit">
        <br>
        Count: <input id="count" dojoType="dijit.form.TextBox" type="text" value="8" size="3">
        <br>
        <button id="searchButton" dojoType="dijit.form.Button" value="store.fetch()" onclick="doSearch()">Search!</button>
      </p>
      <div id="output" style="padding:0 20px;"></div>
      <br>
      <b>IFRAME for sandboxing of results</b>
      <iframe id="wikipediaContent" src="" style="width: 100%; height: 500px;"><iframe>
    </form>
