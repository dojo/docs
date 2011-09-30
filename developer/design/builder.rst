#format dojo_rst

The Dojo Build System
=====================

:Status: Draft
:Version: 1.7+
:Author: Rawld Gill

.. contents::
   :depth: 2

The Dojo Build System

``This document describes the Dojo build system as of v1.7. Historical documentation describing the legacy build system
is available here: xxx``

============
Introduction
============

The Dojo build system is a general-purpose program for transforming a set of resources. It was built to solve the
problem of transforming a set of resources that comprise an application in order to improve the performance of that
application. For this particular purpose, two kinds of transformations are typical:

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

These kind of optimization are termed "deployment optimizations", and the build system includes a rich set of such
optimizations that may be applied to an application prior to deployment. However, the build system is not limited to
these kind of transforms. At its core, the build system is an engine for applying an ordered, synchronized, configurable
set of transforms to a configurable input set. Examples of other usages include document generators, style checkers,
code formatters, lint checkers, and many more. In some ways it is like a make program, except the external processes
that typical make programs execute can be implemented within its the pluggable transform infrastructure. Of course external
processes can be executes as well.

This document describes using the build system for deployment optimizations. See xxx for information about writing your
own custom transforms and configuring the build system for other uses.

========
Overview
========

The overall design of the system is simple. It "discovers" a set of resources and applies a synchronized, ordered set of
resource-dependent transforms to those resources. Both the discovery process and the transforms are controlled by a
user-configurable Javascript object termed a "profile".

When a resource is discovered, it is tagged with one or more flags that help identify the role of that resource. For
example, an AMD module may be tagged "AMD". The profile controls how resources are tagged. After a resource is
discovered and tagged, the system assigns a set of transforms that are to be applied to that resource. This assignment
is based on the resource tags and/or filename and is also controlled by the profile. Then the system takes over and
automatically applies each assigned transform. Once all assigned transforms have been applied to all discovered
resources the program terminates.

Let's look at a couple of examples. Perhaps the simplest transform is to do nothing--don't read the resource, don't
write the resource, don't do anything. Such a "noop" may be applied to version control files, backup files, and other
such files that should not be moved to the deployment tree. 

A slightly more interesting example is a resource that is copied from the development tree to the deployment
tree. Notice that part of such a process causes the build system to "know" that the deployment tree will contain the
resource. This knowledge may be used by other transforms that ensure requisite files exist. For example, a CSS style
sheet checker could check to see that all referenced images existed.

Perhaps the most important transform for resource deployment is dependency scanning Javascript modules and then bundling
dependencies into a single resource to reduce the HTTP transactions required to load a resource.

Available Deployment Optimization Transforms
--------------------------------------------

Dojo includes the deployment optimization transforms listed below. This document gives an overview of each
transform; a more-detailed reference guide is also available for each transform.

compactCss
  Compacts CSS style sheets.

copy
  Copies a resource from a source location to a destination location.

depsDump
  Prints the module dependency tree of an application.

depsScan
  Determines a modules dependencies and interns dojo.cache string resources.

dojoBoot
  Outputs a module that includes the dojo loader; this transform is responsible for writing dojo.js.

dojoPragmas
  Applies dojo pragmas to a resource.

dojoReport
  Outputs a report describing a single run of the deployment optimization transforms.

hasFindAll
  Outputs a report of all has.js usages.

hasFixup
  Trims dead code branches consequent to has feature values known at build time.

hasReport
  Outputs a report describing the name and location of all has.js feature tests

insertSymbols
  Inserts debugging symbols into Javascript resources.

read
  Reads a resource from the file system.

write
  Write a resource to the file system.

writeAmd
  Writes an AMD module to the file system.

writeCss
  Writes a CSS style sheet to the file system

writeDojo
  Outputs a module that includes the dojo loader; this transform is responsible for writing dojo.js.

writeOptimized
  Processes a resource with shrinksafe or the closure compiler and writes the result to the file system.

Quick Reference Guide
---------------------

A _quick reference guide_ is available that lists all command line options and profile switches that control resource
discovery and the transforms.

Advanced Topics
---------------

The build system may be used to execute advanced deployment optimization scenarios. These are discussed in
separate documents as follows:

xxx
  Describes how to build a custom dojo.js with a nonstandard set of modules.

xxx 

  Describes how to build packages that relocate module namespaces (this feature replaces the legacy so-called
  multi-version feature).

Road Map
--------

The remainder of this document describes how use the build system for deployment optimization. The following topics are
covered in order:

1. How to invoke the system.

2. How to control the build system with command line switches.

3. How to configure profiles to indicate what resources to discover and where to output the transformed resources.

4. What set of transforms are available and the kinds of resources those transforms are applied to.

========================
Assumptions for Examples 
========================

This document contains several examples. It assumes the source distribution of the Dojo Toolkit, version 1.7 or greater,
is installed at ~/dev/dtk/. If you are a Windows user, "~" is shorthand for the user's home directory; substitute
whatever directory is convenient for you. For all users, there is nothing special about ~/dev/. We are just using to
indicate the root of that holds the Dojo Toolkit source distribution.

Unless specifically stated otherwise, all examples assume the current working directory is
~/dev/dtk/util/buildscripts. As we'll see, this is not a requirement of the the build system, both rather a convenience
to not have to path to the build system executable.

=========================
Invoking the Build System
=========================

The build system is a Javascript program comprised of a set of AMD modules that may be executed by node.js or Rhino. The
program is distributed with the source version of the Dojo Toolkit. The source tree resides at util/build/. Dojo can be
used to execute console-based Javascript programs in node by issuing the following command:

.. code-block :: text

  node.js path/to/dojo.js load=path/to/startup-module.js <program arguments>

Traditionally, the dojo build system is executed from the /util/buildscripts/ directory. For example, assuming the source
version of the Dojo Toolkit is installed at ~/dev/dtk/, in order to invoke the build system and print the help
message, issue the command:

.. code-block :: text

  ~/dev/dtk/util/buildscripts> node.js ../../dojo/dojo.js load=build --help

Rhino may also be used. Owing the the requisite Java noise, its command is more complicated:

.. code-block :: text

  ~/dev/dtk/util/buildscripts> java -Xms256m -Xmx256m -cp ../shrinksafe/js.jar:../closureCompiler/compiler.jar:../shrinksafe/shrinksafe.jar org.mozilla.javascript.tools.shell.Main  ../../dojo/dojo.js baseUrl=../../dojo" --help

In order to ease this pain, util/buildscripts/ includes a batch program for Windows and a shell script for non-Windows
environments. For the shell script, simply issue the command

.. code-block :: text

  ~/dev/dtk/util/buildscripts> ./build.sh --help

And for Windows:

.. code-block :: text

  ~/dev/dtk/util/buildscripts> ./build.bat --help

The shell script will prefer node.js if it is available. If you would rather use Rhino, you can use the command line
swith ```bin=java``` like this:

.. code-block :: text

  ~/dev/dtk/util/buildscripts> ./build.sh bin=java --help

The Windows batch file always uses Rhino, but includes some hints about how to use node.js if you have a node.js
installed.

Although the legacy build system could be executed when /util/buildscripts/ was ''not'' the current working directory, to
do so required a carefully constructed profile. Indeed, many profiles provided with Dojo source distributions won't work
unless /util/buildscripts/ is the current working directory. The current build system has no such restriction.

=====================
Command Line Switches
=====================

The build system is controlled by a Javascript object termed a "profile" which instructs the system what files to
process and how to process them. The profile itself is constructed from one or more inputs:

1. Zero or more Javascript resources that contain a profile object, as specified by the command line switch
```profile``` which requires a filename argument that points to a profile resource.

2. Zero or more package.json resources that describe a CommonJS package, as specified by the command line switch
```package``` which requires a path that contains a package.json resource.

3. Zero or more loader configuration variables (dojoConfig or require), as specified by the command line switches
```require``` or ```dojoConfig``` which require a filename argument that points to a Javascript resource that contains a
loader configuration.

4. Zero or more other command line switches that give (profile-property-name, profile-property-value) pairs.

The build system processes each resource described above (Items 1-3) in the order provided on the command line; if two
or more resources attempt to set the same profile property, then the last input wins. Some profile properties are mixed
one or two-level deep; see xxx for a description about how each profile property is mixed. The command line switches in
Item 4 are always processed last, so they will always override any existing profile property.

Command line switches have the form

-''variable'' ''value''

Or...

--''long-variable-name'' ''value''

Not all switches have short-name (single-dash) variants. See xxx for a complete list of command line switches.

The build system also supports switches to have the form

''variable''=''value''

This was the form required by the legacy build system released with Dojo v1.6-; it is deprecated in favor of the
more-traditional form.

The build system includes the command switch ```check-args``` which processes the command line, reads all profile,
package, dojoConfig, and require resources, and then prints out the raw input and the resulting mixed profile. This
switch is a great resource for understanding and debugging how a particular build system invocation is consuming the
command line. For example,

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
Javascript numbers, booleans, and null.

==============
Profile Basics
==============

A profile is a Javascript object that controls the build application. As described above, it is constructed as the
aggregate of one or more resources specified on the command line. Usually, a profile resource is used as the basis for
the aggregate.

A profile resource is a Javascript resource that defines the variable ```profile```, which must be a Javascript
object. Typically, a profile resource is given the file type
".profile.js". /util/build/examples/simple-profile1.profile.js contains a trivial example; here are the contents of that
resource:

.. code-block :: javascript

  var profile = {
    someProperty:"someValue",
    someOtherProperty:"someOtherValue"
  };

If we invoke the build system with the ```profile``` switch indicating that profile and dump the result with the
```check-args``` switch, this is what you'll see:

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
contain a file type. When a profile argument is given with no file type, ''and'' the profile argument contains no path
segments, ''and'' the profile resource does not exist in the current working directory, then the build system will try
to find the profile in the /util/buildscripts/profiles directory after appending the file type ".profile.js" as
usual. It is possible to specify a profile with a file type different than ".profile.js" by including the file type in
the profile argument.

Notice that the property ```basePath``` was automatically added to the profile object and set to the path at which the
profile resides. If the profile contained the property ```basePath``` and the value of that property was a relative
path, then the build system would automatically resolve that path with respect to the directory in which the profile
resources resides--''not'' the current working directory. For example, /util/build/examples/relative-base-path.profile.profile.js
has contents:

.. code-block :: javascript

    var profile = {
    	basePath:"."
    };

Which causes the following ```basePath``` initialization:

.. code-block :: text

    ~/dev/dtk/util/buildscripts:./build.sh --profile ../build/examples/relative-base-path --check-args
    running under node.js
    processing profile resource /home/rcgill/dev/dtk/util/build/examples/relative-base-path.profile.js
    {profiles:[{basePath:"/home/rcgill/dev/dtk/util/build/examples"}]}

```basePath``` is used as the reference path when resolving relative source paths. This design allows a profile resource
to be constructed and reside within a package hierarchy in such a way that it is independent of both the location of
the package hierarchy within the file system and the current working directory at the time the build program is
invoked.

Profile resources are Javascript resources that are evaluated by the build system. They are not restricted to hold
JSON. They can, and often will, contain functions. For example, /util/build/examples/profile-with-code.profile.js
has contents:

.. code-block :: javascript

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

When exercised with the ```check-args``` switch, you should see something like this:

.. code-block :: text

    ~/dev/dtk/util/buildscripts:./build.sh --profile ../build/examples/profile-with-code --check-args
    running under node.js
    processing profile resource /home/rcgill/dev/dtk/util/build/examples/profile-with-code.profile.js
    {profiles:[{
    					 basePath:"/home/rcgill/dev/dtk/util/build/examples",
    					 buildTimestamp:"2011-9-29-21:34:2"
    				}]}

The command switch ```dojoConfig``` cause the build system read configurations as given by a variable ```dojoConfig```
as if it was an ordinary profiles. The next section describes how the build system consumes ordinary
configurations. Also note that the dojo loader will simply ignore any configuration variable that it does not
define. These two feature combine to allow all or part of an application's build profile to be contained within the
application configuration. For example, /util/build/examples/dojoConfig.js has contents:

.. code-block :: javascript

    var dojoConfig = {
    	packages:[{
    		name:"dojo",
    		location:"../../../dojo"
    	},{
    		name:"dijit",
    		location:"../../../dijig"
    	}]
    };

When exercised with the ```check-args``` switch, you should see something like this:

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
    					 				location:"../../../dijig",
    					 				name:"dijit"
    					 		}
    					 ]
    				}]}

Notice that basePath, as automatically provided by the build system, when combined with the package locations, give the
correct locations of the dojo and dijit packages. Also take note that you must provide the complete filename, including
a the file type (if any).

The command switch ```require``` is similar to ```dojoConfig```, but processes a configuration argument applied to the
global AMD require function. For example, /util/build/examples/require.js has contents:

.. code-block :: javascript

    require({
    	packages:[{
    		name:"dojo",
    		location:"../../../dojo"
    	},{
    		name:"dijit",
    		location:"../../../dijig"
    	}]
    });

When exercised with the ```check-args``` switch, you should see something like this:

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
    					 				location:"../../../dijig",
    					 				name:"dijit"
    					 		}
    					 ]
    				}]}

As usual, if absent or relative, basePath is automatically computed. Just like ```dojoConfig```, you must provide the
complete filename.

The command switch ```package``` indicates a package.json file or files, and works slightly differently than the others
discussed so far. First, since the filename is fixed ("package.json"), the file path at which the package.json file
resides is given. Second, more than one package.json files may be given by providing a comma-separated list of file
paths.

As each package.json resource is processed, a profile object is manufactured with the following contents (the variable
```packageJson``` in the code that follows represents the package.jon object):

.. code-block :: text

    {
    	basePath:
    	packages:[{
    		name:packageJson.progName || packageJson.name,
    		packageJson:{
    			__selfFilename:<path at which the package.Json file resides>
    			<packageJson properties>
    	}]
    }

Notice that the package.json object is embedded in the package object that the package.json object represents. Also
notice that the property ```__selfFilename``` is set the the absolute path at which the package.Json file resides and is
added to the package.Json object. This gives the reference path for any relative paths found in the package.json object,
the ```lib``` path in particular.

====================
Specifying Resources
====================

The build system "discovers" the set of resources to process by traversing a set of file system trees, individual
directories, and/or individual filenames. There are two ways to specify which trees, directories, and/or files to
discover:

* provide an explicit list of trees, directories, and/or filenames by providing values for the profile properties
  ```trees```, ```dirs```, and ```files```.

* provide a loader configuration that includes one or more package configurations. All resources in the tree implied by
  the package configuration ```location property``` will be discovered.

Trees, Dirs, and Files
----------------------

The profile properties ```trees```, ```dirs```, and ```files``` all have the same format: an array of (source,
destination [,ignore]) pairs or triples. The source and destination are path names for ```trees``` and ```dirs``` and
filenames for ```files```. In each case the properties say where to discover resources and where to output the
discovered resources after they have been transformed. 

The optional ignore value is a regular expression that finds resources that should be ignored. As each resource is
discovered, the full filename (including the complete path), is tested against the regular expression; if the regular
expression is satisfied, then the resource is not entered into the transform process. The ignore parameter should not be
used with ```files```, since this property gives a specific set of filenames to discover; if you want to ignore a
specific filename, then just don't put it into the ```files``` property to begin with. Typically, the ignore regular
expression is used to exclude files such as version control files and editor backup files that ought not be part of a
deployment. A common ignore regular expression is ```/(\/\.)|(~$)/```.

In the case of ```trees```, the discover process discovers all files in the file system hierarchy rooted at each given
source path and schedules those resources for writing to the same relative location in the hierarchy rooted at the
associated destination path. ```dirs``` works the same except that only each single directory is processed--the tree is
not traversed. Lastly, ```files``` simply lists a set of specific files to discover.

Relative Paths
--------------

Typically, profiles should ''not'' contain absolute paths. Instead all paths should be relative which allows project
trees to be copied to different environments without affects location semantics. All relative source paths, for example,
a relative source value in a ```trees``` item, are computed with respect to the profile property ```basePath```. Recall
from the previous section that the build system will automatically resolve a relative ```basePath``` value with respect
to the path in which the profile resides, and if missing, ```basePath``` defaults to ```"."```.

Relative destination paths are computed with respect to the profile property ```releaseDir```, optionally with a
concatenated path segment given by profile property ```releaseName``` (if any). If ```releaseDir``` is relative, then it
is taken to be relative to ```basePath```; if ```releaseDir``` is missing, then it defaults to ```"./release"```. 

Let's look at a best-practice example. Consider the following file hierarchy (note: the Dojo Toolkit is distributed with
the package.json and profile files indicated above. They are also a good source of examples):

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
        /acme
            main.html
            config.js
            /lib
                package.json
                app.profile.js
        /acme-deploy
            /lib
                /dojo
                /dijit
                /acme

Let's assume the acme directory holds an application and it is desired to write the built resource hierarchy for the
application to the directory ~/dev/acme-deploy. In the case, the acme profile file at ~/dev/acme/lib/app.profile.js
might like like this:

.. code-block :: javascript

    var profile = {
    	// point basePath to ~/dev
    	basePath:"../..",
    
    	releaseDir:"./acme-deploy",
    	trees:[
            ["./dtk/dojo", "./lib/dojo"]
            ["./dtk/dijit", "./lib/dijit"]
            ["./acme/lib", "./lib/acme"]
    }

Caution: this is not the best way to express this profile; in a moment we'll see how package configurations should be
used instead. However, this example illustrates a three of key points:

1. Paths ofte can be relative, and when the can be relative, they should be relative.
2. Resources can be discovered anywhere within the reachable file system.
3. The tree layout can be changed between source and destination locations.

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

Using a Package Configuration
-----------------------------

Recall a package configuration includes the property ```location``` that gives the root of all package resources. If
```location``` is missing, then it is taken to be the package name. If ```location``` is ''not'' an absolute URL (the
usual case), then it is prefixed with the loader configuration property ```baseUrl```. Since ```baseUrl``` makes little
sense in the context of the build system which is executed with respect to the local file system rather than an HTTP
server, the build system uses the profile property ```basePath``` in place of ```baseUrl``` when resolving relative
paths. With the exception of substituting ```basePath``` for ```baseUrl``` the build system consumes package
configurations just like the loader. Here is the previous example expressed using this feature:

.. code-block :: javascript

    var profile = {
    	// point basePath to ~/dev
    	basePath:"../..",
    
    	releaseDir:"./acme-deploy",
		packages:[{
			name:dojo,
			location:"./dtk/dojo"
		},{
			name:dijit,
			location:"./dtk/dijit"
		},{
			name:acme,
			location:"./acme/lib"
		}]
    }

The destination location may be given explicitly in the optional, per-package ```destLocation``` property. If it is
missing, then it defaults to the package name, a child of the the release directory.

The real power if this feature is not expressing these package hierarchies in a profile, but rather using the
application configurtion to get the hierarchies for free. For example, assume the acme application expressed its
configuration in the resource ~/dev/acme/config.js like this:

.. code-block :: javascript

    var dojoConfig = {
    	// point basePath to ~/dev
    	basePath:"..",
		
		packages:[{
			name:dojo,
			location:"./dtk/dojo"
		},{
			name:dijit,
			location:"./dtk/dijit"
		},{
			name:acme,
			location:"./acme/lib"
		}]

		deps:["main"]
	}

This configuration is used during to load the application, maybe something like this in the <head> element in ~/dev/acme/main.html.

.. code-block :: html

    <head>
        <script src="./config.js"></script>
    	<script src="../dtk/dojo/dojo.js"></script>
    	<!-- other stuff...maybe -->
    </head>

Given this, the profile at ~/dev/acme/lib/app.profile.js could be rewritten like this:

.. code-block :: javascript

    var profile = {
    	// point basePath to ~/dev
    	basePath:"../..",
    
    	releaseDir:"./acme-deploy",
    }

Finally, both the config.js and profile must be provided to the building to get the desired effect


.. code-block :: text

    ~/dev/dtk/util/buildscripts:./build.sh --dojoConfig ../../acme/config.js --profile ../../acme/lib/app.profile.js --release

Notice how this design eliminates the need to repeat resource location information. Since the development version of
the application has already specified this information; there is no reason to force an independent specification for the
build profile.

Package configurations consumed by the build system can also include the ```trees```, ```dirs```, ```files```, and
```resourceTags``` properties. Relative source paths found in any of these items are computed with respect to the
package ```location``` property. If none of these are provided, then ```trees``` defaults to

.. code-block :: javascript

    [".", ".", /(\/\.)|(~$)/]

This prevents version control files and editor backup files from being processed.

=========================
Advanced Profile Features
=========================

Dojo Pragmas
------------

TODO

Replacements
------------

TODO

Burned In Loader Config
-----------------------

TODO

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
  is given by the analogous properties destName, destLocation, destMain, and destPackageMap. Typically, the destination
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

release
  Process all profiles resources, discover and transform all resources

check
  Process all profiles resources and command line switches and dump the computed profile to the console

help
  Print the help message

version
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
