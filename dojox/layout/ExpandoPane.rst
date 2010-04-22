#format dojo_rst

dojox.layout.ExpandoPane
========================

:Status: Draft
:Version: 1.0
:Authors: ?--
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

dojox.layout.ExpandoPane is a self-collapsing widget for use in a `BorderContainer <dijit/layout/BorderContainer>`_.


============
Introduction
============

This is an experimental widget which provides Expando-like capabilities to a region in a Dijit `BorderContainer <dijit/layout/BorderContainer>`_. The use is able to single-click an icon to open or close the region. 

=====
Usage
=====

The ExpandoPane is used in a similar way to the way a dijit `ContentPane <dijit/layout/ContentPane>`_ is used, but it provides a user interface to "collapse" and "expand" the Pane.

You should ensure that you include the ExpandoPane CSS in your application in order to have the pane render properly:

.. code-block :: javascript
 :linenos:

 <style type="text/css">
   @import url("dojox/form/resources/ExpandoPane.css");
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
      dojo.require("dijit.layout.BorderContainer");
      dojo.require("dijit.layout.ContentPane");
      dojo.require("dojox.layout.ExpandoPane");
    </script>

  .. cv:: html

    <div id="bc" style="width:100%; height:100%; padding: 5px;" 
      dojoType="dijit.layout.BorderContainer">
        <div dojoType="dojox.layout.ExpandoPane" splitter="true" 
          duration="125" region="left" title="Left Section" id="leftPane"
          maxWidth="125" style="width: 125px;">I am the ExpandoPane content!
        </div>
        <div dojoType="dijit.layout.ContentPane" region="center" splitter="true">
          This is a normal ContentPane.
        </div>
    </div>

  .. cv:: css

    <style type="text/css">
      @import url("/moin_static163/js/dojo/trunk/dojox/layout/resources/ExpandoPane.css");
    </style>



========
See also
========

* TODO: links to other related articles
