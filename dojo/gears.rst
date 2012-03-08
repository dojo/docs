.. _dojo/gears:

==========
dojo.gears
==========

A small adapter testing the presence of and providing an instance of a `Google Gears <http://gears.google.com/>`_ factory. Exports a global *google.gears* object if present.

Example
=======

Dojo 1.7 (AMD)
--------------

  .. js ::

    require(["dojo/gears", "dojo/ready"], function(gears, ready){
        ready(function(){
            if(gears.available){
                // safe to assume google.gears.factory is a gears factory
            }
        });
    });
