.. _dojox/widget/SortList:

=====================
dojox.widget.SortList
=====================

.. contents ::
    :depth: 2

Converts an unordered-list into a sortable scrollable pane. 

Examples
========

Raw, degradable UL list
-----------------------
  
.. code-example ::
  :type: inline
  :height: 300
  :width: 660

  Raw, degradable UL list

  .. js ::

        dojo.require("dojox.widget.SortList");

  The markup has to look as follows
  
  .. html ::
    
    <ul data-dojo-type="dojox.widget.SortList" title="SortList From Markup" data-dojo-props="sortable:false" style="width:200px; height:200px;">
        <li>one</li>
        <li>two</li>
        <li>three</li>
        <li>four</li>
        <li>five</li>
        <li>six</li>
        <li>four</li>
        <li>five</li>
        <li>six</li>
        <li>four</li>
        <li>five</li>
        <li>six</li>
        <li>four</li>
        <li>five</li>
        <li>six</li>
    </ul>

  
  A simple set of css rules 
  
  .. css ::

    <link rel="stylesheet" type="text/css" href="{{ baseUrl }}dojox/widget/SortList/SortList.css">


SortList using a Store
----------------------
.. code-example ::
  :type: inline
  :height: 300
  :width: 660

  SortList using a Store

  .. js ::

        dojo.require("dojo.data.ItemFileReadStore");
        dojo.require("dojox.widget.SortList");

  The markup has to look as follows
  
  .. html ::
    
    <div data-dojo-type="dojo.data.ItemFileReadStore"
         data-dojo-props="url:{{ dataUrl }}dijit/tests/_data/countries.json'"
         data-dojo-id="stateStore"></div>
    <ul data-dojo-type="dojox.widget.SortList" data-dojo-props="store:stateStore" title="sortable List" style="width:200px; height:200px;"></ul>

  
  A simple set of css rules
  
  .. css ::
    

    <link rel="stylesheet" type="text/css"
          href="{{ baseUrl }}dojox/widget/SortList/SortList.css">

TODO: programmatic examples

TODO: demos

See Also
========

* `dojox.widget.SortList Nightly Test <http://archive.dojotoolkit.org/nightly/dojotoolkit/dojox/widget/tests/test_SortList.html>`_
