.. _dojo/node:

=========
dojo/node
=========

**dojo/node** is a loader plugin that is used to load "native" `node.js <http://nodejs.org/>`_ modules when using the Dojo loader.

Introduction
============

``dojo/node`` simply accesses the native ``require()`` function of node, passing the plugin argument as the parameter.  The plugin will attempt to resolve the requirement in the same way the node.js require would normally operate (e.g. looking in the current path, looking in ``node_modules``, etc.).  The plugin works for both node internal modules as well as external ones.

This allows you to write all of your code in an AMD style, but utilize node modules seamlessly in your code.

Usage
=====

Require the plugin and pass the module name as the plugin argument string.  Paths will be relative to the path of the current path when ``dojo/dojo`` was loaded.

.. js ::

  require(["dojo/node!util"], function(util){
    // Module available as util
  });

Examples
========

The following example would bootstrap Dojo and then load the internal node.js modules ``util`` and ``fs``.

In ``bootstrap.js``:

.. js ::

  dojoConfig = {
    async: true,
    basePath: ".",
    packages: [{
      name: "dojo",
      location: "lib/dojo"
    },{
      name: "dijit",
      location: "lib/dijit"
    },{
      name: "dojox",
      location: "lib/dojox"
    },{
      name: "app",
      location: "lib/app"
    }],
    deps: ["app/src"]
  };

  require("./lib/dojo/dojo.js");

In ``lib/app/src.js``:

.. js ::

  require(["dojo/node!util", "dojo/node!fs"], funciton(util, fs){
    util.puts("I loaded!");
  });

See Also
========

* :ref:`Dojo's Loader <loader/index>`

* `node.js <http://nodejs.org/>`_
