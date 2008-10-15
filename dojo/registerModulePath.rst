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

The first part is dojo.baseUrl: the path to the Dojo directory. For example, assume the path to dojo.js is "/web/scripts/dojo-1.2/dojo/dojo.js". The baseUrl is "/web/scripts/dojo-1.2/dojo/". Dojo automatically determines this path, but you can explicitly set it via djConfig.baseUrl.  

Next, Dojo assumes the the path for any module names that start with a prefix other than "dojo" are in a sibling directory to the dojo directory.

For instance, if "/web/scripts/dojo-1.2/dojo/dojo.js" is the path to dojo.js, and you do dojo.require("some.module"), Dojo will try to load the JavaScript file using the path "/web/scripts/dojo-1.2/some/module.js".

If you want to load "some.module" from a different path, dojo.registerModulePath can be used to change the path. However, it is more common to use djConfig.modulePaths instead of dojo.registerModulePath directly. Dojo will call dojo.registerModulePath for each entry in djConfig.modulePaths.

Note that the path given to dojo.registerModulePath is always assumed to be relative to dojo.baseUrl, unless the module path starts with at "/" or "http". In those cases, dojo.baseUrl will not be used to determine the final path.

=====
Usage
=====
