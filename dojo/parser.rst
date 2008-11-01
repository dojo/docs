#format dojo_rst

The Dojo Parser
===============


``TODOC`` -- A very brief writeup is available here: http://dojocampus.org/content/2008/03/08/the-dojo-parser/

The Dojo Parser is an optional module which is used to convert specially decorated nodes in the DOM and convert them into `Dijits <dijit>`_. By `decorated` we mean use of a `dojoType` attribute. Any "Class" (or object, such as the ones created by `dojo.declare <dojo/declare>`_) can be instantiated by using a `dojoType` attribute on some node in the DOM, and create a widget out of it.

This is not limited to Dijit, or `dojo.declare <dojo/declare>`_. 

Loading the Parser
------------------

To include the Dojo parser on your page, require the module `dojo.parser`:

.. code-block :: javascript

  dojo.require("dojo.parser");

``note:`` dijit._Templated require()'s dojo.parser, so a lot of examples don't include this step (dijit._Templated is loaded by most every Dijit). It is always safer to explicitly `require <dojo/require>`_ the module than to assume it has been loaded.

Running the Parser
------------------

There are two ways to run the dojo.parser: manually, or before onLoad.

To execute the parser manually, simply call the function ``parse``:

.. code-block :: javascript
  
  dojo.parser.parse();

This will scan the entire DOM for ``dojoType`` attributes, and create new instances from the nodes.

``todoc: scoping a parser call to node by stringId|domNode``

``todoc: running parser onload``

Setting the parser behavior
---------------------------

``todoc: parseOnLoad`` parseOnLoad:false by default, parseOnLoad:true optional, parseOnLoad:true makes addOnLoad call after parsing. howto set parseOnLoad

Instantiating a Node
--------------------

``todoc: attributes on nodes required in class prior, _private class members``

``todoc: parser calls .startup() ``

Caveats
-------

``todoc: re-parsing, duplicate id's``

Examples
--------

Load some HTML content from a `remote URL <quickstart/ajax>`_, and convert the nodes decorated with ``dojoType``'s into widgets:

.. code-block :: javascript

  dojo.xhrGet({
    url: "widgets.html",
    load: function(data){
        dojo.byId("container").innerHTML = data;
        dojo.parser.parse("container");
    }
  });

Delay page-level parsing until after some custom code (having set parseOnLoad:false):

.. code-block :: javascript

  dojo.require("dojo.parser");
  dojo.addOnLoad(function(){
       // do something();
       dojo.parser.parse();
  });
