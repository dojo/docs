#format dojo_rst

dojo.registerModulePath
=======================

:Status: Draft
:Version: 1.0
:Available: since V0.9

.. contents::
   :depth: 2

Maps a module name to a path


============
Introduction
============

Dojo maps module names used in dojo.require calls to paths names. By default, Dojo uses a couple pieces of information to map a module name to a path name:

The first part is dojo.baseUrl: the path to the Dojo directory. For example, assume the path to dojo.js is "/web/scripts/dojo-1.3/dojo/dojo.js". The baseUrl is "/web/scripts/dojo-1.3/dojo/". Dojo automatically determines this path, but you can explicitly set it via djConfig.baseUrl.

Next, Dojo assumes that the path for any module names that start with a prefix other than "dojo" are in a sibling directory to the dojo directory.

For instance, if "/web/scripts/dojo-1.3/dojo/dojo.js" is the path to dojo.js, and you do dojo.require("some.module"), Dojo will try to load the JavaScript file using the path "/web/scripts/dojo-1.3/some/module.js".

If you want to load "some.module" from a different path, dojo.registerModulePath can be used to change the path. However, it is more common to use djConfig.modulePaths instead of dojo.registerModulePath directly. Dojo will call dojo.registerModulePath for each entry in djConfig.modulePaths.

Note that the path given to dojo.registerModulePath is always assumed to be relative to dojo.baseUrl, unless the module path starts with at "/" or "http". In those cases, dojo.baseUrl will not be used to determine the final path.

The second argument to dojo.registerModulePath, the path, should *not* end with a slash. Otherwise the calculated path could be inefficient and generate a path that has two slashes together. For paths that actually point to a file, the ending slash will generate the wrong path.

=====
Usage
=====

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
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
 </script>

========
Example
========

Custom Button
---------------

The following example uses a custom button for a "span".
Note: The custom button is simply an extension of "dijit.form.Button".



.. code-block :: javascript

    <script src="scripts/dojotoolkit/dojo/dojo.js" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript" charset="utf-8">
      // Paths default to dojo.baseUrl ("scripts/dojotoolkit/dojo/"),
      // so we point any module beginning with "my" to the path "scripts/my"
      dojo.registerModulePath('my', '../../my');
        
      // Now that the path is set, load my new button class
      dojo.require('my.form.Button');
        
      // Parse the declarative markup
      dojo.require('dojo.parser');
      dojo.addOnLoad(function() {
        dojo.parser.parse();
      });
    </script>

.. code-block :: css

    <style type="text/css" media="screen">
      .red {
        color: red;
        background: black;
      }
    </style>

.. code-block :: html

    <span dojoType="my.form.Button">my.form.button</span>

========
See Also
========

* `djConfig.modulePaths <http://docs.dojocampus.org/djConfig>`_
* `dojo.moduleUrl <dojo/moduleUrl>`_
