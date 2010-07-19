#format dojo_rst

dojox.widget.SortList
=====================

.. contents::
    :depth: 2

TODO: description





========
Examples
========

Example 1:  Raw, degradable UL list
-------------------------------------------------------
  
.. cv-compound::
  :type: inline
  :height: 300
  :width: 660

	Raw, degradable UL list

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojox.widget.SortList");
    </script>

  The markup has to look as follows
  
  .. cv:: html
    :label: SortList From Markup
    
	<ul dojoType="dojox.widget.SortList" title="SortList From Markup" sortable="false" style="width:200px; height:200px;">
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

  
  .. cv:: css
    :label: A simple set of css rules

    <link rel="stylesheet" type="text/css"
          href="{{ baseUrl }}dojox/widget/SortList/SortList.css">


Example 2:  SortList using a Store
-------------------------------------------------------
.. cv-compound::
  :type: inline
  :height: 300
  :width: 660

	SortList using a Store

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dojox.widget.SortList");
    </script>

  The markup has to look as follows
  
  .. cv:: html
    :label: SortList  and Store From Markup
    
    <div dojoType="dojo.data.ItemFileReadStore"
         url="{{ dataUrl }}dijit/tests/_data/countries.json"
         jsId="stateStore"></div>
    <ul dojoType="dojox.widget.SortList" store="stateStore" title="sortable List" style="width:200px; height:200px;"></ul>

  
  .. cv:: css
    :label: A simple set of css rules

    <link rel="stylesheet" type="text/css"
          href="{{ baseUrl }}dojox/widget/SortList/SortList.css">

TODO: programmatic examples

TODO: demos

========
See Also
========

* `dojox.widget.SortList Test <http://archive.dojotoolkit.org/nightly/dojotoolkit/dojox/widget/tests/test_SortList.html>`_
