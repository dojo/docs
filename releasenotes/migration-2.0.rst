.. _releasenotes/migration-2.0:

===============================
Dojo 1.x to 2.0 migration guide
===============================

.. contents::
   :depth: 3

Currently, many parts of Dojo 2.0 are under development.  As with any major software that is under-development, it is 
hard to predict that the final solution will look like.  These notes provide guidance though on how to try to "future
proof" your application to make it easier to transition to Dojo 2.0 when it release.

Since Dojo 1.X is backwards compatible with previous Dojo 1.x releases, none of these changes are necessary until Dojo 
2.0, but refactoring your code earlier will not only make future porting easier, but also can deliver performance and 
code maintenance benefits early.

AMD
===

Dojo has been upgraded to use the Asynchronous Module Definition (AMD) standard for all of its modules.  This changes
the way you load, access, and define modules.

Loading dojo.js
---------------

Dojo is loaded basically in the same way as before, except that in the ``<script>`` tag the ``djConfig`` attribute has 
been renamed to ``data-dojo-config``.

To get the 2.0-like behavior in 1.7, you should set ``async: true``.

.. html ::

  <script src="dojo/dojo.js" data-dojo-config="async: true"></script>

If configuration options are specified outside of the ``<script>`` tag (rather than as a ``data-dojo-config`` 
attribute), instead of ``djConfig`` you should set ``dojoConfig``:

.. js ::

  var dojoConfig = { async: true }

Loading Modules
---------------

The syntax for loading modules has been changed from a series of ``dojo.require()`` calls like:

.. js ::

  dojo.require("dijit.form.Button");
  dojo.require("dojox.layout.ContentPane");
  ...
  // CODE HERE

into a single require statement:

.. js ::

  require(["dijit/form/Button", "dojox/layout/ContentPane", ...], function(Button, ContentPane, ...){
    // CODE HERE
  });

Notice how the dots (e.g. ``dijit.form.Button``) have been changed to slashes (e.g. ``dijit/form/Button``).  This is 
dot notation represented a global scope object where as the slash notation represent a Module ID (MID).  While these 
are similar in naming, there are actually wholly different concepts.

Also, be careful to never load a module using a ``<script>`` tag.  This will not work; it causes "multiply defined" 
errors from the loader.

Accessing Modules
-----------------

Each module you load is mapped to a function parameter:

.. js ::

  require(["dijit/_base/Color", "dojox/layout/ContentPane"], function(Color, ContentPane){
      Color.fromRgb(...)
  });

That function parameter is the way that you access methods or the class defined in that module. You should no longer 
access any functionality through global variables like ``dojo``, ``dijit``, or ``dojox``.

One implication of this change is that every module you are (directly) using must be put into your dependency list. 
That includes any functionality previously loaded by ``dojo.js``.  The modules that formerly composed ``dojo.js`` 
(modules in ``dojo/_base``) have been replaced with smaller, more specific modules in the top level ``dojo`` directory.
*Note:* as of 1.8, some modules in ``dojo/_base`` are still being used.

Also, note that some method names have been shortened to avoid redundancy. For example, the previous 
``dojo.colorFromRgb()`` is now accessed as ``Color.fromRgb()``, rather than ``Color.colorFromRgb()``.

Defining Modules
----------------

The syntax for defining a module is similar to ``require()``.   In other words, it has been changed from:

.. js ::

  dojo.provide("acme.Dialog");
  dojo.require("dijit._Widget");
  dojo.require("dojo.date");
  //CODE HERE

into:

.. js ::

  define(["dijit/_Widget", "dojo/date"], function(_Widget, date){   ....
    // CODE HERE
    return MyWidget;
  });

Notice that the module (a.k.a. file) itself is *returning* a value.   That is the way other modules access your 
module, as explained in the section above.

Also, notice how the module name previously listed in the ``dojo.provide()`` call (``acme.Dialog`` in the example 
above) is not listed anymore.   The file name itself suffices.

I18N
----

``dojo.requireLocalization()`` has been replaced by the :ref:`dojo/i18n! <dojo/i18n>` loader plugin:

Old syntax:

.. js ::

  dojo.require("dojo.i18n");
  dojo.requireLocalization("dijit.form", "validate");
  var validate = dojo.i18n.getLocalization("dijit.form", "validate");
  console.log(validate.invalidMessage);

New syntax:

.. js ::

  require(["dojo/i18n!dijit/form/nls/validate"], function(i18n){
    console.log(i18n.invalidMessage);
  });

Loading Text Resources and Widget Templates
-------------------------------------------

Use the :ref:`dojo/text! <dojo/text>` plugin instead.

Old syntax:

.. js ::

  var text = dojo.cache("my.module", "template.html");
  // ...

New syntax:

.. js ::

  require("dojo/text!my/module/template.html", function(text){
    //...
  });

URLs
----

Most of the time you use the ``dojo/text!`` plugin to load text from a specific URL, but if you need an actual URL in 
your classes you should use ``require.toUrl()``.

See :ref:`require.toUrl() <loader/amd#utility-functions>` for details.

Quick Reference
---------------

===================================================== ===================== ==========================================
1.x syntax                                            2.0 module            2.0 syntax
===================================================== ===================== ==========================================
dojo.provide("foo/bar"); dojo.require("a/b"); ...                           define(["a/b"], function(b){ ... });
dojo.require(a.b); a.b.foo();                                               require(["a/b"], function(b){ b.foo(); }
djConfig                                                                    data-dojo-config
dojo._Url                                                                   require.toUrl()
dojo.moduleUrl("dijit", "foo.template.html")          require               require.toUrl("dijit/foo/template.html")
dojo.requireLocalization()                            dojo/i18n!            see I18N section above
dojo.getLocalization()                                dojo/i18n!            see I18N section above
dojo.cache("my.module", "template.html")              dojo/text!            require("dojo/text!my/module/template.html", function(text){ ...
===================================================== ===================== ==========================================

Dojo Core
=========

Basic functions
---------------

.. _releasenotes/migration-2.0#testing-object-types:

Testing object types
~~~~~~~~~~~~~~~~~~~~

2.0 will remove the ``isXXX()`` functions defined in ``dojo/_base/lang``.  In most cases they can be easily replaced 
with simple native tests:

=========================== ============================================
1.x                         2.0
=========================== ============================================
``dojo.isString(v)``        ``typeof v == "string"``
``dojo.isArray(v)``         ``v instanceof Array``
``dojo.isFunction(v)``      ``typeof v == "function"``
``dojo.isArrayLike(v)``     ``"length" in v``, etc. (but see note below)
=========================== ============================================

Notes:

- On some browsers ``"length" in v`` will return true for strings and functions, so if you are trying to differentiate 
  between strings and arrays of strings, use the ``typeof v == "string"`` test instead, and if you are trying to 
  differentiate between functions and arrays of functions, use the ``typeof v == "function"`` test instead. It will 
  also return ``true`` for built-in constructors (``Number``, ``String``, etc.) which have ``length``.

- ``typeof value == "function"`` won't match IE's hosted functions (like ``alert``).

- ``v instanceof Array`` won't work if ``v`` was created in a different frame.

dojo/_base/lang
~~~~~~~~~~~~~~~

=================================================   ============================   ====================================
1.x syntax                                          2.0 module                     2.0 syntax
=================================================   ============================   ====================================
dojo.extend                                         dojo/_base/lang                lang.extend
dojo._hitchArgs                                     dojo/_base/lang                lang._hitchArgs
dojo.hitch                                          dojo/_base/lang                lang.hitch
dojo.delegate                                       dojo/_base/lang                lang.delegate
dojo._toArray                                       dojo/_base/lang                lang._toArray
dojo.partial                                        dojo/_base/lang                lang.partial
dojo.clone                                          dojo/_base/lang                lang.clone
dojo.trim                                           dojo/_base/lang                lang.trim
dojo.replace                                        dojo/_base/lang                lang.replace
dojo.mixin                                          dojo/_base/lang                lang.mixin
dojo._mixin                                         dojo/_base/lang                lang._mixin
dojo.exists                                         dojo/_base/lang                lang.exists
dojo.getObject                                      dojo/_base/lang                lang.getObject
dojo.setObject                                      dojo/_base/lang                lang.setObject
=================================================   ============================   ====================================

dojo/_base/kernel
~~~~~~~~~~~~~~~~~

=================================================   ============================   ====================================
1.x syntax                                          2.0 module                     2.0 syntax
=================================================   ============================   ====================================
dojo.deprecated                                     dojo/_base/kernel              kernel.deprecated
dojo.experimental                                   dojo/_base/kernel              kernel.experimental
dojo.version                                        dojo/_base/kernel              kernel.version
dojo.eval                                           dojo/json                      native eval() or json.parse() for json
dojo.global                                         dojo/_base/kernel              kernel.global
=================================================   ============================   ====================================

``global`` is an alias for the global scope that was designed to work both in a browser environment
(where it points to ``window``), and a server environment.

With modern AMD code, hopefully globals are completely unnecessary.
If you do need to create/read a global, then the following pattern is preferred:

.. js ::

   require([...], function(...){
        var global = this;
        ...
        global.myVariable = "hello world";
   });

For strict modules, there's a slightly more complicated syntax:

.. js ::

   "use strict";
   require([...], function(...){
        var global = Function("return this")();
        ...
        global.myVariable = "hello world";
   });

dojo/_base/array
~~~~~~~~~~~~~~~~

*To be determined* - Dojo 2.0 may have ``dojo/array``, or ``dojo/each``, or just shim ``Array`` prototype on IE to 
match behavior of modern browsers.

In 1.7 and later, use "dojo/_base/array" module to get ``forEach()``, ``map()``, etc:

=================================================   ============================   ====================================
1.x syntax                                          2.0 module                     2.0 syntax
=================================================   ============================   ====================================
dojo.forEach                                        dojo/_base/array               array.forEach
dojo.map                                            dojo/_base/array               array.map
dojo.filter                                         dojo/_base/array               array.filter
dojo.every                                          dojo/_base/array               array.every
dojo.some                                           dojo/_base/array               array.some
dojo.indexOf                                        dojo/_base/array               array.indexOf
=================================================   ============================   ====================================

Browser/Device Sniffing
~~~~~~~~~~~~~~~~~~~~~~~

If your code uses browser sniffing, you should load :ref:`dojo/sniff <dojo/sniff>` or 
:ref:`dojox/mobile/sniff <dojox/mobile/sniff>`.  Both these modules leverage the :ref:`dojo/has <dojo/has>` API for 
feature detection.

For example, old code like:

.. js ::

  if(dojo.isIE < 6){
    // ...
  }

should be changed to:

.. js ::

  require(["dojo/has", "dojo/sniff"], function(has){
    if(has("ie") < 6){
      // ...
    }
  });

Overview of where functionality has moved:

=================================================   ============================   ====================================
1.x syntax                                          2.0 module                     2.0 syntax
=================================================   ============================   ====================================
dojo.isOpera                                        dojo/sniff                     has("opera")
dojo.isAIR                                          dojo/sniff                     has("air")
dojo.isKhtml                                        dojo/sniff                     has("khtml")
dojo.isWebKit                                       dojo/sniff                     has("webkit")
dojo.isChrome                                       dojo/sniff                     has("chrome")
dojo.isMac                                          dojo/sniff                     has("mac")
dojo.isSafari                                       dojo/sniff                     has("safari")
dojo.isMozilla                                      dojo/sniff                     has("mozilla")
dojo.isMoz                                          dojo/sniff                     has("mozilla")
dojo.isIE                                           dojo/sniff                     has("ie")
dojo.isFF                                           dojo/sniff                     has("ff")
dojo.isAndroid                                      dojo/sniff                     has("android")
dojo.isBB                                           dojox/mobile/sniff             has("bb")
dojo.isIpad                                         dojox/mobile/sniff             has("ipad")
dojo.isIphone                                       dojox/mobile/sniff             has("iphone")
dojo.isIpod                                         dojox/mobile/sniff             has("ipod")
dojo.isQuirks                                       dojo/sniff                     has("quirks")
dojo.isIos                                          dojo/sniff                     has("ios")
=================================================   ============================   ====================================

Load and Unload Handlers
~~~~~~~~~~~~~~~~~~~~~~~~

Loading and unloading have been moved to ``dojo/ready`` and ``dojo/_base/unload``:

=================================================   ============================   ====================================
1.x syntax                                          2.0 module                     2.0 syntax
=================================================   ============================   ====================================
dojo.addOnLoad(f)                                   dojo/ready                     ready(f)
dojo.ready(f)                                       dojo/ready                     ready(f)
dojo.addOnUnload                                    dojo/_base/unload              unload.addOnUnload
dojo.addOnWindowUnload                              dojo/_base/unload              unload.addOnWindowUnload
=================================================   ============================   ====================================

Events
------

``dojo.connect()`` / ``dojo.disconnect()`` for monitoring DOMNode events have been replaced by the ``on()`` method 
returned from the :ref:`dojo/on <dojo/on>` module.  (For ``dojo.connect()`` usage as advice on plain JavaScript 
functions/methods, see the Advice_ section below)

Old code like:

.. js ::

  var handle = dojo.connect(node, "onclick", callback);
  // ...
  dojo.disconnect(handle);

should be converted to:

.. js ::

  require(["dojo/on"], function(on){
    var handle = on(node, "click", callback);
    // ...
    handle.remove();
  });

Note that:

* the ``on`` prefix was dropped, and ``onclick`` became ``click``

* the "handle" has a remove() method, rather than there being a function like dojo.disconnect()

The NodeList objects returned from ``dojo/query`` also works with an ``.on()`` method rather than a ``.connect()`` 
method.

Old code like:

.. js ::

  dojo.query("li").connect("onclick", callback);

should be converted to:

.. js ::

  require(["dojo/query"], function(query){
    query("li").on("click", callback);
  });

mouseenter/mouseleave
~~~~~~~~~~~~~~~~~~~~~

Dojo supports ``onmouseenter``/``onmouseleave`` synthetically for browsers that do not support those events natively. 
In 1.x these events were specified as strings, just like native events:

.. js ::

  dojo.connect(node, "onmouseenter", callback);

Now they are specified by event objects defined in ``dojo/mouse``, which must be explicitly loaded, and used like this:

.. js ::

  require(["dojo/on", "dojo/mouse"], function(on, mouse){
    on(node, mouse.enter, callback);
  });

Similarly, ``"onmouseleave"`` has become ``mouse.leave``.

Mouse Buttons
~~~~~~~~~~~~~

``dojo.mouseButtons`` has been replaced by the ``dojo/mouse`` module, which must be explicitly loaded.

Code like:

.. js ::

  dojo.connect(node, "onmousedown", function(evt){
    if(dojo.mouseButtons.isLeft(evt){ ... }
  });

should be converted to:

.. js ::

  require(["dojo/on", "dojo/mouse"], function(on, mouse){
    on(node, "mousedown", function(evt){
      if(mouse.isLeft(evt)){ ... }
    });
  });

Keys
~~~~

The symbolic names for keys have been put into the :ref:`dojo/keys <dojo/keys>` module, which must be explicitly 
loaded and can be accessed like this:

.. js ::

  require(["dojo/on", "dojo/keys"], function(on, keys){
    on(node, "keydown", function(evt){
      if(evt.keyCode == keys.F10){ ... }
    });
  });

onkeypress
~~~~~~~~~~

The Dojo ``onkeypress`` normalization to Firefox behavior has been desupported.  For portable applications, you must 
use ``keypress`` for monitoring printable characters (e.g. A-Z, 1-9):

.. js ::

  on(node, "keypress", function(evt){
    if(evt.charCode <= 32){
      // Avoid duplicate events on firefox (this is an arrow key etc. that will be handled by keydown handler)
      return;
    }
    var char = String.fromCharCode(evt.charCode);
    // ...
  });

and keydown for non-printable characters (e.g. arrow keys):

.. js ::

  on(node, "keydown", function(evt){
    switch(evt.keyCode){
     case keys.UP_ARROW:
        // ...
        break;
    }
  });

Note that the normalization of ``evt.charOrCode`` is also gone, so use ``evt.charCode`` for keypress events, or 
``evt.keyCode`` for keydown events.

Event Delegation
~~~~~~~~~~~~~~~~

The ``dojo.behavior`` and ``dojox.NodeList.delegate`` modules have been replaced by functionality built-in to 
``dojo/on``.

Old code:

.. js ::

  var myBehavior = {
    "#mylist li:click" : {
      onclick: onListItemClickHandler
    }
  };
  dojo.behavior.add(myBehavior);
  dojo.behavior.apply();

New code:

.. js ::

  require(["dojo/on", "dojo/query", "dojo/_base/window"], function(on, query, win){
    on(win.doc(), "#mylist li:click", onListItemClickHandler);
  });

connectPublisher()
~~~~~~~~~~~~~~~~~~

``dojo.connectPublisher()`` was an automation of this common form:

.. js ::

  dojo.connect(myObject, "myEvent", function(){
    dojo.publish("/some/topic/name", arguments);
  });

Which became:

.. js ::

  dojo.connectPublisher("/some/topic/name", myObject, "myEvent");

But in 2.0 users should use the following for connecting to DOM events:

.. js ::

  require(["dojo/on", "dojo/topic"], function(on, topic){
    on(myNode, "click", function(){
      topic.publish("/some/topic/name", arg1, arg2, arg3);
    });
  });

Or this for after-advice on arbitrary methods of arbitrary objects:

.. js ::

  require(["dojo/aspect", "dojo/topic"], function(aspect, topic){
    aspect.after(myObj, "myFunc", function(){
      topic.publish("/some/topic/name", arg1, arg2, arg3);
    });
  });

Quick Reference
~~~~~~~~~~~~~~~

=====================================================   ========================   ====================================
1.x syntax                                              2.0 module                 2.0 syntax
=====================================================   ========================   ====================================
dojo.connect(node,"onclick",cb)                         dojo/on                    on(node,"click",cb)   (note that "on" prefix removed)
dojo.connect(node,"onmouseenter",cb)                    dojo/on,dojo/mouse         on(node,mouse.enter,cb)
dojo.connect(node,"onmouseleave",cb)                    dojo/on,dojo/mouse         on(node,mouse.leave,cb)
dojo.connect(node,"onkeypress",cb)                      dojo/on                    on(node,"keypress",cb) for printable or on(node,"keydown",cb) for arrows etc.
dojo.disconnect(handle)                                                            handle.remove()
dojo.connectPublisher                                                              see above
dojo.fixEvent                                           dojo/_base/event           event.fix
dojo.stopEvent                                          dojo/_base/event           event.stop
dojo.mouseButtons.is***()                               dojo/mouse                 mouse.is***()
dojo.isCopyKey                                          ?                          ?
=====================================================   ========================   ====================================

Advice
------

``dojo.connect()`` could be used to perform after advice (based on the concepts of Aspect Oriented Programming) on a
method.  In 2.0 that has been replaced by the ``dojo/aspect`` package.

Old code:

.. js ::

  var handle = dojo.connect(myInstance, "execute", callback);
  // ...
  dojo.disconnect(handle);

is changed to:

.. js ::

  require(["dojo/aspect"], function(aspect){
    var handle = aspect.after(myInstance, "execute", callback, true);
    /  ...
    handle.remove();
  });

Note that ``callback()`` should not return a value, because if it did the returned value would be reported as the 
value that ``myInstance.execute()`` appeared to return, which is not what ``dojo.connect()`` did.

Quick Reference
~~~~~~~~~~~~~~~

=================================================   ============================   ====================================
1.x syntax                                          2.0 module                     2.0 syntax
=================================================   ============================   ====================================
dojo.connect(obj,method,cb)                         dojo/aspect                    aspect.after(obj,method,cb,true)
dojo.disconnect(handle)                                                            handle.remove();
=================================================   ============================   ====================================

Publish and subscribe
---------------------

``dojo.publish()``/``dojo.subscribe()``/``dojo.unsubscribe()`` have been replaced by the ``dojo/topic`` module.

Old code:

.. js ::

  var handle = dojo.subscribe("some/topic", context, callback);
  // ...
  dojo.unsubscribe(handle);

is changed to:

.. js ::

  require(["dojo/topic"], function(topic){
    var handle = topic.subscribe("some/topic", listener)
    // ...
    handle.remove();
  });

And publishing code is changed from:

.. js ::

  dojo.publish("some/topic", [1, 2, 3]);

to:

.. js ::

  require(["dojo/topic"], function(topic){
    topic.publish("some/topic", 1, 2, 3);
  });


Note that no array brackets are used anymore.

Quick Reference
~~~~~~~~~~~~~~~

=================================================   ============================   ====================================
1.x syntax                                          2.0 module                     2.0 syntax
=================================================   ============================   ====================================
dojo.publish("/foo", [1,2,3])                       dojo/topic                     topic.publish("/foo", 1, 2, 3)
dojo.subscribe("/foo", callback)                    dojo/topic                     topic.subscribe("/foo", callback)
dojo.unsubscribe(handle)                                                           handle.remove()
=================================================   ============================   ====================================

DOM Manipulation
----------------

The Dojo DOM related functions previously available as part of ``dojo/dojo.js`` are now in a number of modules which 
must each be explicitly loaded.  These modules are:

* :ref:`dojo/dom <dojo/dom>`: general functions

* :ref:`dojo/dom-attr <dojo/dom-attr>`: setting node attributes

* :ref:`dojo/dom-class <dojo/dom-class>`: adding and removing classes

* :ref:`dojo/dom-construct <dojo/dom-construct>`: creating and destroying nodes

* :ref:`dojo/dom-form <dojo/dom-form>`: form related

* :ref:`dojo/io-query <dojo/io-query>`: query conversion functions

* :ref:`dojo/dom-geometry <dojo/dom-geometry>`: node sizing

* :ref:`dojo/dom-prop <dojo/dom-prop>`: setting node properties

* :ref:`dojo/dom-style <dojo/dom-style>`: setting/getting style for a node

Note in particular that node attribute setting and property setting has been split up. ``dojo/dom-attr`` will 
eventually be deprecated in lieu of ``dojo/dom-prop``.

Note also that combination accessor functions like ``dojo.marginBox()``, ``dojo.contentBox()``, and ``dojo.style()`` 
have been split into separate setter and getter methods.

Quick Reference
~~~~~~~~~~~~~~~

=================================================   ============================   ====================================
1.x syntax                                          2.0 module                     2.0 syntax
=================================================   ============================   ====================================
dojo.byId                                           dojo/dom                       dom.byId
dojo.isDescendant                                   dojo/dom                       dom.isDescendant
dojo.setSelectable                                  dojo/dom                       dom.setSelectable
dojo.attr(node, attr)                               dojo/dom-attr                  attr.get(node, attr)
dojo.attr(node, attr, val)                          dojo/dom-attr                  attr.set(node, attr, val)
dojo.hasAttr                                        dojo/dom-attr                  attr.has
dojo.removeAttr                                     dojo/dom-attr                  attr.remove
dojo.addClass                                       dojo/dom-class                 domClass.add
dojo.hasClass                                       dojo/dom-class                 domClass.contains
dojo.removeClass                                    dojo/dom-class                 domClass.remove
dojo.replaceClass                                   dojo/dom-class                 domClass.replace
dojo.toggleClass                                    dojo/dom-class                 domClass.toggle
dojo.toDom                                          dojo/dom-construct             construct.toDom
dojo.place                                          dojo/dom-construct             construct.place
dojo.create                                         dojo/dom-construct             construct.create
dojo.empty                                          dojo/dom-construct             construct.empty
dojo.destroy                                        dojo/dom-construct             construct.destroy
dojo.fieldToObject                                  dojo/dom-form                  form.fieldToObject
dojo.formToObject                                   dojo/dom-form                  form.toObject
dojo.formToQuery                                    dojo/dom-form                  form.toQuery
dojo.formToJson                                     dojo/dom-form                  form.toJson
dojo._getPadExtents                                 dojo/dom-geometry              geometry.getPadExtents
dojo._getBorderExtents                              dojo/dom-geometry              geometry.getBorderExtents
dojo._getPadBorderExtents                           dojo/dom-geometry              geometry.getPadBorderExtents
dojo._getMarginExtents                              dojo/dom-geometry              geometry.getMarginExtents
dojo._getMarginSize                                 dojo/dom-geometry              geometry.getMarginSize
dojo._getMarginBox                                  dojo/dom-geometry              geometry.getMarginBox
dojo._setMarginBox                                  dojo/dom-geometry              geometry.setMarginBox
dojo.marginBox(node)                                dojo/dom-geometry              geometry.getMarginBox(node)
dojo.marginBox(node,size)                           dojo/dom-geometry              geometry.setMarginBox(node,size)
dojo._getContentBox                                 dojo/dom-geometry              geometry.getContentBox
dojo.setContentSize                                 dojo/dom-geometry              geometry.setContentSize
dojo.contentBox(node)                               dojo/dom-geometry              geometry.getContentBox(node)
dojo.contentBox(node,size)                          dojo/dom-geometry              geometry.setContentSize(node,size)
dojo.position                                       dojo/dom-geometry              geometry.position
dojo._isBodyLtr                                     dojo/dom-geometry              geometry.isBodyLtr
dojo._docScroll                                     dojo/dom-geometry              geometry.docScroll
dojo._getIeDocumentElementOffset                    dojo/dom-geometry              geometry.getIeDocumentElementOffset
dojo._fixIeBiDiScrollLeft                           dojo/dom-geometry              geometry.fixIeBiDiScrollLeft
dojo.style(node, attr)                              dojo/dom-style                 style.get(node, attr)
dojo.style(node, attr, val)                         dojo/dom-style                 style.set(node, attr, val)
dojo.style(node, hash)                              dojo/dom-style                 style.set(node, hash)
dojo.getComputedStyle                               dojo/dom-style                 style.getComputedStyle
dojo._toPixelValue                                  dojo/dom-style                 style.toPixelValue
dojo.queryToObject                                  dojo/io-query                  ioQuery.queryToObject
dojo.objectToQuery                                  dojo/io-query                  ioQuery.objectToQuery
=================================================   ============================   ====================================

dojo/_base/window
~~~~~~~~~~~~~~~~~

**dojo/_base/window** was originally written to serve two main purposes:

   - Provide methods/variables to access the current document and the ``<body>`` element of the current document.

   - Provide functions to switch the "current document", i.e. the document accessed by the methods/variables
     mentioned above, and indirectly by DOM methods where the document isn't implied by the arguments, for example
     ``dojo.byId("xyz")``.

In modern code, you can usually forgo use of this module, and instead just:

   - Use the ``window``, ``document``, and ``document.body`` global variables, or equivalent variables
     for the frame that you want to operate on.

   - If you need to operate on a different frame/document, all of the modern dojo DOM related methods either take a document
     parameter or a DOMNode parameter (which implies a document).   For example:

.. js ::

     require(["dojo/dom", "dojo/dom-geometry"], function(dom, domGeom){
         var node = dom.byId("address", myDocument);
         domGeom.setMarginBox(node, ...);
     });

In V1.9 (and earlier) the old methods are still accessible through AMD via:

=================================================   ============================   ====================================
1.x syntax                                          2.0 module                     2.0 syntax
=================================================   ============================   ====================================
dojo.global                                         dojo/_base/window              window.global
dojo.doc                                            dojo/_base/window              window.doc
dojo.body                                           dojo/_base/window              window.body
dojo.setContext                                     dojo/_base/window              window.setContext
dojo.withGlobal                                     dojo/_base/window              window.withGlobal
dojo.withDoc                                        dojo/_base/window              window.withDoc
=================================================   ============================   ====================================

JSON
----

The JSON methods are available from the :ref:`dojo/json <dojo/json>` package, which must be loaded explicitly.

=================================================   ============================   ====================================
1.x syntax                                          2.0 module                     2.0 syntax
=================================================   ============================   ====================================
dojo.fromJson                                       dojo/json                      json.parse
dojo.toJson                                         dojo/json                      json.stringify
=================================================   ============================   ====================================

Note that the new methods only accept true JSON, not arbitrary JavaScript.  Even the keys in a hash must be quoted

Valid:

.. js ::

  { "foo": 1, "bar": 2 }

Invalid:

.. js ::

  { foo: 1, bar: 2 }

Also, single quotes are invalid, you must use double quotes for keys and string values.

Parser
------

Running the Parser
~~~~~~~~~~~~~~~~~~

The parser is in the :ref:`dojo/parser <dojo/parser>` module, invoked like:

.. js ::

  require(["dojo/parser"], function(parser){
    parser.parse();
  });

Even if you are parsing declaratively via the ``parseOnLoad: true`` ``dojoConfig`` setting, you need to explicitly 
require the parser.

data-dojo-type and data-dojo-props
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``dojoType`` has been renamed to ``data-dojo-type``, and a new ``data-dojo-props`` parameter has been created to 
specify non-native attributes in a way that doesn't violate HTML5 validation.

Old code:

.. html ::

  <button dojoType="dijit.form.Button" tabIndex=2
      iconClass="checkmark">OK</button>

New code:

.. html ::

  <button data-dojo-type="dijit/form/Button" tabIndex=2
      data-dojo-props="iconClass: 'checkmark'">OK</button>

``data-dojo-props`` is a hash that contains name value pairs, for example: ``data-dojo-props=" name: 'hi', size: 123"``
.

Using MIDs
~~~~~~~~~~

Starting in 1.8, referring to classes by their module ID (MID) is the preferred way.

Old code:

.. html ::

  <button data-dojo-type="dijit.form.Button" tabIndex=2
    data-dojo-props="iconClass: 'checkmark'">OK</button>

New code:

.. html ::

  <button data-dojo-type="dijit/form/Button" tabIndex=2
    data-dojo-props="iconClass: 'checkmark'">OK</button>

The MID should match the ``require([...])`` used to require it in and the ``require([...])`` should occur before the 
parser is invoked, but the ``parse()`` doesn't have to specifically occur within the closure of the ``require([...])``.
If the module is not loaded before the invocation of the ``parse()``, the ``dojo/parser`` will attempt to auto-load 
the module, if the value of ``data-dojo-type`` looks like it is a MID.

Connecting to Widget Events
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Previously you could use ``<script type="dojo/connect">`` to monitor widget events and connect to methods:

.. html ::

  <button data-dojo-type="dijit.form.Button">
    <span>Click Me!</span>
    <script type="dojo/connect" event="onclick" args="e">
      // ...
    </script>
  </button>

Now the following is used: ``<script type="dojo/on">`` for events like click, ``<script type="dojo/watch">`` to monitor
changes to a widget's attribute and ``<script type="dojo/aspect">`` to modify the behavior of methods:

.. html ::

  <button data-dojo-type="dijit/form/Button">Click Me!
    <script type="dojo/on" data-dojo-event="click" data-dojo-args="e">
      // ...
    </script>
  </button>
  <div data-dojo-type="dijit/form/TextBox" id="textBox1"
      data-dojo-props="value: 'Old Value'">
    <script type="dojo/watch" data-dojo-prop="value" data-dojo-args="prop,oldValue,newValue">
      console.log("Prop '"+prop+"' was '"+oldValue+"' and is now '"+newValue+"'");
    </script>
  </div>
  <form data-dojo-type="dijit/form/Form">
    <script type="dojo/aspect" data-dojo-advice="before" data-dojo-method="onSubmit">
      // ...
    </script>
    <!-- ... -->
  </form>

jsId
----

The `jsId` attribute has been removed. Replace all `jsId` references with `data-dojo-id`, the behavior is identical.

.. html ::

  <div data-dojo-id="bar" data-dojo-type="some/Thinger">I am exported to window.bar by reference</div>


Query
-----

``dojo/query`` is a new module similar to the old ``dojo.query()`` function.  In general you can use it like 
``dojo.query()``, so old code like:

.. js ::

  dojo.query("li").connect("onclick", callback)

can been replaced by:

.. js ::

  require(["dojo/query"], function(query){
    query("li").on("click", callback);
  });

Points of caution:

  1. As before, you need to require certain NodeList extension modules to get added methods on the NodeList return 
  from ``query()``. The difference is that now the NodeList DOM functions also need to be explicitly loaded. So you 
  need to do:

  .. js ::

    require(["dojo/query", "dojo/NodeList-dom"], function(query){
      query("li").style("display", "none");
    });


  2. ``query()`` can load various selector engines. By default it uses the ``dojo/selector/light`` engine. If you have 
  complicated queries you need to switch it to use a more powerful engine. See :ref:`dojo/query <dojo/query>` for 
  details.

  There are a couple of ways to set the selector engine. First, we can define the selector engine as part of the dojo 
  configuration for the whole page:

  .. html ::

    <script data-dojo-config="selectorEngine='css2.1'" src="dojo/dojo.js"></script>

  You can also specify the selector engine level you are dependent on for each of your modules. This is done by 
  indicating the CSS selector engine level after ``!`` in the ``dojo/query`` module id. For example, if your module 
  needed to do a CSS3 level query, you could write:

  .. js ::

    define(["dojo/query!css3"], function(query){
      query(".someClass:last-child").style("color", "red");
    });

Stores
------

The :ref:`dojo.data <dojo/data>` API stores have been replaced with the new :ref:`dojo/store <dojo/store>` API.

================================   =================================
dojo.data                          dojo/store
================================   =================================
store.getValue(item, "foo")        item.foo
store.getLabel(item)               item.label
store.getItemByIdentifier(id)      store.get(id) returns Deferred
store.fetch(...)                   store.query() returns Deferred
================================   =================================

In order to aid transition, there are two modules that are available:

* :ref:`dojo/store/DataStore <dojo/store/DataStore>` - Can convert a legacy ``dojo.data`` API store and make it appear 
  to be a native ``dojo/store``.

* :ref:`dojo.data.ObjectStore <dojo/data/ObjectStore>` - Wraps a ``dojo/store`` API store and makes it appear to be a 
  legacy ``dojo.data`` store.

Many Dijits are now directly ``dojo/store`` aware, including: :ref:`dijit/form/ComboBox <dijit/form/ComboBox>`, 
:ref:`dijit/form/FilteringSelect <dijit/form/FilteringSelect>`, and :ref:`dijit/Tree <dijit/Tree>`.

Declaring Classes
-----------------

``dojo.declare()`` has been migrated to :ref:`dojo/_base/declare <dojo/_base/declare>`.  There may be further changes 
for Dojo 2.0, for example replacing it by ComposeJS, or may have more modest changes.  For now, for classes you don't 
need in the global scope, you should declare them as baseless.  Something like this:

.. js ::

  dojo.provide("package.myClass");
  dojo.require("dijit._Widget");
  dojo.declare("package.myWidget", [dijit._Widget], {
    // myWidget Class declaration
  });

Should change to something like this:

.. js ::

  define(["dojo/_base/declare", "dijit/_WidgetBase"], 
  function(declare, _WidgetBase){
    return declare([_WidgetBase], {
      // myWidget Class declaration
    });
  });

Notice the omission of the first argument in the ``declare()``. This means that nothing will be set in the global 
scope.  Also, the mixin array uses the return values of the define requirement array, instead of the legacy class 
names. This means that your custom class will only be available within the closure scope of a ``require()`` or 
``define()`` that has required it in.

This does mean your module can only return a single public class, which is more consistent with the concepts of AMD and
baseless anyways, but if you need to create a private class that isn't referenced outside the current module, you can
simply declare it as a variable. For example:

.. js ::

  define(["dojo/_base/declare", "dijit/_WidgetBase"],
  function(declare, _WidgetBase){
    var _myMixin = declare(null, {
      // _myMixin Class private declaration
    });

    return declare([_WidgetBase, _myMixin], {
      // myWidget Class
    });
  });

FX
--

The base FX features of ``dojo/dojo.js`` have been moved to :ref:`dojo/_base/fx <dojo/_base/fx>` and the additional 
features of the ``dojo.fx`` module are now in :ref:`dojo/fx <dojo/fx>`.

=================================================   ============================   ====================================
1.x syntax                                          2.0 module                     2.0 syntax
=================================================   ============================   ====================================
dojo._Line                                          dojo/_base/fx                  baseFx._Line
dojo.Animation                                      dojo/_base/fx                  baseFx.Animation
dojo._fade                                          dojo/_base/fx                  baseFx._fade
dojo.fadeIn                                         dojo/_base/fx                  baseFx.fadeIn
dojo.fadeOut                                        dojo/_base/fx                  baseFx.fadeOut
dojo._defaultEasing                                 dojo/_base/fx                  baseFx._defaultEasing
dojo.animateProperty                                dojo/_base/fx                  baseFx.animateProperty
dojo.anim                                           dojo/_base/fx                  baseFx.anim
=================================================   ============================   ====================================

Promises and Deferreds
----------------------

``dojo.Deferred`` and ``dojo.when`` have been replaced with ``dojo/promise``, ``dojo/Deferred`` and ``dojo/when``.  
The functionality in ``dojo.
DeferredList`` has been replaced by ``dojo/promise/all`` and ``dojo/promise/first``.

Old code like:

.. js ::

  var d = new dojo.Deferred();
  d.addCallback(function(result){
    // handle success
  });
  d.addErrback(function(err){
    // handle failure
  });
  d.callback({ success: true });
  d.errback({ success: false });

Should be refactored like:

.. js ::

  require(["dojo/Deferred"], function(Deferred){
    var d = new Deferred();

    d.then(function(result){
      // handle success
    }, function(err){
      // handle failure
    });

    d.resolve({ success: true });
    d.reject({ success: false });
  });

The following table provides a quick reference to the changes:

=================================================   ============================   ====================================
1.x syntax                                          2.0 module                     2.0 syntax
=================================================   ============================   ====================================
dojo.Deferred                                       dojo/Deferred                  Deferred
dojo.when                                           dojo/when                      when
dojo.DeferredList([...]).then(...)                  dojo/promise/all               all([...]).then(...)
dojo.DeferredList([...], true).then(...)            dojo/promise/first             first([...]).then(...)
=================================================   ============================   ====================================

XHR and IO Requests
-------------------

``dojo.xhr*`` and ``dojo.io.*`` have been replaced with :ref:`dojo/request <dojo/request>`.

Old code like:

.. js ::

  dojo.xhrGet({
    url: "something.json",
    handleAs: "json",
    load: function(data){
      // do something
    },
    error: function(e){
      // handle error
    }
  });

Should be refactored as:

.. js ::

  require(["dojo/request"], function(request){
    request.get("something.json", {
      handleAs: "json"
    }).then(function(data){
      // do something
    }, function(e){
      // handle error
    });
  });

``dojo.io.script`` is replaced by :ref:`dojo/request/script <dojo/request/script>` and ``dojo.io.iframe`` is
replaced by :ref:`dojo/request/iframe` and operate in a similar fashion to the base ``dojo/request`` module.

Note that ``dojo/request`` utilises the new ``dojo/promise`` modules.

Miscellaneous
-------------

=================================================   ============================   ====================================
1.x syntax                                          2.0 module                     2.0 syntax
=================================================   ============================   ====================================
dojo.window                                         dojo/window                    window
dojo.Color                                          dojo/_base/Color               Color
dojo.cookie                                         dojo/cookie                    cookie
dojo.date.locale                                    dojo/date/locale
dojo.date.stamp                                     dojo/date/stamp
dojo.date                                           dojo/date
dojo.dnd.*                                          dojo/dnd/*
dojo.hash                                           dojo/hash                      hash
dojo.html                                           dojo/html                      html
dojo.currency                                       dojo/currency                  currency
dojo.number                                         dojo/number                    number
dojo.string                                         dojo/string                    string
dojo.Stateful                                       dojo/Stateful                  Stateful
dojo.window.*                                       dojo/window                    window.*
dojo.config                                         dojo/_base/config              config
dojo.back.*                                         dojo/hash                      see :ref:`dojo/hash <dojo/hash>` reference doc
=================================================   ============================   ====================================

Dijit
=====

Mapping table for dijit
-----------------------

This is a quick lookup table for methods, attributes, etc. in 1.x mapped to their equivalent method in that module in 
2.0.   Note that many methods that were previously included automatically now need to be explicitly loaded.

The sections underneath this give more detail on conversions.

=================================================   ============================   ====================================
1.x syntax                                          2.0 module                     2.0 syntax
=================================================   ============================   ====================================
dijit.hasDefaultTabStop                             dijit/a11y                     a11y.hasDefaultTabStop
dijit.isTabNavigable                                dijit/a11y                     a11y.isTabNavigable
dijit._getTabNavigable                              dijit/a11y                     a11y._getTabNavigable
dijit.getFirstInTabbingOrder                        dijit/a11y                     a11y.getFirstInTabbingOrder
dijit.getLastInTabbingOrder                         dijit/a11y                     a11y.getLastInTabbingOrder
dijit.byId                                          dijit/registry                 registry.byId
dijit.byNode                                        dijit/registry                 registry.byNode
dijit.registry.toArray                              dijit/registry                 registry.toArray
dijit.registry.forEach()                            dijit/registry                 array.forEach(registry.toArray(), ...)
dijit.registry.filter()                             dijit/registry                 array.filter(registry.toArray(), ...)
dijit.registry.map()                                dijit/registry                 array.map(registry.toArray(), ...)
dijit.registry.every()                              dijit/registry                 array.every(registry.toArray(), ...)
dijit.registry.some()                               dijit/registry                 array.some(registry.toArray(), ...)
dijit.registry.byClass("dijit.form.Button")         dijit/registry                 array.filter(registry.toArray(), function(widget){ return widget.constructor === require("dijit/form/Button"); })
dijit.findWidgets                                   dijit/registry                 registry.findWidgets
dijit.getEnclosingWidget                            dijit/registry                 registry.getEnclosingWidget
dijit.focus                                         dijit/focus                    focus.focus
dijit.registerWin                                   dijit/focus                    focus.registerIframe
dijit._curNode                                      dijit/focus                    focus.curNode
dijit.getFocus()                                    dijit/focus                    focus.curNode (points to node not hash)
dijit._activeState                                  dijit/focus                    focus.activeStack
dojo.require("dijit.sniff")                         dojo/uacss                     require dojo/uacss instead
dojo.subscribe("focusNode",cb)                      dijit/focus                    focus.watch("curNode",cb)
dojo.subscribe("widgetBlur",cb)                     dijit/focus                    focus.on("widget-blur",cb)
dojo.subscribe("widgetFocus",cb)                    dijit/focus                    focus.on("widget-focus",cb)
dijit.getViewport                                   dojo/window                    window.getBox
dijit.placeOnScreen                                 dijit/place:place.at
dijit.placeOnScreenAroundElement(n,an,{BL: "TL"     dijit/place                    place.around(n,an,["before","after"])
dijit.typematic                                     dijit/typematic                typematic
dijit.popup.open({orient:{BL: "TL",...})            dijit/popup                    popup.open({orient:["before","after"]})
dijit.hasWaiRole(node, role)                                                       node.getAttribute("role")==role
dijit.getWaiRole(node)                                                             node.getAttribute("role")
dijit.setWaiRole(node, role)                                                       node.setAttribute("role", role)
dijit.removeWaiRole                                                                node.setAttribute(role, "")
dijit.hasWaiState("selected")                                                      node.hasAttribute("aria-selected")
dijit.getWaiState("describedby")                                                   node.getAttribute("aria-describedby")
dijit.setWaiState("describedby", desc)                                             node.getAttribute("aria-describedby", desc)
dijit.removeWaiState("selected")                                                   node.removeAttribute("aria-selected")
dijit.layout.marginBox2contentBox                   dijit/layout/utils             utils.marginBox2contentBox
dijit.layout.layoutChildren                         dijit/layout/utils             utils.layoutChildren
dojo.connect(myWidget, "onClick", cb)                                              myWidget.on("click", cb)
dojo.connect(myWidget, "onChange", cb)                                             myWidget.watch("value", function(name, o, n){...})
myWidget.setAttribute(name,val)                                                    myWidget.set(name,val)
myWidget.attr(name)                                                                myWidget.get(name)
myWidget.attr(name,val)                                                            myWidget.set(name,val)
myWidget.attr(hash)                                                                myWidget.set(hash)
myWidget.getDescendants                                                            myWidget.getChildren
myWidget.setDisabled(bool)                                                         myWidget.set("disabled", bool)
myWidget.setValue(val)                                                             myWidget.set("value", val)
myWidget.getValue()                                                                myWidget.get("value")
myWidget.getDisplayedValue()                                                       myWidget.get("displayedValue")
myWidget.setDisplayedValue(val)                                                    myWidget.set("displayedValue", val)
myWidget.setLabel(label)                                                           myWidget.set("label", label)
myWidget.setChecked(val)                                                           myWidget.set("checked", val)
myWidget.setHref()                                                                 myWidget.set("href", ...)
myWidget.setContent()                                                              myWidget.set("content", ...)
dojo.connect(myCalendar, "onValueSelected", ...)                                   myCalendar.watch("value", ...)
Editor.focusOnLoad                                  dijit/Editor                   perform manually
Editor.blur()                                       dijit/Editor                   focus something else
dijit._editor.escapeXml()                           dijit/_editor/html             html.escapeXml()
Editor.getNodeHtml()                                dijit/_editor/html             html._getNodeHtml()
Editor.getNodeChildrenHtml()                        dijit/_editor/html             html.getNodeChildrenHtml()
ProgressBar.progress                                dijit/ProgressBar              ProgressBar.value
ProgressBar._setIndeterminateAttr(true)             dijit/ProgressBar              ProgressBar.set("value", Infinity)
ProgressBar._setIndeterminateAttr(false)            dijit/ProgressBar              ProgressBar.set("value", 123)
TitlePane.setTitle(title)                           dijit/TitlePane                TitlePane.set("title", title)
Tooltip.addTarget()                                 dijit/Tooltip                  Tooltip.set("connectId", ...)
Tooltip.removeTarget()                              dijit/Tooltip                  Tooltip.set("connectId", ...)
Tree.store                                          dijit/Tree                     specify Tree.model instead
Tree.query                                          dijit/Tree                     pass query to Tree.model instead
Tree.label                                          dijit/Tree                     pass label to ForestStoreModel instead
Tree.childrenAttr                                   dijit/Tree                     pass to model
Tree.mayHaveChildren                                dijit/Tree                     specify on model
Tree.getItemChildren                                dijit/Tree                     specify on model
_KeyNavContainer.startupKeyNavChildren              dijit/_KeyNavContainer         remove call to method
Form.execute                                        dijit/form/Form                Form.submit
Form.getValues()                                    dijit/form/Form                Form.get("value")
Form.setValues(val)                                 dijit/form/Form                Form.set("value", val)
Form.isValid()                                      dijit/form/Form                Form.get("state")
dijit._setSelectionRange                            dijit/form/_TextBoxMixin       _TextBoxMixin._setSelectionRange
dojo.connect(myForm, "onValidStateChange", cb)      dijit/form/Form                myForm.watch("state", function(name, o, n){...})
dijit._Widget                                       replaced widgets               use dijit/_WidgetBase
dijit._Templated                                    replaced widgets               use dijit/_TemplatedMixin, dijit/_WidgetsInTemplate instead
dijit.form.Slider                                   replaced widgets               use dijit/form/HorizontalSlider, VerticalSlider, etc.
dijit.layout.LayoutContainer                        replaced widgets               use dijit/layout/BorderContainer
dijit.layout.SplitContainer                         replaced widgets               use dijit/layout/BorderContainer
dijit._Calendar                                     replaced widgets               use dijit/Calendar
dijit.layout.AccordionPane                          replaced widgets               use dijit/layout/ContentPane
layoutAlign="top"                                   widget parameters              region="top"
dojoAttachPoint                                     templates                      data-dojo-attach-point
dojoAttachEvent                                     templates                      data-dojo-attach-event
waiRole="button"                                    templates                      role="button"
waiState="selected-false,haspopup-true"             templates                      aria-selected="false" aria-haspopup="true"
attributeMap:{foo:a,bar:b}                          widget definitions             _fooSetter:a, _barSetter:b (NB: in 1.8, _setFooAttr and _setBarAttr)
_setFooAttr:...                                     widget definitions             _fooSetter:... (NB: in 1.8, it's still _setFooAttr)
this._focused                                       widget definitions             this.focused
this._supportingWidgets.push(...)                   widget definitions             this.own(...)
this.connect(node, "onclick", "myMethod")           widget definitions             this.own(on(node, "click", lang.hitch(this, "myMethod")))
this.connect(obj, func, "myMethod")                 widget definitions             this.own(aspect.after(obj, func, lang.hitch(this, "myMethod"), true))
this.subscribe(topicName, "myMethod")               widget definitions             this.own(topic(topicName, lang.hitch(this, "myMethod"))) but note that arguments to myMethod are passed as varargs not array
=================================================   ============================   ====================================

set(), get()
------------

Old widget methods to set and get parameter values, such as:

.. js ::

  myEditor.getValue()
  myTextBox.attr("value")
  myForm.setValue(...);

have been replaced by the standard ``set()`` and ``get()`` methods:

.. js ::

  myEditor.get("value")
  myTextBox.get("value")
  myForm.set("value", ...);


watch(), on()
-------------

Old widget methods to monitor widget events or changes in widget parameters have been consolidated to use ``on()`` and 
``watch()``:

Old code:

.. js ::

  dojo.connect(myForm, "onValidStateChange", function(){ ... });
  dojo.connect(myButton, "onClick", clickCallback);

New code:

.. js ::

  myForm.watch("valid", function(name, oldVal, newVal){
    console.log(myForm.id + ": " + name + " changed from " +
    oldVal + " to " + newVal);
  });
  myButton.on("click", clickCallback);

Templated Widgets
-----------------

The ``dijit/_Templated`` mixin has been split into ``dijit/_TemplatedMixin`` and ``dijit/_WidgetsInTemplateMixin``. In 
addition, ``dojoAttachPoint`` and ``dojoAttachEvent`` have been changed to the HTML5 valid ``data-dojo-attach-point`` 
and ``data-dojo-attach-event``.

For example, old code like:

.. js ::

  dojo.require("dojo.declare");
  dojo.require("dijit._Widget");
  dojo.require("dijit._Templated");

  dojo.declare("SimpleTemplate", [dijit._Widget, dijit._Templated], {
    templateString: "<button><span dojoAttachPoint="label"></span></button>"
  });

will change to:

.. js ::

  require(["dojo/declare", "dijit/_WidgetBase", "dijit/_TemplatedMixin"],
  function(declare, _WidgetBase, _TemplatedMixin){
    declare("SimpleTemplate", [_WidgetBase, _TemplatedMixin], {
      templateString: "<button><span data-dojo-attach-point="label"></span></button>"
    });
  });

If the above example had widgets in the templates, it would also mixin ``dijit/_WidgetsInTemplateMixin``.

To specify a template from a file, ``templatePath`` is no longer supported, and ``dojo.cache()`` shouldn't be used 
either.

Old code:

.. js ::

  templatePath: dojo.moduleUrl("templates", "myTemplate.html")

New code:

.. js ::

  define([..., "dojo/text!./templates/myTemplate.html",
  function(..., myTemplate){
    ...
    templateString: myTemplate

The other change to widgets is that the ``waiRole`` and ``waiState`` parameters are no longer supported, since it's
now easy to use role and state directly.

For instance. Replace:

.. html ::

  <span waiRole="treeitem" waiState="selected-false,haspopup-true"></span>

With:

.. html ::

  <span role="treeitem" aria-selected="false" aria-haspopup="true"></span>


custom setters
--------------
In 1.8 customer setters for attributes have names like _setXxxAttr().   In 2.0 the name will be changed to _xxxSetter().

attributeMap
------------

attributeMap in 1.x was a hash mapping widget attributes to DOM nodes.   For example:

.. js ::

  attributeMap: {
    "index": "focusNode",
    "style": "domNode"
  }

Currently, this is achieved by making separate ``_xxxSetter`` attribute for each attribute to map. Originally
``_xxxSetter`` was a function to set a widget attribute.   It can still be a function, but now it can also be an
object like one of the values from ``attributeMap``.    (NB: In 1.8, it's _setXxxAttr() not _xxxSetter().   This will
change for 2.0.)

The code above would be expressed as:

.. js ::

  _tabIndexSetter: "focusNode",
  _styleSetter: "domNode"

this.connect(), this.subscribe(), this._supportingWidgets
---------------------------------------------------------
The ways to make a widget listen to DOMNode events, do advice on a regular function, subscribe to topics, and
to register a supporting widget have changed.

The new interface is to use the standard dojo methods dojo/on, dojo/aspect, dojo/topic, etc., and call this.own() to
register the handle to be released when the widget is destroyed.   this.own() can be called multiple times, each with
one or more handles specified:

.. js ::

      this.own(
        // setup an event handler (automatically remove() when I'm destroyed)
        on(this.domNode, "click", function(){ ... }),

        // watch external object (automatically unwatch() when I'm destroyed)
        aStatefulObject.watch("x", function(name, oVal, nVal){ ... }),

        // create a supporting (internal) widget, to be destroyed when I'm destroyed
        new MySupportingWidget(...)
      );

Base Functionality
------------------

The methods previously loaded into ``dijit`` by default now must be explicitly loaded from various modules.

TODO: list stuff in ``dijit/registry``, ``dijit/a11y``.

dijit/focus, dijit/place, and dijit/popup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The focus, place, and popup modules in ``dijit/_base`` have been promoted to root of ``dijit``, so they need included 
explicitly by applications that don't want to include all of ``dijit/_base``.

There are a few API changes in the top level modules compared to the ones in ``dijit/_base`` (although for backwards 
compatibility the modules in ``dijit/_base`` maintain their old API):

* ``Popup.around()`` (analogous to ``dijit.popup.placeAroundElement()``) takes a position parameter like 
  ``["before", "after"]`` rather than a set of tuples like ``{BL: "TL", ...}``.   In other words, ``Popup.around()`` 
  replaces ``dijit.popup.placeAroundElement()`` but instead of ``dijit.getPopupAroundAlignment(xyz)``, just pass in 
  ``xzy`` directly.

* ``dijit/focus`` doesn't include the selection related code, just focus related code

* ``dijit/focus`` provides ``.watch()`` and ``.on()`` methods to monitor the focused node and active widgets, rather 
  than publishing topics ``focusNode``, ``widgetBlur``, and ``widgetFocus``.

* Some methods in ``dijit/_base/popup`` used to take DOMNodes or widgets as a parameter; now they just take a widget

Also note that the new dijit/popup module is only available through the new AMD API, e.g.:

.. js ::

  require(["dijit/popup"], function(popup){ popup.open(...); });

Some functions from ``dijit`` have been moved to ``dojo`` core.

* ``dojo/uacss`` will add classes to the ``<html>`` node like ``dj_ie``, representing the browser, browser version, 
  box model, etc.  Formerly ``dojo.require("dijit.sniff")``.

* ``getBox()`` from ``dojo/window`` gets the viewport size. Formerly ``dijit.getViewport()``.

* ``get()`` from ``dojo/window`` converts a document to the corresponding window. Formerly 
  ``dijit.getDocumentWindow()``

* ``scrollIntoView()`` from ``dojo/window`` scrolls a node into view, similar to ``node.scrollIntoView()`` but working 
  around browser quirks. Formerly ``dijit.scrollIntoView()``.

Editor
------

New way of registering plugins: TODO

SplitContainer, LayoutContainer
-------------------------------

Use BorderContainer instead.   (TODO: examples)

Miscellaneous changes
---------------------

_Widget --> _WidgetBase  (TODO: will probably rename again, to Widget)

DojoX
=====

The ``dojox`` namespace will be removed in Dojo 2.0.  Some of the mature sub-packages will like migrate into Dojo Core 
or into Dijit.  The remaining code will be "spun off" into separate packages that will be available via package
management tools and a repository of packages.

In order to ensure your code can be easily migrated, refactoring it to fully leverage AMD and not relay upon the
``dojox`` global variable is critically important.
