#format dojo_rst

The Dojo Parser
===============

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Nathan Toone, Bill Keese, kolban

.. contents::
    :depth: 2

The Dojo Parser is an optional module which is used to convert specially decorated nodes in the DOM and convert them into `Dijits <dijit>`_. By `decorated` we mean use of a `dojoType` attribute. Any "Class" (or object, such as the ones created by `dojo.declare <dojo/declare>`_) can be instantiated by using a `dojoType` attribute on some node in the DOM, and create a widget out of it.

This is not limited to Dijit, or `dojo.declare <dojo/declare>`_. 

Loading the Parser
------------------

To include the Dojo parser on your page, require the module `dojo.parser`:

.. code-block :: javascript

  dojo.require("dojo.parser");

``note:`` dijit._Templated require()'s dojo.parser, so a lot of examples don't include this step (dijit._Templated is loaded by most every Dijit). It is always safer to explicitly `require <dojo/require>`_ the module than to assume it has been loaded.

Running the Parser
------------------

There are two ways to run the dojo.parser: manually, or before onLoad.

To execute the parser manually, simply call the function ``parse``:

.. code-block :: javascript
  
  dojo.parser.parse();

To run the parser when your page loads, add a djConfig="parseOnLoad: true" to your dojo script tag:

.. code-block :: html

		<script type="text/javascript" src="dojo/dojo.js"
			djConfig="parseOnLoad: true"></script>


Setting the parser behavior
---------------------------

``todoc: parseOnLoad`` parseOnLoad:false by default, parseOnLoad:true optional, parseOnLoad:true makes addOnLoad call after parsing. howto set parseOnLoad

``NEW in 1.3:``  Beginning in release 1.3 of dojo, you can manually call dojo.parser.instantiate on any node - and pass in an additional mixin to specify options, such as dojoType, etc.  The values in the mixin would override any values in your node.  For example:

.. code-block :: html

  <div id="myDiv" name="ABC" value="1"></div>

You can manually call the parser's instantiate function (which does the "Magical Typing") by doing:

.. code-block :: javascript

  dojo.parser.instantiate([dojo.byId("myDiv")], {dojoType: "my.custom.type"});

Calling instantiate in this way will return to you a list of instances that were created.  Note that the first parameter to instantiate is an array of nodes...even if it's one-element you need to wrap it in an array

``NEW in 1.4:``  You specify that you do not want subwidgets to be started if you pass _started: false in your mixin.  For example:

.. code-block :: javascript

  dojo.parser.instantiate([dojo.byId("myDiv")], {dojoType: "my.custom.type", _started: false});

``todoc: scoping a parser call to node by stringId|domNode``

Parser syntax
=============
Inside your HTML you mark nodes for the parser by setting dojoType, to specify the class of the widget, and other attributes (to specify parameters to the widget.   For example:

.. code-block :: html

  <input dojoType="dijit.form.TextBox" name="nm" value="hello world">


The parser will scan the entire DOM for ``dojoType`` attributes, and create new instances from nodes like this.

Boolean parameters
------------------

Due to HTML subtleties, for boolean parameters that are false, it's best not to specify the attribute at all.   For example, to specify an enabled button (where the `disabled` property is false), simply don't specify anything for disabled:

.. code-block :: html

  <input dojoType="dijit.form.Button">

Further, in standard HTML (as opposed to XHTML), the special parameters `checked` and `disabled` and `selected` should be specified as single keywords without a value:

.. code-block :: html

  <input dojoType="dijit.form.Button" disabled>
  <input dojoType="dijit.form.CheckBox" checked>

In XHTML they should be specified in the official format of repeating the attribute name as the value:

.. code-block :: html

  <input dojoType="dijit.form.Button" disabled="disabled"/>
  <input dojoType="dijit.form.CheckBox" checked="checked"/>

Although specifying disabled="true" will disable a widget, note that the following syntax should not be used as it's unreliable whether it evaluates to true or false:

.. code-block :: html

  <input dojoType="dijit.form.Button" disabled=""/>


Date parameters
---------------
* Regardless of the locale of the client or server, dates are specified to the parser in ISO format:

.. code-block :: html

  <div dojoType=... when="2009-1-31"></div>

Incidentally, this is also how dates are returned to the server when a form is submitted.


* To specify a value as today's date (or the current time, when specifying a time), use the keyword "now":

.. code-block :: html

  <div dojoType=... when="now"></div>


Type parameter
--------------
The parameter named `type` must always be specified for a dijit.form.Button widget.   Although the default value of `type` for a dijit.form.Button is "button", if no type is specified then IE8 (and other newer browsers) will interpret the type as "submit".

.. code-block :: html

  <button dojoType="dijit.form.Button" type="button">hello world</button>


This is because in the newest version of the HTML specification, the default `type` value for <button> nodes is "submit", not "button".


Function parameters
-------------------
There are two ways to specify a function parameter to a widget, either via an attribute or a script tag (see below).   To specify a function as an attribute you can either specify the name of a function:

.. code-block :: html

  <script>
     function myOnClick(){ ... }
  </script>
  <div dojoType=... onClick="myOnClick"></div>


Alternately, you can inline the text of a function:

.. code-block :: html

  <div dojoType=... onClick="alert('I was clicked');"></div>


Script tags
-----------
Functional parameters can also be specified via script tags embedded inside the widget (as a direct child of the node with dojoType specified).  There are three types of script tags supported:

*Connect to a function*:

To perform a dojo.connect() on a method in a widget, use type="dojo/connect" inside a script node:

.. code-block :: html

    <div dojoType=...>
        <script type="dojo/connect" event="functionToConnectTo">
           console.log("I will execute in addition to functionToConnectTo().");
        </script>
    </div>

*Override a function*:

Sometimes you need to override a function in a widget.   Most commonly that happens when you need to specify a function that returns a value.   (The value returned from dojo.connect()'d functions is ignored.)

In that case use the type="dojo/method" syntax:

.. code-block :: html

    <div dojoType=...>
        <script type="dojo/method" event="functionToOverride">
           console.log("I will execute instead of functionToOverride().");
        </script>
    </div>


*Execute code on instantiation*:

To execute code on instantiation, use the same format but don't specify an event flag:

.. code-block :: html

    <div dojoType=...>
        <script type="dojo/method">
           console.log("I will execute on instantiation");
        </script>
    </div>


*Arguments*:

For functions that take (named) parameters, specify them in an `args` attribute.  For example, onChange() gets a value argument, so to reference it do:

.. code-block :: html

    <div dojoType=...>
        <script type="dojo/connect" event="onChange" args="value">
           console.log("new value is " + value);
        </script>
    </div>

`args` is a comma separated list of attribute names.

*this*:

Note that `this` points to the widget object.

.. code-block :: html

    <div dojoType=...>
        <script type="dojo/connect" event="onChange" args="value">
           console.log("onChange for " + this.id);
        </script>
    </div>


Writing widgets
===============

HTML sets all attributes on nodes as strings.  However, when the parser instantiates your nodes, it looks at the prototype of the class you are trying to instantiate (via dojoType attribute) and trys to make a "best guess" at what type your value should be.  This requires that all attributes you want to be passed in via the parser have a corresponding attribute in the class you are trying to instantiate.

Private members (those that begin with an underscore (_) ) are not mapped in from the source node.

For example, given the class:

.. code-block :: javascript

  dojo.declare("my.custom.type", null, {
    name: "default value",
    value: 0,
    when: new Date(),
    objectVal: null,
    anotherObject: null,
    arrayVal: [],
    typedArray: null,
    _privateVal: 0
  });

And HTML node:

.. code-block :: html

  <div dojoType="my.custom.type" name="nm" value="5" when="2008-1-1" objectVal="{a: 1, b:'c'}" 
         anotherObject="namedObj" arrayVal="a,b,c,1,2" typedArray="['a','b','c',1,2]"
         _privateVal="5" anotherValue="more"></div>

The parser would create an object and pass it paramaters of:

.. code-block :: javascript

  {
    name: "nm",                                 // Just a simple string
    value: 5,                                   // Typed to an integer
    when: dojo.date.stamp.fromISOString("2008-1-1"); // Typed to a date
    objectVal: {a: 1, b:'c'},                   // Typed to an object
    anotherObject: dojo.getObject("namedObj"),  // For strings, try getting the object via dojo.getObject
    arrayVal: ["a","b","c","1","2"],            // When typing to an array, all entries are strings
    typedArray: ["a", "b", "c", 1, 2]           // To get a "typed" array, treat it like an object instead
  }

Note that _privateVal is not passed in (since it is private), and anotherValue is not passed in either (since it does not exist in the prototype of the class).

The parser automatically will call the startup() function of all nodes when it is finished parsing (if the function exists, ie for dijit widgets)

If you don't want to set a default value for an attribute, you can give it an empty value in your prototype.  Empty values of types are as follows:

  * NaN = an integer
  * "" = a string
  * null = an object
  * [] = an array
  * function(){} = a function
  * new Date("") = a date/time




Caveats
=======

``todoc: re-parsing, duplicate id's``

Examples
========

Load some HTML content from a `remote URL <quickstart/ajax>`_, and convert the nodes decorated with ``dojoType``'s into widgets:

.. code-block :: javascript

  dojo.xhrGet({
    url: "widgets.html",
    load: function(data){
        dojo.byId("container").innerHTML = data;
        dojo.parser.parse("container");
    }
  });

Delay page-level parsing until after some custom code (having set parseOnLoad:false):

.. code-block :: javascript

  dojo.require("dojo.parser");
  dojo.addOnLoad(function(){
       // do something();
       dojo.parser.parse();
  });



See Also
========

- `Understanding The Parser <http://dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/understanding-parser>`_ - Part of "The book of Dojo 0.9"
- `Introduction to the Parser <http://dojocampus.org/content/2008/03/08/the-dojo-parser/>`_
