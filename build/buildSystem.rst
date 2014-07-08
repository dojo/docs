.. _build/buildSystem:

=====================
The Dojo Build System
=====================

:Author: Rawld Gill

.. contents ::
   :depth: 2

*This document describes the Dojo build system as of v1.7. Historical documentation describing the build system prior
version 1.7 is available* :ref:`here <build/pre17/build>`.

*See* :ref:`The Dojo Build System <build/index>` *for a complete list of build system documentation resources.*

Introduction
============

The Dojo build system is a general-purpose program for transforming a set of resources. It was built to solve the
problem of transforming a set of resources that comprise an application in order to improve the performance of that
application. For this particular purpose, two kinds of transformations are typical:

* The content of a resource is analyzed and those portions not required are removed. An example is removing dead code
  branches as indicated by has.js feature values known at build time.

* Several resources may be bundled into a single resource so that a single server transaction results in downloading
  those resources. An example is combining several AMD module definitions into a single resource.

The first transform results in smaller resources which decreases transmission time. Even better, depending upon the
environment, the reduction in resource size may result in the user agent caching the resource, thereby completely
eliminating download time. The second transform results in fewer server transactions which, independent of bandwidth,
reduces the latency costs of loading an application. This effect is particularly noticeable when the organization of the
program results in a serial chain of downloads (for example, module A requires module B, but the program doesn't know
this until module A is evaluated). Using these techniques to optimize non-trivial applications often results in
improving load times by a factor of 10 or more.

These kind of optimizations are termed "deployment optimizations", and the build system includes a rich set of such
optimizations that may be applied to an application prior to deployment. However, the build system is not limited to
these kinds of transforms. At its core, the build system is an engine for applying an ordered, synchronized, configurable
set of transforms to a configurable input set. Examples of other usages include document generators, style checkers,
code formatters, lint checkers, and many more. In some ways it is like a make program, except the external processes
that typical make programs execute can be implemented within its pluggable transform infrastructure. Of course external
processes can be executed as well.

This document describes using the build system for deployment optimizations. See xxx for information about writing your
own custom transforms and configuring the build system for other uses.

Overview
========

The design of the system is somewhat complex. It "discovers" a set of resources and then applies a synchronized, ordered set of
resource-dependent transforms to those resources. Both the discovery process and the transforms are controlled by a
user-configurable JavaScript object termed a "profile".

When a resource is discovered, it is tagged with one or more flags that help identify the role of that resource. For
example, an AMD module may be tagged "AMD". The profile controls how resources are tagged. After a resource is
discovered and tagged, the system assigns a set of transforms that are to be applied to that resource. This assignment
is based on the resource tags and/or filename and is also controlled by the profile. Then the system takes over and
automatically applies each assigned transform. Once all assigned transforms have been applied to all discovered
resources the program terminates.

Let's look at a couple of examples. The simplest transform is to do nothing--don't read the resource, don't write the
resource, don't do anything. Such a "noop" may be applied to version control files, backup files, and other such files
that should not be moved to the deployment tree.

A slightly more interesting example is a resource that is copied from the development tree to the deployment
tree. Notice the build system to "know" that the deployment tree will contain the resource. This knowledge may be used
by other transforms that ensure requisite files exist. For example, a CSS style sheet checker could check to see that
all referenced images exist.

Perhaps the most important transform for resource deployment is dependency scanning JavaScript modules and then bundling
dependencies into a single resource to reduce the HTTP transactions required to load a resource.

Road Map
--------

The remainder of this document describes how use the build system for deployment optimization. The following topics are
covered in order:

1. How to invoke the system.

2. How to control the build system with command line switches.

3. How to configure profiles to indicate what resources to discover and where to output the transformed resources.

4. What set of transforms are available and the kinds of resources those transforms are applied to.

Extra Features
--------------

These are discussed in separate documents as follows:

* :ref:`Transform writeDojo <build/transforms/writeDojo>` describes how to build a custom dojo.js with a nonstandard set of
  modules.

Assumptions for Examples
========================

This document contains several examples. It assumes the source distribution of the Dojo Toolkit, version 1.7 or greater,
is installed at ~/dev/dtk/. If you are a Windows user, "~" is shorthand for the user's home directory; substitute
whatever directory is convenient for you. For all users, there is nothing special about ~/dev/. We are just using it to
indicate the root that holds the Dojo Toolkit source distribution.

Unless specifically stated otherwise, all examples assume the current working directory is
~/dev/dtk/util/buildscripts. As we'll see, this is not a requirement of the build system, but rather a convenience
so you don't have to path to the build system executable.

Invoking the Build System
=========================

The build system is a JavaScript program comprised of a set of AMD modules that may be executed by node.js or Rhino. The
program is distributed with the source version of the Dojo Toolkit. The source tree resides at util/build/. Dojo can be
used to execute console-based JavaScript programs in node by issuing the following command:

.. code-block :: text

  node.js path/to/dojo.js load=path/to/startup-module.js <program arguments>

Traditionally, the dojo build system is executed from the /util/buildscripts/ directory. For example, assuming the source
version of the Dojo Toolkit is installed at ~/dev/dtk/, in order to invoke the build system and print the help
message, issue the command:

.. code-block :: text

  ~/dev/dtk/util/buildscripts> node.js ../../dojo/dojo.js load=build --help

Rhino may also be used. Owing to the requisite Java noise, its command is more complicated:

.. code-block :: text

  ~/dev/dtk/util/buildscripts> java -Xms256m -Xmx256m \
  -cp ../shrinksafe/js.jar:../closureCompiler/compiler.jar:../shrinksafe/shrinksafe.jar org.mozilla.javascript.tools.shell.Main \
   ../../dojo/dojo.js baseUrl=../../dojo" --help

In order to ease this pain, util/buildscripts/ includes a batch program for Windows and a shell script for non-Windows
environments. For the shell script, issue the command

.. code-block :: text

  ~/dev/dtk/util/buildscripts> ./build.sh --help

And for Windows:

.. code-block :: text

  ~/dev/dtk/util/buildscripts> ./build.bat --help

The shell script will prefer node.js if it is available. If you would rather use Rhino, you can use the command line
switch ``--java`` like this:

.. code-block :: text

  ~/dev/dtk/util/buildscripts> ./build.sh --java --help

The Windows batch file always uses Rhino, but includes some hints about how to use node.js if you have a node.js
installed.

Although the legacy build system could be executed when /util/buildscripts/ was *not* the current working directory, to
do so required a carefully constructed profile. Indeed, many profiles provided with Dojo source distributions won't work
unless /util/buildscripts/ is the current working directory. The current build system has no such restriction.

Command Line Switches
=====================

The build system is controlled by a JavaScript object termed a "profile" which instructs the system what files to
process and how to process them. The profile itself is constructed from one or more inputs:

1. Zero or more JavaScript resources that contain a profile object, as specified by the command line switch
``--profile``. This switch requires a filename argument that points to a profile resource.

2. Zero or more loader configuration variables (``dojoConfig`` or ``require``), as specified by the command line switches
``--require`` or ``--dojoConfig``. These switches require a filename argument that points to a JavaScript resource that contains a
loader configuration.

3. Zero or more package.json resources that describe a CommonJS package, as specified by the command line switch
``--package``. This switch requires a path that points to a directory that contains a package.json resource.

4. Zero or more other command line switches that give (profile-property-name, profile-property-value) pairs.

The build system processes each resource described above (Items 1-3) in the order provided on the command line; if two
or more resources attempt to set the same profile property, then the last input wins. Some profile properties are more
deeply; see xxx for a description about how each profile property is mixed. The command line switches in Item 4 are
processed last, so they will always override any existing profile property.

Command line switches have the form

  -*variable* *value*

Or...

  --*long-variable-name* *value*

Not all switches have short-name (single-dash) variants. See xxx for a complete list of command line switches.

The build system also supports switches to have the form

  *variable*=*value*

This was the form required by the legacy build system released with Dojo v1.6-; it is deprecated in favor of the
more-traditional form.

The build system includes the command switch ``--check-args`` which processes the command line, reads all profile,
dojoConfig, require, and package resources, and then prints out the raw input. This switch is a great tool for
understanding and debugging how a particular build system invocation is consuming the command line. For example,

.. code-block :: text

    ~/dev/dtk/util/buildscripts:./build.sh --v1 someValue --v2 123 --true true --false false --null null --check-args
    running under node.js
    {
        false:false,
        null:null,
        profiles:[],
        true:true,
        v1:"someValue",
        v2:123
    }

This example points out that number, true, false, and null values are not stored as strings but rather are converted to
JavaScript numbers, booleans, and null.

Profile Basics
==============

As described above, the profile used for any particular invocation of the build system is constructed as the aggregate
of one or more resources specified on the command line. Usually, either a profile resource or a loader configuration
resource is used as the basis for the aggregate.

Profile Resources
-----------------

A profile resource is a JavaScript resource that defines the variable ``profile``, which must be a JavaScript
object. Typically, a profile resource is given the file type
".profile.js". /util/build/examples/simple1.profile.js contains a trivial example; here are the contents of that
resource:

.. js ::

  var profile = {
    someProperty:"someValue",
    someOtherProperty:"someOtherValue"
  };

If we invoke the build system with the ``profile`` switch indicating that profile and dump the result with the
``check-args`` switch, this is what you'll see:

.. code-block :: text

  ~/dev/dtk/util/buildscripts:./build.sh --profile ../build/examples/simple1 --check-args
  running under node.js
  processing profile resource /home/rcgill/dev/dtk/util/build/examples/simple1.profile.js
  {profiles:[{
     basePath:"/home/rcgill/dev/dtk/util/build/examples",
       someOtherProperty:"someOtherValue",
     someProperty:"someValue"
  }]}

Notice the build system automatically appends the ".profile.js" suffix to the profile argument if that argument does not
contain a file type. When a profile argument is given with no file type, *and* the profile argument contains no path
segments, *and* the profile resource does not exist in the current working directory, then the build system will try to
find the profile in the /util/buildscripts/profiles directory after appending the file type ".profile.js". It is
possible to specify a profile with a file type different than ".profile.js" by including the file type in the profile
argument. Of course you can give the ".profile.js" type explicitly as well.

Notice that the property ``basePath`` was automatically added to the profile object and set to the path at which the
profile resides. If the profile contains the property ``basePath`` and the value of that property is a relative
path, then the build system will automatically resolve that path with respect to the directory in which the profile
resources resides--*not* the current working directory. For example, /util/build/examples/relative-base-path.profile.profile.js
has contents:

.. js ::

    var profile = {
        basePath:"."
    };

Which causes the following ``basePath`` initialization:

.. code-block :: text

    ~/dev/dtk/util/buildscripts:./build.sh --profile ../build/examples/relative-base-path --check-args
    running under node.js
    processing profile resource /home/rcgill/dev/dtk/util/build/examples/relative-base-path.profile.js
    {profiles:[{basePath:"/home/rcgill/dev/dtk/util/build/examples"}]}

``basePath`` is used as the reference path when resolving relative source paths. This design allows the semantics of
relative paths contained within the profile resource te be independent of both the location of the package hierarchy
within the greater file system and the current working directory at the time the build program is invoked.

Profile resources are JavaScript resources that are evaluated by the build system. They are not restricted to hold
JSON. They can, and often will, contain functions. For example, /util/build/examples/profile-with-code.profile.js
has contents:

.. js ::

    function timestamp(){
        // this function isn't really necessary...
        // just using it to show you can call a function to get a profile property value
        var d = new Date();
        return d.getFullYear() + '-' + (d.getMonth()+1) + "-" + d.getDate() + "-" +
            d.getHours() + ':' + d.getMinutes() + ":" + d.getSeconds();
    }
    
    var profile = {
        basePath:".",
        buildTimestamp:timestamp()
    };

When exercised with the ``check-args`` switch, you should see something like this:

.. code-block :: text

    ~/dev/dtk/util/buildscripts:./build.sh --profile ../build/examples/profile-with-code --check-args
    running under node.js
    processing profile resource /home/rcgill/dev/dtk/util/build/examples/profile-with-code.profile.js
    {profiles:[{
         basePath:"/home/rcgill/dev/dtk/util/build/examples",
         buildTimestamp:"2011-9-29-21:34:2"
    }]}

Configuration Resources
------------------------

The command switch ``dojoConfig`` causes the build system to read a configuration as given by a variable ``dojoConfig`` as
if it was an ordinary profile. The next section describes how the build system consumes configurations. Also note that
the dojo loader will simply ignore any configuration variable that it does not define. These two features combine to
allow all or part of an application's build profile to be contained within the application configuration. For example,
/util/build/examples/dojoConfig.js has contents:

.. js ::

    var dojoConfig = {
        packages:[{
            name:"dojo",
            location:"../../../dojo"
        },{
            name:"dijit",
            location:"../../../dijit"
        }]
    };

When exercised with the ``check-args`` switch, you should see something like this:

.. code-block :: text

    ~/dev/dtk/util/buildscripts:./build.sh --dojoConfig ../build/examples/dojoConfig.js --check-args
    running under node.js
    processing dojoConfig resource /home/rcgill/dev/dtk/util/build/examples/dojoConfig.js
    {profiles:[{
         basePath:"/home/rcgill/dev/dtk/util/build/examples",
         packages:[
                 {
                         location:"../../../dojo",
                         name:"dojo"
                 },
                 {
                         location:"../../../dijit",
                         name:"dijit"
                 }
         ]
    }]}

Notice that basePath, as automatically provided by the build system, when combined with the package locations, give the
correct locations of the dojo and dijit packages. Also take note that you must provide the complete filename, including
the file type (if any).

The command switch ``require`` is similar to ``dojoConfig``, but processes a configuration argument applied to the
global AMD require function. For example, /util/build/examples/require.js has contents:

.. js ::

    require({
        packages:[{
            name:"dojo",
            location:"../../../dojo"
        },{
            name:"dijit",
            location:"../../../dijit"
        }]
    });

When exercised with the ``check-args`` switch, you should see something like this:

.. code-block :: text

    ~/dev/dtk/util/buildscripts:./build.sh --require ../build/examples/require.js --check-args
    running under node.js
    processing require resource /home/rcgill/dev/dtk/util/build/examples/require.js
    {profiles:[{
         basePath:"/home/rcgill/dev/dtk/util/build/examples",
         packages:[
             {
                     location:"../../../dojo",
                     name:"dojo"
             },
             {
                     location:"../../../dijit",
                     name:"dijit"
             }
         ]
    }]}

As usual, if absent or relative, basePath is automatically computed. Just like ``dojoConfig``, you must provide the
complete filename.

package.json Resources
----------------------

The command switch ``package`` indicates a package.json file or files, and works slightly differently than the others
discussed so far. First, since the filename is fixed ("package.json"), the file path at which the package.json file
resides is given, absent the explicit name "package.json". Second, more than one package.json files may be given by
providing a comma-separated list of file paths.

As each package.json resource is processed, a profile object is manufactured with the following contents (the variable
``packageJson`` in the code that follows represents the package.json object):

.. code-block :: text

    {
        basePath:
        packages:[{
            name:packageJson.progName || packageJson.name,
            packageJson:{
                __selfFilename:<path at which the package.Json file resides>
                <remaining packageJson properties>
            }
        }]
    }

Notice that the package.json object is embedded in a package configuration object that the package.json object
represents. Also notice that the property `selfFilename` is set the absolute path at which the package.Json file
resides and is added to the package.Json object. This gives the reference path for any relative paths found in the
package.json object, the ``directories.lib`` path in particular.

Specifying Resources
====================

The build system "discovers" the set of resources to process by traversing a set of file system trees, individual
directories, and/or individual files. There are two ways to specify which trees, directories, and/or files to
discover:

* provide an explicit list of trees, directories, and/or filenames by providing values for the profile properties
  ``trees``, ``dirs``, and ``files``.

* provide a loader configuration that includes one or more package configurations. All resources in the tree implied by
  the package configuration ``location`` property will be discovered; further, each package configuration may contain
  it's own set of ``trees``, ``dirs``, and ``files`` properties.

Trees, Dirs, and Files
----------------------

The profile properties ``trees``, ``dirs``, and ``files`` all have the same format: an array of (source,
destination [,ignore]) pairs or triples. The source and destination are path names for ``trees`` and ``dirs`` and
filenames for ``files``. In each case the properties say where to discover resources and where to output the
discovered resources after they have been transformed.

The optional ignore value is a regular expression that solves for resources that should be ignored. As each resource is
discovered, the full filename (including the complete path), is tested against the regular expression; if the regular
expression is satisfied, then the resource is not entered into the transform process. The ignore parameter should not be
used with ``files``, since this property gives a specific set of filenames to discover; after all, if you want to ignore
a specific filename, then just don't put it into the ``files`` property to begin with. Typically, the ignore regular
expression is used to exclude files such as version control files and editor backup files that ought not be part of a
deployment. A common ignore regular expression is ``/(\/\.)|(~$)/``.

In the case of ``trees``, the discover process discovers all files in the file system hierarchy rooted at each given
source path and schedules those resources for writing to the same relative location in the hierarchy rooted at the
associated destination path. ``dirs`` works the same except that only each single directory is processed--the tree is
not traversed. Lastly, ``files`` simply lists a set of specific files to discover.

Relative Paths
--------------

Typically, profiles should *not* contain absolute paths. Instead all paths should be relative which allows project
trees to be copied to different environments without affecting location semantics. All relative source paths (for example,
a relative source value in a ``trees`` item) are computed with respect to the profile property ``basePath``. Recall
from the previous section that the build system will automatically resolve a relative ``basePath`` value with respect
to the path in which the profile resides, and if missing, ``basePath`` defaults to ``"."``.

Relative destination paths are computed with respect to the profile property ``releaseDir``, optionally with a
concatenated path segment given by profile property ``releaseName``. If ``releaseDir`` is relative, then it
is taken to be relative to ``basePath``; if ``releaseDir`` is missing, then it defaults to ``"./release"``. The result
of normalizing ``releaseDir`` (if necessary) and appending ``releaseName`` (if any) is termed "destBasePath".

Let's look at an example. Consider the following file hierarchy (note: the Dojo Toolkit is distributed with
the package.json and profile files indicated below--these are a good source of examples):

.. code-block :: text

    ~/dev
        /dtk
            /dojo
                package.json
                dojo.profile.js
            /dijit
                package.json
                dijit.profile.js
            /dojox
            /util
                /doh
                    package.json
                    doh.profile.js
        /myapp
            main.html
            config.js
            app.profile.js
            /lib
                package.json
        /myapp-deploy
            /lib
                /dojo
                /dijit
                /myapp

Let's assume the myapp directory holds an application and it is desired to write the built resource hierarchy for the
application to the directory ~/dev/myapp-deploy. In this case, the myapp profile file at ~/dev/myapp/app.profile.js
might look like this:

.. js ::

    var profile = {
        // point basePath to ~/dev
        basePath:"..",
    
        releaseDir:"./myapp-deploy",
        trees:[
            ["./dtk/dojo", "./lib/dojo"]
            ["./dtk/dijit", "./lib/dijit"]
            ["./myapp/lib", "./lib/myapp"]
    }

Caution: this is not the best way to express this profile; in a moment we'll see how package configurations should be
used instead. However, this example illustrates three key points:

1. Paths can usually be relative. When they can be relative, they should be relative.
2. Resources can be discovered anywhere within the reachable file system.
3. The tree layout can be changed between source and destination locations.

Using a Package Configuration
-----------------------------

Recall a package configuration includes the property ``location`` that gives the root of all package resources. If
``location`` is missing, then it defaults to the package name. If ``location`` is *not* an absolute URL (the
usual case), then it is prefixed with the loader configuration property ``baseUrl``. Since ``baseUrl`` makes little
sense in the context of the build system which is executed with respect to the local file system rather than an HTTP
server, the build system uses the profile property ``basePath`` in place of ``baseUrl`` when resolving relative
paths. With the exception of substituting ``basePath`` for ``baseUrl`` the build system consumes package
configurations just like the loader. Here is the previous example expressed using this feature:

.. js ::

    var profile = {
        // point basePath to ~/dev
        basePath:"..",

        // point releaseDir to ~/dev/myapp-deploy
        releaseDir:"./myapp-deploy"
 
        // now a typical loader packages configuration
        packages:[{
            name:"dojo",
            location:"./dtk/dojo"
        },{
            name:"dijit",
            location:"./dtk/dijit"
        },{
            name:"myapp",
            location:"./myapp/lib"
        }],
    }

The destination location of each package may be given explicitly in the optional, per-package ``destLocation``
property. If it is missing, then it defaults to the package name, a child of the release directory.

The real power of this feature is not expressing these package hierarchies in a profile, but rather using the
application configuration to get the hierarchies for free. For example, assume the myapp application expressed its
configuration in the resource ~/dev/myapp/config.js like this:

.. js ::

    var dojoConfig = {
        // loader configuration...
        packages:[{
            name:dojo,
            location:"./dtk/dojo"
        },{
            name:dijit,
            location:"./dtk/dijit"
        },{
            name:myapp,
            location:"./myapp/lib"
        }],
        deps:["main"]
    }

This configuration may be used to load the application, maybe something like this in the <head> element in
~/dev/myapp/main.html.

.. html ::

    <head>
        <script src="./config.js"></script>
        <script src="../dtk/dojo/dojo.js"></script>
        <!-- other stuff...maybe -->
    </head>

Given this, the profile at ~/dev/myapp/app.profile.js could be rewritten like this:

.. js ::

    var profile = {
        // point basePath to ~/dev
        basePath:"..",
        releaseDir:"./myapp-deploy",
    }

Finally, both the config.js and profile must be provided to the build system to get the desired effect

.. code-block :: text

    ~/dev/dtk/util/buildscripts:./build.sh --dojoConfig ../../myapp/config.js --profile ../../myapp/app --release

(Call this example "config and profile" it is equivalent to the example "config with embedded profile" described below.)

This idea of leveraging a loader config can be taken further. Since the dojo loader will simply ignore properties that
it does not define, you can put profile properties directly in the loader configuration. For example,
~/dev/myapp/config.js could be written as follows:

.. js ::

    var dojoConfig = {
        // loader configuration...
        packages:[{
            name:dojo,
            location:"./dtk/dojo"
        },{
            name:dijit,
            location:"./dtk/dijit"
        },{
            name:myapp,
            location:"./myapp/lib"
        }],
        deps:["main"],

        // now for some profile properties...

        // point basePath to ~/dev
        basePath:"..",

        // point releaseDir to ~/dev/myapp-deploy
        releaseDir:"./myapp-deploy"
    }

This eliminates the need for the profile resource completely.

The build system recognizes the property ``build`` which may hold a profile object that is mixed into the configuration
object as if the profile object was specified on the command line following the configuration resource. This design
serves two purposes:

1. It keeps all build-time profile properties nicely bundled under a single property in what is otherwise a loader
configuration object.

2. It provides a method to make changes to some of the loader configuration when it is consumed as a build profile.

For example, the previous loader configuration could be rewritten as follows:

.. js ::

    var dojoConfig = {
        // loader configuration...
        packages:[{
            name:dojo,
            location:"./dtk/dojo"
        },{
            name:dijit,
            location:"./dtk/dijit"
        },{
            name:myapp,
            location:"./myapp/lib"
        }],
        deps:["main"],

        // now for some profile properties...
        build:{
            // point basePath to ~/dev
                basePath:"..",

            // point releaseDir to ~/dev/myapp-deploy
            releaseDir:"./myapp-deploy"
        }
    }

And used to execute a build like this:

.. code-block :: text

    ~/dev/dtk/util/buildscripts:./build.sh --dojoConfig ../../myapp/config.js --release

(Call this example "config with embedded profile"; it is equivalent to the example "config and profile" described above.)

Notice how this design eliminates the need to repeat resource location information. Since the development version of the
application has already specified (and debugged!) this information; there is no reason to force an independent
specification for the build profile.

There are a few additional details about package configurations when they are consumed by the build system. First, they
can specify different values for all package config object properties as follows:

* ``name`` may be changed by giving a value for ``destName``
* ``location`` may be changed by giving a value for ``destLocation``
* ``main`` may be changed by giving a value for ``destMain``
* ``packageMap`` may be changed by giving a value for ``destPackageMap``

If ``destName`` is not provided, then it defaults to ``name``. The same applies for the other properties. ``location``,
if relative, is computed with respect to ``basePath``; relative ``destLocation`` is computed with respect to the
computed destBasePath.

Second, package configurations can include the ``trees``, ``dirs``, and ``files`` properties. Relative source paths are
computed with respect to the package ``location`` property; relative destination paths are computed with respect to the
package ``destLocation`` property. The tree

.. js ::

    [".", ".", /(\/\.)|(~$)/]

is automatically provided. You can change the ignore value by giving an explicit tree item with source and destination
paths of ".".

Leveraging package.json Resources
---------------------------------

The build system can use a package.json resource to discover the location of resources and find a default profile for a
particular package. Recall, you can provide a package configuration that includes the property ``packageJson`` by
specifying a package.json resource with the command line switch ``--package``. When the build system encounters such a
package config, it will consume the following properties of that object:

* ``directories.lib``, indicating the packages ``location`` property value.
* ``main``, indicating the package's ``main`` property value
* ``version``, indicating the package's version
* ``dojoBuild``, indicating the default profile associated with the package

Relative paths are computed with respect to the path at which the package.json resource resides.

Given this design, you could build the myapp example *without* mentioning the dojo or dijit packages in the profile,
instead supplying the command line argument ``--package ../../dojo,../../dijit``. In practice, this technique is
typically used to execute the default profile of a package. For example, the default profile for dojo can be build like
this:

.. code-block :: text

    ~/dev/dtk/util/buildscripts:./build.sh --package .../../dojo

This is possible because of the dojo package.json resource contains the property dojoBuild which indicates the
default profile for the package. As usual, it should be a relative filename and is computed with respect to the path at
which the package.json resource resides.

The design of the ``dojoBuild`` property is quite handy. For example, the authors of the myapp program may not be
experts on how best to build dojo or dijit. The idea of a default profile as indicated by the ``dojoBuild`` property
solves this problem even when the package.json resource is not mentioned explicitly. Here's how it works.

When the build system is given a profile that contains a set of packages, it automatically attempts to find and consume
each package's package.json resource. The system looks for the file "package.json" in the directory given by the package
configuration ``location`` property. If a package.json resource is found and that resource contains a ``dojoBuild``
property, then the build system automatically consumes that default profile for that package. The build system will use
any properties in the default profile that are not explicitly mentioned a profile provided at the command line; this
allows an easy way to selectively override profile property values found in the default profile for a particular
package or build scenario.

Mixing Multiple Profile Sources
-------------------------------

Profiles and profile properties can come from many sources:

* profile resources
* dataConfig and/or require configuration resources
* package.json resources
* default profiles as given by package.json resources
* individual profile property values can be given directly on the command line

This begs the question, what happens when multiple sources try to set the same package property? The answer: generally,
properties are mixed so that properties that come from sources specified later on the command line overwrite properties
from sources specified earlier. Profile properties are mixed on a per-property basis except for the properties
``packages``, ``paths``, ``plugins``, ``messages``, ``transforms``, and ``staticHasFeatures`` which are mixed
differently. ``packages`` are mixed on a per-package-property basis. See xxx for details about how these other
properties are mixed. Let's look at an example; consider the following two profiles:

*profile-1.profile.js*

.. js ::

  var profile = {
      propA:"A",
      propB:"B",
      propC:"C",
      packages:[{
          name:"myPackage",
          location:"../packages",
          destLocation:"./lib"
      }]
  }

*profile-2.profile.js*

.. js ::

  var profile = {
      propB:"profile-2-B",
      propC:"C",
      propD:"D",
      packages:[{
          name:"myPackage",
          destLocation:"./packages"
      }]
  }

If the build system was instructed to consume profile-1 followed by profile-2 like this:

.. code-block :: text

    ~/dev/dtk/util/buildscripts:./build.sh --profile path/to/profile-1 --profile path/to/profile-2

Then the following profile object would be computed:

.. js ::

  {
      propA:"A",                    // from profile-1
      propB:"profile-2-B",          // overwrite form profile-2
      propC:"C",                    // overwrite from profile-2 that happens to be the same as profile-1
      propD:"D",                    // from profile-2
      packages:[{
          name:"myPackage",         // from profile-2
          location:"../packages",   // from profile-2
          destLocation:"./packages" // overwrite form profile-2
      }]
  }

Lastly, any profile property given on the command line will overwrite any value for that property as computed by mixing
various other profile resources.

Advice
------

Clearly, there are a lot of ways to specify profiles in general and how resources are discovered in particular. Build
scenarios can be trivial or complex, depending upon the particular application. If you've got a tricky use case, the
design described above can almost-certainly handle it. To put a fine point on this, the build system can discover
resources from any reachable path and similarly write transformed resources to any reachable path. There are no
assumptions, restrictions, or requirements imposed by where and how the Dojo Toolkit hierarchy is installed.

Typically, the best way to organize a profile for an application is as follows:

1. Install all dependency packages as per their instructions. Don't fight other package authors.

2. Organize the source code for the application into one or more packages as is appropriate for the design.

3. Construct a JavaScript resource that contains the loader configuration necessary to develop the application. Don't
   worry about build issues while developing the application. This resource should be included in appropriate HTML
   resources via a script element before including the dojo loader. Typically, the configuration should reside at the
   root of the application hierarchy, but this is not required.

4. When it comes time to optimize the application for deployment, construct a profile for the application, but do not
   use the profile to specify resources already specified in the configuration constructed in Step 3. Instead, use the
   profile to modify *some* properties in the configuration (if necessary at all) as well as to specify various profile
   properties that control the transforms.

Alternatives/extensions to this general procedure include:

* Providing a default profile for each package the application defines.

* Including all build profile values in the loader configuration resource (they will simply be ignored by the loader).

* Making the configuration configurable, typically depending on a URL query parameter or build switch.

Don't be concerned about the need to download an extra resource to configure the application. As well see in xxx,
the writeDojo transform allows a customized configuration to be embedded in the loader resource and the replacements
transform allows chunks of resources, like the configuration script element, to be replaced--perhaps with nothing.

Resource Tags
=============

The most fundamental attribute of a resource used to indicate which transforms to apply is its file type. Unfortunately
this usually isn't enough. For example, it may be desirable to not apply any transforms to test resources. The build
system includes machinery to "tag" resources with various flags that may be used to signal which transforms to apply.

A profile and each package configuration may contain the property ``resourceTags``, a hash from tag name to
function. Each function takes two arguments, filename and module-id, and returns true if a given resource should be
tagged with the associated tag or false otherwise. All tag tests are applied to every resource and any single resource
may be tagged with several tag names. See the resources dojo/dojo.profile.js for an example.

The dojo build system decides which transforms to apply to a particular resource based its file type and the following
tags:

``test``
  The resource is part of the test code for the package.

``copyOnly``
  The resource should be copied to the destination location and otherwise left unaltered.

``amd``
  The resource is an AMD module.

``declarative``
  The resource should be scanned for declarative dependencies, pending inclusion in a layer.

``miniExclude``
  The resource should not be copied to the destination if the profile property "mini" is truthy.

Transforms
==========

The Dojo Toolkit includes the deployment optimization transforms listed below. See individual transform reference pages
for complete documentation.

* :ref:`copy <build/transforms/copy>`: Copies a resource from a source location to a destination location.

* :ref:`depsDeclarative <build/transforms/depsDeclarative>`: Scans declarative resources for dependencies and replaces the resource in any layer with any discovered dependencies.

* :ref:`depsDump <build/transforms/depsDump>`: Prints the module dependency graph of one or more modules.

* :ref:`depsScan <build/transforms/depsScan>`: Determines a module's dependencies and interns legacy dojo.cache string resources.

* :ref:`dojoPragmas <build/transforms/dojoPragmas>`: Applies dojo pragmas to a resource.

* :ref:`dojoReport <build/transforms/dojoReport>`: Outputs a report describing a single run of the deployment optimization transforms.

* :ref:`hasFindAll <build/transforms/hasFindAll>`: Finds and optionally reports all has.js feature test usages.

* :ref:`hasFixup <build/transforms/hasFixup>`: Trims dead code branches consequent to has feature values known at build time.

* :ref:`hasReport <build/transforms/hasReport>`: Outputs a report describing the name and location of all has.js feature tests.

* :ref:`insertSymbols <build/transforms/insertSymbols>`: Inserts debugging symbols into JavaScript resources.

* :ref:`optimizeCss <build/transforms/optimizeCss>`: Inlines CSS imports and/or removes comments from CSS files.

* :ref:`read <build/transforms/read>`: Reads a resource from the file system.

* :ref:`write <build/transforms/write>`: Writes a resource to the file system.

* :ref:`writeAmd <build/transforms/writeAmd>`: Writes an AMD module to the file system.

* :ref:`writeDojo <build/transforms/writeDojo>`: Outputs a module that includes the dojo loader; this transform is responsible for writing dojo.js.

* :ref:`writeOptimized <build/transforms/writeOptimized>`: Processes a resource with shrinksafe, closure, or uglifyjs (version 1.x) compiler and writes the result to the file system.

Applying Transforms
===================

As each resource is discovered, it is submitted to a set of
transforms. The build system decides which transforms to apply by testing each resource against the conditions listed
below, in the order listed. The first test that passes indicates the transforms to apply.

1. Tagged ``ignore``

  * Do nothing; the resource is not read or written

2. Tagged ``miniExclude`` and ``profile.mini`` is true

  * Same as [1]

3. Tagged ``test`` and ``profile.copyTests`` is false

  * Same as [1]

4. Tagged ``copyOnly``

  * Copy resource from source location to destination location (copy).

5. The module ``"dojo/dojo"``

  * Read the resource (read)
  * Apply dojo pragmas (dojoPragmas)
  * Find all has.js applications (hasFindAll)
  * Trim dead code branches as given by static, build-time has feature values (hasFixup)
  * Write the processed loader module to the destination with a configuration (writeDojo)
  * Optimize the module with shrinksafe, closure, or uglifyjs (version 1.x) compiler and write the optimized module to the destination (writeOptimized).

6. Modules with the segment ``"/nls/"`` in their module identifier

  * Read the resource (read)
  * Apply dojo progras (dojoPragmas)
  * Find all has.js applications (hasFindAll)
  * Find all dependencies for the module (depsScan)
  * Write the processed  module to the destination (writeAmd)

7. resources  with ``"/nls/"`` in their filename and the filetype of ".js"

  * Same as [6].

8. Tagged ``"synthetic"`` and ``"amd"``

  * Find all dependencies for the module (depsScan)
  * Write the processed  module to the destination (writeAmd)
  * Optimize the module with shrinksafe, closure, or uglifyjs (version 1.x) compiler and write the optimized module to the destination (writeOptimized).

9. Tagged ``"amd"``

  * Read the resource (read)
  * Apply dojo progras (dojoPragmas)
  * Find all has.js applications (hasFindAll)
  * Insert debugging symbols (insertSymbols)
  * Trim dead code branches as given by static, build-time has feature values (hasFixup)
  * Find all dependencies for the module (depsScan)
  * Write the processed  module to the destination (writeAmd)
  * Optimize the module with shrinksafe, closure, or uglifyjs (version 1.x) compiler and write the optimized module to the destination (writeOptimized).


10. Resource has a filetype of ".js" and is tagged ``"test"`` and ``profile.copyTests`` is build

  * Same at [9].

11. Resource has filetype of ".js" and is tagged is not tagged ``"test"``

  * Same as [9].

12. Tagged as ``"test"``

  * Read the resource (read)
  * Apply dojo progras (dojoPragmas)
  * Write the processed  module to the destination (write)

13. Resource has file type of ".html" or ".htm"

  * Same at [12].

14. Resource has file type of ".css"

  * Read the resource (read)
  * Optimize CSS (optimizeCss)
  * Write the processed  module to the destination (write)

15. Any other resource

  * Copy resource from source location to destination location (copy).

Command Line and Profile Property Reference
===========================================

See :ref:`Build Profile Quick Reference Guide <build/qref>`
