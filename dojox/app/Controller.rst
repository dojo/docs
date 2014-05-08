.. _dojox/app/Controller:

====================
dojox/app/Controller
====================

:since: V1.8

The Controller module provides a base Class to control the application by binding events on application's root domNode.
Several controllers required by the framework are implemented in ``dojox/app/controllers`` package:

* ``dojox/app/controllers/Load`` controller: load view templates and view definitions
* ``dojox/app/controllers/Transition`` controller: respond to "startTransition" event and do transition between views
* ``dojox/app/controllers/Layout`` controller: perform views layout
* :ref:`dojox/app/controllers/History <dojox/app/controllers/History>` controller: maintain application's history. This is based on HTML5 history APIs and will not work on platforms that do not support it like IE, Android 3 & 4, iOS4, etc.
* :ref:`dojox/app/controllers/HistoryHash <dojox/app/controllers/History>` controller: maintain application's history. This is based on URL hash and has limitation if refresh the browser and back to an URL which out of current application's history stack.

In the previous release the “dojox/app/controllers/Load”, “dojox/app/controllers/Transition” and “dojox/app/controllers/Layout” were automatically loaded, that is no longer the case, with 1.9 you must have them listed to include them.

A developer using the dojox/app framework can define additional custom controller by extending the base class (``dojox/app/Controller``)
and specifying them in the application configuration file. The events binding to application's root domNode is done by default.
A developer can use Controller's bind() method to bind event to document, window or ``dojo/Evented`` object if needed.

.. js ::

  define(["dojo/_base/lang", "dojo/_base/declare"], function(lang, declare){

	return declare("myApp.myController", Controller, {

		constructor: function(app, events){
			// summary:
			//		bind "myEvent1" and "myEvent2" events on application's root domNode.
			//		bind "resize" event on window
			// app:
			//		dojox.app application instance.
			// events:
			//		{event : handler}
			this.events = {
				"myEvent1": this.myEvent1,
				"myEvent2": this.myEvent2
			};
			this.inherited(arguments);

			// bind "resize" event on window
			this.bind(window, "resize", this.onResize);
		},

		myEvent1: function(){
			// add your code here
		},

		myEvent2: function(){
			// add your code here
		},

		onResize: function(){
			// add your code here
		}
	});
  });

