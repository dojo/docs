.. _dojox/mobile/build:

=====
Build
=====

:Authors: Yoshiroh Kamiyama

.. contents ::
    :depth: 2

Dojo Mobile was designed to have as few dependencies on the dojo and dijit base modules as possible in order to reduce the total download code size for better start-up time performance. However, by default, all the dojo base modules and the dijit base modules are baked into the built file (dojo.js) by the dojo build tool regardless of whether they are actually used or not. So, to take advantage of Dojo Mobile's minimum-dependency approach, you need to specify appropriate build options and dependency information when you build your application. There are sample build profile files and a batch file available for that purpose. The sample profiles are in the dojo/util/buildscripts/profiles/ directory, and the batch file is in the dojox/mobile/build/ directory.

Patching Build Scripts pre-1.7
------------------------------

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
