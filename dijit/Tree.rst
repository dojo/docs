#format sphinx_rst

dijit.Tree
==========

Examples
--------

.. codeviewer::

  <script type="text/javascript">
    dojo.require("dijit.Tree");
  </script>

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
