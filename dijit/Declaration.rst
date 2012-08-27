.. _dijit/Declaration:

=================
dijit.Declaration
=================

:Author: Bill Keese
:Project owner: Bill Keese
:since: V1.2

.. contents ::
   :depth: 2

Declares a widget from markup.

Introduction
============

Just as there are two ways to create a widget instances - declarative and programmatic - so there are two ways to declare a Dijit class (i.e., a type of widget).
As you might guess, the declarative way is slightly easier.

Usage
=====
To declare your class declaratively, use dijit.Declaration.
Uhhhh, OK, too many "declare"s in that sentence.
It's easier to show than to tell.

Here's an example defining a widget called Employee, and then creating two of those Employee widgets:

.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/Declaration"]);

  .. html ::

    <div data-dojo-type="dijit/Declaration" data-dojo-props="widgetClass:'Employee', defaults:{empid:123, name:''}">
        <span>${name}</span>
        <a href="#update.php?id=${empid}">update</a>
        <a href="#delete.php?id=${empid}">delete</a>
    </div>
    <div data-dojo-type="Employee" data-dojo-props="empid:100, name:'Alan Allen'"></div>
    <div data-dojo-type="Employee" data-dojo-props="empid:101, name:'Bob Brown'"></div>
    <div data-dojo-type="Employee" data-dojo-props="empid:102, name:'Cathy Cameron'"></div>


Note that it's defining two widget parameters:

  * empid: Number
  * name: String

And then it's defining a template

.. html ::
 
 <span>${name}</span>
 <a href="#update.php?id=${empid}">update</a>
 <a href="#delete.php?id=${empid}">delete</a>

And finally that it's using the widget parameters name and empid in the template, as the substitution variables ${name} and ${empid}.

Dijit.Declaration turns this markup into a templated widget class.

The code doesn't display anything itself, so it's best to place it right after the BODY tag before any displayable code.



Methods, data-dojo-attach-point, and data-dojo-attach-event
-----------------------------------------------------------

The example below defines a widget named "HideButton" that will hide itself when clicked, and then creates two HideButtons:

.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/Declaration"]);

  .. html ::
 
    <div data-dojo-type="dijit/Declaration" data-dojo-props="widgetClass:'HideButton'">
        XXX<button data-dojo-attach-event="onclick: myClickHandler" data-dojo-attach-point="containerNode"></button>XXX
       <script type="dojo/method" data-dojo-event="myClickHandler">
           this.domNode.style.display="none";
       </script>
    </div>
    <button data-dojo-type="HideButton">Click to hide</button>
    <button data-dojo-type="HideButton">Click to hide #2</button>


A few things to note here:

   * using the <script type="dojo/method"> tag, you can define methods in the widget
   * data-dojo-attach-event and data-dojo-attach-point work the same as in :ref:`dijit._Templated <dijit/_Templated>`


So in the above example, the data-dojo-attach-event="onclick: myClickHandler" will call myClickHandler()
whenever the button is clicked, and then myClickHandler() will hide the widget.


Extending Other Widgets
-----------------------
Often dijit.Declaration is used to define a widget as an extension of another widget, changing the behavior.

HideButton2 extends HideButton (above) and changes the template (but keeps the onclick handler).
Here we define HideButton2 and then create two HideButton2's:

.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/Declaration"]);

  .. html ::

    <div data-dojo-type="dijit/Declaration" data-dojo-props="widgetClass:'HideButton'">
        XXX<button data-dojo-attach-event="onclick: myClickHandler" data-dojo-attach-point="containerNode"></button>XXX
       <script type="dojo/method" data-dojo-event="myClickHandler">
           this.domNode.style.display="none";
       </script>
    </div>
    <span data-dojo-type="dijit/Declaration" data-dojo-props="widgetClass:'HideButton2', mixins:['HideButton']">
        YYY<button data-dojo-attach-event="onclick: myClickHandler" data-dojo-attach-point="containerNode"></button>YYY
    </span>
    <button data-dojo-type="HideButton2">Hide me extended</button>
    <button data-dojo-type="HideButton2">Hide me extended #2</button>


The mixins attribute tells which classes you widget will be based on.
You can include more than one class here - each separated by commas.
The first class is not technically a mixin - it's the parent class of this new widget.


dojo/aspect
------------

As an alternate to <script type="dojo/method">, you can use <script type="dojo/aspect">.
The latter will additional code rather than overriding an already defined method.

However, you can get the same effect using <script type="dojo/method"> and calling this.inherited(arguments).

An example of dojo/aspect is:

.. html ::
 
    <div data-dojo-type="dijit/Declaration" data-dojo-props="widgetClass:'simpleAdvisedWidget'">
        Just a plain ol' piece of text
        <script type="dojo/aspect" data-dojo-method="startup">
            console.debug("being started");
        </script>
    </div>

Every widget declared with class simpleAdvisedWidget will have the handler connected to it.

Note that dojo/aspect is not suitable for methods that need to return a value.

Notes
=====
- widgetsInTemplate is automatically set to true, so any widgets you place in the template will be automatically filled in.
- If you do not specify mixin, the widget class will be a subclass of :ref:`dijit._Widget <dijit/_Widget>` and mix in :ref:`dijit._Templated <dijit/_Templated>`. If you specify mixin, the first class listed must be a subclass of :ref:`dijit._Widget <dijit/_Widget>`. At least one of the mixins should itself mixin :ref:`dijit._Templated <dijit/_Templated>`, or you should supply :ref:`dijit._Templated <dijit/_Templated>` yourself as a mixin.
- Only one extension point implementation of preamble.
