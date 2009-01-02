#format dojo_rst

dijit._Templated
================

:Status: Draft
:Version: 1.0
:Project owner: Bill Keese
:Available: since V0.9

.. contents::
   :depth: 2

============
Introduction
============

dijit._Templated is a mixin for most widgets in dijit.  It takes an HTML template, and creates the widget's DOM tree according to that template.  In other words, it implements buildRendering() for you.

Note that the underscore in the name implies not that _Template is a private class, but rather that it's a mixin, rather than a widget.

=====
Usage
=====

Mixin dijit._Templated when you declare your widget:

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   dojo.declare("MyWidget", [dijit._Widget, dijit._Templated], { ... });
 </script>

and then *don't* define buildRendering().

============
The template
============
The template is specified in the widget attribute templatePath or templateString, and points to some HTML w/a single root node, with special attributes on the nodes, plus possibly substitution variables, etc.

The tags in the template can have these special attributes, in addition to typical attributes like class:

  * dojoAttachPoint
  * dojoAttachEvent
  * waiRole
  * waiState

dojoAttachPoint
---------------
In the JavaScript of a widget, you often might wish to refer to some of its html template's dom nodes directly. In this case the widget will need to access the <span> with the count in order to change the value.

You might think the widget author could just use ids in the html template, and then dojo.byId() in the widget's js. But if she does, then if two or more widget instances are created, they'll all have the same ids!  Obviously code will blow up then.

Instead, you the widget author do the following:

1. In your widget template's html, for every node that these variables are supposed to correspond to (eg point to), you add the attribute: dojoAttachPoint="yourVariableNameHere".

2. In your widget's js, you use (without declaring them) variables for these nodes. In this case you will access this.counter.

The reason the variables are undeclared is that when the code in _Templated scans the html in step 1, and it finds the variables in the dojoAttachPoint attribute, it adds those variables to your widget class, dynamically.

dojoAttachEvent
---------------
dojoAttachEvent will automatically setup a connection from an event on the DOM node (onclick in this case) to call a method in the widget (in this case increment().

Here's an example of dojoAttachPoint and dojoAttachEvent:

.. cv-compound::

  .. cv:: javascript

	<script type="text/javascript">
		dojo.require("dijit._Widget");
		dojo.require("dijit._Templated");
		dojo.declare("FancyCounter",
			[dijit._Widget, dijit._Templated], {
				// counter
				_i: 0,

				templateString:
					"<div>" +
						"<button dojoAttachEvent='onclick: increment'>press me</button>" +
						"&nbsp; count: <span dojoAttachPoint='counter'>0</span>" +
					"</div>",
				 
				 increment: function(){
				 	this.counter.innerHTML = ++this._i;
				 }
			});
		dojo.require("dojo.parser");
	</script>

  .. cv:: html

	<span dojoType="FancyCounter">press me</span>


waiRole and waiState
--------------------
These attributes are for accessibility, and define the role of DOM nodes such as "tree".   See `Creating Accessible Widgets <writingWidgets/a11y>`_ for more information.


containerNode
-------------
Often a widget declared in markup will have contents, i.e. it will contain some other DOM.   For example:

.. code-block:: html

  <button dojoType="dijit.form.Button">press me</button>

If the template defines dojoAttachPoint="containerNode", the children from the srcNodeRef will be copied to this node.

For example:

.. cv-compound::

  .. cv:: javascript

    <script>
		dojo.require("dijit._Widget");
		dojo.require("dijit._Templated");
		dojo.declare("MyButton",
			[dijit._Widget, dijit._Templated], {
				templateString:
				    "<button dojoAttachPoint='containerNode'></button>"
			});
		dojo.require("dojo.parser");
    </script>

  .. cv:: html

	<button dojoType="MyButton">press me</button>

Substitution variables
----------------------
A template can also reference substitution variables like ${title}.   ${title} references the title attribute of the widget.

However, this is not recommended, as (due to implementation details) it only handles setting of the title on widget instantiation. In other words, myWidget.attr('title', 'My new title') won't work if you use substitution variables.


widgetsInTemplate
-----------------
If you set widgetsInTemplate to true in your widget you can add dojoType="..." declarations to your widget template.

In that case, the dojoAttachPoint associated with that node will point to a widget, not a DOM node.

Similarly, dojoAttachEvent calls on that node will connect to events on the widgets (like onClick) rather than events on the DOM node (like onclick).

TODO: add example

The widgetsInTemplate feature does not support adding layout widgets as children.  In particular there are issues with startup() and resize() calls to the children.

Also note that a widget's getChildren() method and similar methods will *not* include the widgets declared in the template, but rather just the widgets inside the containerNode.   This is because the widgets declared in the template are internal objects, effectively hidden from widget users.  In other words, only the developer of the widget knows that it internally contains widgets.


========
See also
========

* `Writing Widgets <gettingStarted/writingWidgets>`_
