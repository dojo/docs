.. _build/xDomain:

============================================
Build System:  Cross-Domain (xDomain) Builds
============================================

:Project owner: ?--
:since: V?

.. contents ::
   :depth: 2

`Content copied (pending modification) from main quickstart page:`

Cross Domain (X-Domain) Builds
------------------------------

Doing an xdomain build allows you to load Dojo and your custom modules from another domain.

Benefits
~~~~~~~~

* You get more connections in MSIE, since you can load from another domain. Faster loading.
* You get increased cacheability/startup if many of your applications use the same installation.
* Resource loading does not block the rest of the page from filling in as with Dojo's normal, synchronous loading.
* With a local install, your ISP may charge you for all of those Dojo bits that you are serving.


Implications/Limitations
~~~~~~~~~~~~~~~~~~~~~~~~

* Not all external resources can be xdomain loaded, in particular some support files that need to be loaded from the same domain as the HTML page. See module-specific notes below.
* **Requires** an "xdomain" build of Dojo (see below for more info on how to make an xdomain build).
* Asynchronous loading. You MUST use dojo.ready() to register a callback function to get notification of package loading. This can be used even after the initial page load. Just do the dojo.require()s that you need, and then call dojo.ready() with a callback function, and once those new packages are loaded (or if they are already loaded), then the callback will be called. This technique works even for the normal Dojo loader, so this is a good practice to use even when not using an xdomain build.
* Avoid using document.write(): Since module can load asynchronously, after the page is loaded, document.write can cause problems.

Module-specific Notes
~~~~~~~~~~~~~~~~~~~~~

**dojo.io.iframe.create(), dijit.Editor, dijit._editor.RichText**: You need to save dojo/resources/blank.html to the same domain as your HTML page and set dojoConfig.dojoBlankHtmlUrl to the path on that domain. **Note:** The dijit.Editor/dijit._editor.RichText has a bug in release 1.1.0 where it was not using this dojoConfig parameter. It is fixed in Dojo 1.1.1 and later.

**dojo.back**: You need to save dojo/resources/blank.html to the same domain as your HTML page and set dojoConfig.dojoIframeHistoryUrl to the path on that domain.

**dojox.flash.Info()**: It uses document.write() which will cause problems if dojox.flash is loaded via dojo.require().

Doing xdomain builds
~~~~~~~~~~~~~~~~~~~~

Sample xdomain build command::

  $ cd util/buildscripts
  $ build.sh profile=foo loader=xdomain xdDojoPath=http://my.server.com/path/to/buildoutputdir action=release

xdDojoPath is optional. It just burns in the location of Dojo, Dijit and DojoX into the built dojo.js. If you do not specify that option, then you will need to use dojoConfig.modulePaths/dojo.registerModulePath() in your HTML page to set the xdomain locations for Dojo, Dijit and DojoX. For your own custom modules, you will have to set dojoConfig.modulePaths/dojo.registerModulePath() even if you us the xdDojoPath build option.

**For Dojo 0.9 through 1.1.x**: there is a `bug about loading dojox.gfx with an xdomain build <http://trac.dojotoolkit.org/ticket/4462>`_; this is fixed in Dojo 1.2. If you want to use dojox.gfx with an xdomain build of Dojo 0.9-1.1.x, there some work-arounds exist:

  #. Include dojox/gfx.js directly in your page with a script tag in the HTML source, after the dojo.js script tag (do not use gfx.xd.js, use gfx.js).
  #. Include dojox.gfx in a layer file that you load via a script tag in the HTML source (load the .js layer file, not the .xd.js layer file).

How to use xdomain builds in web pages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* In **dojoConfig**, add **useXDomain = true**.
* In **dojoConfig**, add a modulePaths object that maps where to find your modules.
* Register a callback function to get notification of when the packages are loaded by using **dojo.ready()**.
* Optional: set a wait time in milliseconds (**dojoConfig.xdWaitSeconds**) that specifies how long the resource loader should wait for a resource to load until returning an error. Since script elements do not give information about failed or long-running requests, this timeout is used to prevent infinite waiting in the browser. An exception will be thrown to indicate a load error. The default xdWaitSeconds is 15.

XDomain Example
~~~~~~~~~~~~~~~

`Here is an example <http://jburke.dojotoolkit.org/demos/xdlocal/LocalAndXd.html>`_ showing how to load local modules along with an xdomain-loaded Dojo and Dijit. You can `download this example <http://jburke.dojotoolkit.org/demos/xdlocal/xdlocal.zip>`_.

See also
========

* TODO: links to other related articles
