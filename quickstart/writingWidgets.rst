#format dojo_rst

Writing Your Own Widget
=======================
:Status: Contributed
:Version: 1.0
:Authors: Bill Keese

.. contents::
	:depth: 2

It's hard for you to leave well-enough alone. We give you widgets, and now you want to change them. Or you want to make your own.

No problem! Dijit components are extendible, so you can make changes without touching the source code. In a way, you already do this by specifying your own attributes - e.g. sliders that go from 0-100 look different than those going from 0-200. But sometimes you need to go further. Maybe you need to create different behavior for onClick, or substitute a custom validation routine. This kind of modification uses extension points described in Common Attributes. You can add your own code to extension points through markup or through pure JavaScript calls to dojo.declare.

You can also create Dijit classes from scratch. Again, you can do this either through markup - using the dijit.Declaration dojoType attribute - or through dojo.declare.


=====================
Starting From Scratch
=====================

Let's look at how to create a widget from scratch.

Technically, a widget can be any javascript "class" that implements a constructor taking parameters and a srcNodeRef (a pointer to a source DOM node).

.. code-block:: javascript

  constructor: function(params, srcNodeRef){
	  console.log("creating widget with params " + dojo.toJson(params) + " on node " + srcNodeRef);
  }


However, all the widgets in dijit and dojox, are built on top of the `dijit._Widget <dijit/_Widget>`_ base class.

The simplest widget you can create is a *behavioral* widget, i.e., a widget that just uses the DOM tree passed into it rather than creating a DOM tree.

.. code-example::
  :djConfig: parseOnLoad: false

  .. javascript::
	:label: The widget definition

	<script>
		dojo.require("dijit._Widget");
		dojo.require("dojo.parser");
	
		dojo.addOnLoad(function(){
			dojo.declare("MyFirstBehavioralWidget", [dijit._Widget], {
					// put methods, attributes, etc. here
			});
	
			// Call the parser manually so it runs after our widget is defined
			dojo.parser.parse();
		});
	</script>

  .. html::
	:label: Instantiate the widget in markup

	<span dojoType="MyFirstBehavioralWidget">hi</span>

This is merely creating a javascript object (of type MyFirstBehavioralWidget) associated with the <span> in the original markup.  You would create a postCreate() method referencing this.domNode that did connections, etc. to do something interesting w/that DOM node.

This kind of behavioral widget is useful in some cases, but it has severe limitations, namely that the widget user must supply a DOM tree.   Normally, widgets create their own DOM tree, replacing a simple <span> or <button> node with a complex DOM tree.  Note that sometimes, if the user just calls

.. code-block:: javascript

	new MyWidget({})

there isn't even a DOM node to replace at all.


Here's a simple example of a widget that creates it's own DOM tree:


.. code-example::
  :djConfig: parseOnLoad: false

  .. javascript::
	:label: Define the widget and instantiate programatically

	<script>
		dojo.require('dijit._Widget');
		// the dojo.parser is only needed, if you want 
		// to instantiate the widget declaratively (in markup)
		// dojo.require("dojo.parser");
	
		dojo.addOnLoad(function(){
			dojo.declare("MyFirstWidget",[dijit._Widget], {
				buildRendering: function(){
					// create the DOM for this widget
					this.domNode = dojo.create("button", {innerHTML: "push me"});
				}
			});
			// Create the widget programatically
			(new MyFirstWidget()).placeAt(dojo.body());
	
			// Call the parser manually so it runs after our widget is defined
			// (only needed if you want to instantiate the widget declaratively (in markup)):
			// dojo.parser.parse();
		});
	</script>

  .. html::
	:label: Nothing to do here

     <!-- Nothing to do here -->

This widget doesn't do much, but it does show the minimum requirement for a (non-behavioral) widget: create a DOM tree.

Now let's write a widget that performs some javascript.   We'll setup an onclick handler on a button node which will increment a counter:

.. code-example::
  :djConfig: parseOnLoad: false

  .. javascript::
	:label: Define the widget

	<script>
		dojo.require("dijit._Widget");
		dojo.require("dojo.parser");
		dojo.addOnLoad(function(){
			dojo.declare("Counter", [dijit._Widget], {
				// counter
				_i: 0,
	
				buildRendering: function(){
					// create the DOM for this widget
					this.domNode = dojo.create("button", {innerHTML: this._i});
				},
	
				postCreate: function(){
					// every time the user clicks the button, increment the counter
					this.connect(this.domNode, "onclick", "increment");
				},
	
				increment: function(){
					this.domNode.innerHTML = ++this._i;
				}
			});

			// Call the parser manually so it runs after our widget is defined
			dojo.parser.parse();
		});
	</script>

  .. html::
	:label: Instantiate declaratively

	<span dojoType="Counter"></span>

postCreate() is called after buildRendering() is finished, and is typically used for connections etc. that can't be done until the DOM tree has been created.


=================
Templated Widgets
=================
OK, we've seen how to create a widget based directly on the `dijit._Widget <dijit/_Widget>`_ class.  In practice though, this isn't done very often, as it's rather cumbersome to create a complicated DOM structure by hand.   There's a mixin called `dijit._Templated <dijit/_Templated>`_ that makes all of this easier.  _Templated implements buildRendering() for you, and all you have to do is specify a template i.e, an HTML fragment, that specifies the DOM for the widget.

Let's start using templates by expanding on our counter example, but making it a little more complicated.  The user will be able to specify a label for the button, and the count will be printed after the button.  The user will also be able to specify a label for the counter.

The code to instantiate will look like this:

.. code-block:: html

  <div dojoType="FancyCounter" label="counter label">button label</div>

The first thing to do is to create some plain HTML to show you want the widget to look like:

.. cv:: html

  <div>
	<button>press me</button>
	&nbsp;count: <span>0</span>
  </div>

Note that the template should have a single top level root node.

Next, we modify the template above with some commands for _Templated:

.. code-block:: html

  <div>
	<button dojoAttachEvent='onclick: increment'>press me</button>
	&nbsp;count: <span dojoAttachPoint='counter'>0</span>"
  </div>

dojoAttachPoint and dojoAttachEvent are documented in detail on the `dijit._Templated <dijit/_Templated>`_ page, but the important thing to note is that dojoAttachEvent sets up a listener for events on the DOM nodes, and dojoAttachPoint sets up a pointer to the DOM nodes.

So, putting that all together the source becomes:

.. code-example::
  :djConfig: parseOnLoad: false

  .. javascript::

	<script type="text/javascript">
		dojo.require("dijit._Widget");
		dojo.require("dijit._Templated");
		dojo.require("dojo.parser");
	
		dojo.addOnLoad(function(){
			dojo.declare("FancyCounter", [dijit._Widget, dijit._Templated], {
				// counter
				_i: 0,
	
				templateString: "<div>" +
					"<button dojoAttachEvent='onclick: increment'>press me</button>" +
					"&nbsp; count: <span dojoAttachPoint='counter'>0</span>" +
					"</div>",
	
				increment: function(){
					this.counter.innerHTML = ++this._i;
				}
			});
	
			// Call the parser manually so it runs after the widget is defined
			dojo.parser.parse();
		});
	</script>

  .. html::

	<span dojoType="FancyCounter">press me</span>

==========
Attributes
==========

All widgets have attributes that can be set on widget creation, or changed during the use of the widget, much like DOM nodes have attributes.   The main difference is that to get/set widget attributes after creation, you need to call the attr() method.

But how do you as a widget writer make your widget have attributes, and handle when the caller changes their value?

Declaring attributes
--------------------
As a widget writer, you need to declare all your widget parameters in the prototype, along with a value.  The value serves both as a default value (if no value was specified on instantiation), and also tells the parser the data type of the parameter.  In this case we are declaring a string parameter:

.. code-block:: javascript

	// label: String
	// Button label
	label: "push me"

.. code-block:: javascript

	// duration: Integer
	// Milliseconds to fade in/out
	duration: 100

.. code-block:: javascript

	// open: Boolean
	// Whether pane is visible or hidden
	open: true

Note that all the documentation for an attribute needs to go next
to the attribute definition, even when you need special documentation about how attr() performs for that
widget.  For example:

.. code-block:: javascript

  // value: Date
  //     The date picked on the date picker, as a Date Object.
  //     When setting the date on initialization (ex: new DateTextBox({value: "2008-1-1"})
  //     or changing it (ex: attr('value', "2008-1-1")), you  can specify either a Date object or
  //     a string in ISO format
  value: new Date()


attributeMap
------------
Often widget attributes are mapped into the widget's DOM.   For example, a TitlePane has a "title" parameter which becomes the innerHTML of the TitlePane.titleNode DOM node (where titleNode is defined as a dojoAttachPoint, see above).

You might think that that mapping would be specified inside of the widget's template, but actually it's specified in something called the "attributeMap".  attributeMap can map widget attributes to DOM node attributes, innerHTML, or class.

That explanation is confusing, but an example will help.

Here's a simple widget for displaying a business card.  The widget has 3 parameters:

  * name
  * phone number
  * CSS class name to apply to name


Each parameter is specified in the attributeMap to say how it relates to the template:

.. code-example::
  :djConfig: parseOnLoad: false

  .. javascript::

	<script type="text/javascript">
		dojo.require("dijit._Widget");
		dojo.require("dijit._Templated");
		dojo.require("dojo.parser");
	
		dojo.addOnLoad(function(){
			dojo.declare("BusinessCard", [dijit._Widget, dijit._Templated], {
				// Initialization parameters
				name: "unknown",
				nameClass: "employeeName",
				phone: "unknown",
	
				templateString:
					"<div class='businessCard'>" +
						"<div>Name: <span dojoAttachPoint='nameNode'></span></div>" +
						"<div>Phone #: <span dojoAttachPoint='phoneNode'></span></div>" +
					"</div>",
	
				attributeMap: {
					name: { node: "nameNode", type: "innerHTML" },
					nameClass: { node: "nameNode", type: "class" },
					phone: { node: "phoneNode", type: "innerHTML" },
				}
			});
	
			// Call the parser manually so it runs after our widget is defined
			dojo.parser.parse();
		});
	</script>

  .. css::

	<style>
		.businessCard {
			border: 3px inset gray;
			margin: 1em;
		}
		.employeeName {
			color: blue;
		}
		.specialEmployeeName {
			color: red;
		}
	</style>

  .. html::

	<span dojoType="BusinessCard" name="John Smith" phone="(800) 555-1212"></span>
	<span dojoType="BusinessCard" name="Jack Bauer" nameClass="specialEmployeeName" phone="(800) CALL-CTU"></span>

Also note how the first example uses the default value of nameClass whereas the second example uses a custom value.   We could also have made a parameter called "class", and mapped it to this.domNode.   Note though that you need to put quotes around the name as it's a reserved word in javascript.

To map a widget attribute to a DOM node attribute, you do:

.. code-block :: javascript

  attributeMap: {
		disabled: {node: "focusNode", type: "attribute" }
  },

or alternately just

.. code-block :: javascript

  attributeMap: {
		disabled: "focusNode"
  },

Both code blocks copy the widget's "disabled" attribute onto the focusNode DOM node in the template.


Custom setters/getters
----------------------

When you have an attribute where setting/getting it is more complicated than attributeMap can
handle, you need to write custom getters/setters for it. The naming convention (for an attribute named foo) is _setFooAttr() and
_getFooAttr(). attr() will automatically detect and call these custom setters.

Here's an example of a behavioral widget (it uses the DOM node from the supplied markup) that has an "open" attribute that controls whether the widget is hidden or shown:

.. code-example::
  :djConfig: parseOnLoad: false

  .. javascript::

	<script type="text/javascript">
		dojo.require("dijit._Widget");
		dojo.require("dijit._Templated");
		dojo.require("dojo.parser");
	
		dojo.addOnLoad(function(){
			dojo.declare("HidePane",[dijit._Widget], {
				// parameters
				open: true,
	
				_setOpenAttr: function(/*Boolean*/ open){
					this.open = open;
					dojo.style(this.domNode, "display", open ? "block" : "none");
				}
			});
	
			// Call the parser manually so it runs after our widget is defined
			dojo.parser.parse();
		});
	</script>

  .. html::

	<span dojoType="HidePane" open="false" jsId="pane">This pane is initially hidden</span>
	<button onclick="pane.attr('open', true);">show</button>
	<button onclick="pane.attr('open', false);">hide</button>

Custom setters are quite common. Usually you don't need a custom getter (as the default action
for attr('foo') is to access Widget.foo), but for something like Editor where it's impractical to constantly
keep Editor.value up to date, writing a custom _getValueAttr() accessor makes sense.

Life cycle
----------
The custom setters listed above, plus every attribute listed in attributeMap, is applied during
widget creation (in addition to whenever someone calls attr('name', value)).

Note that the application happens after ``buildRendering()`` but before ``postCreate()``, so
you need to make sure that none of that code is dependent on something that happens
in postCreate(), or later. This in particular is an issue for any widgets that depend on timeouts
for setup, which need to have special code to handle when _setDisabledAttr() etc. is
called during startup.

eg:

.. code-block :: javascript
  :linenos:

  dojo.declare("my.Thinger", dijit._Widget, {
	
	   value:9,
	
	   buildRendering: function(){
			this.inherited(arguments);
			this.multiplier = 3;
	   },
	
	   _setValueAttr: function(value){
		   this.value = value * this.multiplier;
	   }
	
  });

Had the ``multiplier`` member been defined in ``postCreate``, the initial automated value setting done by attr() would fail.

==========
Containers
==========

Often a widget declared in markup will have contents, i.e. it will contain some other DOM.   For example:

.. code-block:: html

  <button dojoType="dijit.form.Button">press me</button>

In the common case of non-behavioral widgets (that create a new DOM tree to replace the <button> node in the above example), the widgets need to copy the DOM tree inside of the <button> declaration to the widget's new DOM tree.

The attach point where that input is copied is called containerNode.   In other words, if you check myButton.containerNode.innerHTML in the above example, it will be "press me".

For widgets that mixin _Templated, that is handled automatically, as long as the template specifies dojoAttachPoint="containerNode".


Having said all that, now we define the widget, referencing this template via the templateString attribute.   Note that often the template is stored in a file, and in that case templateString should reference the file via `dojo.cache() <dojo/cache>`_.

.. code-example::
  :djConfig: parseOnLoad: false

  .. javascript::

	<script>
		dojo.require("dijit._Widget");
		dojo.require("dijit._Templated");
		dojo.require("dojo.parser");
	
		dojo.addOnLoad(function(){
			dojo.declare("MyButton",[dijit._Widget, dijit._Templated], {
				templateString:
					"<button dojoAttachPoint='containerNode'></button>"
			});
	
			// Call the parser manually so it runs after our widget is defined
			dojo.parser.parse();
		});
	</script>

  .. html::

	<button dojoType="MyButton">press me</button>


=========================
Creating extension points
=========================
Let's say you've written a widget, and when the user clicks on it, something happens. What you want is for the programmer using the widget to be able to either *change* what happens, or have something happen in addition, without having to edit your widget.

To see how to do this, let's see how dijit.form.Button does it for clicking. Note that we need to distinguish between DOM events, which happen on DOM elements; and widget events, which fire when things happen in the widget. (To make this clearer: DOM onclick might fire on elements in your widget, but you would only want the widget's onClick (Note: camelCase!) to fire when your widget is an "enabled" state.)

1. In your template html, on the html elements you want to have fire DOM events, add the attribute dojoAttachEvent as follows. Here's some of the dijit Button's Button.html (with ... where I've left stuff out):

.. code-block :: html

  <div class="dijit dijitReset dijitLeft dijitInline"
	dojoAttachEvent="ondijitclick:_onButtonClick,onmouseenter:_onMouse,onmouseleave:_onMouse,onmousedown:_onMouse"
  ...

The onclick refers to the DOM event on this div. The _onButtonClick refers to a plain old js method in Button.js. By plain old js method, I mean it's not a DOM event handler. It's plain old js, written by some dijit programmer.

2. In your widget's js file, define the plain old js method in dojoAttachEvent, as well as an "extension point" method for your programmer to override.

In Button.js you'll find:

.. code-block :: javascript

  _onButtonClick: function( /*Event*/ e) {
	...// Trust me, _onClick calls this._onClick
  },
  _onClick: function( /*Event*/ e) {
	...
	return this.onClick(e);
  },
  onClick: { // nothing here: the extension point!
   
  }

Here's what's going on. In step 1, all onClick events are redirected to the Button widget's plain old js method _onButtonClick. This in turn calls plain old _onClick, which does stuff, which then calls plain old js method onClick.

_onButtonClick does stuff that must always happen (and calls _onClick()).

_onClick does stuff that must always happen (and calls onClick()).

onClick does nothing! It's empty!

Why? Because it is here that the programmer using the widget can add their own function, for some custom action that should happen every time the DOM event onclick fires.

Step 3 shows how the widget user can add their custom function, without having to edit the widget.

3. In some html page that is using (dojo.require-ing) the dijit Button widget, the user writes this:

.. code-block :: html

  <button dojoType="dijit.form.Button" onClick="alert('Woohoo! I'm using the extension point "onClick"!!');">press me</button>

or alternately this:

.. code-block :: html

  <div dojoType="dijit.form.Button">
	<script type="dojo/method" event="onClick" args="evt">
	  alert('Woohoo! I'm using the extension point "onClick"!!');
	</script>
	 press me
  </div>

Now, whenever someone in the browser clicks on the widget (ok, specifically inside it's top-level div in this case), _onButtonClick and _onClick will execute, but so will the extra alert() statement.

3a. What if you don't want to override the extension point, but want it to execute and then have something custom execute? Just use type="dojo/connect" instead of type="dojo/method".

Closing words:

1) Despite the name of the attribute "event", as in event="onClick", it's value is not a DOM event. Remember: onClick is just a plain old js method. (Dojo is misleading here).

2) How can you find the plain old js methods to override or "connect" to (in the dojo sense of dojo.connect)? Well, that can be painful. First, you have to look inside the widget. Or inside its ancestors/superclasses. Or theirs. Or theirs. Not fun. Second, they aren't named consistenly. Sometimes _ means private, sometimes it means protected. (TODO: move to separate page?)


=============================
Useful self-scoping functions
=============================

There are two sets of functions available to all widgets which simplify connections with other widgets an DOM nodes:

  * connect/disconnect
  * ``New in 1.4`` subscribe/unsubscribe

These functions operate similar to their dojo.* counterparts - with two exceptions.  First, the target function will always be executed within the scope of the widget.  Second, these connections/subscriptions will be cleaned up during the destroy() lifecycle phase of the widget.


=============
Accessibility
=============

These pages list how to make your widgets accessible to people with poor/no vision, etc.

* `Creating Accessible Widgets <quickstart/writingWidgets/a11y>`_
* `Testing Widgets for Accessibility <quickstart/writingWidgets/a11yTesting>`_

============================
Alternate Templating Engines
============================

There's an alternate template syntax for widgets which lets you have conditional code in templates and other advanced features.

* DTL

  * `DTL manual from 1.2 <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-dtl>`_
  * `DTL <quickstart/writingWidgets/dtl>`_  (currently the top page from the above link has been copied to `DTL_cur <dojox/dtl>`_)

* Mustache
  
  * `proposal`

========
See also
========

* `Declaring a widget in markup <dijit/Declaration>`_
* Widgets in templates are discussed on the `dijit._Templated <dijit/_Templated>`_ page
* `Example: File Upload Dialog Box <quickstart/writingWidgets/example>`_
* `Dropdowns and Popups <quickstart/writingWidgets/popups>`_
* `Intro to behavioral and templated <http://dojocampus.org/content/2008/04/20/what-is-a-_widget/>`_
* `The Memo <http://dojotoolkit.org/book/dojo-book-0-4/part-4-more-widgets/writing-your-own-widget/memo>`_ - doc about writing a simple widget from scratch
