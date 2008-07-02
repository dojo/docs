#format dojo_rst

dijit.Tree
==========

Tree

Examples
--------

.. codeviewer::

  <script type="text/javascript">
    dojo.require("dojo.data.ItemFileReadStore");
    dojo.require("dijit.Tree");
    dojo.require("dijit.Menu");
  </script>

	<div dojoType="dojo.data.ItemFileReadStore" jsId="continentStore"
		url="http://docs.dojocampus.org/moin_static163/js/dojo/1.1.1/dijit/tests/_data/countries.json"></div>
	<div dojoType="dijit.tree.ForestStoreModel" jsId="continentModel" 
		store="continentStore" query="{type:'continent'}"
		rootId="continentRoot" rootLabel="Continents" childrenAttrs="children"></div>

	<h3>Tree with hardcoded root node (not corresponding to any item in the store)</h3>
	<p>Clicking a folder node will open/close it (openOnclick==true), and clicking a leaf node will popup an alert.</p>
	<div dojoType="dijit.Tree" id="mytree"
		model="continentModel" openOnClick="true">
		<script type="dojo/method" event="onClick" args="item">
			alert("Execute of node " + continentStore.getLabel(item)
				+", population=" + continentStore.getValue(item, "population"));
		</script>

		<script type="dojo/method" event="onOpen" args="item">
			console.log("Open of node " + continentStore.getLabel(item));
		</script>
		<script type="dojo/method" event="onClose" args="item">
			console.log("Close of node " + continentStore.getLabel(item));
		</script>
	</div>

	<ul dojoType="dijit.Menu" id="tree_menu" style="display: none;">
		<li dojoType="dijit.MenuItem" onClick="alert('Hello world');">Enabled Item</li>
		<li dojoType="dijit.MenuItem" disabled="true">Disabled Item</li>
		<li dojoType="dijit.MenuItem" iconClass="dijitEditorIcon dijitEditorIconCut"
			onClick="alert('not actually cutting anything, just a test!')">Cut</li>
		<li dojoType="dijit.MenuItem" iconClass="dijitEditorIcon dijitEditorIconCopy"
			onClick="alert('not actually copying anything, just a test!')">Copy</li>
		<li dojoType="dijit.MenuItem" iconClass="dijitEditorIcon dijitEditorIconPaste"
			onClick="alert('not actually pasting anything, just a test!')">Paste</li>

		<li dojoType="dijit.PopupMenuItem">
			<span>Enabled Submenu</span>
			<ul dojoType="dijit.Menu" id="submenu2">
				<li dojoType="dijit.MenuItem" onClick="alert('Submenu 1!')">Submenu Item One</li>
				<li dojoType="dijit.MenuItem" onClick="alert('Submenu 2!')">Submenu Item Two</li>
				<li dojoType="dijit.PopupMenuItem">
					<span>Deeper Submenu</span>

					<ul dojoType="dijit.Menu" id="submenu4">
						<li dojoType="dijit.MenuItem" onClick="alert('Sub-submenu 1!')">Sub-sub-menu Item One</li>
						<li dojoType="dijit.MenuItem" onClick="alert('Sub-submenu 2!')">Sub-sub-menu Item Two</li>
					</ul>
				</li>
			</ul>
		</li>
		<li dojoType="dijit.PopupMenuItem" disabled="true">

			<span>Disabled Submenu</span>
			<ul dojoType="dijit.Menu" id="submenu3" style="display: none;">
				<li dojoType="dijit.MenuItem" onClick="alert('Submenu 1!')">Submenu Item One</li>
				<li dojoType="dijit.MenuItem" onClick="alert('Submenu 2!')">Submenu Item Two</li>
			</ul>
		</li>
	</ul>
