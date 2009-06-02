#format dojo_rst

dojox.data.OpmlStore
====================

:Status: Contributed, Draft
:Version: 1.0
:Author: Jared Jurkiewicz
:Available: since V1.0

.. contents::
  :depth: 2

OpmlStore is a simple read-only store provided by Dojo and contained in the DojoX project. OpmlStore is a read interface to work with `Opml <http://en.wikipedia.org/wiki/OPML>`_ formatted XML files. Similar to ItemFileReadStore, OpmlStore reads the contents from an http endpoint or a browser DOM object that contains Opml formatted data.

The following dojo.data APIs are implemented by OpmlStore

* `dojo.data.api.Read <dojo/data/api/Read>`_
* `dojo.data.api.Identity <dojo/data/api/Identity>`_ - *Identity is implemented as the index number of the <outline> node*

The following example shows an Opml data source:

.. code-block :: xml

  <?xml version="1.0" encoding="ISO-8859-1"?>
  <opml version="1.0">
    <head>
      <title>geography.opml</title>
      <dateCreated>2006-11-10</dateCreated>
      <dateModified>2006-11-13</dateModified>
      <ownerName>Magellan, Ferdinand</ownerName>
    </head>
    <body>
      <outline text="Africa" type="continent">
        <outline text="Egypt" type="country"/>
        <outline text="Kenya" type="country">
          <outline text="Nairobi" type="city"/>
          <outline text="Mombasa" type="city"/>
        </outline>
        <outline text="Sudan" type="country">
          <outline text="Khartoum" type="city"/>
        </outline>
      </outline>
      <outline text="Asia" type="continent">
        <outline text="China" type="country"/>
        <outline text="India" type="country"/>
        <outline text="Russia" type="country"/>
        <outline text="Mongolia" type="country"/>
      </outline>
      <outline text="Australia" type="continent" population="21 million">
        <outline text="Australia" type="country" population="21 million"/>
      </outline>
      <outline text="Europe" type="continent">
        <outline text="Germany" type="country"/>
        <outline text="France" type="country"/>
        <outline text="Spain" type="country"/>
        <outline text="Italy" type="country"/>
      </outline>
      <outline text="North America" type="continent">
        <outline text="Mexico" type="country" population="108 million" area="1,972,550 sq km">
          <outline text="Mexico City" type="city" population="19 million" timezone="-6 UTC"/>
	  <outline text="Guadalajara" type="city" population="4 million" timezone="-6 UTC"/>
        </outline>
        <outline text="Canada" type="country" population="33 million" area="9,984,670 sq km">
          <outline text="Ottawa" type="city" population="0.9 million" timezone="-5 UTC"/>
          <outline text="Toronto" type="city" population="2.5 million" timezone="-5 UTC"/>
        </outline>
        <outline text="United States of America" type="country"/>
      </outline>
      <outline text="South America" type="continent">
        <outline text="Brazil" type="country" population="186 million"/>
        <outline text="Argentina" type="country" population="40 million"/>
      </outline>
    </body>
  </opml>

Each data item is one of the <outline> tags. Each attribute on the outline acts as a attribute of the data item. For children tags, they are accessed via a special 'children' attribute. So, as expected by dojo.data, everything can be easily accessed via csvStore.getValue's'(), which makes it pluggable into dojo.data aware widgets.

==================
Constructor Params
==================

+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| **Parameter**  | **Required** | **Description**                                                                                | **Since** |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| url            | No           |This optional parameter specifies what URL from which to load the Opmldata Note                 | 1.0       |
|                |              |that this URL is only loaded one time, as this is an in-memory data store.                      |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| data           | No           |A DOM of OPML data to use to populate the store. This parameter can be                          | 1.0       |
|                |              |used instead of *url*. when you wish to load data differently then modify it to fit the expected|           |
|                |              |Opml format.                                                                                    |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| label          | No           |A string that identifies which attribute to treat as the human-readable label. It must match one| 1.0       |
|                |              |of the attributes on the <outline> tags for it to be effective.                                 |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
|urlPreventCache | No           |Flag denoting whether or not browser caching should be avoided.  Defaults to false.             | 1.4       |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+

============
Query Syntax
============

The query syntax used by dojox.data.OpmlStore is identical to the query syntax used by `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_

=============
Query Options
=============

Dojo.data defines support for a 'queryOptions' modifier object that affects the behavior of the query. The two defined options listed by the API are *ignoreCase* and *deep*. OpmlStore supports these options. The affect of these options on a query is defined below.

+------------+------------------------------------------------------------------------------------------------------------------------+
| **Option** | **Result**                                                                                                             |
+------------+------------------------------------------------------------------------------------------------------------------------+
| ignoreCase |The default is **false**. When set to true, the match on attributes is done in a case-insensitive fashion. This means   |
|            |with ignoreCase: true, a query of A* would match *Apple* and *acorn*                                                    |
+------------+------------------------------------------------------------------------------------------------------------------------+
| deep       |Default is *false*. By default, only root outline tags are matched. By setting to true, children tags are also scanned  |
+------------+------------------------------------------------------------------------------------------------------------------------+

========
Examples
========

Connecting OpmlStore to dijit.form.ComboBox
-------------------------------------------

*Note that dijit.form.ComboBox automatically passes the queryOption deep:true. This is because for ComboBox, hierarchy does not make sense, so searching as a flat list is preferable*

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.data.OpmlStore");
      dojo.require("dijit.form.ComboBox");
    </script>

  .. cv :: html 

    <div dojoType="dojox.data.OpmlStore" url="/moin_static163/js/dojo/trunk/release/dojo/dojox/data/tests/stores/geography.xml" jsId="geoStore"></div>
    <div dojoType="dijit.form.ComboBox" store="geoStore" searchAttr="text"></div>


Connecting OpmlStore to dijit.Tree
----------------------------------

*Since Opml data can be hierarchical, the Tree widget is an excellent demo for it. A similar demo can be seen with ItemFileReadStore.*
`here <quickstart/data/usingdatastores/simple>`_

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.data.OpmlStore");
      dojo.require("dijit.Tree");
    </script>

  .. cv :: html 

    <div dojoType="dojox.data.OpmlStore" url="/moin_static163/js/dojo/trunk/release/dojo/dojox/data/tests/stores/geography.xml" jsId="geoStore2" label="text"></div>
    <div dojoType="dijit.tree.ForestStoreModel" jsId="geoModel" store="geoStore2" query="{}" rootId="Geography" rootLabel="Geography"></div>
    <div dojoType="dijit.Tree" model="geoModel"></div>

    
Connecting OpmlStore to dojox.grid.DataGrid
-------------------------------------------

*Note here that as part of the DataGrid definition, the queryOption deep is set true. For the DataGrid, hierarchy here does not make sense*

.. cv-compound ::

  .. cv :: javascript

    <script>
      dojo.require("dojox.grid.DataGrid");
      dojo.require("dojox.data.OpmlStore");

      var layoutGeo = [
        [
          { field: "text", name: "Name", width: 10 },
          { field: "type", name: "Geography Type", width: 10 },
          { field: "population", name: "Population", width: 'auto' }
        ]
      ];
    </script>

  .. cv :: html

    <div dojoType="dojox.data.OpmlStore" url="/moin_static163/js/dojo/trunk/release/dojo/dojox/data/tests/stores/geography.xml" jsId="geoStore3" label="text"></div>

    <div style="width: 400px; height: 300px;">
      <div id="grid" 
        dojoType="dojox.grid.DataGrid" 
        store="geoStore3" 
        structure="layoutGeo" 
        query="{}"
        queryOptions="{'deep':true}" 
        rowsPerPage="40">
      </div>
    </div>

  .. cv:: css

    <style type="text/css">
      @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/resources/Grid.css";
      @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/grid/resources/nihiloGrid.css";

      .dojoxGrid table {
        margin: 0;
      }
    </style>
