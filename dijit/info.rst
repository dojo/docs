## page was renamed from dijit
#format dojo_rst

Dijit
=====

:Authors: Peter Higgins, Bill Keese, Tobias Klipstein, Nikolai Onken, Craig Riecke,

.. contents::
    :depth: 2

*Dijit* is a widget system layered on top of Dojo. If you are new to the whole Dojo experience, Dijit is a good place to start. You can build amazing Web 2.0 GUI's using very little, or no, JavaScript (though having an understanding of JavaScript will take you a long way, as will a good understanding of HTML). 

======
Themes
======

Dijit comes bundled with four themes: Claro (new in Dojo 1.5), Tundra, Soria, and Nihilo. Themes are collections of images (icons and background images) and CSS, and brings a common visual style and color scheme to all the widgets. You can override the theme by container or by widget element to add nuance and flair. Themes must be included by the inclusion of the theme's root file from the relative position in the source tree:

.. code-block :: html

  <link rel="stylesheet" href="lib/dijit/themes/tundra/tundra.css">

and by the addition of a theme class name on a parent element. By using the ``<body>`` tag, we are able to ensure all widgets in the page have the same CSS rules (some widgets like `Dialog <dijit/Dialog>`_ intentionally attach themselves to the ``<body>`` element, so no styling is present if the class identifier is on some child node):

.. code-block :: html

  <html>
  <head>
      <title>Hello, Dijit</title>
      <link rel="stylesheet" href="lib/dijit/themes/tundra/tundra.css">
      <script src="lib/dojo/dojo.js"></script>
      <script type="text/javascript">
         dojo.require("dijit.Dialog");
      </script>
  </head>
  <body class="tundra">
      <h1>Hello, Dijit</h1>
  </body>
  </html>

It is recommended you include the theme CSS file **before** ``dojo.js`` to avoid any potential latency issues.

To learn more about themes, see `Dijit Themes and Theming <dijit-themes>`_.


===============
Dijit i18n/a11y
===============

Everything in Dijit is designed to be globally accessible -- to accommodate users with different languages and cultures as well as those with different abilities.  Language translations, bi-directional text, and cultural representation of things like numbers and dates are all encapsulated within the widgets.  Server interactions are done in a way that makes no assumptions about local conventions.  All widgets are keyboard accessible and using the standard Dijit theme, usable in high-contrast mode as well as by screen readers.  These features are baked in so that, as much as possible, all users are treated equally.


============
Dijit Basics
============

You can use Dijit in one of two ways: **declaratively** by using special attributes inside of regular HTML tags, and **programmatically** through JavaScript (you are welcome to mix-and-match the two styles as you see fit). You have the same options either way. 

.. code-block :: html
  :linenos:

  dojo.require("dijit.Dialog"); 
  dojo.addOnLoad(function(){
    // create a "hidden" Dialog:
    var dialog = new dijit.Dialog({ title:"Hello Dijit!" }, "someId");
    dialog.startup();

    // Hint: In order to open the dialog, you have to call 
    // dialog.show();
  });

is identical to: 

.. code-block :: html
  :linenos:

  <script type="text/javascript">
     dojo.require("dijit.Dialog");
  </script>
  <div dojoType="dijit.Dialog" title="Hello Dijit!" id="someId"></div>

The declarative method requires you include the `dojo.parser <dojo/parser>`_ and have either ``djConfig.parseOnLoad`` set to true, or you manually call ``dojo.parser.parse()`` when you would like the widgets (dijits) to be created.

**note:** Dijit uses a special function for access, `dijit.byId() <dijit/byId>`_ ... This is **not** the same as `dojo.byId <dojo/byId>`_, which works exclusively on DomNodes. Dijit stores all active widgets in the `dijit.registry <dijit/registry>`_, and uses id's as unique qualifiers. dijit.byId returns the instance (widget) from a passed ID, allowing you access to all the methods and properties within:

.. code-block :: html
  :linenos:

  <script type="text/javascript">
     dojo.addOnLoad(function(){
         // dojo.byId("foobar") would only be a normal domNode. 
         var myDialog = dijit.byId("foobar");
         // .attr() is only available in 1.2; For previous versions, use .setContent("<p>replaced!</p>");
         myDialog.attr("content", "<p>I've been replaced!</p>"); 
         myDialog.show();
     });
  </script>
  <div id="foobar" dojoType="dijit.Dialog" title="Foo!">
     <p>I am some content</p>
  </div> 

If you need a reference to a the actual Node used to display the widget, Dijit stores it as a property in the instance: ``.domNode``. You can use this property for styling, positioning, or other `DOM manipulation <quickstart/dom>`_:

.. code-block :: javascript
  :linenos:

  var thinger = dijit.byId("foobar");
  dojo.place(thinger.domNode, dojo.body(), "last");
  // functionally equilivant to:
  // dojo.body().appendChild(thinger.domNode);

When creating widgets programatically, pass an id:"" parameter:

.. code-block :: javascript
  :linenos:

  var dialog = new dijit.Dialog({
     id:"myDialog",
     title:"Programatic"
  });
  dialog.startup();
  // compare them:
  console.log(dijit.byId("myDialog") == dialog);

Otherwise, a unique ID will be generated for you:

.. code-block :: javascript
  :linenos:

  var dialog = new dijit.Dialog({ title:"No ID" })
  console.log(dialog.id); 
  
All Dijits follow the same programmatic convention. Create a new instance with the JavaScript ``new`` function, pass an object-hash of properties and functions (in this case, title:""), and supply an optional "source node reference". 

.. code-block :: javascript
  :linenos:

  var node = dojo.byId("makeADialog");
  var dialog = new dijit.Dialog({ title:"From Source Node" }, node);
  dialog.show();

This will cause the creator to use the node with id="makeADialog", and turn it into a `Dialog <dijit/Dialog>`_. You can pass a node reference directly (as seen above), or simply pass a string id. Either way, the reference passes through dojo.byId:

.. code-block :: javascript
  :linenos:

  var dialog = new dijit.Dialog({ title:"From Source byId" }, "makeADialog");
  dialog.show();

Locating Widgets
----------------

There are many ways to locate a widget in a page, and access a reference to that Widget. Widget's are Objects: collections of attributes and DomNode references. Once you have a reference to a widget, you can use that object (or any of its member properties) through that widget. There are three "main" ways to access a widget:

The simplest way to access a widget is `dijit.byId <dijit/byId>`_. When the widget is created, if the Node used to create the widget (eg: srcNodeRef) had a DOM attribute ``id``, that becomes the widget's id in the `dijit.registry <dijit/registry>`_.

With the following markup:

.. code-block :: html
  :linenos:
 
  <div id="myDialog" dojoType="dijit.Dialog" title="A Dialog"><p class="innerContent">Content</p>/div>

The Dialog instance would be available through the byId call to `myDialog`:

.. code-block :: javascript
  :linenos:

  dijit.byId("myDialog").show(); // show my dialog instance

If the ID is unknown for some reason, the function `dijit.getEnclosingWidget <dijit/getEnclosingWidget>`_ can be used by passing any child DOM Node reference. Again using the above markup, if we pass a reference to the ``p`` element inside the widget to ``getEnclosingWidget``, we will again be returned a reference to the Dialog:

.. code-block :: javascript
  :linenos:

  var node = dojo.query("p.innerContent")[0]; // a domNode found by query
  var w = dijit.getEnclosingWidget(node); // find the widget this node is in
  w.show();

The last, most common method, is a lot like ``getEnclosingWidget``, though it only works if the node passed is the widget's ``.domNode`` member (aka: the top-level node in the template, or the node used to create the widget instance):

.. code-block :: javascript
  :linenos:

  var w = dijit.byId("myDialog");
  var node = w.domNode; // this is a bad example, but illustrates the relationship
  var widget = dijit.byNode(node); // now, w == widget 
  widget.show(); 

Note: it typically doesn't take that many lines to use `dijit.byNode <dijit/byNode>`_, this was a crafted example to illustrate the relationship between widgets and its ``domNode`` property. Most typically one would use ``byNode`` in some kind of event handler outside of the widget code:

.. code-block :: javascript
  :linenos:

  dojo.connect(someNode, "onclick", function(e){
      var w = dijit.byNode(e.target); 
      if(w){ w.show(); }
  });

There are other ways of accessing and manipulating widgets, mostly involving the `dijit.registry <dijit/registry>`_, a collection of all widgets active on a page. 

==========
Attributes
==========

Widgets have initialization parameters and attributes that can be read/write after initialization.
In general it's the same list, although certain attributes (like id and type) can only be set
during initialization.

This basically mirrors how vanilla HTML DOM nodes work, although the syntax is a bit different.
Specifically, to get/set attributes after initialization, you need to use the ``attr()`` method:

.. code-block :: javascript

  // set title
  myTitlePane.attr('title', 'hello world');

  // find out if button is disabled
  var dis = myButton.attr('disabled');

  // set to the current date
  myDateTextBox.attr('value', new Date());

It also supports a hash API like `dojo.attr() <dojo/attr>`_, for setting multiple attributes:

.. code-block :: javascript

  myInput.attr({ tabIndex: 3, disabled: true, value: 'hi'});

Common Attributes of Dijits
---------------------------

There are several attributes common to (most) all Dijit instances. These appear as members to a widget instance, and can be accessed once you have a reference to the widget by one of the methods mentioned above.  Some of the more popular are:

* .domNode - The top-level node in the widget. All widgets have a DOM Node attached to them, either through the srcNodeRef passed during instantiation, or a one created by the widget framework when declaring one programatically. This is a `real` DOM Node, and is common in all Dijits. If you wish to show or hide a widget, for example, you would modify the CSS property ``display`` for the .domNode:

.. code-block :: javascript
 :linenos:

  // hide a widget with id="myThiner"
  dojo.style(dijit.byId("myThinger").domNode, "display", "none"); 

* .containerNode - If a widget uses a template to create complex markup and has inner markup to be displayed within the widget, the containerNode member is a reference to the node where the content was moved to. For example with a `dijit.Dialog <dijit/Dialog>`_ only the surrounding domNode is used to create the widget, and any contents of that node are set inside the template's `containerNode`. When using .attr() to set and load content, this is the node that will be targeted for that content.

* declaredClass - this is actually a relic of `dojo.declare <dojo/declare>`_, which is how widgets are defined. The declaredClass is a string equal to the fully qualified name of the widget class.

.. code-block :: javascript
 :linenos:

  var dialog = new dijit.Dialog({ title:"foo" }, "bar");
  dialog.declaredClass == "dijit.Dialog" // true

==================
Behavioral widgets
==================

In general, widgets create their own DOM structure.  For example,

.. code-block :: javascript

  var b = new dijit.form.Button({label: "press me"})

will create a new widget, where b.domNode can be inserted into the document at the appropriate point.

When instantiated declaratively,

.. code-block :: html

   <button dojoType="dijit.form.Button">press me</button>

Note that the original button node is thrown away, after scanning the node for attribute settings and innerHTML.
The new DOM automatically replaces the old button node.

However, there's another type of widget called a "behavioral widget" that merely modifies the original node (called the ``srcNodeRef``).

When using behavioral widgets, you need to specify a source DOM node for them to operate on.  For example:

.. code-block :: javascript

   new dojox.widget.FishEyeLite({...}, "mySourceDom");

This comes naturally if you are instantiating from markup.  For example, a behavioral widget to add a confirm dialog to an anchor might be used like this:

.. code-block :: html

   <a href="..." dojoType="dojoc.widget.ConfirmAnchor">

Dijit doesn't have any behavioral widgets, given that it's meant to be able to be used in a purely programmatic setting (without requiring the developer to create any skeletal ``sourceDOM`` nodes), but it is a useful paradigm for some applications, and is supported by Dijit. 
