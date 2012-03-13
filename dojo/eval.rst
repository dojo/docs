.. _dojo/eval:

=========
dojo.eval
=========

*Deprecated*.

To convert JSON to a javascript object, use :ref:`dojo/json::parse() <dojo/json#parse>`:

.. js ::

  require(["dojo/json"], function(json){
    var parsed = json.parse("{x: 5, y: 3}");
  });


To evaluate an arbitrary string of javascript, just use eval():

.. js ::

   eval("x = 5");

