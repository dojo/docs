#format dojo_rst

The Dojo Build System
=====================

:Status: Draft
:Version: 1.7+
:Author: Rawld Gill

.. contents::
   :depth: 2

The Dojo Build System

============
Introduction
============

This document describes the Dojo build system as of v1.7. The build system released with v1.7 is a completely new design
and implementation compared to the build system that was released with Dojo versions 1.0.x - 1.6.x. The key capability
of the new system is the ability to consume and optimize modules that conform to the Asynchronous/Module Definition
specification as well as modules the use the the legacy loader API (dojo.require, dojo.provide and the rest). It also
includes several new features:

* The ability to run on node.js, often decreasing build times by a factor of 10 or more.

* The ability to consume CommonJS package descriptions, greatly simplifying build profile construction.

* The ability to consume run-time configurations (i.e., dojoConfig values).

* Greatly enhanced capability to specify the location and content of source and destination file hierarchies.

* The ability to trim dead code as identified by static has.js feature values

Perhaps most interesting, the new system is also intended to serve as a generalized, Javascript-based platform for
processing a set of resources. The traditional purpose of the build system--transforming a set of resources into a set
of optimized resources for deployment--is but one example of potential uses of the system. As the Dojo community moves
forward towards Dojo 2.0, the new system will likely be used for such tasks as automatic code generation, static semantic
analysis, dead code removal, and so on.

Although the new system has many new capabilities, it is 100% compatible with version 1.6- profiles.

This tutorial and reference describes the Dojo build system in its entirety. Understanding the dojo loader is an
important prerequisite to using the builder. See `The Dojo Loader'_ for details.

===============
Design Overview
===============

The Dojo build system is a general-purpose program for transforming resources. Although general purpose, it was built to
solve the problem of transforming a set of resources that comprise a browser-based application in order to improve the
load-time performance of that application. For this particular purpose, two kinds of transformations are
typical:

* The content of a resource is analyzed and those portions not required are removed. An example is removing code branches
  as indicated by has.js feature values known at build time.

* Several resources may be bundled into a single resource so that a single server transaction results in downloading
  those resources. An example is combining several AMD module definitions into a single resource.

The first transform results in smaller resources which decreases transmission time. Even better, depending upon the
environment, the reduction in resource size may result in the user agent caching the resource, thereby completely
eliminating download time. The second transform results in fewer server transactions which, independent of bandwidth,
reduces the latency costs of loading an application. This effect is particularly noticeable when the organization of the
program results in a serial chain of downloads (for example, module A requires module B, but the program doesn't know
this until module A is evaluated). Using these techniques to optimize non-trivial applications often results in
improving load times by a factor of 10 or more.

The semantics of any particular transform range from trivial to quite powerful. The Dojo build system includes several
transforms. Further, the system is designed so that transforms may be easily constructed and plugged into the transform
engine. We hope that the system fosters a community of transforms solving problems like automatic document generation,
code formatting, static semantic analysis, and so on.

The overall design of the system is simple. It "discovers" a set of resources and applies an ordered set of
resource-dependent transforms to those resources. Both the discovery process and the transforms are controlled by a
"profile" which is a user-configurable Javascript object.

The dojo build system includes a discovery process that discovers resources as indicated by profile properties. You can
add additional discovery processes and/or remove the default discovery process. For now, the important point is that
there is some process that "discovers" resources and then "starts" these resources in the configurable transformation
process.

When a resource is started, the system queries the profile for the set of transforms that should be applied to that
particular resource. The profile includes the property transformJobs, a vector of [predicate, transform vector]
pairs. Each started resource is applied to each predicate and the transform vector associated with the first predicate
that returns true gives the set of transforms to apply to that particular resource.

Transforms are functions that take a resource and do some resource-dependent work. Reading, applying dojo pragmas,
parsing, dependency tracing, and writing are all examples of transforms. Obviously, transforms must be applied in a
prescribed order (for example, reading before writing). Further, some transforms may operate on multiple resources that
have already undergone a prescribed set of transforms. For these kinds of transforms, the system provides synchronization
machinery to ensure that all resources have completed transformation up to a prescribed step before any resource is
allowed to proceed to the next step. Such steps are termed "gates". Any gate that is designated such that all
resources must pass the previous gate before any resource is allowed to begin the designated gate is termed a
"synchronized gate". A gate is associated with each transform.

Here's a summary of the design:

* Transforms are functions applied to resources.

* Each transform is associated with a gate; gates give the order transforms are applied.

* TransformJobs maps a particular resource to an ordered set of transforms to apply to that resource.

* Resources are discovered by a discovery process; once discovered, the system applies each resource to the predicates in
transformJobs to find the transforms to apply, and then controls the application of all prescribed transforms to all
discovered resources until the last gate is passed and then terminates.

The system is highly configurable: the discovery process(es), transforms, transform-gate associations, and transformJobs
are all configurable through the profile. The system provides a default configuration so you won't have to bother with
configuring this machinery until and unless you want to do something special. Further details about how to write
customized processes will be covered in another tutorial; the remainder of this tutorial will describe the dojo-provided
transforms that an be used to optimize programs for deployment.

=========================
Invoking the Build System
=========================

The build system is a program comprised of a set of AMD modules that may be executed by node.js or Rhino. The program is
distributed with the source version of the Dojo Toolkit as a CommonJS package. The source tree resides at util/build/. A
new feature of Dojo 1.7 is the ability to run console-based Javascript programs in node by issuing the following
command:

.. code-block :: text

node.js path/to/dojo.js load=path/to/startup-module.js <program arguments>

Traditionally, the dojo build system is executed from the /util/buildscripts directory. For example, assuming the source
version of the Dojo Toolkit is installed at ~/dev/dtk/, in order to build the Dojo base profile with node.js, execute the
following command:

.. code-block :: text

~/dev/dtk/util/buildscripts> node.js ../../dojo/dojo.js load=build profile=base

Rhino may also be used. Owing the the requisite Java noise, its command is more complicated:

.. code-block :: text

~/dev/dtk/util/buildscripts> java -Xms256m -Xmx256m -cp ../shrinksafe/js.jar:../closureCompiler/compiler.jar:../shrinksafe/shrinksafe.jar org.mozilla.javascript.tools.shell.Main  ../../dojo/dojo.js baseUrl=../../dojo" profile=base

In order to ease this pain, util/buildscripts/ includes a shell script (Unix, Linux, OS X) and batch program
(Windows). For the shell script, simply issue the command

.. code-block :: text

~/dev/dtk/util/buildscripts> ./build.sh profile=base

And for Windows:

.. code-block :: text

~/dev/dtk/util/buildscripts> ./build.bat profile=base

The shell script will prefer node.js if it is available. The Windows batch file always uses Rhino, but includes some
hints about how to use node.js if you have a node.js installed.

=====================
Controlling The Build
=====================

The build system is controlled by a Javascript object termed a "profile" which instructs the system what files to
process, how to process them, and where to write the output. The profile itself is constructed from one or more inputs:

* one or more Javascript resources that contain a profile object

* one or more package.json resources that describe a CommonJS package, optionally pointing to an external,
  package-dependent profile resource

* one or more loader configuration variables (dojoConfig or require)

* command line switches

The build system processes each resource described above in the order provided on the command line; if two or more
resources attempt to set the same profile property, then the last input wins. Some profile properties are mixed one or
two-level deep; see xxx). The command line switches are always processed last, so they will always override any existing
profile property.

Prior to v1.7, the build system expected command line switches to have the form

``variable=value``

Although v1.7 can consume switches provided as such, this format is deprecated in favor of the more-transitional form:

``-variable value``

Or...

``--long-variable-name value``

Not all switches have short name (single-dash) variants. See xxx for a complete list of command line switches.

====================
Specifying Resources
====================

This section describes how a build profile specifies which files to read and where to write them.

Methods Used in Dojo Version 1.6-
---------------------------------

In v1.6-, the profiles contained two properties that described which files to read: ``prefixes`` and ``layers``. ``prefixes`` was an
array of pairs. The first item in each pair gave a top-level module name (e.g., "dojo", "dijit", "myPackage"); the
second item gave a path where the Javascript resources for that module tree resided. For example,

.. code-block :: javascript

prefixes = [
    ["dojo", "~/dev/dtk/dojo"],
    ["dijit", "../dijit"]
]

If no dojo path was given then it was assumed to be "../../dojo", relative to the current working directory. Since the
v1.6- build system assumed (without directly saying so) that the build program was always invoked from the
util/buildscripts/ directory, this had the net effect of causing dojo directory to default to the same location as the
dojo being used with the build program.

If a relative path was given for the dojo directory, it was take to be relative to the current working directory, again,
assumed to be the util/buildscripts/ directory.

If a relative path was given for any top-level module other than dojo, then the path was taken to be relative to the dojo
directory. So in the example above, the path for dijit resolves to "~/dev/dtk/dojo/../dijit" = "~/dev/dtk/dijit".

In v1.6-, the ``layers`` property contained an array of objects, with each object containing several properties:

``name``
  The resource name of a module to build (a single Javascript resource); relative paths were relative to the
  dojo directory.

``dependencies``
  An array of module names to bundle into the built version of the module given by name.

``layerDependencies``
  An array of module names to exclude from the built version of the module given by name.

``copyrightFile``
  Filename of a simple text file that was prepended to build layer files. If omitted, the default Dojo
  copyright notice was used instead.

A 1.6- layer object could also contained the properties ``resourceName``, ``discard``, ``keepRequires``, ``customBase``;
however, these are not relavent to this discussion, so I'll ignore them.

The intent of a layer object is to describe a so-called "layer" module which is an aggregation of several modules. The
aggregations is computed to include the module given by name, plus its dependency tree, plus any modules given in
``dependencies`` plus their dependency trees, minus any modules given in ``layerDependencies`` and their dependency
trees. Often, modules mentioned in ``layerDependencies`` will themselves be layer modules, but they may also be
ordinary modules.

Notice that each layer object may describe one or more top-level modules in its ``dependencies`` property. If a top-level
module was discovered in a layer's ``dependencies`` property that was not explicitly given in the ``prefixes`` property, then that
module was automatically added to prefixes as a sibling of the dojo tree. Consider the following ``prefixes`` and ``layers``
property values:

.. code-block :: javascript

prefixes = [
    ["dojo", "~/dev/dtk/dojo"],
    ["dijit", "../dijit"]
],

layers = [{
    name:"../myPackage/main.js",
    dependencies:["myPackage.menu", "myPackage.scrollbar", "myPackage.mainWindow"]
});

In this example, the v1.6- build system would behave as the following ``prefixes`` value was provided:

.. code-block :: javascript

prefixes = [
    ["dojo", "~/dev/dtk/dojo"],
    ["dijit", "../dijit"]
    ["myPackage", "../myPackage"]
],

In version 1.6-, the aggregate of all the module trees described by ``prefixes`` (including those implied by ``layers``)
described which files the build system processed.

In version 1.6-, the profile properties ``releaseDir`` and ``releaseName`` were concatenated to indicated where to write all
processed module trees, and all module trees were written as siblings whether or not they were siblings as input. If a
relative path was given for ``releaseDir``, it is taken to be relative to the current working directory, as usual, assumed
to be util/buildscripts/. The default value for ``releaseDir`` was "../../release". A non-empty ``releaseName`` caused an
additional path segment to be concatenated to ``releaseDir``; the default value for releaseName was "dojo". Consequently, by
default, the build system would output a tree rooted at "release/dojo", with release/ located as a sibling of the dojo
directory.

If you take a moment and consider the design described above, you'll see that it is really describing a system that
builds several packages, denoted by top-level module names. As usual, Dojo was well ahead of its time as this system
predates the CommonJS package system by several years. On the other side of the coin the system is highly "dojo centric"
assuming that all "packages" are relative to dojo and further, by default, computing the location of both dojo and the
output directories relative to the /util/buildscripts directory. This design is clearly awkward and completely reworked
as of v1.7. That said, and in spite of the fact I wrote the entire description in past tense, the version 1.7 build
system can consume v1.6- profiles. But before I describe backcompat, let's look at the new design for specifying which
files to process and where to write them.

Fundamentals of v1.7+ Profiles
-----------------------------

Starting with v1.7, source trees are specified to the build system exactly as they are specified to the loader: by a
package configuration (see `The Dojo Loader`_ for details on how to write a package configuration). The only difference between the
loader and the build system is that the loader uses the property ``baseUrl`` whereas the build system uses the property
``basePath``. The destination location for processed package trees is also specified by a package configuration. By
default the source package configuration is used to compute the destination location with the exception that the
property ``destBasePath`` is used in place of ``basePath``. Finally, build profile resources are specified by providing a
Javascript resource that defines the variable ``profile`` instead of the variable ``dependencies`` found
in v1.6- profiles. Here is an example of a v1.7 profile that mirrors the example given in the previous section:

.. code-block :: javascript

profile = {
  basePath:"~/dev/dtk",
  packages:[{
    name:"dojo"
  },{
    name:"dijit"
  },{
    name:"myPackage"
  }]
};

As described in the loader tutorial, the location for dojo, dijit, and myPackage is computed by appending the package
name to ``basePath`` (remember ``basePath`` in the build system is equivalent to ``baseUrl`` in the loader). So these packages are
located at ~/dev/dtk/dojo, ~/dev/dtk/dijit, and ~/dev/dtk/myPackage, respectively.

If a relative ``releaseDir`` is given, then the path is taken to be relative to ``basePath``. For version 1.7-, releaseDir
defaults to "./release" and ``releaseName`` defaults to null. So the built packages will be located at
~/dev/dtk/release/dojo, ~/dev/dtk/release/dijit, and ~/dev/dtk/release/myPackage.

The flexibility of the package configuration variable allows the build system to source trees from anywhere and write
the processed output anywhere. It is a much more flexible, not-dojo-centric system for specifying where to read and write
files.

v1.7 keeps the ``layers`` property but cleans it up a bit. Like 1.6-, ``layers`` is an array of layer objects. Each object
may contain the following properties:

``name``
  The AMD module name of the layer

``include``
  An array of AMD module names indicating the modules to include in the layer; analogous to ``dependencies`` in 1.6-.

``exclude``
  An array of AMD module names indicating the modules to exclude from the layer; analogous to ``layerDependencies`` in 1.6-.

``copyright``
  Copyright text to include in the layer

``copyrightFile``
  [optional] Same as 1.6-.

Unlike 1.6-, v1.7+ will not derive implied packages from layer object's ``include`` or ``exclude`` properties. If you want to
reference a package, put it in the packages configuration.

Backwards Compatibility
-----------------------

The build system can deduce that it is being given a 1.6- profile by noticing a profile resource defines the property
``dependencies`` and does not define the property ``profile``. When a v1.6- profile is detected, the build system converts
that profile into a 1.7+ profile on-the-fly as follows:

* The set of top-level modules is computed as usual in v1.6- by taking the union of all modules explicitly given in the
  prefixes property and all top-level modules implied in the dependencies and layerDependencies properties of any layer
  objects.

* All top-level modules are interpreted as unique packages and a package configuration is constructed for each package.

* If a relative path is given for the dojo package, it is assumed to be relative to the /util/buildscripts
  directory; otherwise, if no path is given for the dojo package, it is assumed to be the same dojo tree as is being
  used to execute the build program (typically /util/buildscripts/../../dojo/)

* If a relative path is given for any other package, it is assumed to be relative to the dojo package as computed above.

* ``basePath`` is computed to be the parent of the dojo package; notice that since all package locations are explicitly
  computed to be absolute paths as described above, ``basePath`` does not enter into the calculation of any package path.

* The v1.6- default values for ``releaseDir`` and ``releaseName`` are "/util/build/../../release" and "dojo", respectively
  (exactly as they are in 1.6-), which results in the v1.6 behavior.

For the most part, you can provide a version 1.6- profile to the v1.7+ build system and it will Just Work. As I'll
describe below, the version 1.7 build system includes the ability to process multiple profiles. If you utilize this
capability, I strongly recommend you convert all your profiles to the v1.7+ format.

=========================
Advanced Profile Features
=========================

Resource Tags
-------------

The most fundamental attribute of a resource used to indicate which transforms to apply is its file type. Unfortunately
this usually isn't enough. For example, it may be desirable to not apply any transforms to test resources. The build
system includes machinery to "tag" resources with various flags that may be used to signal which transforms to apply.

Optionally, a package configuration may contain the property ``resourceTags``, a hash from tag name to function. Each
function takes two arguments, filename and module-id, and returns true if a given resource should be tagged with the
associated tag or false otherwise. All tag tests are applied to every resource and any single resource may be tagged
with several tag names. See the resources dojo/dojo.profile.js for and example.

The dojo build system decides which transforms to apply to a particular resource based its filetype and the following
tags:

``test``
  The resource is part of the test code for the package.

``copyOnly``
  The resource should be copied to the destination location and otherwise left unaltered.

``amd``
  The resource is an AMD module.

``miniExclude``
  The resource should not be copied to the destination of the profile property "mini" is truthy.

Trees, Dirs, and Files
----------------------

Notice that a package gives a root for all package resources in the package location property. Typically, it is not
desirable to blindly process every file in the file system hierarchy rooted at a package location. For example, backup
files and files used by a version control system (e.g., .svn or .git directories) should not be included in the build
process. 

In order to refine which files are discovered, each package may explicitly include the property ``trees`` which gives an
array of triples of (source, destination, regular-expression). source and destination are paths that say the source and
destination location of file hierarchy trees to discover; regular-expression indicates the files that should be ignored
in the source tree. If relative paths are provided, they are relative to the package location and package destination
location, respectively. If no trees are given, the the build system automatically provides the following default value:

.. code-block :: javascript

  trees:[
    [".", ".", /(\/\.)|(~$)/]
  ]

This default causes all files in the package source location to be discovered and destined for the package
destination location with the exception of any file that begins with a dot (typically a hidden file used by editors
or version control) or ends with "~$", an Emacs backup filename.

Although uncommon, the ``trees`` array can contain any number of triples, allowing trees outside the package to be processed
as part of the package.

The build system similarly allows the properties ``dirs`` and ``files``, both arrays of triples as described above, to be
included in a package configuration. As the names imply, the items in ``dirs`` indicate single directories to be processed
while ``files`` indicates single files to be processed.

The per-package ``trees``, ``dirs``, and ``files`` profile machinery to include any reachable file in the build process.

Dojo Pragmas
------------

TODO

Replacements
------------

TODO

Burned In Loader Config
-----------------------

TODO


=========================
Processing Profiles
=========================

New to v1.7+, the build system can process many individual profiles from many disparate sources during a single
build. The following command line options are available to indicate which profiles to process.

``--profile filename``
  If filename does not end in ".js", then it is assumed to be a profile distributed with the Dojo source release
  located in util/buildscripts/profiles. Otherwise, filename is assumed to give the name of a Javascript resource
  that provides either a v1.6- or v1.7+ profile.

``--dojoConfig filename``
  filename must give the name of a Javascript resource that contains the a variable named dojoConfig that
  contains a loader configuration. Note that a loader configuration provides a set of package configurations which is
  sufficient to instruct the build system on which resources to transform. Optionally, the dojoConfig variable may
  include the property ``dojoBuild`` which may contain profile properties in addition to those (or to override those) at the top
  level of ``dojoConfig``. For example, the property ``basePath`` may be provided directly as a property of ``dojoConfig`` (of
  course this property is meaningless to the loader) or indirectly at ``dojoConfigl.dojoBuild.basePath``.

``--require filename``
  filename must give the name of a Javascript resource that contains the variable ``require`` which is interpreted
  just as ``dojoConfig`` described above or an application of the function ``require`` to a configuration object. In the latter
  case, the configuration object is interpreted just as ``dojoConfig`` described above.

``--package filename``
  filename must give the name of a package.json file. The package.json file is used to describe a single package to be
  transformed by the build system. Optionally, the property ``dojoBuild`` may be used to specify the a profile for the
  package. This indirection is necessary since it is illegal for JSON files to contain executable code (for example, the
  functions used to tag resources).

A single invocation of the build system may include any number of any of the above profile resources. If multiple
resources are given, then each resource is processed left to right, aggregating properties found in later profiles with
those found in earlier profiles. See individual properties descriptions for a description about how a multiple values
for a particular are mixed.

==========================
Profile Property Reference
==========================

basePath
  Analogous to baseUrl when resolving package locations with the dojo loader. Defaults to "." for profile and
  package.json files; no default otherwise.

releaseDir
  Analogous to baseUrl when resolving package locations with the dojo loader. Defaults to "./release" for v1.7+
  profiles; defaults to /util/buildscripts/../../release for 1.6- profiles.

trees
  Identical to the trees property available in a package configuration object, except package independent. Relative
  source and/or destination names are relative tod basePath and releaseDir respectively.

dirs
  Identical to the dirs property available in a package configuration object, except package independent. Relative
  source and/or destination names are relative tod basePath and releaseDir respectively.

files
  Identical to the files property available in a package configuration object, except package independent. Relative
  source and/or destination names are relative tod basePath and releaseDir respectively.

packages
  An array of package configurations objects. Packages are mixed on a per-package level. Package configuration objects
  may contain the properties name, location, main, and packageMap as described in xxx. The destination location for a package
  is given by the anlogous properties destName, destLocation, destMain, and destPackageMap. Typically, the destination
  properties are derived from the source properties with destName===name, destLocation===destBasePath/destName,
  destMain===main, and destPackageMap===packageMap. Packages may also contain the properties trees, dirs, and files as
  described in xxx.

copyTests
  If truthy but not "build", then copy  all resources tagged as a tests to the release destination. If "build", then apply
  all appropriate transforms to any resource tagged as a test as if it were not tagged as a test. If falsy, ignore the
  all resources tagged as tests.

mini
  If truthy ignore all resources tagged as excludeMini; if copyTests is falsy or missing, also ignore all resources
  tagged as tests.

layers
  An array of layer objects; each layer object may contain the properties name, include, exclude, copyright,
  copyrightFile. For v1.6- backcompat the properties dependencies and layerDependencies are recognized. See xxx for
  details.

stripConsole
  falsy, "none", "warn", and "all". If "warn" is provided, then all console.warn applications are stripped from the
  code; if "all" is provided then all console.warn and console.error applications are stripped from the code. This
  option only works if a particular resource is optimized via layerOptimize or optimize.

layerOptimize
  falsy, "comments", "shrinksafe", "shrinksafe.keeplines", "closure", "closure.keeplines". Specifies the level of
  optimization (minification) applied to a layer resource. "comments" strips comments only. "shrinksafe" applies
  shrinksafe minification; if the ".keeplines" suffix is included then new-lines are not stripped. "closure" applies
  Google closure compiler simple-mode minification; if the ".keeplines" suffix is included then new-lines are not
  stripped.

optimize
  Same as layerOptimize, except applies to all modules that are not layer modules.

cssOptimize
  falsy, "comments", "comments.keepLines"
  If comments then comments and new-lines are stripped for CSS files and all files given by CSS @import directives that
  are not given in the property cssImportIgnore are are inlined. If "comment.keeplines" behaves identically except that
  new-lines are not stripped.

cssImportIgnore
  falsy, comma-seperated list of filenames
  Gives the list of CSS filename to not inturn during CSS optimization as described by the cssOptimize switch

internStrings
  boolean
  If true, all inline dojo.cache- and templatePath-implied strings. Note: templateCssPath is no longer supported.

defaultConfig
  TODO

staticHasFeatures
  TODO

applyDojoPragmas
  TODO

insertAbsMids
  TODO

scopeMap
  TODO

version
  TODO


Profile Properties Deprecated as of Version 1.7
-----------------------------------------------

The action clean is no longer supported. Use ``rm`` on Unix/Linux/OS X or ``rmdir`` on Windows.


Profile Properties Removed as of Version 1.7
--------------------------------------------

The following profile properties are not necessary with the introduction of the new loader, query machinery, build
system, and AMD module format in 1.7: ``localeList``, ``loader``, ``log``, ``xdDojoPath``, ``scopeDjConfig``, ``xdScopeArgs``, ``xdDojoScopeName``,
``expandProvide``, ``buildLayers``, ``query``, ``removeDefaultNameSpace``, ``addGuards``.


=====================
Command Line Switches
=====================

In addition to the ``profile``, ``dojoConfig``, ``require``, and ``package`` command line switches mentioned in xxx, the
build system defines the following "action" switches:

--release
  Process all profiles resources, discover and transform all resources

--check
  Process all profiles resources and command line switches and dump the computed profile to the console

--help
  Print the help message

--version
  Print the version number of the build program

Although the "action=switch" defined by the v1.6- system may be used, that syntax is deprecated and you should just
specify the switch.

The clean action has been removed. Since the system is now extremely flexible is describing where output is written, a
mistake in a profile could result in cleaning your hard drive. We'll let you do that yourself with the rm/rmdir
commands. (We also note that deleting file trees is not the typical function of a compiler program).

Lastly, any scalar profile property can be specified on the command line. For example, ``basePath`` could be specified
as follows:

.. code-block :: text

~/dev/dtk/util/buildscripts> ./build.sh --profile myApp --basePath /www/deploy/myApp --release

This example also demonstrates the ``release`` command line switch which is instructs the build system to process all
profiles and execute the transforms. In addition to release, the build system defines the following actions:


.. _The Dojo Loader: http://livedocs.dojotoolkit.org/developer/design/loader
