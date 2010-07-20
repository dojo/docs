#format dojo_rst

build system build script (build.sh or build.bat)
=================================================

:Status: Draft
:Version: 1.0
:Project owner: Scott Jenkins
:Available: since 1.0

.. contents::
   :depth: 2

============
Introduction
============

The ``build.sh`` (unix) or ``build.bat`` (Windows) script located in the Dojo source distrubtion tree under ``\\util\buildscripts`` is used to trigger the build process.

**Notes**  

  * For advanced users, the command line arguments to the script are passed in to the ``build.js`` execution environment as part of the overall ``kwArgs`` object that it receives.
  
  * Any of the following parameters can be set directly in the profile file as part of the overall `dependencies` Object 

=====
Usage
=====

The parameters to build are (the value after the equal sign is the default value, if one exists, as of Dojo 1.2.3):

cssImportIgnore=
  If using cssOptimize="comments", then you can force the @import inlining step to ignore a set of files by using this option. The value of this option should be a comma separated list of CSS files names to ignore. The file names should match whatever strings are used for the @import calls.

xdScopeArgs=
  If the loader=xdomain build option is used, then the value of this option will be used as the arguments to the function that defines the modules in the .xd.js files. This allows for more than one version of the same module to be in a page. See documentation on djConfig.scopeMap for more information.

cssOptimize=
  Specifies how to optimize CSS files. If "comments" is specified, then code comments and line returns are stripped, and files referenced via @import are inlined. If "comments.keepLines" is specified, then code comments are stripped and @import calls are inlined, but line returns are preserved.

releaseName=dojo
  The name of the release. A directory inside 'releaseDir' will be created with this name.

localeList=ar,ca,cs,da,de-de,el,en-gb,en-us,es-es,fi-fi,fr-fr,he-il,hu,it-it,ja-jp,ko-kr,nl-nl,no,pl,pt-br,pt-pt,ru,sk,sl,sv,th,tr,zh-tw,zh-cn
  The set of locales to use when flattening i18n bundles.

releaseDir=../../release/
  The top level release directory where builds end up. The 'releaseName' directories will  be placed inside this directory.

  Note:  the default value of ``releaseDir`` will place the built Dojo directory tree *within* the source Dojo distribution tree that the buildscripts directory is a part of.  This is normally not a good behavior if you are including any custom source code modules; in these cases, you will want to override the default with a location outside the source tree.


copyTests=true
  Turn on or off copying of test files.  

  When off (any non-truthy value--however ``false`` is your clearest choice), the Dojo test directory is not copied into your release distribution.  This can reduce the overall size of your distribution.

action=help
  The build action(s) to run. Can be a comma-separated list, like action=clean,release. The possible build actions are: clean, release.

  clean
     Remove the releaseDir and any contents it may have.

  release
     Build the release directories.  

  Note:  when you specify ``release``, the ``clean`` option is implied automatically, *unless* you use the ``buildLayers`` option.

  Most of the time, you will specify ``action=release``.

symbol=
  Inserts function symbols as global references so that anonymous functions will show up in all debuggers (esp. IE which does not attempt to infer function names from the context of their definition). Valid values are "long" and "short". If "short" is used, then a symboltables.txt file will be generated in each module prefix's release directory which maps the short symbol names to more descriptive names.

internStrings=true
  Turn on or off widget template file interning.

  Normally, during the build process, one of the things that the builder does is take the separate HTML template files used by templated Dojo widgets (there are many of these in `Dijit <dijit/index>`_) and convert them to inline string values within the as-built source file for the widget (as well as any layers that widget is built into).  

scopeMap=
  Change the default dojo, dijit and dojox scope names to something else. Useful if you want to use Dojo as part of a JS library, but want to make a self-contained library with no external dojo/dijit/dojox references. Format is a string that contains no spaces, and is similar to the djConfig.scopeMap value (note that the backslashes below are required to avoid shell escaping): ``scopeMap=[[\"dojo\",\"mydojo\"],[\"dijit\",\"mydijit\"],[\"dojox\",\"mydojox\"]]``

mini=false
  Removes files like tests, demos dijit/bench, unfinished themes, and interned Dijit templates from the build. Overrides the value set for copyTests.

  When ``mini=true`` is specified, the smallest possible version of Dojo is generated given the other parameters.  Mini versions are built without the following resources:

    * tests
    * demonstrations
    * partial (unfinished themes)
    * original template files (since they would have been interned)

optimize=
  Specifies how to optimize module files. If "comments" is specified, then code comments are stripped. If "shrinksafe" is specified, then Dojo Shrinksafe will be used on the files, and line returns will be removed. If "shrinksafe.keepLines" is specified, then Dojo Shrinksafe will be used on the files, and line returns will be preserved. If "packer" is specified, Then Dean Edwards' Packer will be used, etc.

  Possible values for this parameter are:

  shrinksafe
     Use Shrinksafe in its default mode, where it strips both comments and blank lines

  shrinksafe.keepLines
     Use Shrinksafe to remove comments, but leave line breaks as-is, to facilitate human reading of the file (usually for debugging)

  closure
     Minify with the Google Closure compiler.  Requires Java 6.

  packer
     Minify with Dean Edwards' Packer.


     Note: the Shrinksafe minification that is used by default is much more effective in most contexts than the Packer minification.  Use this parameter only on servers which do not do their own automatic gzip compression of files being sent.  The packer minification does more extensive name mangling than Shrinksafe and so may cause difficulty in debugging.  The new Google Closure compiler, not included with this distribution, generally provides the best results.

loader=default
  The type of dojo loader to use. "default" or "xdomain" are acceptable values.

log=0
  Sets the logging verbosity. See jslib/logger.js for possible integer values.

profileFile=
  A file path to the the profile file. Use this if your profile is outside of the profiles directory. Do not specify the "profile" build option if you use "profileFile".

xdDojoPath=
  If the loader=xdomain build option is used, then the value of this option will be used to call dojo.registerModulePath() for dojo, dijit and dojox. The xdDojoPath should be the directory that contains the dojo, dijit and dojox directories, and it should NOT end in a slash. For instance: 'http://some.domain.com/path/to/dojo090'.

stripConsole=
  Strips console method calls from JS source. Applied to layers and individual modules resource files. Valid values are "normal" (strips all but console.warn and console.error calls), "all" (strips all console calls), "normal,warn" (strips all but console.error calls), "normal,error" (strips all but console.warn errors).

version=0.0.0.dev
  The build will be stamped with this version string.  That is, the ``dojo.version`` value specified in the as built version will contain this version number. 

  This parameter does not affect the names of the directories created by the build system.

profile=base
  The name of the profile to use for the build. It must be the first part of the profile file name in the profiles/ directory. For instance, to use base.profile.js, specify profile=base.

layerOptimize=shrinksafe
  Specifies how to optimize the layer files. If "comments" is specified, then code comments are stripped. See the 'optimize' parameter for possible values.

scopeDjConfig=
  Burn in a djConfig object into the built dojo.js file. Useful if you are making your own scoped dojo and you want a djConfig object local to your version that will not be affected by any globally declared djConfig object in the page. Value must be a string that will look like a javascript object literal once it is placed in the built source. use Dojo as part of a JS library, but want to make a self-contained library with no external dojo/dijit/dojox. Example (note that the backslashes below are required to avoid shell escaping if you type this on the command line): ``scopeDjConfig={isDebug:true,scopeMap:[[\"dojo\",\"mydojo\"],[\"dijit\",\"mydijit\"],[\"dojox\",\"mydojox\"]]}``


xdDojoScopeName=dojo
  If the loader=xdomain build option is used, then the value of this option will be used instead of 'dojo' for the 'dojo._xdResourceLoaded()' calls that are done in the .xd.js files. This allows for dojo to be under a different scope name but still allow xdomain loading with that scope name.

buildLayers=
  A comma-separated list of layer names to build. Using this option means that only those layers will be built. This helps if you are doing quick development and test cycles with layers. If you have problems using this option, try removing it and doing a full build with action=clean,release. This build option assumes you have done at least one full build first.

========
Examples
========

.. code-block :: javascript

  ./build.sh action=release,clean profile=myprofile version=1.5.0 releaseDir=myrelease
