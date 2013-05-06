.. _dojox/mobile/build:

=====
Build
=====

:Authors: Yoshiroh Kamiyama

.. contents ::
    :depth: 2

Dojo Mobile has been designed to have as few dependencies on the dojo and dijit base modules as 
possible in order to reduce the total download code size for better start-up time performance. 
However, by default, all the dojo base modules and the dijit base modules are baked into the 
built file (dojo.js) by the dojo build tool regardless of whether they are actually used or not. 
So, to take advantage of Dojo Mobile's minimum-dependency approach, you need to specify 
appropriate build options and dependency information when you build your application. There 
are sample build profile files and a batch file available for that purpose. The sample profiles 
are in the dojo/util/buildscripts/profiles/ directory, and the batch file is in the 
dojox/mobile/build/ directory.

How to build Dojo Mobile
========================

Dojo Mobile provides two sample profile files: mobile-all.profile.js and mobile.profile.js, 
which are in the dojo/util/buildscripts/profiles folder. To easily build with these profiles, 
there are simple batch files available in the dojox/mobile/build folder; build.bat is for Windows, 
and build.sh is for Linux. You can run those batch files from the command line. Usage is as follows.

.. html::

  > build
  Usage: build separate|single [webkit]
    separate  Create mobile.js that includes only dojox/mobile
    single    Create a single dojo.js layer that includes dojox/mobile

separate
--------
The "separate" option uses mobile.profile.js and creates mobile.js that includes ONLY the 
Dojo Mobile base modules. It does not include the dojo base or the dijit base modules. _compat.js 
is also created for desktop browser support. Also, dojo.js is created, but it is an ordinary dojo 
base build, not a customBase build.

Note that Dojo Mobile "base" includes only the modules listed in dojox/mobile/_base.js, that is, 
it does not include all the Dojo Mobile widgets. For example, ScrollableView, Carousel, SpinWheel, 
form controls, etc. are not included in the base. If you want them in your build, you can simply add 
them in the dependencies array in a profile file.

single
------
The "single" option uses mobile-all.profile.js and creates a single dojo.js layer that includes 
Dojo Mobile base and all the dependent dojo/dijit modules. _compat.js is also created for desktop 
browser support. This build enables the customBase option. So, only the minimum dojo/dijit base modules 
are included in the resulted dojo.js.

webkit
------
See :ref:`Special Dojo Build: WebKit Mobile <build/webkit-mobile>` for information on how to do a 
webkit-mobile only
build of dojo. This will reduce a significant amount of code by eliminating code paths for 
Internet Explorer, etc.
