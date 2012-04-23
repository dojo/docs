.. _dojo/registerModulePath:

=======================
dojo.registerModulePath
=======================

:since: V0.9

.. contents ::
   :depth: 2

Maps a module name to a path.

**Warning**: ``dojo.registerModulePath`` and the ``modulePaths`` configuration property
have been deprecated in Dojo 1.7 in favor of the ``packages`` configuration property.


Introduction
============

Dojo module loader maps module names used in dojo.require or require() calls to paths names.  By default, Dojo uses a
couple pieces of information to map a module name to a path name:

The first part is dojo.baseUrl: the path to the Dojo directory. For example, assume the path to dojo.js is "/web/scripts/dojo-1.3/dojo/dojo.js". The baseUrl is "/web/scripts/dojo-1.3/dojo/". Dojo automatically determines this path, but you can explicitly set it via dojoConfig.baseUrl.

Next, Dojo assumes that the path for any module names that start with a prefix other than "dojo" are in a sibling directory to the dojo directory.

For instance, if "/web/scripts/dojo-1.3/dojo/dojo.js" is the path to dojo.js, and you do dojo.require("some.module"), Dojo will try to load the JavaScript file using the path "/web/scripts/dojo-1.3/some/module.js".

If you want to load "some.module" from a different path, dojo.registerModulePath can be used to change the path. However, it is more common to use dojoConfig.modulePaths instead of dojo.registerModulePath directly. Dojo will call dojo.registerModulePath for each entry in dojoConfig.modulePaths.

Note that the path given to dojo.registerModulePath is always assumed to be relative to dojo.baseUrl, unless the module path starts with at "/" or "http". In those cases, dojo.baseUrl will not be used to determine the final path.

The second argument to dojo.registerModulePath, the path, should *not* end with a slash. Otherwise the calculated path could be inefficient and generate a path that has two slashes together. For paths that actually point to a file, the ending slash will generate the wrong path.

Usage
=====

Dojo 1.7+ (AMD)
---------------

``dojo.registerModulePath`` is deprecated in Dojo 1.7+.  Going forward,
the ``packages`` configuration property should be used.  For example:

.. js ::

  var dojoConfig = {
    packages: [
      {
        name: "lib",
        location: "../../lib"
      }
    ]
  };

For more information on ``packages`` and other loader configuration properties,
see the documentation for :ref:`the Dojo Loader <loader/amd>`.

Dojo < 1.7
----------

.. js ::

   // Register "lib" to be a peer to Dojo's parent folder.
   // Make sure the module path does *not* end in a slash.
   dojo.registerModulePath("lib", "../../lib");

   // This module path is relative to the dojo baseUrl,
   // so we can find resources without knowing details
   // of the file structure.

   // E.g. if dojo lives at /somepath/dojotoolkit/dojo/dojo.js
   // then baseURL is "/somepath/dojotoolkit/dojo/"
   // and "lib" module path refers to "/somepath/lib"

   // lib.foo is required from /somepath/lib/foo.js
   dojo.require("lib.foo");

   // get a dojo.URI that points to "/somepath/lib/foo/images"
   var images = dojo.moduleUrl("lib.foo.images");

   // module paths can be overridden, e.g.
   dojo.registerModulePath("lib.css", "../../css");
   // module "lib" is unchanged except that "lib.css"
   // now refers to "/somepath/css"

   // we can set an absolute path by prefixing it with "/" or "http:"
   dojo.registerModulePath("aoldojo", "http://o.aolcdn.com/dojo/1.5/dojo");

Example
========

Custom Button
---------------

The following example uses a custom button for a "span".
Note: The custom button is simply an extension of "dijit.form.Button".

[Dojo 1.7 (AMD)]

.. js ::

      require(['dojo/_base/kernel', 'dojo/ready', 'dojo/parser', 'dojo/_base/loader'], function(dojo, ready, parser){

        // Paths default to dojo.baseUrl ("scripts/dojotoolkit/dojo/"),
        // so we point any module beginning with "my" to the path "scripts/my"
        dojo.registerModulePath('my', '../../my');

        // Now that the path is set, load my new button class
        require(['my/form/Button'], function(){
          // Parse the declarative markup
          ready(function(){
            parser.parse();
          });
        });
      });


[Dojo < 1.7]

.. js ::

      // Paths default to dojo.baseUrl ("scripts/dojotoolkit/dojo/"),
      // so we point any module beginning with "my" to the path "scripts/my"
      dojo.registerModulePath('my', '../../my');

      // Now that the path is set, load my new button class
      dojo.require('my.form.Button');

      // Parse the declarative markup
      dojo.require('dojo.parser');
      dojo.addOnLoad(function(){
        dojo.parser.parse();
      });

.. css ::

      .red {
        color: red;
        background: black;
      }

.. html ::

    <span data-dojo-type="my.form.Button">my.form.button</span>

See Also
========

* :ref:`dojoConfig.modulePaths <dojo/config>`
* :ref:`dojo.moduleUrl <dojo/moduleUrl>`
