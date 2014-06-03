.. _dojo/parser:

===========
dojo/parser
===========

.. contents ::
    :depth: 3

The Dojo Parser is an optional module which is used to convert specially decorated nodes in the DOM and convert them
into :ref:`Dijits <dijit/index>`, Widgets or other Objects. By `decorated` we mean use of a ``data-dojo-type``
attribute. Any "Class" (or object, such as the ones created by :ref:`dojo.declare <dojo/declare>`) can be instantiated
by using a ``data-dojo-type`` attribute on some node in the DOM, and create a widget out of it.

This is not limited to Dijit, or :ref:`dojo/_base/declare <dojo/_base/declare>` and can instantiate any available Dojo
Class or Module.

Inside your HTML you mark nodes for the parser by setting the ``data-dojo-type`` attribute, to specify the class of the
widget, and other attributes, to specify parameters to the widget.   For example:

.. html ::

  <input data-dojo-type="dijit/form/TextBox" name="nm" value="hello world">

The parser can scan the entire DOM for ``data-dojo-type`` attributes, and create new instances from nodes like this.

The parser also allows function parameters and connections to be done via ``<script>`` tags, for example:

.. html ::

  <div data-dojo-type=...>
    <script type="dojo/connect" data-dojo-event="functionToConnectTo">
      console.log("I will execute in addition to functionToConnectTo().");
    </script>
  </div>

This form of markup is referred to as the "declarative" form of Dojo versus the "programmatic" form. While many
developers find the declarative syntax a very easy way to prototype and start quickly with Dojo, declarative syntax does
have some distinct disadvantages that should be considered when using it in a production application:

* With non-widget objects (e.g. data stores), the only way to utilise them declaratively is to scope them in the global
  namespace (using ``data-dojo-id``). This means when some content is unloaded and the corresponded DOM is destroyed,
  including any widgets referencing it, garbage collection does not kick in, because there is still a reference to the
  object in the global scope. This can inadvertently increase the memory footprint of your application.

* Declarative scripting is created using the ``new Function()`` method under the covers. Depending upon the browser and
  JavaScript engine, there are significant limitations to the engines ability to optimise the code and collapse the
  scope stack of the function. This can inadvertently decrease the performance and increase the memory footprint of your
  application.

* Because of the need to scan the DOM, parse nodes, validate that modules are loaded, etc., the parser will always be
  slower than using a programmatic syntax. Especially with non-modern browsers like IE6, IE7 and IE8, they can be rather
  dramatic performance hits. While in many cases these may not be perceptible to the end user of an application, other
  performance factors can easily build up into what is perceived as a "slow" application and proper consideration should
  be given.

Getting Started
===============

Loading the Parser
------------------

To include the Dojo parser on your page, require the module ``dojo.parser``:

.. js ::

  require(["dojo/parser"], function(parser){
    // write your code here
  });

**Note:** While many examples historically don't expressly require the ``dojo/parser`` because it was required by
:ref:`dijit.Templated <dijit/_Templated>` and :ref:`dijit/_TemplatedMixin <dijit/_TemplatedMixin>`, it is always best to
be explicit about requiring the parser.

Running the Parser
------------------

There are two ways to run the ``dojo/parser``: manually, or during ``onLoad``.

To execute the parser manually, simply call the function ``parse()``:

.. js ::

  require(["dojo/parser"], function(parser){
    parser.parse();
  });

In many situations this can be an over simplification of what you need to have in place for the parser to work
correctly. For example, you often need several other things in place before you can actually effectively parse the
content of a page. You obviously need the DOM to be ready, plus you also need to ensure that ``dojo/hccss`` has run if
you want to ensure accessibility works as designed. A more realistic version would be something like:

.. js ::

  require(["dojo/parser", "dojo/ready"], function(parser, ready){
    ready(function(){
      parser.parse();
    });
  });

To run the parser when your page loads, add a ``data-dojo-config="parseOnLoad: true"`` to your dojo script tag:

.. html ::

  <script type="text/javascript" src="dojo/dojo.js"
      data-dojo-config="parseOnLoad: true"></script>

**Note:** again, don't forget to explicitly require ``dojo/parser`` in this case!
See :ref:`the 1.7 release notes <releasenotes/1.7#parser>` for more details.

Return Results
--------------

Because certain features introduced in Dojo 1.8 can cause the parser to run in an asynchronous fashion, but in Dojo 1.X
there is a need to maintain backwards compatibility, ``dojo/parser::parse()`` returns a combined object that is an array
combined with a promise. When running in sync mode, the array part of the object will contain the instantiated objects.
When running in async mode, the promise part of the object will resolve with an array of instantiated objects when the
parse is finished.

For new development, it is best interact with ``parse()`` as if it was only a promise. For example, to do something with
the instantiated objects, you would want to do something like:

.. js ::

  require(["dojo/parser", "dojo/_base/array"], function(parser, array){
    parser.parse().then(function(instances){
      array.forEach(instances, function(instance){
        // do something with instances
      });
    });
  });

Markup
======

This section discusses how to write markup (HTML) on your page to be interpreted by the parser.

Object Types
------------

The attribute ``data-dojo-type`` is used to specify the type of the object to be instantiated. As of Dojo 1.8, the
parser accepts a Module ID (MID) for the type. Previously it accepted the declared class name of the object. It also
accepts anything that is declared in the global scope. Therefore all the following are valid:

.. js ::

  require(["dojo/parser", "dijit/form/TextBox"], function(parser, TextBox){
    // Globally scope TextBox
    MyTextBox = TextBox;
    
    parser.parse();
  });

.. html ::

  <!-- Dojo 1.8+ Only -->
  <input data-dojo-type="dijit/form/TextBox" type="text" name="dept1" />
  
  <!-- Prior Versions of Dojo -->
  <input data-dojo-type="dijit.form.TextBox" type="text" name="dept2" />
  <input data-dojo-type="MyTextBox" type="text" name="dept3" />

For new development in Dojo 1.8 or later, the MID is the preferred way of referring to a class for instantiation.

When using widgets, you should use the closest native HTML tag that represents the widget. This allows the page to
degrade if something goes wrong, it ensures better a11y, it will layout better while your page is being parsed and it
ensure that native attributes are appropriate for the type of widget you are instantiating.  If you are unsure, the fallback scenario would be a ``<div>``.  Some examples would be:

========================== ==========================
Dijit Type                 HTML Element
========================== ==========================
dijit/form/Button          ``<button type="button">``
dijit/form/TextBox         ``<input type="text" />``
dijit/form/Select          ``<select>``
dijit/form/Form            ``<form>``
dijit/layout/ContentPane   ``<div>``
========================== ==========================

data-dojo-mixins
~~~~~~~~~~~~~~~~

There is another optional parameter introduced in Dojo 1.8 called ``data-dojo-mixins``, which allows dynamic extension
of a class specified in ``data-dojo-type``. Additional classes are specified as a comma separated list. For example, the
following:

.. html ::

  <div data-dojo-type="dojox/treemap/TreeMap" data-dojo-mixins="dojox/treemap/Keyboard, dojox/treemap/DrillDownUp"
    data-dojo-props="store: myStore"></div>

is equivalent to using the following class construction for the ``div``:

.. js ::

  require(["dojo/parser", "dojo/_base/declare", "dojox/treemap/TreeMap", "dojox/treemap/Keyboard",
      "dojox/treemap/DrillDownUp"],
    function(parser, declare, TreeMap, Keyboard, DrillDownUp){
      new declare([TreeMap, Keyboard, DrillDownUp])({ store: myStore });
  });

If the ``data-dojo-type`` is not a class based on :ref:`dojo/_base/declare <dojo/_base/declare>`, the parser will look
for an ``extend()`` method on the ``data-dojo-type`` class object and call it with the list of mixins as parameters in
order to build the composed object. This makes this mechanism compatible with ComposeJS.

.. _dojo/parser#auto-require:

Auto Require
~~~~~~~~~~~~

As of Dojo 1.8, the parser supports auto require. If as the document is being parsed any of the constructors are missing
in either ``data-dojo-type`` or ``data-dojo-mixins`` and that class name looks like a MID (e.g. contains a slash),
the parser will attempt to require in those modules after it has finished scanning the DOM. This means that you do not
explicitly have to require in classes in your declarative markup before the parser is invoked. The following example
demonstrates that feature:

.. code-example ::

  Notice how there is no ``require()`` in this example (or JavaScript code for that matter).

  .. html ::

    <form data-dojo-type="dijit/form/Form">
      <table>
        <tbody>
          <tr>
            <td><label for="field1">Name</label></td>
            <td><input type="text" name="field1" data-dojo-type="dijit/form/TextBox" /></td>
          </tr>
          <tr>
            <td><label for="field2">Password</label></td>
            <td><input type="password" name="field2" data-dojo-type="dijit/form/TextBox" /></td>
          </tr>
        </tbody>
      </table>
      <button type="submit" data-dojo-type="dijit/form/Button">Login</button>
    </form>

While this feature does provide a fair amount of flexibility, developers should be consciously aware when they are not
being explicit about their requirements, as this can have unintended consequences. For example, because the code will
"just work", it does mean that if a build profile is not configured properly, you find yourself in a situation where
your code it requiring in modules that are not part of a layer and reducing the performance of your deployed 
application or your deployed code will not work because it is missing modules that were being auto-required in your 
development environment.

To assist in ensuring that this feature is not used accidently, when ``isDebug`` is set to ``true`` in your 
``dojoConfig``, the ``dojo/parser`` will log warning messages to the console, identifying which modules are being auto-
required.

Developers should give due consideration when they choose to use declarative syntax and not be explicit about their
requirements before invoking ``.parse()``.

.. _dojo/parser#declarative-require:

Declarative Require
-------------------

As of Dojo 1.8, the parser supports a declarative require syntax, so modules can be required declaratively and mapped to
variables in the global scope, without the need of using the ``require()`` function in JavaScript. For example:

.. html ::

  <script type="dojo/require">
    on: "dojo/on",
    registry: "dijit/registry",
    Button: "dijit/form/Button"
  </script>

This would load and map ``dojo/on`` to ``on``, ``dijit/registry`` to ``registry`` and ``dijit/form/Button`` to
``Button`` so the following would be possible, which would dynamically add an event handler to another Dijit Button when
the other one is clicked:

.. html ::

  <button type="button" id="button1" data-dojo-type="Button"></button>
  <button type="button" id="button2" data-dojo-type="Button">
    <span>Click Me!</span>
    <script type="dojo/on" data-dojo-event="click">
      on(registry.byId("button1"), "click", function(){
        console.log("I was clicked!");
      });
    </script>
  </button>

When ``parse()`` is invoked, the parser will scan the DOM, look for the declarative require script blocks, require in
any modules and map them to the variables in the global scope and remove the script blocks from the DOM. It will then
continue with parsing the rest of the DOM and start instantiating the objects.

Because the parser uses the key name to set the object in the global scope, so a key name of ``app.module`` would deep
create an ``app`` object, and then a ``module`` property of the ``app`` object. You will need to escape the key name by
wrapping it in double quotes(``"``) like the following:

.. html ::

  <script type="dojo/require">
    "app.on": "dojo/on",
    "app.registry": "dijit/registry",
    "app.Button": "dijit/form/Button"
  </script>

.. _dojo/parser#parser-parameters:

Parser Parameters
-----------------

Object properties which correspond to native HTML attributes appear directly in the markup. Custom widget parameters are
put into the ``data-dojo-props`` field. For example:

.. html ::

  <!-- Dojo 1.8+ -->
  <input data-dojo-type="dijit/form/TextBox" name="dept"
      data-dojo-props="scrollOnFocus: true"/>

.. html ::

  <!-- Dojo < 1.8 -->
  <input data-dojo-type="dijit.form.TextBox" name="dept"
      data-dojo-props="scrollOnFocus: true"/>

Boolean parameters
~~~~~~~~~~~~~~~~~~

Due to HTML subtleties, for boolean parameters that have a coressponding HTML attribute that are false, it's best not 
to specify the attribute at all. For example, to specify an enabled button (where the ``disabled`` property is 
``false``), simply do not specify anything for ``disabled``:

.. html ::

    <input data-dojo-type="dijit/form/Button">

Further, in standard HTML prior to HTML 5 and as opposed to XHTML, the special parameters ``checked`` and ``disabled``
and ``selected`` should be specified as single keywords without a value:

.. html ::

    <input data-dojo-type="dijit/form/Button" disabled>
    <input data-dojo-type="dijit/form/CheckBox" checked>

In XHTML and HTML 5 they should be specified in the official format of repeating the attribute name as the value:

.. html ::

    <input data-dojo-type="dijit/form/Button" disabled="disabled"/>
    <input data-dojo-type="dijit/form/CheckBox" checked="checked"/>

Although specifying ``disabled="true"`` will disable a widget, note that the following syntax should not be used as it
is unreliable whether it evaluates to true or false:

.. html ::

    <input data-dojo-type="dijit/form/Button" disabled=""/>

Date parameters
~~~~~~~~~~~~~~~

Regardless of the locale of the client or server, dates are specified to the parser in ISO format:

.. html ::

    <div data-dojo-type=... when="2009-1-31"></div>

Incidentally, this is also how dates are returned to the server when a form is submitted.

To specify a value as today's date (or the current time, when specifying a time), use the keyword "now":

.. html ::

    <div data-dojo-type=... when="now"></div>

Function parameters
~~~~~~~~~~~~~~~~~~~

There are two ways to specify a function parameter to a widget, either via an attribute or a script tag (see below). To
specify a function as an attribute you can either specify the name of a function:

.. html ::

  <script>
    function myOnClick(){ ... }
  </script>
  <div data-dojo-type=... data-dojo-props="onClick: myOnClick"></div>

Alternately, you can inline the text of a function:

.. html ::

    <div data-dojo-type=... data-dojo-props="onClick: function(){ alert('I was clicked'); }"></div>

Script Tags
-----------

The parser allows the specification of behaviors through custom types in script blocks to extend and enhance the
functionality of declarative widgets. This is commonly referred to as "declarative scripting". This is done by
specifying a script block that is a direct child of a node with decorate with ``data-dojo-type``. There are different
types of script tags supported:

Changing the Behavior of a Method
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The execute code that changes the behavior of a method, use ``type="dojo/aspect"``. All three forms of advice supported
by :ref:`dojo/aspect <dojo/aspect>` are usable:

.. html ::

  <div data-dojo-type=...>
    <script type="dojo/aspect" data-dojo-advice="after" data-dojo-method="method1" data-dojo-args="e">
      console.log("I ran after!");
    </script>
    <script type="dojo/aspect" data-dojo-advice="around" data-dojo-method="method2" data-dojo-args="origFn">
      return function(){ // Have to act as a function factory
        console.log("I ran before!");
        origFn.call(this); // You have to call the original function
        console.log("I ran after!");
      };
    </script>
    <script type="dojo/aspect" data-dojo-advice="before" data-dojo-method="method3" data-dojo-args="i">
      console.log("I ran before!");
      i++; // Modifying argument
      return [i]; // Returning modified arguments to be used with original function
    </script>
  </div>

**Note** If ``data-dojo-advice`` is omitted, ``"after"`` is assumed.

Execute Code when an Event Occurs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The execute code when an event occurs ``type="dojo/on"`` can be used and it normalises events between DOM and widget
events. It also follows the conventions in :ref:`dojo/on <dojo/on>`:

.. html ::

  <div data-dojo-type=...>
    <script type="dojo/on" data-dojo-event="click" data-dojo-args="e">
      console.log("I was clicked!");
    </script>
  </div>

Execute Code on Change of Property
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To execute code when a value changes for a property for objects that support ``object.watch()`` (
:ref:`dojo/Stateful <dojo/Stateful>`) the ``type="dojo/watch"`` can be used:

.. html ::

  <div data-dojo-type=...>
    <script type="dojo/watch" data-dojo-prop="value" data-dojo-args="prop,oldValue,newValue">
      console.log("Property '"+prop+"' changed from '"+oldValue+"' to '"+newValue+"'");
    </script>
  </div>

The ``.watch()`` function always passes three arguments when it is called, representing the property that change, the
old value and then the new value.

**Note** because ``data-dojo-prop`` attribute was introduced after the attribute changes of 1.6, there is no backwards
support for just ``prop`` as an attribute.

Overriding a Method
~~~~~~~~~~~~~~~~~~~

To fully override a method, the following can be used:

.. html ::

  <div data-dojo-type=...>
    <script type="dojo/method" data-dojo-event="someMethod">
      console.log("I am the override!");
    </script>
  </div>

Execute Code on Instantiation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To execute code on instantiation, use the same format but don't specify an event flag:

.. html ::

    <div data-dojo-type=...>
        <script type="dojo/method">
           console.log("I will execute on instantiation");
        </script>
    </div>

Connecting to a Method
~~~~~~~~~~~~~~~~~~~~~~

*Deprecated*, use ``"dojo/aspect"`` or ``"dojo/on"`` instead.  To connect to a method the following can be used:

.. html ::

  <div data-dojo-type=...>
    <script type="dojo/connect" data-dojo-event="onClick" data-dojo-args="e">
      console.log("I was clicked!");
    </script>
  </div>

Declarative Scripting Arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For functions that take (named) parameters, specify them in an ``data-dojo-args`` attribute. For example, ``onChange()``
gets a value parameter, so to reference it do:

.. html ::

  <div data-dojo-type=...>
    <script type="dojo/aspect" data-dojo-advice="after" data-dojo-event="onChange" data-dojo-args="value">
      console.log("new value is " + value);
    </script>
  </div>

``data-dojo-args`` is a comma separated list of parameter names. This example overrides ``TreeStoreModel``\'s method
``getChildren()``:

.. html ::

  <div data-dojo-type="dijit/tree/TreeStoreModel" store="store">
    <script type="dojo/method" data-dojo-event="getChildren" data-dojo-args="item, onComplete">
      return store.fetch({query: {parent: store.getIdentity(item)}, onComplete: onComplete});
    </script>
  </div>

Changing the Execution Scope of a Declarative Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For functions that need to be executed within a defined context, they can be specified with the ``with`` attribute.  For
example the following will caused the function to be wrapped with the ``myVar``:

.. html ::

  <div data-dojo-type=...>
    <script type="dojo/connect" data-dojo-event="onChange" data-dojo-args="value" with="myVar">
      // ...
    </script>
  </div>

Script Scope
~~~~~~~~~~~~

Note that ``this`` points to the widget object.

.. html ::

  <div data-dojo-type=...>
    <script type="dojo/connect" data-dojo-event="onChange" data-dojo-args="value">
      console.log("onChange for " + this.id);
    </script>
  </div>

Writing widgets
===============

This section discusses how to ensure you can write classes that the parser can understand and instantiate successfully.

Specifying attributes and types
-------------------------------

For backwards compatibility reasons, the parser will scan nodes and their attributes and pass them into the object
constructor. Using non-standard HTML attributes is *deprecated* and will likely be removed in 2.0. Documentation is
provided here for completeness, but any new code development should use ``data-dojo-props`` for passing properties to
the objects constructor.

HTML treats all attributes on nodes as strings. However, when the parser instantiates your nodes, it looks at the
prototype of the class you are trying to instantiate (via ``data-dojo-type`` attribute) and tries to make a "best guess"
at the type of each object attribute. This requires that all attributes you want to be passed in via the parser have a
corresponding attribute in the class you are trying to instantiate, if you are not using ``data-dojo-props``.

Private members (those that begin with an underscore (``_``) ) are not mapped in from the source node.

For example, given the class:

.. js ::

  require(["dojo/_base/declare", "dojo/parser"], function(declare, parser){
    MyCustomType = declare(null, {
      name: "default value",
      value: 0,
      when: new Date(),
      objectVal: null,
      anotherObject: null,
      arrayVal: [],
      typedArray: null,
      _privateVal: 0
    });
    
    parser.parse();
  });

And HTML node:

.. html ::

  <div data-dojo-type="MyCustomType" name="nm" value="5" when="2008-1-1" objectVal="{a: 1, b:'c'}"
       anotherObject="namedObj" arrayVal="a, b, c, 1, 2" typedArray="['a', 'b', 'c', 1, 2]"
       _privateVal="5" anotherValue="more"></div>

The parser would create an object and pass it parameters of:

.. js ::

    {
      name: "nm",                                       // Just a simple string
      value: 5,                                         // Typed to an integer
      when: dojo.date.stamp.fromISOString("2008-1-1");  // Typed to a date
      objectVal: {a: 1, b:'c'},                         // Typed to an object
      anotherObject: dojo.getObject("namedObj"),        // For strings, try getting the object via dojo.getObject
      arrayVal: ["a", "b", "c", "1", "2"],              // When typing to an array, all entries are strings
      typedArray: ["a", "b", "c", 1, 2]                 // To get a "typed" array, treat it like an object instead
    }

Note that ``_privateVal`` is not passed in (since it is private), and ``anotherValue`` is not passed in either (since it
does not exist in the prototype of the class).

The parser automatically will call the ``startup()`` function of all nodes when it is finished parsing (if the function
exists, e.g. for Dijits)

If you don't want to set a default value for an attribute, you can give it an empty value in your prototype.  Empty
values of types are as follows:

* ``NaN`` - an integer

* ``""`` - a string

* ``null`` - an object

* ``[]`` - an array

* ``function(){}`` - a function

* ``new Date("")`` - a date/time

markupFactory()
---------------

As listed above, the parser expects widget constructors to follow a certain format (where the first argument is a hash
of attribute names/values, and the second is the ``srcNodeRef`` which is the node that was parsed to instantiate the
object).

If you are retrofitting an existing class to work with the parser, and the constructor does not follow this format,
simply create a markupFactory method (a static method) which takes those two parameters and creates a new instance of
the widget:

.. js ::

  markupFactory: function(params, srcNodeRef){
    // ...
    return newWidget;
  }

In addition the ``markupFactory`` can be used to allow the widget to do something that the parser doesn't automatically
support, like the parsing of child nodes of the main node.  The developer can then adjust the initialisation parameters
of the widget and pass those to the constructor.  The parser passes the class constructor as the third argument when it
invokes the ``markupFactory``.  For example:

.. js ::

  markupFactory: function(params, srcNodeRef, ctor){
    // ...
    return new ctor(params, srcNodeRef);
  }

This also ensures that subsequent descendant classes that do not override the markupFactory are created properly.

Parser API Notes
================

parse()
-------

Instead of parsing the whole document, you can select a smaller portion of the document by passing the parser the node
that the parsing should start at. This is accomplished by passing the ``rootNode`` argument directly in the ``rootNode``
parameter or the ``args`` parameter:

.. js ::

  require(["dojo/parser", "dojo/dom"], function(parser, dom){
    parser.parse(dom.byId("myDiv"));
  });

.. js ::

  require(["dojo/parser", "dojo/dom"], function(parser, dom){
    parser.parse({
      rootNode: dom.byId("myDiv");
    });
  });

You can specify the base Dojo scope by using the ``scope`` keyword in the arguments.  This will change the parser to
look for ``data-[scope]-*`` instead of the default ``data-dojo-*`` in markup attributes.  For example, the following
would be valid:

.. js ::

  require(["dojo/parser", "dojo/dom"], function(parser, dom){
    parser.parse({
      scope: "myScope"
    });
  });

.. html ::

  <div data-myScope-type="dijit/form/Button" data-myScope-id="button1" 
      data-myScope-params="onClick: myOnClick">Button 1</div>

instantiate()
-------------

You can manually call ``dojo/parser::instantiate()`` on any node - and pass in an additional mixin to specify options,
such as ``data-dojo-type``, etc. The values in the mixin would override any values in your node. For example:

.. html ::

    <div id="myDiv" name="ABC" value="1"></div>

You can manually call the parser's instantiate function (which does the "Magical Typing") by doing:

.. js ::

  require(["dojo/parser", "dojo/dom"], function(parser, dom){
    parser.instantiate([dom.byId("myDiv")], { data-dojo-type: "my/custom/type" });
  });

Calling instantiate in this way will return to you a list of instances that were created. Note that the first parameter
to instantiate is an array of nodes, even if it's one-element you need to wrap it in an array.

You specify that you do not want sub-widgets to be started if you pass ``_started: false`` in your mixin.  For example:

.. js ::

  require(["dojo/parser", "dojo/dom"], function(parser, dom){
    parser.instantiate([dom.byId("myDiv")], { data-dojo-type: "my/custom/type", _started: false });
  });

construct()
-----------

You can manually call ``dojo/parser::construct()`` and will construct a single instance of an object. It takes several
arguments:

========= ========== ===================================================================================================
Argument  Type       Description
========= ========== ===================================================================================================
ctor      Function   The class constructor.
node      DOMNode    This node will be replaced/attached to by the widget.  It can also specify the arguments to pass to
                     ctor.
mixin     Object?    *Optional* A hash that should be mixed into the properties sent to the ctor.
options   Object?    *Optional* A hash of special keyword arguments that are used in the construction of an object.
scripts   DomNode[]? *Optional* Array of ``<script type="dojo/*">`` DOMNodes.  If not specified, will search for 
                     ``<script>`` tags inside node.
inherited Object?    *Optional* A hash of attributes that have been inherited from a ancestor node.
========= ========== ===================================================================================================

Caveats
=======

If you try to parse the same content twice, or parse content mentioning id's of existing widgets, it will cause an
exception about duplicate id's.

Examples
========

.. code-example ::
  :djConfig: parseOnLoad: false

  An example that creates a login form.

  .. js ::

    require(["dojo/parser", "dojo/ready", "dijit/form/Button", "dijit/form/Form", "dijit/form/TextBox"],
    function(parser, ready){
      ready(function(){
        parser.parse();
      });
    });

  .. html ::

    <form type="dijit/form/Form">
      <table>
        <tbody>
          <tr>
            <td><label for="username">Username:</label></td>
            <td><input type="text" name="username" data-dojo-type="dijit/form/TextBox"
                data-dojo-props="placeHolder: 'type in your name'" /></td>
          </tr>
          <tr>
            <td><label for="password">Password:</label></td>
            <td><input type="password" name="password" data-dojo-type="dijit/form/TextBox"
                data-dojo-props="placeHolder: 'enter your password'" /></td>
          </tr>
        </tbody>
      </table>
      <button type="submit" data-dojo-type="dijit/form/Button">Login</button>
    </form>

.. code-example ::

  An example that uses a declarative require and declarative scripting only.

  .. html ::

    <script type="dojo/require">
      on: "dojo/on",
      Button: "dijit/form/Button",
      registry: "dijit/registry",
      domConst: "dojo/dom-construct"
    </script>
    <div id="output"></div>
    <button type="button" data-dojo-type="Button">
      <span>Click Me First!</span>
      <script type="dojo/on" data-dojo-event="click">
        on(registry.byId("clickButton"), "click", function(){
          domConst.place("<p>I was clicked!</p>", "output");
        });
        registry.byId("clickButton").set("label", "Click Me Now!");
        registry.byId("clickButton").set("disabled", false);
        this.set("disabled", true);
      </script>
    </button>
    <button type="button" id="clickButton" data-dojo-type="Button" disabled="disabled">Can't Click Me</button>

.. code-example ::
  :djConfig: parseOnLoad: false, async: true

  An example that uses the parser in an asyncronous fashion and does something with the returned instances.

  .. js ::

    require(["dojo/parser", "dojo/_base/array", "dojo/ready", "dijit/form/Button"],
    function(parser, array, ready){
      ready(function(){
        parser.parse().then(function(instances){
          array.forEach(instances, function(instance){
            instance.set("label", "Click Me!");
            instance.set("disabled", false);
          });
        });
      });
    });

  .. html ::

    <button type="button" data-dojo-type="dijit/form/Button" disabled="disabled">Don't Click Me!</button>
    <button type="button" data-dojo-type="dijit/form/Button" disabled="disabled">Don't Click Me!</button>
    <button type="button" data-dojo-type="dijit/form/Button" disabled="disabled">Don't Click Me!</button>

See also
========

* :ref:`dojo/_base/declare <dojo/_base/declare>` - Dojo's class declaration module

* :ref:`dojo/promise <dojo/promise>` - Dojo's promise (asynchronous communication) package.
