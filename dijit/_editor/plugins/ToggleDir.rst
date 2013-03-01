.. _dijit/_editor/plugins/ToggleDir:

===============================
dijit/_editor/plugins/ToggleDir
===============================

:Authors: Jared Jurkiewicz
:Developers: Bill Keese, Jared Jurkiewicz
:since: V1.0

.. contents ::
    :depth: 2

Not all documents in the world are read from Left-To-Right.
There are several languages, in fact, that are read from Right-To-Left, such as Arabic, Hebrew, and so forth.
So, there are times it would be great to see what your document would look like in Right-To-Left view.
With this plugin, you can do that.

Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* Button with icon in toolbar for toggling right-to-left(RTL)/left-to-right(LTR) mode.
* Update is done on the body element of the containing iframe, so as such does not alter the page containing the editor, only the editor contents.
* Auto-detects if the whole page is in RTL mode when editor is initialized and toggles the mode appropriately on Editor.

Limitations
===========

* The button being toggled 'on' always means RTL mode.  You cannot define button 'on' as meaning LTR.

Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.
The first thing you need to do is require into the page you're using the editor.
This is done in the same spot as your require() call is made, usually the head script tag.
For example:

.. js ::
 
    require(["dojo/parser", "dijit/Editor", "dijit/_editor/plugins/ToggleDir"]);


Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.
For example:

.. html ::

  <div data-dojo-type="dijit/Editor" id="editor" data-dojo-props="extraPlugins:['toggleDir']"></div>



And that's it.
The editor instance you can reference by 'dijit.byId("editor")' is now enabled with all the toolbar actions provided by the ToggleDir plugin.


Examples
========

Basic Usage
-----------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. js ::

      require(["dojo/parser", "dijit/Editor", "dijit/_editor/plugins/ToggleDir"]);

    
  .. html ::

    <b>Toggle the RTL button and see the content swap back and forth</b>
    <br>
    <div data-dojo-type="dijit/Editor" height="250px" id="input" data-dojo-props="extraPlugins:['toggleDir']">
        <br />
        <br />
        <a href="http://www.dojotoolkit.org">The best Ajax Toolkit there is, Dojo!</a>
        <br />
        <h3>Some text:</h3>
        <p>
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent interdum placerat velit et pretium. Curabitur semper est sit amet elit condimentum placerat. Donec urna mi, egestas ut tristique ut, porttitor non mauris. Vestibulum egestas sodales libero. Nulla vitae metus eros, ac cursus quam. Phasellus sit amet arcu ac ipsum commodo posuere. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec pulvinar diam sed massa facilisis gravida. Nulla facilisi. Sed dapibus nunc in justo volutpat nec posuere odio volutpat. Nulla ante enim, semper et fringilla ut, dapibus in mi. Mauris vulputate arcu eget neque tincidunt vestibulum. Maecenas laoreet, quam non rhoncus cursus, nisi magna dictum velit, non aliquam tortor ipsum ut metus. Nam eu est quis quam accumsan eleifend. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;
        </p>
        <br />
        <img src="http://jaredj.dojotoolkit.org/images/dojo.logo.png" alt="The Dojo Toolkit" />
        <br />
    </div>


See Also
========

* :ref:`dijit/Editor <dijit/Editor>`
* :ref:`dijit/_editor/plugins <dijit/_editor/plugins>`
* :ref:`dojox/editor/plugins <dojox/editor/plugins>`
