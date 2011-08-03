Using on module with pre-AMD-style Dojo api's
---------------------------------------------

The dojo/on module can also be loaded with dojo.require("dojo.on") to make available as dojo.on. For example:

.. code-block :: javascript

  dojo.require("dojo.on");
  dojo.on(document, "click", clickHandler);
