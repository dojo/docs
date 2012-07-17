.. _dojo/text:

=========
dojo/text
=========

.. contents ::
   :depth: 2

**dojo/text** is an AMD plugin that loads arbitrary string data from a file and returns it.  It is the replacement for 
:ref:`dojo/cache() <dojo/cache>` from earlier versions of Dojo.  Essentially the :ref:`loader <loader/index>` will 
load a text resource and return it as an argument to the callback function of a ``define()`` or ``require()``.

Usage
=====

Usage require supplying the resource URL to load after the ``!``.  This URL can be expressed in relative terms and 
will assume a root of the Dojo base by default:

.. js ::

	require(["dojo/text!something.html"], function(something){
		// something = contents of something.html
	});

In particular, ``dojo/text`` is used to load Dijit templates, for example:

.. js ::
 
  define(["dojo/_base/declare", "dijit/_Widget", "dojo/text!dijit/templates/Dialog.html"],
  function(declare, _Widget, template){

    return declare(_Widget, {
      templateString: template
    });
  });

Examples
========

.. code-example ::
	:djConfig: async: true, parseOnLoad: false

	Loads and displays ``helloworld.html``.

	.. js ::

		require(["dojo/text!/dojo/helloworld.html", "dojo/dom-construct", "dojo/domReady!"], 
		function(helloworld, domConst){
			domConst.place(helloworld, "output");
		});

	.. html ::

		<div id="output"></div>

See Also
========

* :ref:`dojo/cache() <dojo/cache>`

* :ref:`Dojo AMD Loader <loader/index>`
