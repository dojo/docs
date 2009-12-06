#format dojo_rst

dojox.html.set
===============

:Authors: Sam Foster, Bill Keese, Frederic, Marcus Reimann
:Project owner: ?
:Available: since V1.2

.. contents::
   :depth: 2

Extensions to content setting utilities in dojo.html

============
Introduction
============

dojox.html.set and its helper dojox.html._ContentSetter extend the content-setting available in their `dojo.html <dojo/html>`_ counterparts, by adding support for executing scripts, adding style. The _ContentSetter provides this functionality to the `dojox.layout.ContentPane <dojox/layout/ContentPane>`_ widget.

Be careful: Loading content with script and style blocks is often a questionable practice. A more secure and recommended solution is, to load just pure data with the help of the available Dojo datastores. But beside this general principle, there are also valid use cases, and times when loading content with scripts is the only option available. In such cases, dojox.html.set() can help you.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

  dojo.require("dojox.html._base");
  dojox.html.set(node, content, {
      executeScripts: true, 
      scriptHasHooks: false,
      renderStyles: true
  });

===========  =======================  ======================================================================
Parameter    Type                     Description
===========  =======================  ======================================================================
node         DomNode  	              The parent element that will receive the content.
content      String|DomNode|NodeList  The content to be set on the parent element. This can be an html string, a node reference or a NodeList, dojo.NodeList, Array or other enumerable list of nodes.
params       Object                   Optional. Optional flags/properties to configure the content-setting. See dojo.html._ContentSetter
===========  =======================  ======================================================================


========
Examples
========

Set content with styles
-----------------------

.. code-example::

  .. javascript::

    <script type="text/javascript">
        dojo.require("dojox.html._base");
        dojo.addOnLoad(function(){
            var content = "<div style='background-color: #dffadb; padding: 10px;'>"
                +"The content."
                + "</div>"
                +"<div style='background-color: #faefdb; padding: 10px;'>"
                + "It can be an html string, a node reference or a NodeList, "
                + "dojo.NodeList, Array or other enumerable list of nodes."
                + "</div>";
            dojox.html.set(dojo.byId("myNode1"), content, {
                executeScripts: false, 
                scriptHasHooks: false,
                renderStyles: true
            });
        });
    </script>

  .. html::

    <div id="myNode1">I'm an empty node</div>


========
See also
========

* `Quickstart Tutorial: Using Dojo Data <quickstart/data/usingdatastores>`_

  As a more secure alternative for loading pure data
