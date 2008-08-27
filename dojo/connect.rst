## page was renamed from 1.2/dojo/connect
#format dojo_rst

dojo.connect
============

:Status: Contributed, Draft
:Version: 1.0

Syntax
------

.. code-block :: javascript
  
  dojo.connect(obj: Object, event: String, context: Object, method: String|Function, dontFix: Boolean); (view source)

Events in JavaScript or Dojo based applications are essential to making applications work. Connecting an event handler (function) to an element or an object is one of the most common things you will do when developing applications using Dojo. Dojo provides a simple API for connecting events via the dojo.connect() function. One important thing to note here is that events can be mapped to any property or object or element. Using this API you can wire your user interfaces together or allow for your objects to communicate. The dojo.connnect() API does not require that the objects be Dojo based. In other words, you can use this API with your existing code and interfaces.

See the `Event QuickStart <quickstart/events>`_ for a good introduction. 

``FIXME: quickstart is more informative. fill in details and more technical information below``

Example
-------

Connecting to a button click
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cv-compound::

  .. cv:: html
    :label: A dojo button

    <div dojoType="dijit.form.Button" id="button1">Click me!</div>

  .. cv:: javascript
    :label: The jscript to connect to an onclick event

    <script language="text/javascript">
      dojo.require("dijit.form.Button");

      function helloPressed(){
       alert('You pressed the button');
      }
      dojo.addOnLoad(function(){
        dojo.connect(dojo.byId("button1"), "onclick", helloPressed);
      });
    </script>
