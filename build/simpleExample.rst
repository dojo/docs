#format dojo_rst

Simple Buildsystem Examples
===========================

:Status: Draft
:Version: 1.4
:Project owner: James Burke
:Available: since 1.0

.. contents::
   :depth: 2

**Note: As of 1st March 2010 this page is under active development. Please come back soon!**

This document provides some simple examples of using the Dojo build system, how to layout your directory structure and other best practices.

============
Introduction
============

For an introduction to the build system, see `<build>`_. This page assumes you already know you want a build, but are not quite sure how to go about it. 

Like most parts of Dojo the build system has been designed to be both powerful and flexible. There are a lot of different options available to tweak your system but, for the majority of first-time users, sticking to the defaults in this example will do you just fine.

=========
Example 1
=========

Download dojoBuildSystemExample.zip (click 'AttachFile' at the bottom of the page, and then 'get') and unzip. Note: Because the source release of Dojo is quite large it isn't included in the zip file. Once you've unpacked the zip, go to js/dojo-src run getDojo.sh. Then repeat this withing the js/dojo-1.4.1 directory. These scripts will download the base dojo releases for you and unzip them into the locations used by the build system.

As an aside, I think it's good practise to have a completely clean dojo release every time you do a build. If you want to patch it, you should create a 'patches' module in your own namespace and add the patches either as part of the build process, or by writing code that updates itself. Otherwise upgrades will be very painful. The way this example has been structured you can delete the entire dojo-src or dojo-1.4.1 directories at any time and replace with a fresh build.

Now, to do a build, go to the 'js' directory and run 'makeRelease.sh'. This runs the dojo build system and creates another directory called dojo-ourRelease that sits alongside the dojo-src and dojo-1.4.1 directories. See the image below.

The general idea is as follows:

 * dojo-1.4.1: A release of Dojo. Use for doing development work
 * dojo-src: A source release of Dojo. Use this for packaging/building only
 * dojo-ourRelease: A customized version of Dojo containing all of Dojo/Dijit/Dojox plus your code, minimized and built into layer as specified by your profile. Use this for your live systems.


The zip file basically contains a very simple dojo build system for a simple page. There are two copies of the page. One uses the standard Dojo release, one the built version (once you've done the build). If you open both pages up in tabs in Firefox, with Firebug on the 'Net' tab displaying 'All' and do a hard refresh (ctrl-shift-R) you should notice that the unbuilt version does about 70 HTTP requests whereas the built one about 15.

By reducing the build system down to a really, really simple set of files hopefully it'll all start to make sense.

===========================
Definitions - A quick recap
===========================

Layer
-----

A collection of JS from a number of dojo modules that has been squashed into a single file. Essentially when you're developing you want to keep all your modules separate as it makes it easier to manage - different people working on different modules don't have to interfere with each other. But for deployment your site will (generally) feel quicker if you have all your JS in a single file. It means that, when you do a dojo.require() the code will already have been fetched from the server and parsed so you don't have to wait for the asynchronous download.

Namespace
---------

Similar to a namespace in C#, or packages in Java. If you've not done any C# or Java think of a namespace as just a way of dividing up code such that it doesn't clash with other code. Consider a world with no namespaces. I write an awesome accordion widget. It's not like dijit.layout.Accordion, it's like a musical instrument. You can play notes on it and it animates and all sorts of awesome. So, I call my widget 'accordion'. And then the dijit guys decide to create their accordion layout widget. But instead of calling it 'dijit.layout.Accordion' they just call it 'accordion'. Now we have a problem, because if I want to use both on the same page how does my script know which accordion to create when I do a 'new Accordion()'? So we solve this by having namespaces. In this case, 'dojo', 'dijit' and 'dojox' are all namespaces. 'layout' is a sub-namespace of 'dijit'. My funky accordion musical instrument widget should be put under 'mrtom.widget.musicalInstruments.Accordion'. So, 'mrtom', 'mrtom.widget' & 'mrtom.widget.musicalInstruments' are all namespaces too. In the example zip file above, the namespace is 'yourCompany' with a sub-namespace of 'example'. Your code should go in it's own namespace.

The default location for your namespace would be alongside the 'dojo', 'dijit' and 'dojox' directories. However I put my top-level namespace ('yourCompany') in the same location as my dojo-release directory as it means I can happily delete the dojo-release and dojo-src directories whenever I want as they don't contain any of my code.

Resource Name 
-------------

During the build, Dojo will move all the files from 'dojo-src' to 'resourceName'. It will then create the layer, do all the smushing of JS and CSS and put all that stuff under 'resourceName' as well. So you need to change <script type="text/javascript" src="js/dojo-release/dojo/dojo.js"> to <script type="text/javascript" src="js/releaseName/dojo/layerName.js"> (you might want to include dojo.js as well, depending on if your layer contains all the bits of Dojo you need as well as all the dijits and your own code). You also want to change the location of the CSS so you grab the smushed CSS as well. (Like with JS, smushing the CSS into a single file loads more quickly because it reduces the number of HTTP requests and removes comments, which allows the CSS parser in your browser to decipher it more quickly). The build system also makes a copy of all the files, after being minimized, in your release. This means you don't have to add modules that are used infrequently to your layers - any dojo.require() calls for modules that are not loaded will be loaded via XHR instead.  Remember, Dojo locates files relative to dojo.js, and you've just changed the location of dojo.js at the beginning of this paragraph, so you need to move everything else too!

Pros of this approach
---------------------
 * Dojo released code and your code kept separately
 * Can include multiple layers on a page easily

Cons of this approach
---------------------

 * Obviously you are not going to keep two copies of your HTML files kicking around, so you have to change the contents of the file on the server side depending on if you are in a live or development environment

=========
Example 2
=========

// TODO

========
See also
========

 * `<build>`_
 * `<build/directoryLayout>`_
