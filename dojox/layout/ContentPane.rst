.. _dojox/layout/ContentPane:

========================
dojox.layout.ContentPane
========================

:Project owner: ?--
:since: V?

.. contents ::
   :depth: 2

dojox.layout.ContentPane is an extension to dijit.layout.ContentPane providing script execution, among other things.

Introduction
============

dojox/layout/ContentPane is an extension of dijit/layout/ContentPane, so anything that you can do with dijit's content
pane you can also with dojox's.  Even though this is in dojox, this layout widget is well tested and should be
considered production ready.  There are a couple additional parameters added in the dojox content pane, namely: adjustPaths,
cleanContent, renderStyles, scriptHasHooks.  Your content (either via setContent or setHref) can even include additional
dojo widgets, you only need to load dojo.js in the calling/parent page.  You can call require() inside your pane's
content as well.  If parseOnLoad (from dijit/layout/ContentPane) is true, then the dojo parser will create the widgets
in your pane's content.  Many other layout widgets are children of dijit/layout/ContentPane.  So if you want to have a
Dialog widget that has the ability to execute scripts, you need to roll your own (say my/Dialog) that is a child of
dojox/layout/ContentPane instead of dijit/layout/ContentPane.  This is a fairly simple change usually requiring only a
couple search/replaces.


Usage
=====

TODO: how to use the component/class/method

.. js ::

   // your code



Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example

Executing JavaScript inside ContentPane
---------------------------------------

dijit/layout/ContentPane widgets are an invaluable tool for many common layout tasks.  You can update the content inside
one of these panes via the setContent or setHref methods, unfortunately if your content contains any JavaScript via inline
script tag or script tag with src attribute you might be surprised to find out that it will not execute.  How do you get
around this?

Back in the 0.4 days of dojo, the ContentPane widget (then called dojo.widget.ContentPane) had an executeScripts parameter
and also a somewhat confusing scriptSeparation parameter to deal with scoping.  Setting executeScripts="true" on your
content pane caused any JavaScript inside the pane content to execute when content was initially loaded.

When dojo 1.0 was released (well, technically 0.9) the ContentPane layout widget removed the executeScripts parameter to
make a leaner widget, removing a complicated feature that most content panes do not use.  The demand for this feature
created the need for a new content pane, which was placed in dojox as dojox/layout/ContentPane.  This new widget supports
the executeScripts parameter, and thankfully removed the need for the 0.4 scriptSeparation parameter.

If you need to execute JavaScript inside your content panes, use dojox/layout/ContentPane instead of
dijit/layout/ContentPane and set executeScripts="true".  Actually executeScripts defaults to "true" but might be a
visual cue down the road as to why you are using dojox/layout/ContentPane.


.. js ::

  require(["dojo/ready", "dojox/layout/ContentPane"], function(ready, ContentPane){
        ready(function(){
            var myContentPane = new ContentPane({
                style:"height:125px"
            }, "targetID");
            
            myContentPane.setHref("contentWithJavaScript.html");
        });
    });


See also
========

* through the use of the scriptHasHooks setting, a :ref:`Deferred instance <dojo/Deferred>`, onLoadDeferred and it's then() method, you can simulate the dojo.ready behavior from inside the loaded content.
* An alternative is to set scriptHasHooks=true, and have content like this in your loaded content:

.. js ::
 
   dojo.connect(_container_, "onLoad", function(){
      /* your script */
   });

This will connect your local function to the onLoad callback of the enclosing ContentPane.
