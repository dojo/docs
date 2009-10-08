#format dojo_rst

dojox.widget.Pager
==================

:Status: Draft
:Version: 1.0
:Project owner: Nikolai Onken
:Available: since V?

.. contents::
   :depth: 2

TODO: short summary of the component/class/method


============
Introduction
============

TODO: introduce the component/class/method


=====
Usage
=====

TODO: how to use the component/class/method

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // your code
 </script>



========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example: Horizontal Pager
-------------------------------------

.. cv-compound::

  .. cv:: css

    <style type="text/css">
        @import "http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dojox/widget/Pager/Pager.css";
    </style>


  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojo.data.ItemFileReadStore");
        dojo.require("dojox.widget.Pager");
    </script>

  .. cv:: html

    <!-- the datastore -->
    <div dojoType="dojo.data.ItemFileReadStore" jsId="pagerStore" id="pagerStore" 
        url="http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dojox/widget/tests/_pager-data.json"></div>

    <h2>Horizontal Pager</h2>

    <div style="padding:8px">
        <div dojoType="dojox.widget.Pager" id="dojoxMenu1" 
            store="pagerStore" style="width: 410px; height: 150px"></div>
    </div>


========
See also
========

* TODO: links to other related articles
