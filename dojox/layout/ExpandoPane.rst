.. _dojox/layout/ExpandoPane:

dojox.layout.ExpandoPane
========================

:Status: Draft
:Version: 1.0
:Authors: ?--
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

dojox.layout.ExpandoPane is a self-collapsing widget for use in a :ref:`BorderContainer <dijit/layout/BorderContainer>`.


============
Introduction
============

This is an experimental widget which provides Expando-like capabilities to a region in a Dijit :ref:`BorderContainer <dijit/layout/BorderContainer>`. The use is able to single-click an icon to open or close the region. 

=====
Usage
=====

The ExpandoPane is used in a similar way to the way a dijit :ref:`ContentPane <dijit/layout/ContentPane>` is used, but it provides a user interface to "collapse" and "expand" the Pane.

You should ensure that you include the ExpandoPane CSS in your application in order to have the pane render properly:

.. code-block :: css
 :linenos:

 <style type="text/css">
   @import url("dojox/layout/resources/ExpandoPane.css");
 </style>


========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.layout.ContentPane");
      dojo.require("dijit.layout.BorderContainer");
      dojo.require("dojox.layout.ExpandoPane");
    </script>

  .. cv:: html

    <div data-dojo-type="dijit.layout.BorderContainer" data-dojo-props="design:'sidebar', gutters:true, liveSplitters:true" id="borderContainer">
      <div data-dojo-type="dojox.layout.ExpandoPane" title="Left Expando" data-dojo-props="title: 'Left Expando', maxWidth:225, splitter:true, region:'leading'" style="width: 225px;">
        Hi. I'm the Expando Pane
      </div>
      <div data-dojo-type="dijit.layout.ContentPane" data-dojo-props="splitter:true, region:'center'">Hi, I'm center</div>
    </div>

  .. cv:: css

    <style type="text/css">
      @import url("{{ baseUrl }}dojox/layout/resources/ExpandoPane.css");

      html, body {
        width: 100%;
        height: 100%;
        margin: 0;
      }

      #borderContainer {
        width: 100%;
        height: 100%;
      }
    </style>



========
See also
========

* TODO: links to other related articles
