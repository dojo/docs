.. _dijit/RadioMenuItem:

===================
dijit.RadioMenuItem
===================

.. contents ::
    :depth: 2

The RadioMenuItem is a radio-button-like menu item for toggling on/off.
It's meant to be used in a group, where only one item in the group is selected at a time.

A user defined event function, onChange, is used to handle check/uncheck events.


Examples
========

This menu has two groups of radio buttons:

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/DropDownMenu", "dijit/RadioMenuItem", "dijit/MenuSeparator"]);

  .. html ::


	<div id="menu" data-dojo-type="dijit/DropDownMenu">
		<div id="g1r1" data-dojo-id="g1r1" data-dojo-type="dijit/RadioMenuItem"
			 data-dojo-props="group: 'g1'">red</div>
		<div id="g1r2" data-dojo-id="g1r2" data-dojo-type="dijit/RadioMenuItem"
			 data-dojo-props="group: 'g1', checked:true">yellow</div>
		<div id="g1r3" data-dojo-id="g1r3" data-dojo-type="dijit/RadioMenuItem"
			 data-dojo-props="group: 'g1'">green</div>
		<div data-dojo-type="dijit/MenuSeparator"></div>
		<div id="g2r1" data-dojo-id="g2r1" data-dojo-type="dijit/RadioMenuItem"
			 data-dojo-props="group: 'g2'">small</div>
		<div id="g2r2" data-dojo-id="g2r2" data-dojo-type="dijit/RadioMenuItem"
			 data-dojo-props="group: 'g2', checked:true">normal</div>
		<div id="g2r3" data-dojo-id="g2r3" data-dojo-type="dijit/RadioMenuItem"
			 data-dojo-props="group: 'g2'">large</div>
	</div>

See also
========

* :ref:`dijit/CheckedMenuItem <dijit/CheckedMenuItem>` - for menu items that are independently checked/unchecked
