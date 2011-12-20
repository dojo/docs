.. _dojox/widget/Pager:

==================
dojox.widget.Pager
==================

:Project owner: Peter Higgins
:since: V1.1.1

.. contents ::
   :depth: 2

A Pager, displaying a list of sized nodes.


Introduction
============

TODO: introduce the component/class/method


Usage
=====

.. js ::

   // your code

This Widget uses dojo.data, Dojo's uniform and consistent data access layer.


Examples
========

Programmatic example
--------------------

TODO: example

Declarative example: Horizontal Pager
-------------------------------------

.. code-example ::

  .. css ::

        @import "{{baseUrl}}dojox/widget/Pager/Pager.css";


  .. js ::

        dojo.require("dojo.data.ItemFileReadStore");
        dojo.require("dojox.widget.Pager");

  .. html ::

    <!-- the datastore -->
    <div data-dojo-type="dojo.data.ItemFileReadStore" data-dojo-id="pagerStore" id="pagerStore"
        data-dojo-props="url:'{{dataUrl}}dojox/widget/tests/_pager-data.json'"></div>

    <h2>Horizontal Pager</h2>

    <div style="padding:8px">
        <div data-dojo-type="dojox.widget.Pager" id="dojoxMenu1"
            data-dojo-props="store:pagerStore" style="width: 410px; height: 150px"></div>
    </div>


See also
========

* :ref:`Using Datastores <quickstart/data/usingdatastores>`
* `Planned cleanups and enhancements for dojox.widget.Pager <http://trac.dojotoolkit.org/ticket/8012>`_
