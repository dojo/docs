#format dojo_rst

dojo.NodeList-fx
================

:Status: Draft
:Version: 1.2


.. contents::
   :depth: 2

This module incorporates `dojo.fx <dojo/fx>`_ functionality into `dojo.query <dojo/query>`_ by extending the `dojo.NodeList <dojo/NodeList>`_ Class. 

The first most important thing to do is require the module into your page:

.. code-block :: javascript

  dojo.require("dojo.NodeList-fx");

To use your newly created functions in NodeList, issue a ``dojo.query()`` call:

.. cv-compound::

  .. cv:: html

     <button id="fadebutton">Fade Them Out</button> 
     <div id="fadebuttontarget">
        <li class="thinger">Item One</li>
        <li class="thinger">Item Two</li>
     </div>

  .. cv:: javascript

     <script type="text/javascript">
        dojo.require("dojo.NodeList-fx");
        dojo.addOnLoad(function(){
            dojo.query("#fadebutton").onclick(function(){
                dojo.query("#fadebuttontarget li").fadeOut().play();
            });
        });
     </script>

The most important thing to note is NodeList animations return an instance of a `dojo._Animation <dojo/_Animation>`_, the foundation for all Dojo FX. This prevents further chaining, as you have to explicitly call ``.play()`` on the returned animation.

The parameters you can specify to each animation provided are identical to their `dojo.fx <dojo/fx>`_ counterparts, omitting the ``node:`` parameter, as each node in the NodeList is passed for you.

There are more NodeList animations provided by the `dojox.fx.ext-dojo.NodeList <dojox/fx/NodeList>`_ module, in the `dojox.fx <dojox/fx>`_ project.

.. _dojo.fx: dojo/fx
.. _dojox.fx: dojox/fx
