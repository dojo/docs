.. _dijit/_TemplatedMixin:

=====================
dijit/_TemplatedMixin
=====================

:Authors: Peter Higgins, Bill Keese, Nikolai Onken
:Project owner: Bill Keese
:since: V1.7

.. contents ::
   :depth: 2


Introduction
============

dijit/_TemplatedMixin is a mixin for most widgets in dijit.
It takes an HTML template, and creates the widget's DOM tree according to that template.
In other words, it implements buildRendering() for you.

Note that the underscore in the name implies not that _TemplatedMixin is a private class,
but rather that it's a mixin, rather than a widget.

Usage
=====

Mixin dijit/_TemplatedMixin when you declare your widget:

.. js ::

   require(["dojo/_base/declare", "dijit/_WidgetBase", "dijit/_TemplatedMixin"], function(_WidgetBase, _TemplatedMixin)
      declare("MyWidget", [_WidgetBase, _TemplatedMixin], {
         templateString: "<div>hello world</div>"
      });
   });

and then instead of defining buildRendering(), define a ``templateString``.


The template
============

The template is specified in the widget attribute ``templateString``, and points to some HTML w/a `single root node`,
with special attributes on the tags, plus possibly substitution variables, etc.

It can either be specified as a literal string:

.. js ::
 
   require(["dojo/_base/declare", "dijit/_WidgetBase", "dijit/_TemplatedMixin"], function(_WidgetBase, _TemplatedMixin)
      declare("MyWidget", [_WidgetBase, _TemplatedMixin], {
         templateString: "<div>hello world</div>"
      });
   });


or pulled in from a file using the :ref:`dojo/text! <dojo/text>` plugin.

.. js ::
 
    require([
        "dojo/_base/declare",
        "dijit/_WidgetBase", "dijit/_TemplatedMixin", "dojo/text!myNameSpace/templates/MyWidget.html"
    ], function(declare, _WidgetBase, _TemplatedMixin, template){
        declare("MyWidget", [_WidgetBase, _TemplatedMixin], {
            templateString: template,
        });
    });

When using a built or released Dijit tree, the build will ``internStrings``, converting the dojo/text! call
into a literal string, avoiding a network request when users load the widget.

Because ``_TemplatedMixin`` extends :ref:`_AttachMixin <dijit/_AttachMixin>`, the tags in the template can have these special attributes, in addition to typical attributes like class:

  * data-dojo-attach-point
  * data-dojo-attach-event

See the :ref:`_AttachMixin <dijit/_AttachMixin>` documentation for more details.

containerNode
-------------

Often a widget declared in markup will have contents, i.e.
it will contain some other DOM.
For example:

.. html ::

  <button data-dojo-type="dijit/form/Button">press me</button>

If the template defines data-dojo-attach-point="containerNode", the children from the srcNodeRef will be copied to this node.

For example:

.. code-example::
  :djConfig: parseOnLoad: false
  :width: 400
  :height: 250
  :toolbar: versions, dir

  .. js ::

    require([
        "dojo/_base/declare", "dojo/parser",
        "dijit/_WidgetBase", "dijit/_TemplatedMixin", "dojo/domReady!"
    ], function(declare, parser, _WidgetBase, _TemplatedMixin){
        var MyButton = declare("MyButton", [_WidgetBase, _TemplatedMixin], {
            templateString:
                "<button data-dojo-attach-point='containerNode' data-dojo-attach-event='onclick: onClick'></button>",
            onClick: function(evt){
                    alert("Awesome!!");
            }
        });
        parser.parse();
    });

  .. html ::

    <button data-dojo-type="MyButton">press me</button>

Substitution variables
----------------------

A template can also reference substitution variables like ${title}.
${title} references the title attribute of the widget.

However, this is not recommended, as (due to implementation details) it only handles setting of the title on widget instantiation.
In other words, myWidget.set('title', 'My new title') won't work if you use substitution variables.

See the section on "Mapping widget attributes to DOMNode attributes" in
:ref:`Writing Widgets <quickstart/writingWidgets>` for an alternative to substitution variables.


Common Pitfalls
===============

1. Be sure to only have one root node in your template

2. Don't start your template (or end it) with a comment (because that means you technically have two nodes)

3. Avoid a trailing </div> at the end of your template


See also
========

* :ref:`Writing Widgets <quickstart/writingWidgets>`
