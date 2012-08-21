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

* `Modern Dojo Tutorial <http://dojotoolkit.org/documentation/tutorials/1.8/modern_dojo/>`_

* `Hello Dojo Tutorial <http://dojotoolkit.org/documentation/tutorials/1.8/hello_dojo/>`_

* :ref:`The Dojo Loader <loader/amd>` - Further information on the loading process
