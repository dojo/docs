#format dojo_rst

Writing Your Own Widget
=======================
:Status: Draft
:Version: 1.0
:Authors: Bill Keese

.. contents::
    :depth: 2

It's hard for you to leave well-enough alone. We give you widgets, and now you want to change them. Or you want to make your own.

No problem! Dijit components are extendible, so you can make changes without touching the source code. In a way, you already do this by specifying your own attributes - e.g. sliders that go from 0-100 look different than those going from 0-200. But sometimes you need to go further. Maybe you need to create different behavior for onClick, or substitute a custom validation routine. This kind of modification uses extension points described in Common Attributes. You can add your own code to extension points through markup or through pure JavaScript calls to dojo.declare.

You can also create Dijit classes from scratch. Again, you can do this either through markup - using the dijit.Declaration dojoType attribute - or through dojo.declare.


=================
Extending _Widget
=================

Let's look at how to create a widget from scratch, built directly on top of the _Widget base class.

Technically speaking, the simplest widget you can create is a *behavioral* widget, i.e., a widget that just uses the DOM tree passed into it rather than creating a DOM tree.


.. cv-compound::

  .. cv:: javascript

    <script>
	dojo.require("dijit._Widget");
	dojo.declare("MyFirstBehavioralWidget", [dijit._Widget], {
		buildRendering: function(){
			// the DOM for this widget is whatever the user passed in
			// (user is required to pass something in)
			this.domNode = this.srcNodeRef;
		}
	});
	dojo.require("dojo.parser");
    </script>

  .. cv:: html

	<span dojoType="MyFirstBehavioralWidget">hi</span>

This is merely creating a javascript object (of type MyFirstBehavioralWidget) associated with the <span> in the original markup.

This kind of behavioral widget is useful in some cases, but it has severe limitations, namely that the user must supply a DOM tree.   Normally, widgets create their own DOM tree, replacing a simple <span> or <button> node with a complex DOM tree.  (Note that sometimes, if the user just calls

.. code-block:: javascript

  new MyWidget({})

there isn't even a DOM node to replace at all.


Here's a simple example of a widget that creates it's own DOM tree, and replaces the source DOM node with it's DOM tree:


.. cv-compound::

  .. cv:: javascript

    <script>
	dojo.declare("MyFirstWidget",[dijit._Widget], {
		buildRendering: function(){
			// create the DOM for this widget
			this.domNode = dojo.create("button", {innerHTML: "push me"});
     
				// swap out the original source DOM w/the DOM for this widget
				var source = this.srcNodeRef;
				if(source && source.parentNode){
					source.parentNode.replaceChild(this.domNode, source);
				}
			}
		});
		dojo.addOnLoad(function(){
			// Create the widget programatically
			new MyFirstWidget({}).placeAt(dojo.body());
		});
    </script>

  .. cv:: html

	<span dojoType="MyFirstWidget">i'll be replaced</span>

This widget doesn't do much, but it does show the minimum requirements for a (non-behavioral) widget: create a DOM tree and inserts it into into the document.


Now let's write a widget that performs some javascript.   We'll setup an onclick handler on a button node which will increment a counter:

.. cv-compound::

  .. cv:: javascript

    <script>
		dojo.require("dijit._Widget");
		dojo.declare("Counter", [dijit._Widget], {
			// counter
			_i: 0,
     
			buildRendering: function(){
				// create the DOM for this widget
				this.domNode = dojo.create("button", {innerHTML: this._i});
    
				// swap out the original source DOM w/the DOM for this widget
				var source = this.srcNodeRef;
				if(source && source.parentNode){
					source.parentNode.replaceChild(this.domNode, source);
				}
			},
				 
			postCreate: function(){
			 	// every time the user clicks the button, increment the counter
			 	this.connect(this.domNode, "onclick", "increment");
			 },
				 
			increment: function(){
				 this.domNode.innerHTML = ++this._i;
			}
		});
		dojo.require("dojo.parser");
    </script>

  .. cv:: html

	<span dojoType="Counter"></span>

postCreate() is called after buildRendering() is finished, and is typically used for connections etc. that can't be done until the DOM tree has been created.   We don't put that code into buildRendering() because (as documented below), the _Templated mixin defines buildRendering() for you.


==========
_Templated
==========
OK, we've seen how to create a widget based directly on the _Widget class.  In practice though, this isn't done very often, as it's rather cumbersome to create a complicated DOM structure by hand.   There's a mixin called _Templated that makes all of this easier.  _Templated implements buildRendering() for you, and all you have to do is specify a template i.e, an HTML fragment, that specifies the DOM for the widget.

Let's start using templates by expanding on our counter example, but making it a little more complicated.  The user will be able to specify a label for the button, and the count will be printed after the button.  The user will also be able to specify a label for the counter.

The code to instantiate will look like this:

.. code-block:: html

  <div dojoType="Counter" label="counter label">button label</div>

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

There are a few things to note here:


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


==========
Attributes
==========

All widgets have attributes that can be set on widget creation, or changed during the use of the widget, much like DOM nodes have attributes.   The main difference is that to get/set widget attributes after creation, you need to call the attr() method.

But how do you as a widget writer make your widget have attributes, and handle when the caller changes their value?

Declaring attributes
--------------------
As a widget writer, you need to declare all your widget parameters in the prototype, along with a value.  The value serves both as a default value (if no value was specified on instantiation), and also tells the parser the data type of the parameter.  In this case we are declaring a string parameter:

.. code-block:: javascript

				// text: String
				//		This is an widget parameter
				text: "push me",

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
Commonly, widget attributes are mapped into the widget's DOM.   For example, a TitlePane has a "title" parameter which becomes the innerHTML of the TitlePane.titleNode DOM node (where titleNode is defined as a dojoAttachPoint, see above).

You might think that that mapping would be specified inside of the widget's template, but actually it's specified in something called the "attributeMap".  attributeMap can map widget attributes to DOM node attributes, innerHTML, or class.

That explanation is confusing, but an example will help.  You can see this in action for TitlePane:

.. code-block :: javascript

	attributeMap: dojo.delegate(dijit.layout.ContentPane.prototype.attributeMap, {
		title: { node: "titleNode", type: "innerHTML" }
	}),

The widget's title attribute becomes the innerHTML of TitlePane.titleNode.

(The fancy delegate stuff is so TitlePane's attributeMap has everything that ContentPane has,
plus this additional command.  BTW, that's the reason that attributeMap is declared inside the javascript file rather than as part of the template.)

To map a widget attribute to a DOM node attribute, you do:

.. code-block :: javascript

  attributeMap: {
        disabled: {node: "focusNode", type: "attribute" }
  }),

or alternately just

.. code-block :: javascript

  attributeMap: {
        disabled: "focusNode"
  }),

Both code blocks copy the widget's "disabled" attribute onto the focusNode DOM node in the template.

attributeMap also supports class attributes like iconClass.  See dijit.Menu for an example of all of these in action:

.. code-block :: javascript

	attributeMap: dojo.delegate(dijit._Widget.prototype.attributeMap, {
		label: { node: "containerNode", type: "innerHTML" },
		iconClass: { node: "iconNode", type: "class" },
		disabled: {node: "focusNode", type: "attribute" }
	}),


Substitution variables
----------------------
Note that if you are extending from _Templated, you can alternately use substitution variables like ${label} inside your template.   However, this is not recommended, as (due to implementation details) it only handles setting of the title on widget instantiation.   In other words, myWidget.attr('title', 'My new title') won't work if you use substitution variables.


Custom setters/getters
----------------------

When you have an attribute where setting/getting it is more complicated than attributeMap can
handle, you need to write custom getters/setters for it. The naming convention (for an attribute named foo) is _setFooAttr() and
_getFooAttr(). attr() will automatically detect and call these custom setters.

Custom setters are quite common. Usually you don't need a custom getter (as the default action
for attr('foo') is to access Widget.foo), but for something like Editor where it's impractical to constantly
keep Editor.value up to date, writing a custom _getValueAttr() accessor makes sense.

Life cycle
----------
The custom setters listed above, plus every attribute listed in attributeMap, is applied during
widget creation (in addition to whenever someone calls attr('name', value)).

Note that the application happens after buildRendering() but before postCreate(), so
you need to make sure that none of that code is dependent on something that happens
in postCreate(), or later. This in particular is an issue for any widgets that depend on timeouts
for setup, which need to have special code to handle when _setDisabledAttr() etc. is
called during startup.

==========
Containers
==========

Often a widget declared in markup will have contents, i.e. it will contain some other DOM.   For example:

.. code-block:: html

  <button dojoType="dijit.form.Button">press me</button>

In the common case of non-behavioral widgets (that create a new DOM tree to replace the <button> node in the above example), the widgets need to copy the DOM tree inside of the <button> declaration to the widget's new DOM tree.

The attach point where that input is copied is called containerNode.   In other words, if you check myButton.containerNode.innerHTML in the above example, it will be "press me".

For widgets that mixin _Templated, that is handled automatically, as long as the template specifies dojoAttachPoint="containerNode".


Having said all that, now we define the widget, referencing this template.  We can either reference it via templatePath, or templateString.   For this demo we'll inline it into the javascript with templateString, although usually it's loaded indirectly from a file (via templatePath).

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
   ;
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



===========
More topics
===========

These pages list some more information you need for writing widgets from scratch, or making more complicated changes.

* `Understanding templates <quickstart/writingWidgets/templates>`_  (TODO: remove; already documented above)
* `Declaring a widget programatically <quickstart/writingWidgets/dojoDeclare>`_ (TODO: same here?)
* `Declaring a widget in markup <quickstart/writingWidgets/dijitDeclaration>`_
* `The Widget Life-cycle <quickstart/writingWidgets/lifecycle>`_
* `More on attributes <quickstart/writingWidgets/attributes>`_  (TODO: remove; already documented above)
* `Widgets In Template <quickstart/writingWidgets/widgetsInTemplate>`_
* `Example: File Upload Dialog Box <quickstart/writingWidgets/example>`_
* `Dropdowns and Popups <quickstart/writingWidgets/popups>`_



=============
Accessibility
=============

These pages list how to make your widgets accessible to people with poor/no vision, etc.

* `Creating Accessible Widgets <quickstart/writingWidgets/a11y>`_
* `Testing Widgets for Accessibility <quickstart/writingWidgets/a11yTesting>`_


===
DTL
===

There's an alternate template syntax for widgets that lets you have conditional code in templates and other advanced features.
TODO: add code from <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-dtl>`_. to under here: 

* `DTL <quickstart/writingWidgets/dtl>`_  (currently the top page from the above link has been copied to `DTL_cur <dojox/dtl>`_


==================
Behavioral widgets
==================

TODO: explain behavioral widgets, maybe

1.  adding a confirmation to anchors

   this.connect(this.domNode, "onclick", function(e){ if(!confirm('leave')){ e.preventDefault(); }} }):

2. a second example:  'add icon for external links'

    this.domNode.appendChild(img);

See also first part of `what is a widget <http://dojocampus.org/content/2008/04/20/what-is-a-_widget/>`_, but that's probably too complicated.

========
See also
========

* `Intro to behavioral and templated <http://dojocampus.org/content/2008/04/20/what-is-a-_widget/>`_ - TODO: add specific page about behavioral widgets here
* `The Memo <http://dojotoolkit.org/book/dojo-book-0-4/part-4-more-widgets/writing-your-own-widget/memo>`_ - doc about writing a simple widget from scratch (TODO: move that here?  Before the more complex File Uploading box example?)
