.. _dojox/mobile/build:

=====
Build
=====

:Authors: Yoshiroh Kamiyama

.. contents ::
    :depth: 2

Dojo Mobile was designed to have as few dependencies on the dojo and dijit base modules as possible in order to reduce the total download code size for better start-up time performance. However, by default, all the dojo base modules and the dijit base modules are baked into the built file (dojo.js) by the dojo build tool regardless of whether they are actually used or not. So, to take advantage of Dojo Mobile's minimum-dependency approach, you need to specify appropriate build options and dependency information when you build your application. There are sample build profile files and a batch file available for that purpose. The sample profiles are in the dojo/util/buildscripts/profiles/ directory, and the batch file is in the dojox/mobile/build/ directory.

How to build Dojo Mobile
========================

Dojo Mobile provides two sample profile files: mobile-all.profile.js and mobile.profile.js, which are in the dojo/util/buildscripts/profiles folder. To easily build with these profiles, there are simple batch files available in the dojox/mobile/build folder; build.bat is for Windows, and build.sh is for Linux. You can run those batch files from the command line. Usage is as follows.

.. html::

  > build
  Usage: build separate|single [webkit]
    separate  Create mobile.js that includes only dojox.mobile
    single    Create a single dojo.js layer that includes dojox.mobile

separate
--------
The "separate" option uses mobile.profile.js and creates mobile.js that includes ONLY the dojox.mobile base modules. It does not include the dojo base or the dijit base modules. _compat.js is also created for desktop browser support. Also, dojo.js is created, but it is an ordinary dojo base build, not a customBase build.

Note that "the dojox.mobile base" includes only the modules listed in dojox/mobile/_base.js, that is, it does not include all the Dojo Mobile widgets. For example, ScrollableView, Carousel, SpinWheel, form controls, etc. are not included in the base. If you want them in your build, you can simply add them in the dependencies array in a profile file.

single
------
The "single" option uses mobile-all.profile.js and creates a single dojo.js layer that includes dojox.mobile base and all the dependent dojo/dijit modules. _compat.js is also created for desktop browser support. This build enables the customBase option. So, only the minimum dojo/dijit base modules are included in the resulted dojo.js.

webkit
------
See :ref:`Special Dojo Build: WebKit Mobile <build/webkit-mobile>` for information on how to do a webkit-mobile only
build of dojo.   This will reduce a significant amount of code by eliminating code paths for Internet explorer, etc.

Patching Build Scripts pre-1.7
==============================

If you are using dojo-1.6 or older, before running the build batch file, you may need to manually apply the following patch to your build script in order to completely remove all the unused modules from your build. (As you can see, it is just addition of "false&&" in the while condition.) The patch disables finding the dojo base modules being used from the dependent modules with a simple pattern matching, which sometimes unexpectedly picks up unused modules. The file to be patched is util/buildscripts/jslib/buildUtil.js. (Note that this is no longer valid for dojo-1.7)

.. js ::

  --- buildUtil.js-orig
  +++ buildUtil.js
  @@ -1506,7 +1506,7 @@
     var addedResources = {};
  -  while((matches = buildUtil.baseMappingRegExp.exec(tempContents))){
  +  while(false&&(matches = buildUtil.baseMappingRegExp.exec(tempContents))){
	 var baseResource = buildUtil.baseMappings[matches[1]];
	 // Make sure we do not add the dependency to its source resource.
