#format dojo_rst

build profiles
==============

:Status: Draft
:Version: 1.0
:Project owner: (docs) Scott Jenkins
:Available: 1.0

.. contents::
   :depth: 3

The build profile is a simple JavaScript file containing an object which provides the parameters driving the build.

============
Introduction
============

The builder reads its parameters from a profile, which is a JavaScript file named *something*.profile.js, typically containing a ``dependencies`` object matching the structure described in this article.

The builder automatically appends ``.profile.js`` to the name of the profile specified on the build command line, so this naming convention is mandatory.

Note:  throughout the various options described below, file system paths are often specified.  Even on Windows based hosts, use forward slashes (akin to Unix) as directory separators, instead of the Windows native backslash.

==============
Empty Profiles
==============

If you specify an empty profile containing no ``dependencies`` object (such as the ``base.profile.js`` file shipped with the Dojo distribution), all defaults will be applied to the build.  In this case, the builder will create a single layer, ``dojo.js``, which contains only Dojo Base.  All other resources will be loaded from the distribution on demand via ``dojo.require``.

===================
Dependencies Object
===================

The top level object in the profile should be of the general format:

.. code-block :: javascript 

  dependencies: {
     layers: [
        // Individual layer objects...
     ],
     prefixes: [
        // Individual prefix objects...
     ]
  }

dependencies
  Optional.  An object, possibly containing ``layers`` and ``prefixes`` members.  By convention, the ``layers`` member comes first in source.

layers
  Optional.  An array of individual layer objects, one per layer which the build should generate.  The sequence is significant--layers are built in the order in which they are specified within the ``layers`` array.

prefixes
  Optional.  An array of individual prefix objects, describing where relative to the source directory tree, a particular top-level module's source is found.

======
Layers
======

Each member of the top level ``layers`` array is an object similar to (in many builds, only a few of these options will be used):

.. code-block :: javascript

  { 
    name: "string.discard",
    resourceName: "string.discard",
    discard: false,
    copyrightFile: "myCopyright.txt",
    dependencies: [
	// List of resources this layer depends on
       'dijit.form.Button',
       'dojox.data.Grid'
    ]
  }

The build system will build one layer file for each member object within the top level ``layers`` array.  It interprets the members of each individual layer object as follows:

name
   The path to and file name of the file that will be built for the layer.  

   This path is actually relative to ``/util``.  Therefore, to specify a layer file that will be created  in the dijit directory, you would specify ``../dijit/layerfilename.js``. 

resourceName
   Optional, String.  The name of the resource module to be provided by the layer.  If this is specified, the layer file will contain a ``dojo.provide`` statement specifying the resourceName.  

   Note  
     If you are using localization, your resourceName must have an entry in the ``dependencies.prefixes`` list, in order for the localization system to find your resources.

discard
   Optional.  Normally, this property is omitted.  If set to true, the layer file will be discarded after it is assembled.  You would use this in order to exclude the same resources from being built into another, subsequent layer (via the ``layerDependencies`` list for the subsequent layer) without actually creating an additional layer file in your as-built directory.  

copyrightFile
   Optional.  Filename of a simple text file that will be prepended to build layer files.  If omitted, the default Dojo copyright notice will be used instead.

dependencies
   Optional, array of string.  A list of Dojo resources that this this layer relies on.  Normally, they are to be included in the layer.  The builder will locate and include each of the resources listed in the ``dependencies`` array, then locate and include each resource referenced within those resources with a ``dojo.require`` statement, and so on recursively until all modules required to actually implement all of the layer dependencies are built into the layer. 

   No module will be included in the layer more than once, even if it is referenced at multiple locations within the web of resources the layer uses.
 
   Note
       It is not a documentation error that this property has the same name as the top level object.

   Hint
       It may be more effective to create a dummy JavaScript file with multiple ``dojo.require`` statements in the source tree, and simply list the dummy file as a dependency rather than try to maintain a detailed dependency list within the profile.

   Advanced notes
      * When the builder parses for dependencies in your source files, it is looking for the standard dojo.require('module-name') syntax via regular expression.  If you use the syntax dojo['require'] (or any other legal JavaScript construct), the builder will not recognize the dependency and will not include that resource.
      * The advanced `keepRequires <build/keepRequires>`_ option changes the behavior of the dependency list, by causing specified ``dojo.require`` statements found within the dependent modules to not be included in the layer build.  
     
layerDependencies
   Specifies other layers which are *prerequisites* for this layer; resources in the prerequisite layers are not duplicated in the current layer being built.  That is, if the builder locates a ``dojo.require`` statement in a source file, but that resource has already been placed in one of the layers specified as one of the layer dependencies, that resource will not be included in the current layer.

   Note
      All layers have an implicit dependency on dojo.js, but additional layerDependencies may be specified.

      Layer dependency should be specified based on the perquisite layer's path, not its name.

keepRequires
   Optional.  Changes the behavior of the layer dependency list, by causing specified ``dojo.require`` statements found within the dependent modules to not be included in the layer build.  

   See the `keepRequires detailed description <build/keepRequires>`_.

customBase
   Optional.  Used to build exceptionally small ``dojo.js`` layer, not including all of the standard Dojo Base.

   See the `customBase detailed description <build/customBase>`_.


========
Prefixes
========

An array of prefix descriptors, where each prefix descriptor is a length == 2 array of strings, similar to this:

.. code-block :: javascript

        prefixes: [
                [ "dijit", "../dijit" ],
                [ "dojox", "../dojox" ]
        ]

Each prefix describes where to find a top level namespace relative to the ``/util`` directory of the source tree.  As the builder finds modules which are required for a layer, it uses the prefix list to determine where to locate the module's files within the source tree.

Within each prefix descriptor, the members are:

first member (module name)
  String.  The name of a top-level module.

second member (path)
  String.  The path to that module's *directory* relative to the source ``/util`` directory.

Note:  If you have a custom module namespace outside of the Dojo source distribution tree, you will need to specify it in the prefix list as similarly to:

.. code-block :: javascript

        prefixes: [
                [ "dijit", "../dijit" ],
                [ "dojox", "../dojox" ],
                // Unix style, in the user's home directory, for example
                [ "myNamespace", "~/src/myNamespace" ]
                // For Windows OS, this might be something like [ "myNamespace", "M:/myNamespace" ]
        ]

This permits you to build into your distribution private namespace resources which are not within the Dojo distrubtion directory tree.



========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
