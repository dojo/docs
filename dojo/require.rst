.. _dojo/require:

============
dojo.require
============

*Deprecated*.   Use ``require()`` instead.

Old code:

.. js ::

    dojo.require("dijit.form.Button");
    dojo.require("dojox.layout.ContentPane");
    ...
    CODE HERE

New code:

.. js ::

    require(["dijit/form/Button", "dojox/layout/ContentPane", ...], function(Button, ContentPane, ...){
       CODE HERE
    });

Notice how the dots (ex: dijit.form.Button) have been changed to slashes (ex: "dijit/form/Button").

See Also
========

* :ref:`The Dojo Loader <loader/amd>`_ - Further information on the loading process
