## page was renamed from 1.2/dojo/html
#format dojo_rst

dojo.html
=========

:Status: Draft
:Version: 1.0
:Authors: Sam Foster, Nikolai Onken, Marcus Reimann
:Developers: Sam Foster, Alex Russell, Dylan Schiemann
:Available: since V1.2

.. contents::
    :depth: 2
 
As of version 1.2, **dojo.html** is home to a single public helper method: **dojo.html.set()**. It is used to safely and conveniently replace an element's content, while providing some hooks and options for how the replacement should be handled.

As of version 1.3, `dojo.place() <dojo/place>`__ accepts HTML strings for inserting HTML, and may be a better choice for simple HTML insertion. Unless you need to use the params capabilities of **dojo.html.set**, you should use dojo.place(cont, node, "only"). dojo.place() has more robust support for injecting an HTML string into the DOM, but it only handles inserting an HTML string as DOM elements, or inserting a DOM node. dojo.place does not handle NodeList insertions or the other capabilities as defined by the params argument for dojo.html.set().

=====
Usage
=====

You can think of dojo.html.set() like the good old `ContentPane <dijit/layout/ContentPane>`__, but outside of a "Pane".


========
Examples
========

.. codeviewer::

    <script type="text/javascript">
    dojo.require("dojo.html");
    dojo.addOnLoad(function() {
      // the first argument is a node reference
      console.log("loaded");
      dojo.html.set(dojo.byId("mycontent"), "loaded!");
    })
    </script>

    <div id="mycontent">
      Loading...
    </div>

Of course, if that was all you needed to do, you'd be better of just setting innerHTML directly. The value of dojo.html.set comes when things get a little less trivial: 


.. codeviewer::

    <button id="setbtn">Click to set content</button>
    <table id="mytable">
      <tr><td>Nothing here yet</td></tr>
    </table>


    <script type="text/javascript">
    dojo.require("dojo.html");

    var sethandle = dojo.connect(dojo.byId("setbtn"), "onclick", function() {

      dojo.html.set(dojo.byId("mytable"), '<tr>'
        +'<td><label>How much?</label></td>'
        +'<td><input type="text" dojoType="dijit.form.NumberTextBox" value="0"'
        +  ' constraints="{min:0,max:20,places:0}"'
        +  ' promptMessage= "Enter a value between 0 and +20"'
        +  ' required= "true" invalidMessage= "Wrong!" />'
        +'</td>'
        +'</tr>', {
          parseContent: true, 
          onBegin: function() {
            dojo.require('dijit.form.NumberTextBox');
            this.inherited("onBegin", arguments);
          }
      });
      dojo.disconnect(sethandle); 
      sethandle = null;
      dojo.byId("setbtn").innerHTML = "Done"; 
    })
    </script>

We're getting a lot done here. First, note that we're setting content on a table. Some browsers get very unhappy when you try and set ``innerHTML`` on tables (and other elements) - ``dojo.html.set`` handles all that for you. Also, note that the content includes a widget, and we've added a 3rd parameter to our ``set()`` call - an object with some configuration for this set operation. ``parseContent: true`` tells ``set`` that when the content has been slopped in there, it should run the parser over the element. 

This is a common pattern, and yeilds a common problem - what if we haven't got the classes necessary already required? We provide an ``onBegin`` function to the set operation to first require the necessary widget. We call ``this.inherited`` just in case ``onBegin`` has other work it needs to do. But what is "``this``"? ``dojo.html.set`` makes use of a ``dojo.html._ContentSetter`` class to encapsulate the work it needs to do, so ``this`` is an instance of that class. For advanced usage like this, see the api docs and look over source code to fully understand how you can leverage the _ContentSetter class. 

My use of ``dojo.connect`` to trigger the new content is purely an example, you could obviously make this call from an event handler, xhr callback, etc. There are many many possibilities - here's just a couple ideas: applying ``dojo.behavior`` to the new content, fading/animating the new content, cloning the new content into another node, escaping or performing substitutions on the content before it lands. I'll also mention here that this functionality is also made availiable for ``NodeLists`` (``dojo.query`` result objects) via the ``dojo.NodeList-html`` module

What else comes out of the box? set takes the following optional params to configure its behavior: 

:cleanContent: 
    Should the content be cleaned of doctype, title and other bothersome markup before injection? 

:extractContent: 
    Should the content extracted from the ``<body>`` wrapper before injection?

:parseContent: 
    Should the node by passed to the parser after the new content is set

:onBegin: 
    Called right before the content is swapped out, use it for pre-processing your content, preparing the target node, or whatever. **Note**: ``onBegin`` does have a default implementation, so unless you wish to replace that, you should include ``this.inherited("onBegin", arguments)`` in the function you provide here. You can refer to your target node as ``this.node``, and your content is available as ``this.content`` - be sure to put them back when you are done.

:onEnd: 
    Called right after the content is swapped out, use it for post-processing your content, or whatever. **Note**: ``onEnd`` also has a default implementation. If you use ``parseContent`` you can grab the array of widget objects that yeilds from ``this.parseResults``		

:onContentError: 
    This event is called if an error is caught while inserting the new content. A typical example might be if you attempt to inject a ``div`` into a ``tr`` or similar. 


==========
Background
==========

If all of this seems a little familiar to you, its because this functionality previously lived inside the `ContentPane <dijit/layout/ContentPane>`_ widget (since dojo's early days). The goal of ``dojo.html.set``, the ``_ContentSetter`` and the helper methods it employs were to make this functionality available outside of the dijit context, and promote code reuse both across the toolkit and in your code. Some of the other options you may have used in 0.4, or `dojox.layout.ContentPane <dojox/layout/ContentPane>`_ are destined to live in a dojox counterpart to this module, and should be available by 1.2's release.   


========
See also
========

* `dojo._base.html <dojo/_base/html>`__

  Basic DOM handling functions, included in Dojo Base
