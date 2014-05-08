.. _dojox/mobile/templating-mobile-widgets:

===============================
Templating dojox/mobile widgets
===============================

.. contents ::
    :depth: 2

Introduction
============

The templating mechanism is a feature of dijit widgets which take an HTML template and 
create the widget's DOM tree according to that template. For details,
see :ref:`dijit/_TemplatedMixin <dijit/_TemplatedMixin>` and the tutorial 
`Creating Template-based Widgets <http://dojotoolkit.org/documentation/tutorials/1.8/templated/>`_.

Differently than the dijit widgets, the dojox/mobile widgets do not inherit from 
``dijit/_TemplatedMixin``. However, a subset of the widgets can be templated by 
subclassing them and adding the inheritance from ``dijit/_TemplatedMixin`` (and from
``dijit/_WidgetsInTemplateMixin`` if the template contains widgets).

The following dojox/mobile widgets support templating:

* ``Button`` (mandatory attach point in the template for the property ``containerNode``)
* ``CheckBox`` (no mandatory attach point)
* ``Heading`` (optional attach points for the properties ``labelNode`` and ``labelDivNode``)
* ``ListItem`` (mandatory attach point for the property ``labelNode``)
* ``RadioButton`` (no mandatory attach point)
* ``Slider`` (mandatory attach point for the properties ``focusNode``, ``valueNode``, 
  ``relativeParent``, ``progressBar``, ``touchBox``, ``handle``)
* ``Switch`` (mandatory attach point for the properties ``inner``, ``left``, ``right``, 
  ``knob``, ``input``)
* ``ToggleButton`` (mandatory attach point for the property ``containerNode``)
* ``View`` (no mandatory attach point).

Examples of templates for all the widgets which support templating can be found 
in the directory ``dojox/mobile/tests/templates`` (these templates are used in 
``dojox/mobile/tests/templatestest_Templated-widgets.html``).


Examples
========

Example: templated dojox/mobile/ListItem
----------------------------------------

In this example, the template does not contains widgets. Hence, the templated
subclass of ``ListItem`` extends ``dijit/_TemplatedMixin`` but does not need to
extend ``dijit/_WidgetsInTemplateMixin``. Note also that, in this example, 
the template defines an attach point for ``ListItem``'s ``labelNode`` property. 
Thanks to that, if the ``label`` property of the ``ListItem`` is set, 
the ``innerHTML`` of the ``labelNode`` element of the template is automatically
set to the value of the ``label`` property. Additionally, the template uses
the variable substition mechanism for embedding content depending on the value 
of a (custom) ``myProp`` property.

.. code-example::
  :type: inline
  :djconfig: async: true, parseOnLoad: true
  :width: 600
  :height: 400
  :version: 1.9
  :theme: deviceTheme

  .. js ::

	var template =
		"<div>" +
		"	Text from template. Embeds text from the label property:" + 
		"	<div data-dojo-attach-point='labelNode'></div>" +
		"	and also from the custom property myProp: ${myProp}" +
		"</div>";
	
	// Templated widget class (used in markup)
	var TemplatedListItem;
	
	require([
		"dojox/mobile/parser",
		"dojox/mobile",
		"dojox/mobile/compat",
		"dojo/_base/declare",
		"dijit/_TemplatedMixin",
		"dojox/mobile/ListItem"
	], function(parser, mobile, compat, declare, TemplatedMixin, ListItem){
	
		TemplatedListItem = declare( 
			[ListItem, TemplatedMixin], {
				label: "My label",
				myProp: "default value of myProp",
				templateString: template
			}
		);
	});
	
  .. html ::
	
	<div data-dojo-type="dojox/mobile/View">
		<h1 data-dojo-type="dojox/mobile/Heading"
			data-dojo-props="label: 'Templated ListItem'"></h1>
		<ul data-dojo-type="dojox/mobile/RoundRectList"
			data-dojo-props="variableHeight: true">
			<li data-dojo-type=TemplatedListItem
				data-dojo-props="label: 'Apple'">
			</li>
			<li data-dojo-type=TemplatedListItem
				data-dojo-props="label: 'Banana', myProp: 'custom value of myProp'">
			</li>
			<li data-dojo-type=TemplatedListItem
				data-dojo-props="label: 'Cherry'">
			</li>
		</ul>
	</div>

Example: templated dojox/mobile/Heading
---------------------------------------

In the following example, the template contains widgets. Hence, the templated
subclass of ``Heading`` also extends ``dijit/_WidgetsInTemplateMixin``, in addition
to ``dijit/_TemplatedMixin``. Note also that, in this example, the template defines
attach points for ``Heading``'s ``backButton``, ``labelNode``, and ``labelDivNode`` 
properties.

.. code-example::
  :type: inline
  :djconfig: async: true, parseOnLoad: true
  :width: 600
  :height: 400
  :version: 1.9
  :theme: deviceTheme

  .. js ::


	var template =
		"<div class='mblHeading mblHeadingCenterTitle'>" +
		"	<span data-dojo-type='dojox/mobile/ToolBarButton'" +
		"		data-dojo-attach-point='backButton'" +
		"		data-dojo-props='arrow: \"left\", back: false, transitionDir: -1'>" +
		"	</span>" +
		"	<ul data-dojo-type='dojox/mobile/TabBar'" +
		"		style='float:right;'" +
		"		data-dojo-props='barType:\"segmentedControl\", selectOne:false'>" +
		"		<li data-dojo-type='dojox/mobile/TabBarButton'" +
		"			data-dojo-props='icon:\"mblDomButtonWhiteUpArrow\"'></li>" +
		"	<li data-dojo-type='dojox/mobile/TabBarButton'" +
		"		data-dojo-props='icon:\"mblDomButtonWhiteDownArrow\"'></li>" +
		"	</ul>" +
		"	<span class='mblHeadingSpanTitle'" +
		"		data-dojo-attach-point='labelNode'>" +
		"	</span>" +
		"	<div class='mblHeadingDivTitle'" +
		"		data-dojo-attach-point='labelDivNode'>" +
		"	</div>" +
		"</div>";
	
	require([
		"dojox/mobile/parser",
		"dojox/mobile",
		"dojox/mobile/compat",
		"dijit/_TemplatedMixin",
		"dijit/_WidgetsInTemplateMixin",
		"dojox/mobile/TabBar", // preload the widget modules used in the template
		"dojox/mobile/TabBarButton",
		"dojox/mobile/ToolBarButton",
		"dojox/mobile/Heading"
	]);
	
  .. html ::
	
	<div data-dojo-type="dojox/mobile/View">
		<h1 data-dojo-type="dojox/mobile/Heading"
			data-dojo-props="label: 'Templated Heading', back: 'Back', templateString: template"
			data-dojo-mixins="dijit/_TemplatedMixin, dijit/_WidgetsInTemplateMixin">
		</h1>
		<ul data-dojo-type="dojox/mobile/RoundRectList">
			<li data-dojo-type="dojox/mobile/ListItem"
				data-dojo-props="label: 'Apple'">
			</li>
			<li data-dojo-type="dojox/mobile/ListItem"
				data-dojo-props="label: 'Banana'">
			</li>
			<li data-dojo-type="dojox/mobile/ListItem"
				data-dojo-props="label: 'Cherry'">
			</li>
		</ul>
	</div>

See also
========

* `Creating Template-based Widgets <http://dojotoolkit.org/documentation/tutorials/1.8/templated/>`_ (tutorial).
* For other examples of templated mobile widgets, see ``dojox/mobile/tests/test_Templated-widgets.html``.
