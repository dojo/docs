.. _build/transforms/writeDojo:

=========================
Build Transform writeDojo
=========================

:Author: Rawld Gill

.. contents ::
   :depth: 2

Summary
=======

Writes the dojo loader and any layers that are designated as boot layers to destination locations.

Description
===========

This transform writes the dojo loader to the loader destination, usually dojo.js in the dojo package directory. It also
writes any layers with a truthy ``boot`` property to their destination resources by prefixing the normal layer text,
as computed by the writeAmd transform, with the dojo loader text, thereby causing the layer to include the loader and be
"bootable".

The dojo loader is not an AMD module. The source version of the loader looks like this:

*dojo/dojo.js*

.. js ::

    (function(userConfig, defaultConfig){
    
      // dojo loader definition goes here
    
    })
    //>>excludeStart("replaceLoaderConfig", kwArgs.replaceLoaderConfig);
    (
        // userConfig
        (function(){
            // make sure we're looking at global dojoConfig etc.
            return this.dojoConfig || this.djConfig || this.require || {};
        })(),
    
        // defaultConfig
        {
            // the default configuration as provided by the source version of dojo goes here
            // see dojo/dojo.js for details
        }
    );
    //>>excludeEnd("replaceLoaderConfig")

The build system defines the profile argument ``replaceLoaderConfig`` as truthy which causes the application to the
loader factory to be deleted. This transform constructs user configuration and default configuration objects and writes
these to along with the transformed loader factory text.

The user configuration object may be specified in the profile property ``userConfig``. If ``userConfig`` is a string,
then it is used verbatim; otherwise, it must be a JavaScript object giving a loader configuration see xxx. The object
need not be a JSON object and may contain functions. For example,

.. js ::

    var profile = {
        userConfig:{
            hasCache:{
                someFeature:function(global, doc, element){
                    // the has feature test for someFeature
                }
            }
        }
    };

If no value if given for ``userConfig``, then it defaults to the string ``"this.dojoConfig || this.djConfig ||
this.require || {}"``, which causes the built loader to select the various possible locations for a loader user
configuration. This behavior is identical to the source version of the loader.

**Warning**: When a user configuration is given by providing a value of for the profile property ``userConfig``, the
resulting loader will not automatically consume a global ``dojoConfig``, ``djConfig``, or ``require`` loader
configuration object.

The default configuration object, is built up from various profile properties:

* if the profile property ``baseUrl`` exists, then the loader configuration property ``baseUrl`` is set accordingly

* a package configuration is constructed for each package given in the build

  * For all packages, the ``name`` property is set to the value of ``destName`` in the package configuration (see xxx);
    similarly for ``main`` and ``destMain``.

  * For the dojo package, ``location`` property is set to "." This has the net effect of causing the dojo package to
    reside at the value of ``baseUrl`` during run time.

  * For all packages other than dojo, the ``location`` property is computed by examining the ``destLocation`` package
    configuration property, and computing the equivalent path expressed as a relative path to the path that holds the
    dojo package; this equivalent path is used for the package ``location`` property in each package
    configuration. Notice that since the path that holds the dojo package is assumed to be equivalent to ``baseUrl``,
    making every other package relative to the dojo package has the net effect of making those package locations
    relative to ``baseUrl``.

  * After the package configuration properties described above are computed for package *package-name*, any properties
    defined at the profile property ``defaultConfig.packages[`` *package-name* ``]]`` are mixed in to the computed
    package configuration object. This provides a method to override any of the default package configuration
    computations.

* all properties of the profile property ``defaultConfig``, with the exception of the property ``packages`` are then
  mixed into the default configuration object.

The resulting user configuration and default configuration objects are stringified (if necessary--the userConfiguration
may already be a string) and added to the transformed loader factory text to express an application of the loader
factory. This effectively replaces the block marked by the "replaceLoaderConfig" dojo pragma arguments. The resulting
loader factory text can then be used to write the loader resource (usually dojo.js) and prefix any bootable layers.

By default, the dojo/dojo module is a layer module that includes the single module dojo/main which results in loader
so-called "dojo base". At the time of writing, dojo/main includes the following modules:

    dojo/main
    dojo/_base/kernel
    dojo/has
    dojo/_base/config
    dojo/_base/sniff
    dojo/_base/lang
    dojo/_base/array
    dojo/ready
    dojo/domReady
    dojo/_base/declare
    dojo/_base/Deferred
    dojo/_base/json
    dojo/json
    dojo/_base/Color
    dojo/_base/browser
    dojo/_base/connect
    dojo/on
    dojo/topic
    dojo/Evented
    dojo/aspect
    dojo/_base/event
    dojo/dom-geometry
    dojo/_base/window
    dojo/dom
    dojo/dom-style
    dojo/mouse
    dojo/keys
    dojo/_base/unload
    dojo/_base/html
    dojo/dom-attr
    dojo/dom-prop
    dojo/dom-construct
    dojo/dom-class
    dojo/_base/NodeList
    dojo/query
    dojo/selector/_loader
    dojo/NodeList-dom
    dojo/_base/xhr
    dojo/io-query
    dojo/dom-form
    dojo/_base/fx

This default may be overridden by providing an explicit dojo/dojo layer configuration (see xxx writeAmd). Historically,
this technique has been termed building a "custom base". However, as of v1.7, specifying the contents of the dojo/dojo
layer is no different than specifying the contents of any other module, so it's no longer considered a particularly
complex or advanced feature.

Lastly, during the construction of the dojo/dojo layer, if the profile property ``version`` is present, then it is used
as a replacement for any embedded version numbers found in the layer. The property ``version`` must have the form

  *major* **.** *minor* **.** *patch* **.** *flag*

Where major, minor, and patch must all be positive integers and flag can be anything. Any less significant subset may be
omitted; omitted minor and patch segments default to "0"; an omitted flag segment defaults to an empty string.

If present, the dojo/dojo layer is searched for the pattern

  ``/major:\s*\d*,\s*minor:\s*\d*,\s*patch:\s*\d*,\s*flag:\s*".*?"\s*,/``

If the pattern is found and the profile property ``version`` was provided, then property values in the resource text
are replaced with the in the obvious manner.

The transform writes the dojo/dojo resource text, after transforming as described above, the destination
location. Additionally, the resource text for all bootable layers (see xxx) is written to their destination locations
after prefixing that text with the dojo/dojo resource text.

Profile Knobs
=============


``defaultConfig`` (default = see below)
  * [*object that gives the default loader configuration*] Used to build up the default loader configuration. Typically
    not provided.

``userConfig`` (default = ``"this.dojoConfig || this.djConfig || this.require || {}"``)
  * [*string*] The explicit text to write for the user configuration applied to the loader factory.

  * [*object*] The object to user for the user configuration applied to the loader factory. The object need not be a
    strict JSON object.

  **Warning**: When a user configuration is given by providing a value of for the profile property ``userConfig``, the
  resulting loader will not automatically consume a global ``dojoConfig``, ``djConfig``, or ``require`` loader
  configuration object.

``version`` (default = *the version given by the dojo package*)
  * [*string*] A string with the format *major* **.** minor* **.** *patch* **.** *flag*, where major, minor, and patch
    must all be positive integers and flag can be anything. Any less significant subset may be omitted; omitted minor
    and patch segments default to "0"; an omitted flag segment defaults to an empty string.

``dojo/dojo`` layer configuration
  The dojo/dojo layer configuration gives the contents of the dojo layer, usually written to dojo/dojo.js. The default
  value of the dojo/dojo layer is given as follows:

.. js ::

    {
        include:["dojo/main"],
        exclude:[],
        boot:true
    }

Source Location
===============

util/build/transforms/writeDojo.js
