.. _dojox/app/main:

==============
dojox/app/main
==============

:since: V1.7

``dojox/app/main`` (Application) is used to create a ``dojox/app`` Application object using a configuration object.

The Application class itself doesn't currently exist as an exported class. The module only exports a function, which when
provided a configuration file will declare & instantiate the Application class that will actually be used on a page.

.. js ::

	require(["dojox/json/ref", "dojox/app/main", "dojo/text!app/config.json"],function(json, Application, config){
		app = Application(json.parse(config));
	});


