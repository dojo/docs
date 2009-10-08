## page was renamed from 1.2/dojo/connect
#format dojo_rst

dojo.connect
============

:Status: Contributed, Draft
:Version: 1.0
:Authors: ?--

.. contents::
    :depth: 2

dojo.connect connects events to methods, so that after the event occurs, the new connected method is called too.

============
Introduction
============

`dojo.connect` is the core event handling and delegation method in
Dojo. It allows one function to "listen in" on the execution of
any other, triggering the second whenever the first is called. Many
listeners may be attached to a function, and source functions may
be either regular function calls or DOM events.

`dojo.connect` connects listeners to actions, so that after event fires, a
listener is called with the same arguments passed to the orginal
function.

Since `dojo.connect` allows the source of events to be either a
"regular" JavaScript function or a DOM event, it provides a uniform
interface for listening to all the types of events that an
application is likely to deal with though a single, unified
interface. DOM programmers may want to think of it as
"addEventListener for everything and anything".

When setting up a connection, the `event` parameter must be a
string that is the name of the method/event to be listened for. If
`obj` is null, `dojo.global` is assumed, meaning that connections
to global methods are supported but also that you may inadvertantly
connect to a global by passing an incorrect object name or invalid
reference.

`dojo.connect` generally is forgiving. If you pass the name of a
function or method that does not yet exist on `obj`, connect will
not fail, but will instead set up a stub method. Similarly, null
arguments may simply be omitted such that fewer than 4 arguments
may be required to set up a connection See the examples for deails.

The return value is a handle that is needed to 
remove this connection with `dojo.disconnect`.

=====
Usage
=====

.. code-block :: javascript
  
  dojo.connect(obj: Object, event: String, context: Object, method: String|Function, dontFix: Boolean);


========
Examples
========

.. code-block :: javascript

	// When obj.onchange(), do ui.update():
	dojo.connect(obj, "onchange", ui, "update");
	dojo.connect(obj, "onchange", ui, ui.update); // same

	// Using return value for disconnect:
	var link = dojo.connect(obj, "onchange", ui, "update");
	...
	dojo.disconnect(link);

	// When onglobalevent executes, watcher.handler is invoked:
	dojo.connect(null, "onglobalevent", watcher, "handler");

	// When ob.onCustomEvent executes, customEventHandler is invoked:
	dojo.connect(ob, "onCustomEvent", null, "customEventHandler");
	dojo.connect(ob, "onCustomEvent", "customEventHandler"); // same

	// When ob.onCustomEvent executes, customEventHandler is invoked
	// with the same scope (this):
	dojo.connect(ob, "onCustomEvent", null, customEventHandler);
	dojo.connect(ob, "onCustomEvent", customEventHandler); // same

	// When globalEvent executes, globalHandler is invoked
	// with the same scope (this):
	dojo.connect(null, "globalEvent", null, globalHandler);
	dojo.connect("globalEvent", globalHandler); // same


Connecting to a button click
----------------------------

This example shows, how to use dojo.connect in order to connect the onclick-Event to a function.

.. cv-compound::

  .. cv:: javascript
    :label: The jscript to connect to an onclick event

    <script language="text/javascript">
        dojo.require("dijit.form.Button");

        function helloPressed(){
            alert('You pressed the button');
        }

        dojo.addOnLoad(function(){
            // Create a button programmatically:
            var button = new dijit.form.Button({
                label: "Click me!"
                },
                "button1"
            );

            // Use dojo.connect to connect the onclick-Event to a function:
            // dojo.connect(dojo.byId("button1"), "onclick", helloPressed);           
        });
    </script>

  .. cv:: html
    :label: A dojo button

    <button id="button1" type="button">
    </button>


========
See also
========

* `Event QuickStart <quickstart/events>`_ for a good introduction
