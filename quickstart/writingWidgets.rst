.. _quickstart/writingWidgets:

=======================
Writing Your Own Widget
=======================

.. contents ::
    :depth: 2

It's hard for you to leave well-enough alone. We give you widgets, and now you want to change them. Or you want to make your own.

No problem! Dijit components are extensible, so you can make changes without touching the source code. In a way, you already do this by specifying your own attributes - e.g. sliders that go from 0-100 look different than those going from 0-200. But sometimes you need to go further. Maybe you need to create different behavior for onClick, or substitute a custom validation routine. This kind of modification uses extension points described in Common Attributes. You can add your own code to extension points through markup or through pure JavaScript calls to dojo.declare.

You can also create Dijit classes from scratch. Again, you can do this either through markup - using the dijit.Declaration data-dojo-type attribute - or through dojo.declare.


Starting From Scratch
=====================

Let's look at how to create a widget from scratch.

Technically, a widget can be any JavaScript "class" that implements a constructor taking parameters and a srcNodeRef (a pointer to a source DOM node).

.. js ::

  constructor: function(params, srcNodeRef){
      console.log("creating widget with params " + dojo.toJson(params) + " on node " + srcNodeRef);
  }


However, all the widgets in dijit and dojox, are built on top of the :ref:`dijit._WidgetBase <dijit/_WidgetBase>` base class.

The simplest widget you can create is a *behavioral* widget, i.e., a widget that just uses the DOM tree passed into it rather than creating a DOM tree.

.. code-example::
  :djConfig: parseOnLoad: false

  The widget definition

  .. js ::
    
        require([
            "dojo/_base/declare", "dojo/parser", "dojo/ready",
            "dijit/_WidgetBase",
        ], function(declare, parser, ready, _WidgetBase){

            declare("MyFirstBehavioralWidget", [_WidgetBase], {
                // put methods, attributes, etc. here
            });
            ready(function(){
                // Call the parser manually so it runs after our widget is defined, and page has finished loading
                parser.parse();
            });
        });

  Instantiate the widget in markup
 
  .. html ::
  
    <span data-dojo-type="MyFirstBehavioralWidget">hi</span>

This is merely creating a JavaScript object (of type MyFirstBehavioralWidget) associated with the <span> in the original markup.  You would create a postCreate() method referencing this.domNode that did connections, etc. to do something interesting w/that DOM node.

This kind of behavioral widget is useful in some cases, but it has severe limitations, namely that the widget user must supply a DOM tree.   Normally, widgets create their own DOM tree, replacing a simple <span> or <button> node with a complex DOM tree.  Note that sometimes, if the user just calls

.. js ::

    new MyWidget({})

there isn't even a DOM node to replace at all.


Here's a simple example of a widget that creates it's own DOM tree:


.. code-example::
  :djConfig: parseOnLoad: false

  Define the widget and instantiate programmatically.   Note that the parser is not used, since that's only needed if the widget is instantiated through markup.

  .. js ::

        // the parser is only needed, if you want
        // to instantiate the widget declaratively (in markup)
        require([
            "dojo/_base/declare", "dojo/dom-construct", "dojo/ready", "dojo/_base/window",
            "dijit/_WidgetBase",
        ], function(declare, domConstruct, ready, win, _WidgetBase){

            declare("MyFirstWidget", [_WidgetBase], {
                buildRendering: function(){
                    // create the DOM for this widget
                    this.domNode = domConstruct.create("button", {innerHTML: "push me"});
                }
            });

            ready(function(){
                // Create the widget programmatically and place in DOM
                (new MyFirstWidget()).placeAt(win.body());
            });
         });

This widget doesn't do much, but it does show the minimum requirement for a (non-behavioral) widget: create a DOM tree.

Now let's write a widget that performs some JavaScript.   We'll setup an onclick handler on a button node which will increment a counter:

.. code-example ::
  :djConfig: parseOnLoad: false

  Define the widget

  .. js ::

        require([
            "dojo/_base/declare", "dojo/dom-construct", "dojo/parser", "dojo/ready",
            "dijit/_WidgetBase",
        ], function(declare, domConstruct, parser, ready,_WidgetBase){
            declare("Counter", [_WidgetBase], {
                // counter
                _i: 0,
    
                buildRendering: function(){
                    // create the DOM for this widget
                    this.domNode = domConstruct.create("button", {innerHTML: this._i});
                },
    
                postCreate: function(){
                    // every time the user clicks the button, increment the counter
                    this.connect(this.domNode, "onclick", "increment");
                },
    
                increment: function(){
                    this.domNode.innerHTML = ++this._i;
                }
            });

            ready(function(){
                // Call the parser manually so it runs after our widget is defined, and page has finished loading
                parser.parse();
            });
        });

  Instantiate declaratively

  .. html ::

    <span data-dojo-type="Counter"></span>

postCreate() is called after buildRendering() is finished, and is typically used for connections etc. that can't be done until the DOM tree has been created.


Templated Widgets
=================
OK, we've seen how to create a widget based directly on the :ref:`dijit._WidgetBase <dijit/_WidgetBase>` class.  In practice though, this isn't done very often, as it's rather cumbersome to create a complicated DOM structure by hand.   There's a mixin called :ref:`dijit._TemplatedMixin <dijit/_TemplatedMixin>` that makes all of this easier.  _TemplatedMixin implements buildRendering() for you, and all you have to do is specify a template i.e, an HTML fragment, that specifies the DOM for the widget.

Let's start using templates by expanding on our counter example, but making it a little more complicated.  The user will be able to specify a label for the button, and the count will be printed after the button.  The user will also be able to specify a label for the counter.

The code to instantiate will look like this:

.. html ::

  <div data-dojo-type="FancyCounter" data-dojo-props="label:'counter label'">button label</div>

The first thing to do is to create some plain HTML to show you want the widget to look like:

.. html ::

  <div>
    <button>press me</button>
    &nbsp;count: <span>0</span>
  </div>

Note that the template should have a single top level root node.

Next, we modify the template above with some commands for _TemplatedMixin:

.. html ::

  <div>
    <button data-dojo-attach-event='onclick: increment'>press me</button>
    &nbsp;count: <span data-dojo-attach-point='counter'>0</span>"
  </div>

data-dojo-attach-point and data-dojo-attach-event are documented in detail on the :ref:`dijit._TemplatedMixin <dijit/_TemplatedMixin>` page, but the important thing to note is that data-dojo-attach-event sets up a listener for events on the DOM nodes, and data-dojo-attach-point sets up a pointer to the DOM nodes.

So, putting that all together the source becomes:

.. code-example::
  :djConfig: parseOnLoad: false

  .. js ::

       require([
            "dojo/_base/declare", "dojo/parser", "dojo/ready",
            "dijit/_WidgetBase", "dijit/_TemplatedMixin"
        ], function(declare, parser, ready, _WidgetBase, _TemplatedMixin){

            declare("FancyCounter", [_WidgetBase, _TemplatedMixin], {
                // counter
                _i: 0,

                templateString: "<div>" +
                    "<button data-dojo-attach-event='onclick: increment'>press me</button>" +
                    "&nbsp; count: <span data-dojo-attach-point='counter'>0</span>" +
                    "</div>",

                increment: function(){
                    this.counter.innerHTML = ++this._i;
                }
            });

            ready(function(){
                // Call the parser manually so it runs after our widget is defined, and page has finished loading
                parser.parse();
            });
        });

  .. html ::

    <span data-dojo-type="FancyCounter">press me</span>

Attributes
==========

All widgets have attributes that can be set on widget creation, or changed during the use of the widget, much like DOM nodes have attributes.   The main difference is that to get/set widget attributes after creation, you need to call the set() and get() methods.

But how do you as a widget writer make your widget have attributes, and handle when the caller changes their value?

Declaring attributes
--------------------
As a widget writer, you need to declare all your widget parameters in the prototype, along with a value.  The value serves both as a default value (if no value was specified on instantiation), and also tells the parser the data type of the parameter.  In this case we are declaring a string parameter:

.. js ::

    // label: String
    //      Button label
    label: "push me"

.. js ::

    // duration: Integer
    //      Milliseconds to fade in/out
    duration: 100

.. js ::

    // open: Boolean
    //      Whether pane is visible or hidden
    open: true

Note that all the documentation for an attribute needs to go next
to the attribute definition, even when you need special documentation about how set() performs for that
widget.  For example:

.. js ::

  // value: Date
  //     The date picked on the date picker, as a Date Object.
  //     When setting the date on initialization (ex: new DateTextBox({value: "2008-1-1"})
  //     or changing it (ex: set('value', "2008-1-1")), you can specify either a Date object or
  //     a string in ISO format
  value: new Date()


Mapping widget attributes to DOMNode attributes
-----------------------------------------------
Often widget attributes are mapped into the widget's DOM.  For example, the tabIndex setting on a widget should map to that widget's focusNode.

This is not done by putting ${...} strings inside the widget's template.   Actually, most of the time, the mapping happens automatically.   Standard DOMNode attributes like tabindex, alt, aria-labelledby, etc. are copied to the widget's "focusNode" if it's defined, or to the "domNode" otherwise.

You can also explicitly specify mappings to DOM node attributes, innerHTML, or class, overriding the default behavior.   This allows more complicated mappings, like when TitlePane has a "title" parameter which becomes the innerHTML of the TitlePane.titleNode DOM node (where titleNode is defined as a data-dojo-attach-point, see above).

That explanation is confusing, but an example will help.

Here's a simple widget for displaying a business card.  The widget has 3 parameters:

  * name
  * phone number
  * CSS class name to apply to name


Each parameter has a corresponding _setXXXAttr to say how it relates to the template:

.. code-example::
  :djConfig: parseOnLoad: false

  .. js ::

       require([
            "dojo/_base/declare", "dojo/parser", "dojo/ready",
            "dijit/_WidgetBase", "dijit/_TemplatedMixin"
        ], function(declare, parser, ready, _WidgetBase, _TemplatedMixin){

            declare("BusinessCard", [_WidgetBase, _TemplatedMixin], {
                templateString:
                    "<div class='businessCard'>" +
                        "<div>Name: <span data-dojo-attach-point='nameNode'></span></div>" +
                        "<div>Phone #: <span data-dojo-attach-point='phoneNode'></span></div>" +
                    "</div>",

                // Attributes
                name: "unknown",
                _setNameAttr: { node: "nameNode", type: "innerHTML" },

                nameClass: "employeeName",
                _setNameClassAttr: { node: "nameNode", type: "class" },

                phone: "unknown",
                _setPhoneAttr: { node: "phoneNode", type: "innerHTML" }
            });

            ready(function(){
                // Call the parser manually so it runs after our widget is defined, and page has finished loading
                parser.parse();
            });
        });

  .. css ::

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

  .. html ::

    <span data-dojo-type="BusinessCard" data-dojo-props="name:'John Smith', phone:'(800) 555-1212'"></span>
    <span data-dojo-type="BusinessCard" data-dojo-props="name:'Jack Bauer', nameClass:'specialEmployeeName', phone:'(800) CALL-CTU'"></span>


To map a widget attribute to a DOM node attribute, you do:

.. js ::

  _setDisabledAttr: {node: "focusNode", type: "attribute" }


or alternately just

.. js ::

  _setDisabledAttr: "focusNode"

Both code blocks copy the widget's "disabled" attribute onto the focusNode DOM node in the template.

A more complicated example to map an attribute called "img" to this.imageNode.src:

.. js ::

  _setImgAttr: {node: "imageNode", type: "attribute", attribute: "src" }



Custom setters/getters
----------------------

When you have an attribute where setting/getting it is more complicated than an object like above can
handle, you need to write custom getters/setters methods for it.   Like above, the naming convention
(for an attribute named foo) is _setFooAttr() and _getFooAttr().
Set() and get() will automatically detect and call these custom setters.

Here's an example of a behavioral widget (it uses the DOM node from the supplied markup)
that has an "open" attribute that controls whether the widget is hidden or shown:

.. code-example::
  :djConfig: parseOnLoad: false

  .. js ::

       require([
            "dojo/_base/declare", "dojo/dom-style", "dojo/parser", "dojo/ready",
            "dijit/_WidgetBase", "dijit/_TemplatedMixin"
        ], function(declare, domStyle, parser, ready, _WidgetBase, _TemplatedMixin){

            declare("HidePane", [_WidgetBase], {
                // parameters
                open: true,

                _setOpenAttr: function(/*Boolean*/ open){
                    this._set("open", open);
                    domStyle.set(this.domNode, "display", open ? "block" : "none");
                }
            });

            ready(function(){
                // Call the parser manually so it runs after our widget is defined, and page has finished loading
                parser.parse();
            });
        });

  .. html ::

    <span data-dojo-type="HidePane" data-dojo-props="open:false" data-dojo-id="pane">This pane is initially hidden</span>
    <button onclick="pane.set('open', true);">show</button>
    <button onclick="pane.set('open', false);">hide</button>

Custom setters are quite common. Usually you don't need a custom getter (as the default action
for get('foo') is to access Widget.foo), but for something like Editor where it's impractical to constantly
keep Editor.value up to date, writing a custom _getValueAttr() accessor makes sense.

Note in the above example the use of this._set("open", open).    This saves the current value of the
"open" attribute calling any handlers registered with watch(), to monitor attribute changes.

Life cycle
----------
The custom setters specified above (both functions and mappings to DOMNodes) are applied
at widget creation time for every attribute either specified to the widget constructor,
or with a non-null non-blank non-zero default value.

In addition the custom setters are called whenever someone calls set('name', value)).

Note that the application happens after ``buildRendering()`` but before ``postCreate()``, so
you need to make sure that none of that code is dependent on something that happens
in postCreate(), or later. This in particular is an issue for any widgets that depend on timeouts
for setup, which need to have special code to handle when _setDisabledAttr() etc. is
called during startup.

eg:

.. js ::
  
  dojo.declare("my.Thinger", _WidgetBase, {
    
       value:9,
    
       buildRendering: function(){
            this.inherited(arguments);
            this.multiplier = 3;
       },
    
       _setValueAttr: function(value){
           this.value = value * this.multiplier;
       }
    
  });

Had the ``multiplier`` member been defined in ``postCreate``, the initial automated value setting done by set() would fail.

Containers
==========

Often a widget declared in markup will have contents, i.e. it will contain some other DOM.   For example:

.. html ::

  <button data-dojo-type="dijit/form/Button">press me</button>

In the common case of non-behavioral widgets (that create a new DOM tree to replace the <button> node in the above example), the widgets need to copy the DOM tree inside of the <button> declaration to the widget's new DOM tree.

The attach point where that input is copied is called containerNode.   In other words, if you check myButton.containerNode.innerHTML in the above example, it will be "press me".

For widgets that mixin _TemplatedMixin, that is handled automatically, as long as the template specifies data-dojo-attach-point="containerNode".


Having said all that, now we define the widget, referencing this template via the templateString attribute.
Note that often the template is stored in a file,
and in that case templateString should reference the file via the :ref:`dojo.text! <dojo/text>` plugin.

.. code-example::
  :djConfig: parseOnLoad: false

  .. js ::

        require([
            "dojo/_base/declare", "dojo/parser", "dojo/ready",
            "dijit/_WidgetBase", "dijit/_TemplatedMixin"
        ], function(declare, parser, ready, _WidgetBase, _TemplatedMixin){

            declare("MyButton", [_WidgetBase, _TemplatedMixin], {
                    templateString:
                        "<button data-dojo-attach-point='containerNode'></button>"
            });

            ready(function(){
                // Call the parser manually so it runs after our widget is defined, and page has finished loading
                parser.parse();
            });
        });

  .. html ::

    <button data-dojo-type="MyButton">press me</button>


Creating extension points
=========================
Let's say you've written a widget, and when the user clicks on it, something happens. What you want is for the programmer using the widget to be able to either *change* what happens, or have something happen in addition, without having to edit your widget.

To see how to do this, let's see how dijit/form/Button does it for clicking. Note that we need to distinguish between DOM events, which happen on DOM elements; and widget events, which fire when things happen in the widget. (To make this clearer: DOM onclick might fire on elements in your widget, but you would only want the widget's onClick (Note: camelCase!) to fire when your widget is an "enabled" state.)

1. In your template html, on the html elements you want to have fire DOM events, add the attribute data-dojo-attach-event as follows. Here's some of the dijit Button's Button.html (with ... where I've left stuff out):

.. html ::

  <div class="dijit dijitReset dijitLeft dijitInline"
    data-dojo-attach-event="ondijitclick:_onButtonClick,onmouseenter:_onMouse,onmouseleave:_onMouse,onmousedown:_onMouse"
  ...

The onclick refers to the DOM event on this div. The _onButtonClick refers to a plain old js method in Button.js. By plain old js method, I mean it's not a DOM event handler. It's plain old js, written by some dijit programmer.

2. In your widget's js file, define the plain old js method in data-dojo-attach-event, as well as an "extension point" method for your programmer to override.

In Button.js you'll find:

.. js ::

  _onButtonClick: function( /*Event*/ e){
    ... // Trust me, _onClick calls this._onClick
  },
  _onClick: function( /*Event*/ e){
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

3. In some html page that is using (require-ing) the dijit Button widget, the user writes this:

.. html ::

  <button data-dojo-type="dijit/form/Button" onClick="alert('Woohoo! I'm using the extension point "onClick"!!');">press me</button>

or alternately this:

.. html ::

  <div data-dojo-type="dijit/form/Button">
    <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
      alert('Woohoo! I'm using the extension point "onClick"!!');
    </script>
     press me
  </div>

Now, whenever someone in the browser clicks on the widget (ok, specifically inside it's top-level div in this case), _onButtonClick and _onClick will execute, but so will the extra alert() statement.

4. What if you don't want to override the extension point, but want it to execute and then have something custom execute? Just use type="dojo/connect" instead of type="dojo/method".

Closing words:

1) Despite the name of the attribute "data-dojo-event", as in data-dojo-event="onClick", it's value is not a DOM event. Remember: onClick is just a plain old js method. (Dojo is misleading here).

2) How can you find the plain old js methods to override or "connect" to (in the dojo sense of dojo.connect)? Well, that can be painful. First, you have to look inside the widget. Or inside its ancestors/superclasses. Or theirs. Or theirs. Not fun. Second, they aren't named consistently. Sometimes _ means private, sometimes it means protected. (TODO: move to separate page?)


Useful self-scoping functions
=============================

There are two sets of functions available to all widgets which simplify connections with other widgets an DOM nodes:

  * connect/disconnect
  * ``New in 1.4`` subscribe/unsubscribe

These functions operate similar to their dojo.* counterparts - with two exceptions.  First, the target function will always be executed within the scope of the widget.  Second, these connections/subscriptions will be cleaned up during the destroy() lifecycle phase of the widget.


Accessibility
=============

These pages list how to make your widgets accessible to people with poor/no vision, etc.

* :ref:`Creating Accessible Widgets <quickstart/writingWidgets/a11y>`
* :ref:`Testing Widgets for Accessibility <quickstart/writingWidgets/a11yTesting>`

Alternate Templating Engines
============================

There's an alternate template syntax for widgets which lets you have conditional code in templates and other advanced features.

* DTL

  * :ref:`DTL <dojox/dtl>`  (currently the top page from the above link has been copied to)

* Mustache
  
  * `just a proposal`

Common Issues
=============

Having trouble adding support for widgets templates? Ensure that any mixins referenced (_TemplatedMixin, _WidgetsInTemplate) in the dependency list for the widget are listed after the _WidgetBase dependency. This ensures those mixins will extend methods provided by _WidgetBase, rather than the other way round. 

For example, the following sample:

.. js ::

       require(["dojo/_base/declare", "dijit/_WidgetBase", "dijit/_TemplatedMixin"], 
           function(declare, _WidgetBase, _TemplatedMixin){
               declare("SomeModule", [_TemplatedMixin, _WidgetBase], {
               });
        });

Should be changed to: 

.. js ::

       require(["dojo/_base/declare", "dijit/_WidgetBase", "dijit/_TemplatedMixin"], 
           function(declare, _WidgetBase, _TemplatedMixin){
               declare("SomeModule", [_WidgetBase, _TemplatedMixin], {
               });
        });


See also
========

* :ref:`Declaring a widget in markup <dijit/Declaration>`
* Widgets in templates are discussed on the :ref:`dijit._WidgetsInTemplateMixin <dijit/_WidgetsInTemplateMixin>` page
* :ref:`Example: File Upload Dialog Box <quickstart/writingWidgets/example>`
* :ref:`Dropdowns and Popups <dijit/popup>`
