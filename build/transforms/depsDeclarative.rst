.. _build/transforms/depsDeclarative:

===============
depsDeclarative
===============

:Author: Kitson Kelly

.. contents ::
  :depth: 2

Scans appropriately tagged resources for any declarative module dependencies and adds them to a layer.  This is designed to specifically compliment the :ref:`dojo/parser <dojo/parser>` features of auto-require and declarative require.

Description
===========

Modules or resources tagged with ``declarative`` will be scanned for their declarative dependencies.  Then each layer of the build will be inspected for the module/resource and be replaced with the appropriate dependencies.

Using the auto-require feature, but not building your dependencies into a layer could dramatically decrease the performance of your production application.  This provides you a mechanism to use the feature without needing to worry about explicitly requiring your modules in JavaScript.  For example if you have the following resource of ``index.html`` in your application:

.. html ::

  <div data-dojo-type="dijit/layout/ContentPane">
    <button type="button" data-dojo-type="dijit/form/Button">Click Me!</button>
  </div>

The ``dojo/parser`` will automatically load ``dijit/layout/ContentPane`` and ``dijit/form/Button`` if they are not 
already loaded.  If you then, in your build profile, tag the resource as declarative:

.. js ::

  resourceTags: {
    declarative: function(filename){
      return /\.htm(l)?$/.test(filename); // tags any .html or .htm files as declarative
    }
  }

And then include it in a layer (like your ``dojo/dojo`` one):

.. js ::

  layers: {
    "dojo/dojo": {
      include: [ "dojo/dojo", "app/index.html" ],
      customBase: true,
      boot: true
    }
  }

Then you will get a built layer that includes ``dijit/layout/ContentPane`` and ``dijit/form/Button`` plus all the 
necessary dependencies.  The name of the file to be scanned for dependencies needs to be a resolvable Module ID (MID) 
by the builder, which usually means that the file is within a package and identified in your package map within the 
build profile, for example, in the above situation, you might have a ``packages`` property of:

.. js ::

  packages:[{
    name: "dojo",
    location: "../dojo"
  },{
    name: "dijit",
    location: "../dijit"
  },{
    name: "dojox",
    location: "../dojox"
  },{
    name: "app",
    location: "./app"
  }]

It is worthy to note that the builder will not "build" your resources into the layer, like if you used the 
``dojo/text`` plugin, where the resource would be loaded and in-lined into the layer, it simply scans the resource for 
dependencies.

The transform also supports the declarative require syntax.  Therefore if you have something like:

.. html ::

  <script type="dojo/require">
    on: "dojo/on"
  </script>

And that resource is also tagged and included in a layer, the ``dojo/on`` module would be added as a dependency.

See Also
========

* :ref:`dojo/parser <dojo/parser>` - The Dojo declarative syntax parser.
