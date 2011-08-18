#format dojo_rst

Localized Build Example
=======================

:Authors: Nick Fenwick
:Available: since as long as I can remember

.. contents::
   :depth: 3

This page attempts to describe how to include localized strings bundles in your custom build.

============
Introduction
============

The dojo build system results in "layers", which are single large .js files that contain a concatenation (plus some magic sugar) of individual .js files from the SDK.  Localization bundles are not, by default, included in these layer .js files.  They exist in their own parallel set of .js files, and are built into their own concatenated .js file.  So, a "layer" can actually be thought of two files, a main .js file containing the Javascript implementation (and interned template strings), and a set of strings bundle .js files.

This document is more to do with how to arrange your source files so that the build system can work its magic.  We do not directly employ any build system switches or capabilities via ``build.sh`` or the profile .js file.

======================================================
Starting Point - A Simple Test Dijit And Build Profile
======================================================

Lets say we have a test dijit called ``testdijits.Foo``.  It is defined in ``testdijits/Foo.js``.  An example directory structure might be:

.. code-block :: text

  dojo/..dojo SDK here..
  dojo/dojo/dojo.js ..for example..
  testdijits/Foo.js .. the test dijit implementation

We keep the 'testdijits' folder outside the main dojo SDK directory to keep it distinct from the version of dojo we're using.

A custom build profile might look like this:

.. code-block :: text

  dependencies = {
  	layers: [
  		{
  			name: "testdijits.js",
  			resourceName: "testdijits", /* This is what is dojo.provide()'d by the layer */
  			dependencies: [
  				"testdijits.Foo"
  			]
  		}
  	],
  
  	prefixes: [
  		[ "dijit", "../dijit" ],
  		[ "dojox", "../dojox" ],
  		[ "testdijits", "../../testdijits"]
  	]
  };

Remember that the build process first copies all directories mentioned in ``prefixes`` to the build output directory, and then resolves all relative paths relative to that subtree; it does not resolve paths relative to your original source directories.  The build will find Foo.js by looking up its namespace "testdijits" in the prefixes section, and resolve the "../../testdijits" path relative to the directory containing dojo.js.  Run the build with a command like:

build.sh releaseName=test profile=test action=clean,release

The built layer will be in ``../../release/test/dojo/testdijits.js``.

The build will also produce a localized strings bundle for the "testdijits.js" layer.  In the build directory, look in ../../release/test/dojo/nls.  You should see a file for each locale, e.g. testdijits_ar.js, testdijits_ca.js, etc.  Each will be nearly empty, with a simple provide call e.g. ``dojo.provide("dojo.nls.testdijits_ar");``.  This indicates that the build process has created localised strings bundles for your layer, but there were no actual strings provided to put in those bundles.

A 'real world' build will contain many dijits (testdijits.Foo, testdijits.Bar, testdijits.App etc.), each with their own strings bundle.  Our aim is to make those individual strings bundles build to a single file for efficient download to the client at runtime, rather than a single network request per file.

=======================
Adding A Strings Bundle
=======================

So far, no localization.  Lets add a string resource.  Our Foo.js implementation should try to load and use a strings bundle

.. code-block :: html

  dojo.provide("testdijits.Foo");
  dojo.require("dijit._Widget");
  dojo.require("dijit._Templated");
  
  dojo.declare("testdijits.Foo", [ dijit._Widget, dijit._Templated ], {
  	
  	// Our template contains a localised string from the messages bundle
  	templateString: "<div><p>The string: ${messages.test}</div>",
  	
  	// On creation, pull in the correct strings bundle
  	postMixInProperties: function(){
  		this.inherited(arguments);
  		console.log("Foo calling requireLocalization..");
  		dojo.requireLocalization("testdijits", "Foo");
  		console.log("Foo calling getLocalization for lang ", this.lang);
  		this.messages = dojo.i18n.getLocalization("testdijits", "Foo", this.lang);
  		console.log("TEST LOCALIZATION: ", this.messages);
  	}
  })

So the template contains a template variable usage, ${messages.test}.  Before the template is processed, the widget lifecycle dictates that ``postMixInProperties`` is called, which our implementation uses to prepare and make available a ``this.messages`` variable.  This is simply a variable on our dijit instance.  When the template is then processed in ``buildRendering`` later in the lifecycle, the ${messages.test} reference is resolved from ``this.messages.test``.

We must add a strings bundle in a `magic <http://en.wikipedia.org/wiki/Magic_%28programming%29>`_ directory called ``nls``, like so:

.. code-block :: text

  testdijits/Foo.js     - The original Foo.js implementation
  testdijits/nls/Foo.js - The new strings bundle

That is the 'default' language resource, for when no locale has been specified, or the requested locale is not available.  If we just provide that file, then every locale (fr, zh and so on) will contain that strings bundle.

Note:
  * we have not specified the strings bundle in the build profile
  * the requireLocalization call is picked up by the build process automatically, and used to load the nls/Foo.js file for minification.  If you change the line to e.g. ``dojo.requireLocalization("testdijitsxxx", "Foo")`` you'll notice that the Foo.js strings bundle is no longer inlined as described here.

The ``testdijits/nls/Foo.js`` file should contain:

.. code-block :: text

  define({ root:
  //begin v1.x content
  ({
  	test: 'this is a test'
  })
  //end v1.x content
  })

Now run the build again.  You will find that the 'this is a test' string gets included in _every_ layer nls file test/dojo/nls/testdijits* .. testdijits_ar.js, testdijits_en.js, and so on.  The files that previously had a single dojo.provide call now look like:

.. code-block :: text

  [neek nlstest (develop)]$ cat test/dojo/nls/testdijits_ar.js
  dojo.provide("dojo.nls.testdijits_ar");dojo.provide("testdijits.nls.Foo");testdijits.nls.Foo._built=true;dojo.provide("testdijits.nls.Foo.ar");testdijits.nls.Foo.ar={"test":"this is a test"};

This bundle will now be loaded by the requireLocalization call above, and provided to our code by the getLocalization call, and used by the dijit in the template by means of the template parameter ${messages.test}.

To use this dijit, use a simple test file such as ``test.html``:

.. code-block :: html

  <!DOCTYPE html>
  <html><head><title>Localized build test</title>
  <script type="text/javascript">
  	var djConfig = {
  		parseOnLoad: true
  	};
  </script>
  <script type="text/javascript" src="test/dojo/dojo.js"></script>
  <script type="text/javascript">
  	dojo.require("testdijits.Foo");
  </script>
  </head>
  <body>
  <p>Here is the dijit:</p>
  <div data-dojo-type="testdijits.Foo"></div>
  </body></html>

``test/dojo/dojo.js`` should refer to the ``test`` build output by the custom build run above.  It will have been built to the ``release`` dir in your dojo SDK by default.  Loading that web page in a browser should result in a page that shows:


.. code-block :: text

  Here is the dijit:
    
  The string: this is a test

An important distinction to make here is that the original source of yours (slightly modified) is in the output build, *as well as* the compiled layer and nls resources.  This can be confusing for a beginner.  Focussing on the output build tree, in the ``test`` directory (because we specified ``releaseName=test`` on the build.sh command line):

.. code-block :: text

  testdijits/Foo.js        - The source testdijits/Foo.js implementation (slightly modified, see later)
  testdijits/nls/Foo.js    - The source strings bundle
  dojo/testdijits.js       - The compiled layer containing testdijits/Foo.js
  dojo/nls/testdijits_*.js - Many nls resources, one per supported locale, containing testdijits/nls/Foo.js

When you come to actually use your compiled layer, you'll be using the files from ``dojo/testdijits.js`` and ``dojo/nls/testdijits_*.js``, _not_ the copy of your original code, in ``testdijits/*``.

==============================================
Optimising Performance - Using the Built Layer
==============================================

In the test.html file above, we only linked to the dojo.js file.  Thus, the dojo.require("testdijits.Foo") had to fetch all dijit files over the network.  We aren't actually using our built layer at all.  The Net panel in the debugger shows many individual requests:


.. code-block :: text

  test.html
  dojo.js
  Foo.js
  _Widget.js
  _WidgetBase.js
  manager.js
  Stateful.js
  _base.js
  focus.js
  window.js
  place.js
  AdapterRegistry.js
  popup.js
  window.js
  scroll.js
  sniff.js
  uacss.js
  typematic.js
  wai.js
  _Templated.js
  string.js
  parser.js
  stamp.js
  cache.js
  i18n.js
  Foo.js

The first Foo.js is ``test/testdijits/Foo.js`` and the second is ``test/testdijits/nls/Foo.js``.  Note that I haven't had to manually load that second Foo.js file .. it has been loaded automatically by the ``dojo.getLocalization`` call.

If you add ``locale: 'fr'`` to the djConfig at this point, you'll see no different in the network requests, it still fetches the ``test/testdijits/nls/Foo.js`` file.  Why didn't it even bother looking for a 'fr' nls file?  I'll answer this in the next section.

To use your built layer, link to it after the link to dojo.js:

.. code-block :: html

  <script type="text/javascript" src="test/dojo/dojo.js"></script>
  <script type="text/javascript" src="test/dojo/testdijits.js"></script>
  <script type="text/javascript">
  	dojo.require("testdijits.Foo");
  </script>

Suddenly, the load performance is very different.  The Net panel now shows:

.. code-block :: text

  test.html
  dojo.js
  test/dojo/testdijits.js
  test/dojo/nls/testdijits_en-us.js

Important points to note here:
  * ``test/dojo/testdijits.js`` contains the javascript implementation and inlined templates of all dijits mentioned in the profile .js file for that layer.
  * ``test/dojo/nls/testdijits_en-us.js`` contains the strings bundles for all those dijits.

================================================
The Build Bakes Available Locales Into Your Code
================================================

Going back to before we linked to the built layer ``test/dojo/testdijits.js``, when we added ``djConfig: { locale: 'fr' }``, why did the build not even look for a ``fr`` nls file?  The answer lies in what the build system does to your Foo.js implementation.  Just when you thought you'd put the following in your source testdijits/Foo.js file:

.. code-block :: javascript

  dojo.requireLocalization("testdijits", "Foo");

You'll see different code in the build output directory, test/testdijits/Foo.js:

.. code-block :: javascript

  dojo.requireLocalization("testdijits", "Foo", null, "ROOT");

The extra ``null, "ROOT"`` information tells the loader at runtime what string bundles are actually available.

When you simply include a ``fr`` localized strings bundle in your source directory tree, by creating:

.. code-block :: text

  testdijits/nls/fr/Foo.js

.. you find that the Foo.js implementation in the build output is different:

.. code-block :: javascript

  dojo.requireLocalization("testdijits", "Foo", null, "ROOT,fr");

You don't need to change any code for this to happen.  If fact it you create a directory called ``pumpkins``, the requireLocalization call will then tell dojo that there is a ``pumpkins`` locale available.  This is how the loader knows to directly fetch ``test/testdijits/nls/fr/Foo.js`` when you specify a locale of ``fr``, and the base resource ``test/testdijits/nls/Foo.js`` when any other locale is requested.

=========================
Providing Other Languages
=========================

From here it's simple to add another strings resource, along with the single ``testdijits/nls/Foo.js`` file from before.

.. code-block :: text

  dojo/..dojo SDK here..
  dojo/dojo/dojo.js ..for example..
  testdijits/Foo.js .. the test dijit implementation
  testdijits/nls/Foo.js
  testdijits/nls/fr/Foo.js

``fr/Foo.js`` might contain:

.. code-block :: text

  define({ root:
  //begin v1.x content
  ({
  	test: 'FRENCH this is a test FRENCH'
  })
  //end v1.x content
  })

The custom build would then contain the same files as before, but the ``fr`` file contains the localized string:

.. code-block :: text

  test/dojo/nls/testdijits_en.js - The default "this is a test"
  test/dojo/nls/testdijits_fr.js - Contains "FRENCH this is a test FRENCH"

Specifying ``locale: 'fr'`` in test.html results in the following network activity:

.. code-block :: text

  test.html
  dojo.js
  test/dojo/testdijits.js
  test/dojo/nls/testdijits_fr.js

And of course, the page shows:

.. code-block :: text

  Here is the dijit:
  
  The string: FRENCH this is a test FRENCH

======================
Multiple Custom Dijits
======================

Just to demonstrate that this approach really does save on network traffic, lets add a second dijit, ``testdijits.Bar``, to our ``testdijits`` namespace, provide language resources for it, and add it to our build profile.

  * Create the testdijits/Bar.js implementation, just like Foo but specifying ``"testdijits", "Bar"`` in the calls to ``requireLocalization`` and ``getLocalization``.
  * Create ``nls/Bar.js`` and ``nls/fr/Bar.js``
  * Add a ``testdijits.Bar`` entry to the profile .js file for the build.
  * Add a dojo.require of "testdijits.Bar" to our test.html file (not strictly required if you are linking to the built layer, dojo/testdijits.j, as the testdijits.Bar dijit will already be loaded from that, so the dojo.require call has nothing to do).

Our source directory now looks like:

.. code-block :: text

  dojo/..dojo SDK here..
  dojo/dojo/dojo.js ..for example..
  testdijits/Foo.js .. the test dijit implementation
  testdijits/Bar.js .. the test dijit implementation
  testdijits/nls/Foo.js
  testdijits/nls/fr/Foo.js
  testdijits/nls/Bar.js
  testdijits/nls/fr/Bar.js

The network activity on loading test.html has no extra requests:

.. code-block :: text

  test.html
  dojo.js
  test/dojo/testdijits.js
  test/dojo/nls/testdijits_fr.js

And the page shows the new dijit and its localised string (you can see that Bar is a simple copy of Foo with the string "BAR" inserted here and there so we can tell the difference in the output):

.. code-block :: text

  Here is the dijit:
  
  The string: FRENCH this is a test FRENCH
  
  BAR The string: FRENCH BAR this is a test BAR FRENCH BAR

========================
A Note About ArcGIS/ESRI
========================

This write-up is designed to cover a basic, standalone, non-xd build of dojo.  At the time of writing, I know very little about ArcGIS.  I have seen `http://coreyalix.blogspot.com/2010/12/dojo-custom-builds-with-localized.html`_ and it seems quite a run-around.  I cannot say whether that author was doing the right thing, and if possible this section should be extended to cover localising dijits loaded as xd resources that are not local to the dojo_xd.js being used as the core loader.
