#format dojo_rst

dojo.gears
==========

A small adapter testing the presence of and providing an instance of a `Google Gears <http://gears.google.com/>`_ factory. Exports a global *google.gears* object if present.

Example:
--------

  .. javascript::

    dojo.require("dojo.gears");
    dojo.ready(function(){
        if(dojo.gears.available){
            // safe to assume google.gears.factory is a gears factory
        }
    });

