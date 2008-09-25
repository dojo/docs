#format dojo_rst

Dijit
=====

:Status: Contributed, Draft
:Version: 1.0
:Available: since V0.3

.. contents::
  :depth: 2

*Dijit* is a widget system layered on top of Dojo. If you are new to the whole Dojo experience, Dijit is a good place to start. You can build amazing Web 2.0 GUI's using very little, or no, JavaScript (though having an understanding of JavaScript will take you a long way) 

======
Themes
======

Dijit comes bundled with three themes: Tundra, Soria, and Nihilo. Themes are collections of images and CSS, and brings a common design and color scheme to all the widgets. You can override the theme by container or by element to add nuance and flair. Themes must be included by the inclusion of the theme's root file from the relative position in the source tree:

.. code-block :: html

  <link rel="stylesheet" href="lib/dijit/themes/tundra/tundra.css">

and by the addition of a theme class name on a parent element. By using the ``<body>`` tag, we are able to ensure all widgets in the page have the same CSS rules:

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

To learn more about themes, see `Dijit themes <dijit-themes>`_.


===============
Dijit i18n/a11y
===============

Everything in Dijit is designed to be globally accessible -- to accommodate users with different languages and cultures as well as those with different abilities.  Language translations, bi-directional text, and cultural representation of things like numbers and dates are all encapsulated within the widgets.  Server interactions are done in a way that makes no assumptions about local conventions.  All widgets are keyboard accessible and using the standard Dijit theme, usable in high-contrast mode as well as by screen readers.  These features are baked in so that, as much as possible, all users are treated equally.


============
Dijit Basics
============

You can use Dijit in one of two ways: **declaratively** by using special attributes inside of regular HTML tags, and **programmatically** through JavaScript. You have the same options either way. 

.. code-block :: html
  :linenos:

  dojo.require("dijit.Dialog"); 
  dojo.addOnLoad(function(){  
    var dialog = new dijit.Dialog({ title:"Hello Dijit!" }, "someId");
    dialog.startup();
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

If you need a reference to a the actual Node used to display the widget, Dijit stores it as a property in the instance: ``.domNode``. You can use this property for styling, positioning, or other `DOM manipulation <quickstart/DomManipulation>`_:

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
  
All Dijits follow the same programatic convention. Create a new instance with the JavaScript ``new`` function, pass an object-hash of properties and functions (in this case, title:""), and supply an optional "source node reference". 

.. code-block :: javascript
  :linenos:

  var node = dojo.byId("makeADialog");
  var dialog = new dijit.Dialog({ title:"From Source Node" }, node);
  dialog.show();

This will cause the creator to use the node with id="makeADialog", and turn it into a `Dialog <dijit/Dialog>`_. You can pass a node refernece directly (as seen above), or simply pass a string id. Either way, the reference passes through dojo.byId:

.. code-block :: javascript
  :linenos:

  var dialog = new dijit.Dialog({ title:"From Source byId" }, "makeADialog");
  dialog.show();


==========
Attributes
==========

Widgets have initialization parameters and attributes that can be read/write after initialization.
In general it's the same list, although certain attributes (like id and type) can only be set
during initialization.

This basically mirrors have vanilla HTML DOM nodes work, although the syntax is a bit different.
Specifically, to get/set attributes after initialization, you need to use the attr() method:

.. code-block :: javascript

  // set title
  myTitlePane.attr('title', 'hello world');

  // find out if button is disabled
  var dis = myButton.attr('disabled');

  // set to the current date
  myDateTextBox.attr('value', new Date());

It also supports a hash API like dojo.attr(), for setting multiple attributes:

.. code-block :: javascript

  myInput.attr({ tabIndex: 3, disabled: true, value: 'hi'});


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

note that the original button node is thrown away, after scanning the node for attribute settings and innerHTML.
The new DOM automatically replaces the old button node.

However, there's another type of widget called a "behavioral widget" that merely modifies the original node (called the srcNodeRef).

When using behavioral widgets, you need to specify a source DOM node for them to operate on.  For example:

.. code-block :: javascript

   new dojox.widget.FishEyeLite({...}, "mySourceDom");

This comes naturally if you are instantiating from markup.  For example, a behavioral widget to add a confirm dialog to an anchor might be used like this:

.. code-block :: html

   <a href="..." dojoType="dojoc.widget.ConfirmAnchor">

Dijit doesn't have any behavioral widgets, given that it's meant to be able to be used in a purely programmatic setting (without requiring the developer to create any skeletal sourceDOM nodes), but it is a useful paradigm for some applications.
