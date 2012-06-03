.. _dojo/gears:

==========
dojo/gears
==========

*Deprecated* since Google Gears has been deprecated by Google.

A small adapter testing the presence of and providing an instance of a `Google Gears <http://gears.google.com/>`_ 
factory. Exports a global *google.gears* object if present.

Example
=======

.. js ::

  require(["dojo/gears", "dojo/ready"], function(gears, ready){
      ready(function(){
          if(gears.available){
              // safe to assume google.gears.factory is a gears factory
          }
      });
  });
