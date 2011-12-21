.. _dojox/data/AppStore:

===================
dojox.data.AppStore
===================

:Project owner: Benjamin Schell
:since: V1.3

.. contents ::
   :depth: 2

A store implementing an Atom store with complete ATOM Publishing Protocol support. Allows reading and writing of ATOM formatted feeds.

Introduction
============

The dojox.data.AppStore is an data store implementation of the ATOM Publishing Protocol (APP).  It makes use of the dojox.atom subproject for handling ATOM feeds and entries.

Limitations
===========

The AppStore makes use of dojo.xhr to get and modify feeds and entries.  Because of this, the AppStore is limited by the browser same domain policy, where xhr can only open connections back to the server that originated the page.  If you require accessing ATOM feeds from external services, you will need to make use of a proxy.

Supported APIs
==============

The following dojo.data APIs are implemented by AppStore:

* :ref:`dojo.data.api.Read <dojo/data/api/Read>`
* :ref:`dojo.data.api.Write <dojo/data/api/Write>`
* :ref:`dojo.data.api.Identity <dojo/data/api/Identity>`

Constructor Parameters
======================

+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| **Parameter**  | **Required** | **Description**                                                                                | **Since** |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| url            | yes          |This parameter specifies what URL from which to load the ATOM feed document, and is also the    |1.3        |
|                |              |base url used for publishing new feed entries if the feed supports it.                          |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| urlPreventCache| No           |This parameter tells the AppStore whether or not to append a query param to the URL to prevent  |1.3        |
|                |              |the browser from caching the feed url.                                                          |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+

Input Data Format
=================

The input data format is the standard `ATOM <http://en.wikipedia.org/wiki/Atom_(standard)>`_ feed format.  An example of an ATOM feed is below:

.. code-block :: xml
 
  <?xml version='1.0' encoding='utf-8'?>
  <feed xmlns='http://www.w3.org/2005/Atom' xml:lang='en-US'>
    <title>Example.com</title>
    <link rel="alternate" type="text/html" href="http://example.com/" hreflang="en" title="Example.com" />
    <subtitle type='text'>Example.com's Sample Feed</subtitle>
    <rights>Copyright Example.com</rights>
    <id>http://example.com/samplefeed.xml</id>
    <updated>2007-08-07T20:00:00-05:00</updated>
    <link rel="self" type="application/atom+xml" href="http://www.example.com/samplefeed.xml"/>
    <entry>
        <title>Test Entry #1</title>
        <id>http://example.com/samplefeed.xml/entry/1</id>
        <link rel='alternate' href='http://example.com/1.html'/>
        <summary type='html'>
            <p>This is a sample entry in our Atom feed.  It is simply a large paragraph in the summary.<p>
            <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Cras cursus. Aliquam eget metus sed leo lacinia
            rutrum. Nunc lacus lacus, viverra placerat, laoreet nec, placerat vel, eros. Donec nec magna id sem commodo rutrum.
            Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Aenean pede. Quisque vel
            leo. In vitae nisi. Curabitur sodales congue nibh. Maecenas ultrices ante nec ipsum. Aenean quis nibh. Aenean semper,
            quam vitae ullamcorper euismod, arcu leo tincidunt nunc, vel pulvinar turpis dolor a elit. Praesent nonummy nunc
            faucibus nibh. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus laoreet,
            ante auctor condimentum venenatis, magna quam varius elit, at feugiat dolor metus id quam. Etiam enim.<p>
        </summary>
        <author>
            <name>Test User</name>
            <email>test@example.com</email>
        </author>
        <updated>2007-08-07T04:00:00-05:00</updated>
    </entry>
    <entry>
        <title>Test Entry #2</title>
        <id>http://example.com/samplefeed.xml/entry/2</id>
        <link rel='alternate' href='http://example.com/2.html'/>
        <summary type='text'>
            This is a sample entry in our Atom feed.  It is simply a large paragraph in the summary. This is straight text.
            Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Cras cursus. Aliquam eget metus sed leo lacinia
            rutrum. Nunc lacus lacus, viverra placerat, laoreet nec, placerat vel, eros. Donec nec magna id sem commodo rutrum.
            Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Aenean pede. Quisque vel
            leo. In vitae nisi. Curabitur sodales congue nibh. Maecenas ultrices ante nec ipsum. Aenean quis nibh. Aenean semper,
            quam vitae ullamcorper euismod, arcu leo tincidunt nunc, vel pulvinar turpis dolor a elit. Praesent nonummy nunc
            faucibus nibh. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus laoreet,
            ante auctor condimentum venenatis, magna quam varius elit, at feugiat dolor metus id quam. Etiam enim.
        </summary>
        <author>
            <email>test@example.com</email>
        </author>
        <updated>2007-08-07T06:00:00-05:00</updated>
    </entry>
  </feed>

Usage
=====

The AppStore conforms to the dojo.data APIs and all example usage scenarios for them apply here as well.  Please refer to the :ref:`dojo.data API <dojo/data/api>` page for more details.  In general, since it conforms to the dojo.data API, all data-bound widgets in dijit can connect to, and make us of, the ATOM data.  Please refer to the examples section for more usage details.


Attribute List
--------------

An ATOM entry is comprised of attributes that define the details of the entry, such as its title, date updated, summary information, content, and so on.  Below is the table list defining what the common attributes are valid to use with the data store getValue(s) and setValue(s) functions of the data store APIs for data access.   The list is not complete, but the attributes not listed are not commonly used by feed consumers.  Certain properties return complex objects instead of strings, these are identified in the type field.  For more specific information on the structure of that complex property, see the table below the attribute list.

+---------------+------------------------------------------------------------------------------------------------------+----------------------+
| **Attribute** | **Description**                                                                                      | **Type**             |
+---------------+------------------------------------------------------------------------------------------------------+----------------------+
| title         | The title of the entry.                                                                              | string               |
+---------------+------------------------------------------------------------------------------------------------------+----------------------+
| subtitle      | The sub-title of the entry.                                                                          | string               |
+---------------+------------------------------------------------------------------------------------------------------+----------------------+
| summary       | The summary of the entry.                                                                            | string               |
+---------------+------------------------------------------------------------------------------------------------------+----------------------+
| content       | The entry content.                                                                                   | string               |
+---------------+------------------------------------------------------------------------------------------------------+----------------------+
| category      | The category this entry is cataloged under.  'Entertainment, News, Sports', etc.                     | string               |
+---------------+------------------------------------------------------------------------------------------------------+----------------------+
| author        | The person who published the entry (multi valued field).                                             | object/object array  |
+---------------+------------------------------------------------------------------------------------------------------+----------------------+
| contributor   | Contributors to the entry content. (multi valued field).                                             | object/object array  |
+---------------+------------------------------------------------------------------------------------------------------+----------------------+
| link          | The direct link to the ATOM entry.                                                                   | object/object array  |
+---------------+------------------------------------------------------------------------------------------------------+----------------------+
| rights        | The copyright statement of the entry.                                                                | string               |
+---------------+------------------------------------------------------------------------------------------------------+----------------------+
| id            | The unique ID for this entry in the feed.                                                            | string               |
+---------------+------------------------------------------------------------------------------------------------------+----------------------+
| updated       | The last date the entry was updated.                                                                 | string               |
+---------------+------------------------------------------------------------------------------------------------------+----------------------+
| published     | The date the entry was published.                                                                    | string               |
+---------------+------------------------------------------------------------------------------------------------------+----------------------+

**Complex Properties**

Complex properties are those that require more than a simple string to represent their values.  The current items in the ATOM feed entry that are represented this way are 'Author', 'Contributor' and 'Link'.  All of these have either sub-tags or attributes that are important information.  These attributes are modeled as their own classes in :ref:`dojox.atom.io.model.js <dojox/atom/io/model>`.  The information about each is below:

+---------------+------------------------------------------------------------------------------------+----------------------------------------+
| **Attribute** | **Implementing Class**                                                             | **Properties**                         |
+---------------+------------------------------------------------------------------------------------+----------------------------------------+
| author        | dojox.atom.io.model.Person                                                         | name: The name of the person           |
|               |                                                                                    |                                        |
|               |                                                                                    | email: The email address of the person |
|               |                                                                                    |                                        |
|               |                                                                                    | uri:  The person's web address, if any |
+---------------+------------------------------------------------------------------------------------+----------------------------------------+
| contributor   | dojox.atom.io.model.Person                                                         | name: The name of the person           |
|               |                                                                                    |                                        |
|               |                                                                                    | email: The email address of the person |
|               |                                                                                    |                                        |
|               |                                                                                    | uri:  The person's web address, if any |
+---------------+------------------------------------------------------------------------------------+----------------------------------------+
| link          | dojox.atom.io.model.Link                                                           | href: The web address the link goes to |
|               |                                                                                    |                                        |
|               |                                                                                    | hrefLang: The language the href goes to|
|               |                                                                                    |                                        |
|               |                                                                                    | title: The title of the link           |
|               |                                                                                    |                                        |
|               |                                                                                    | type: The type of the link             |
|               |                                                                                    |                                        |
|               |                                                                                    | rel: How the link relates to the entry |
+---------------+------------------------------------------------------------------------------------+----------------------------------------+


Query Syntax
============

The fetch method query syntax for AppStore is the same as :ref:`ItemFilereadStore <dojo/data/ItemFileReadStore>`. It allows a list of attributes to match against in an AND fashion. For example, a query object to locate all items with attribute foo that has value bar and attribute bit that has value bite, would look like

.. js ::

  { title:"bar", subtitle:"bite"}

Okay, easy. Now what if I want to do a fuzzy match of items?  Can this be done?   Yes. AppStore supports wildcard matching. Specifically, it supports multi-character * and single character ? as wildcards in attribute value queries.

Query Examples
==============

Match items with multi-character wildcard
-----------------------------------------

*Matching attribute title that has a value starting with bar*

.. js ::

  { title:"bar*"}


Match items with single character wildcard
------------------------------------------

*Matching attribute title the value of which ends with ar and starts with any character.*


.. js ::

  { title:"?ar"}


Match items on multiple attributes
----------------------------------

*Matching multiple attributes with various wildcards.*


.. js ::

  { title:"?ar", subtitle:"bob", category:"*it*"}


Examples
========

Example 1: Programmatic instantiation and querying of ATOM Feeds.
-----------------------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dojox.data.AppStore");
      dojo.require("dijit.form.Button");

      // This function performs some basic dojo initialization and will do the fetch calling for this example
      function initSimple(){
        var appStore = new dojox.data.AppStore({url:"{{dataUrl}}dojox/atom/tests/widget/samplefeedEdit.xml"});

        dojo.connect(dijit.byId("simpleFetchButton"), "onClick", function(){
          function gotEntries(items, request){
            if(items){
              // Got the items, let's attach in the results (title, date updated).
              var list = dojo.byId("list");
              for(i = 0; i < items.length; i++){
                var e = items[i];
                var title = appStore.getValue(e, "title");
                var updated = appStore.getValue(e, "updated");
                list.appendChild(dojo.doc.createTextNode(title));
                list.appendChild(dojo.doc.createElement("br"));
                list.appendChild(dojo.doc.createTextNode(updated));
                list.appendChild(dojo.doc.createElement("br"));
                list.appendChild(dojo.doc.createElement("br"));
              }
            }
          }
          appStore.fetch({onComplete: gotEntries});
        });
      }
      // Set the init function to run when dojo loading and page parsing has completed.
      dojo.ready(initSimple);

  .. html ::

    <div data-dojo-type="dijit.form.Button" id="simpleFetchButton">Click me to search the store and display feed titles</div>
    <br>
    <br>
    <span id="list">
    </span>

Example 2: Programmatic instantiation and querying of ATOM Feed Entry titles.
-----------------------------------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dojox.data.AppStore");
      dojo.require("dijit.form.Button");

      // This function performs some basic dojo initialization and will do the fetch calling for this example
      function initSimple2(){
        var appStore = new dojox.data.AppStore({url:"{{dataUrl}}dojox/atom/tests/widget/samplefeedEdit.xml"});

        dojo.connect(dijit.byId("simpleFetchButton2"), "onClick", function(){
          function gotEntries(items, request){
            if(items){
              // Got the items, let's attach in the results (title, date updated).
              var list = dojo.byId("list2");
              for(i = 0; i < items.length; i++){
                var e = items[i];
                var title = appStore.getValue(e, "title");
                var updated = appStore.getValue(e, "updated");
                list.appendChild(dojo.doc.createTextNode(title));
                list.appendChild(dojo.doc.createElement("br"));
                list.appendChild(dojo.doc.createTextNode(updated));
                list.appendChild(dojo.doc.createElement("br"));
                list.appendChild(dojo.doc.createElement("br"));
              }
            }
          }
          appStore.fetch({query: {title: "*Editable*"}, onComplete: gotEntries});
        });
      }
      // Set the init function to run when dojo loading and page parsing has completed.
      dojo.ready(initSimple2);

  .. html ::

    <div data-dojo-type="dijit.form.Button" id="simpleFetchButton2">Click me to search the entries for titles with 'Editable'</div>
    <br>
    <br>
    <span id="list2">
    </span>


Example 3: Connecting AppStore to DataGrid
------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dojox.data.AppStore");
      dojo.require("dojox.grid.DataGrid");

      var layout = [
        [
          { field: "title", name: "Title", width: 15 },
          { field: "link", name: "Link", width: 5, formatter: function(value){ return "<a href=\"" + value.href + "\" target=\"_blank\">Link</a>";}},
          { field: "author", name: "Author", width: '10', formatter: function(value){
              var ret = "";
              if(value.name){ ret = value.name; }
              if(value.email){
                if(value.name){
                  ret += " (" + value.email +")";
                }else{
                 ret = value.email;
                }
              }
              return ret;
            }
          },
          { field: "updated", name: "Last Modified", width: 'auto' }
        ]
      ];

      function resizeGrid(){
          grid.resize();
      }
      dojo.ready(resizeGrid)


  .. html ::

    <div data-dojo-type="dojox.data.AppStore" data-dojo-id="appStore" data-dojo-props="url:'{{dataUrl}}dojox/atom/tests/widget/samplefeedEdit.xml'"></div>
    <div data-dojo-id="grid" data-dojo-type="dojox.grid.DataGrid" data-dojo-props="store:appStore, query:{}, structure:layout" style="width: 600px; height: 200px;"></div>
    <br>
    <br>
    <span id="list2">
    </span>

  .. css ::

      @import "{{baseUrl}}dojox/grid/resources/Grid.css";
      @import "{{baseUrl}}dojox/grid/resources/nihiloGrid.css";

      .dojoxGrid table {
        margin: 0;
      }

Example 4: Write example: Changing Title and showing in DataGrid
----------------------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.Button");
      dojo.require("dojox.data.AppStore");
      dojo.require("dojox.grid.DataGrid");

      var layout2 = [
        [
          { field: "title", name: "Title", width: 15 },
          { field: "link", name: "Link", width: 5, formatter: function(value){ return "<a href=\"" + value.href + "\" target=\"_blank\">Link</a>"}},
          { field: "updated", name: "Last Modified", width: 'auto' }
        ]
      ];

      function initGrid(){
          thegrid.resize();
          dojo.connect(dijit.byId("changeTitleButton"), "onClick", function(){
             function gotAllItems(items, request){
               if(items){
                 var i;
                 // Change all the titles.
                 for(i = 0; i < items.length; i++){
                   appStore2.setValue(items[i], "title", "This is new title #" + i);
                 }
                 // Requery to reload grid.  This is needed as this store does not currently implement the notification API.
                 thegrid.setQuery({});
               }
             }
             appStore2.fetch({onComplete: gotAllItems});
          });
      }
      dojo.ready(initGrid)


  .. html ::

    <div data-dojo-type="dojox.data.AppStore" data-dojo-id="appStore2" data-dojo-props="url:'{{dataUrl}}dojox/atom/tests/widget/samplefeedEdit.xml'"></div>
    <div data-dojo-id="thegrid" data-dojo-type="dojox.grid.DataGrid" data-dojo-props="store:appStore2, query:{}, structure:layout2" style="width: 600px; height: 200px;"></div>
    <br>
    <br>
    <button id="changeTitleButton" data-dojo-type="dijit.form.Button">Change all titles!</button>
  
  .. css ::

      @import "{{baseUrl}}dojox/grid/resources/Grid.css";
      @import "{{baseUrl}}dojox/grid/resources/nihiloGrid.css";

      .dojoxGrid table {
        margin: 0;
      }


See also
========

* :ref:`dojox.atom <dojox/atom>`
* :ref:`dojox.data.AtomReadStore <dojox/data/AtomReadStore>`
