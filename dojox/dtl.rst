#format dojo_rst

dojox.dtl
=========

:Authors: Neil Roberts
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

The Django Template Language (DTL) uses a system of templates that can be compiled
once and rendered indefinitely afterward. Templates consist of simple tags
and filters.


========
Overview
========

Dojo's implementation of DTL matches Django 0.9. Features from more recent releases of Django are currently
being added. Along with the standard tags and filters, some new ones have been added
that leverage the additional capabilities of the browser.

Within Django, DTL is intended to only handle text.
Dojo's implementation is able to handle HTML which gets parsed to DOM instructions
in addition to text. Actually, the text and DOM portions of dojox.dtl are two separate layers. 
The DOM layer sits on top of the text layer (base). It's been implemented in such a way
that you have little to fear when moving your code from Django to dojox.dtl.
Your existing templates should work, and will benefit from the massive
performance gain of being able to manipulate the DOM, rather than having to do
clunky innerHTML swaps you would have to do with a text-only system. It also
allows for new DOM-centric capabilities.

.. code-example::
  :version: 1.3.2-2.0

  .. javascript::

    <script type="text/javascript">
      dojo.require("dojox.dtl.Inline");
    </script>

  .. html::
 
    <div dojoType="dojox.dtl.Inline" id="inline" context="{items: ['apple', 'banana', 'orange']}">
      <ul>
        {% for item in items %}
          <li>{{ item }}</li>
        {% endfor %}
      </ul>
    </div>


=============
Markup Syntax
=============

Since Dojo implements markup just as it is in Django's implementation, the best place to visit would be `The Django Book`_ or the `Django Template Language Documentation`_.

But in case you are just itching to know what it looks like, it's made up of some simple parts: ``{% tags %}``, ``{{ variables }}``, ``{{ variables|filtered }}`` and ``{{ variables|more:"advanced"|filtering }}``. Sometimes tags have groupings of tags, sometimes they work alone.


=====================
Template Constructors
=====================

We have 2 base constructors when using DTL outside of a widget: ``dojox.dtl.Template`` and ``dojox.dtl.DomTemplate``.

``Template`` works only with text. What this means is that you can't use it to do DOM manipulation, you can only use it to generate text that you might use to set a node's innerHTML.

``DomTemplate`` is an extension to ``Template``, which means in terms of size that it's the full size of ``Template`` plus some more code. But using ``DomTemplate``, you can do direct DOM manipulation. This means that if a node is inside of an ``{% if %}`` block, it will be removed from DOM if the logic is false, and will be added to DOM if the logic is true.

Both of these constructors can take either plain text or a URL.


==============================
Using the Template Constructor
==============================

Creating a New Instance
-----------------------

You can create a new instance of ``dojox.dtl.Template`` using either a URL or a string.

Once you've created an instance of the object (which now contains a compiled version of your template that you can render as many times as you want), you have a few options:

The ``update`` Function
-----------------------

Every ``dojox.dtl.Template`` instance will have an update function. This function will change the innerHTML of a node, or a list of nodes. This function accepts a node, a node ID, or a dojo.query result as its first parameter, and an object or URL as its second parameter, to be used as a context.

The ``render`` function
-----------------------

This works exactly the same as rendering a template in Django.

.. code-example::
  :version: 1.3.2-2.0

  .. javascript::

    <script type="text/javascript">
      dojo.require("dojox.dtl");
      dojo.require("dojox.dtl.Context");

      var template = new dojox.dtl.Template("Hello {{ place }}!");
      var context = new dojox.dtl.Context({
        place: "World"
      });
      console.debug(template.render(context)); // Hello World!
    </script>

Use ``dojo.query``
------------------

With the ``dojo.query`` extension, you don't even need to create a template instance. What this means is that repeatedly rendering a template will be slightly slower, but your code will be more compact.

To use, make sure you require the ``dojox.dtl.ext-dojo.NodeList`` module, which adds the dtl function. It accepts a string or URL as its first parameter, and an object or URL as its second parameter. Like the update function above, it will change the innerHTML values of all nodes in the dojo.query result, using the first parameter as its template and the second parameter as its context.

.. code-example::
  :version: 1.3.2-2.0

  .. javascript::

    <script type="text/javascript">
      dojo.require("dojox.dtl.ext-dojo.NodeList");

      dojo.query(".fruit").dtl("Fruit is: {{ fruit }}", { fruit: "apple" });
    </script>


================
Writing a Widget
================

We'll bypass how to use the raw ``DomTemplate`` object (we'll get into that later) and explain how to write a widget using Dojo's implementation of the Django Template Language.

Both of the solutions covered here work almost exactly like ``dijit._Templated``, which is covered elsewhere in the book. To use the text version, mix in ``dojox.dtl._Templated`` and to use the HTML version, mix in ``dojox.dtl._DomTemplated``.

These objects will use ``templatePath``, ``templateString``, and use the ``dojoAttachPoint`` and ``dojoAttachEvent`` node attributes.

It adds a single function: ``render``. This function is to be used in the event of re-rendering. One of the main reasons for re-render would be if not all data was available during instantiation. The template will be rendered during creation even if you don't call the ``render`` function.

The template will be rendered using the widget object as its context. If you don't want this behavior, you can pass your own context object to the render function.

.. code-example::
  :version: 1.3.2-2.0

  .. javascript::

    <script type="text/javascript">
      dojo.require("dojox.dtl._Templated");

      dojo.declare("demo", [dojox.dtl._Widget, dojox.dtl._Templated] {
        templateString: "<div>I like eating {{ fruit }}</div>",
        postCreate: function(){
          this.fruit = "apple";
          this.render();
        }
      });
    </script>


====================================
Differences with the ``extends`` tag
====================================

In Django, the extends tag looks through the installed applications until it finds the named template. In a browser environment, we don't want to have to go searching for templates, so there has to be a way to reference a specific file, while not changing the markup style of the extends tag.

The "easiest" way to do this is to put an explicit reference to the template. This means that you need to specify a URL in relation to your root page. But doing it like this creates a problem if you want to move around your directory structure, or if a page in a different directory wants to use the template.

Django helps us out by allowing a variable name to be used in the extends tag. What we can do with this, then, is set a variable in the context using ``dojox.moduleUrl``.

If we're using the ``extends`` tag in an HTML environment, there's another factor to consider. Let's say we have a blog and there are two ways of viewing the page: a list view, and a detail view. Both of these views use a parent node that contains the page header, a menu, and a sidebar. We don't want the template system to have to redraw the DOM for their parent template, but how do we indicate that? There are two ways.

The first is to use a string in the ``extends`` tag, outlined in the "easiest" way at the top. Putting "shared:" at the beginning of the string tells the extends tag to reuse the nodes between all other children that also want to share the parent.

The significantly better way is partly outlined in the section above on ``dojo.moduleUrl``. You can use a variable containing a ``dojo.moduleUrl``, but how do you tell the extends tag that you want to share the parent? Instead of just passing a ``dojo.moduleUrl call``, when we have an extends tag that looks like {% extends parent %}, we can use an object with ``url`` and ``shared`` that looks like this:

.. code-example::
  :version: 1.3.2-2.0

  .. javascript::

    new dojox.dtl.Context({
      parent: {
        url: dojo.moduleUrl("mymodule.templates", "template.html"),
        shared: true
      }
    });


=======================================
Differences with the ``Context`` Object
=======================================

Unlike the page serving model of Django, we can keep our ``Context`` objects around between each template render. What we want to be able to do is quickly clone an existing context, and either reduce, or add to, the data in the object. To do this, there are two new functions:

* ``filter``: Just put the keys you want to key in its arguments to get only those keys back in a cloned ``Context``.
* ``extend``: Just pass it an object to get a cloned ``Context`` containing all of the old keys, plus the new ones.

Some new functions are added to allow tags to communicate with the rendering object.

* ``setThis``: Sets the object on which to perform operations. Used by the ``attach``/``dojoAttachPoint`` attribute tag, for example.
* ``getThis``: Used by tags, gets the currently set ``this`` object.

.. _The Django Book: http://www.djangobook.com/en/2.0/chapter04/
.. _DJango Template Language Documentation: http://docs.djangoproject.com/en/1.2/topics/templates/
