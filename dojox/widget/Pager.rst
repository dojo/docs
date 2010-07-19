#format dojo_rst

dojox.widget.Pager
==================

:Project owner: Peter Higgins
:Available: since V1.1.1

.. contents::
   :depth: 2

A Pager, displaying a list of sized nodes.


============
Introduction
============

TODO: introduce the component/class/method


=====
Usage
=====

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // your code
 </script>

This Widget uses dojo.data, Dojo's uniform and consistent data access layer.


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
        @import "{{baseUrl}}dojox/widget/Pager/Pager.css";
    </style>


  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojo.data.ItemFileReadStore");
        dojo.require("dojox.widget.Pager");
    </script>

  .. cv:: html

    <!-- the datastore -->
    <div dojoType="dojo.data.ItemFileReadStore" jsId="pagerStore" id="pagerStore" 
        url="{{dataUrl}}dojox/widget/tests/_pager-data.json"></div>

    <h2>Horizontal Pager</h2>

    <div style="padding:8px">
        <div dojoType="dojox.widget.Pager" id="dojoxMenu1" 
            store="pagerStore" style="width: 410px; height: 150px"></div>
    </div>


========
See also
========

* `Using Datastores <quickstart/data/usingdatastores>`_
* `Planned cleanups and enhancements for dojox.widget.Pager <http://trac.dojotoolkit.org/ticket/8012>`_
