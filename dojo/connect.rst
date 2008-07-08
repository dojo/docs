#format dojo_rst

dojo.connect
============

Events in JavaScript or Dojo based applications are essential to making applications work. Connecting an event handler (function) to an element or an object is one of the most common things you will do when developing applications using Dojo. Dojo provides a simple API for connecting events via the dojo.connect() function. One important thing to note here is that events can be mapped to any property or object or element. Using this API you can wire your user interfaces together or allow for your objects to communicate. The dojo.connnect() API does not require that the objects be Dojo based. In other words, you can use this API with your existing code and interfaces.

Examples
--------

Following examples explain the usage of dojo.connect in detail

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
