.. _dojo/provide:

============
dojo.provide
============

*Deprecated*.    Use define() instead.

Old syntax:

.. js ::

     dojo.provide("acme.Dialog");
     dojo.require("dijit._Widget");
     dojo.require("dojo.date");
     CODE HERE


New syntax:

.. js ::

    define(["dijit/_Widget", "dojo/date"], function(_Widget, date){   ....
         CODE HERE
         return MyWidget;
    });

Notice that the module (a.k.a. file) itself is *returning* a value.   That's the way other modules access your module.

Also, notice how the module name previously listed in the dojo.provide() call ("acme.Dialog" in the example above) is not listed anymore.   The file name itself suffices.
