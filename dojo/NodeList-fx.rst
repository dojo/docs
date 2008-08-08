#format dojo_rst

dojo.NodeList-fx
================

:Status: Draft
:Version: 1.2

This module incorporates `dojo.fx </dojo/fx>`_ functionality into `dojo.query </dojo/query>`_ by extending the `dojo.NodeList </dojo/NodeList>`_ Class. 

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

The most important thing to note is NodeList animations return an instance of a ``dojo._Animation``, the foundation for all Dojo FX. This prevents further chaining, as you have to explicitly call ``.play()`` on the returned animation. If you wish you continue chaining after an query animation, you can use the `.anim </dojo/anim>`_ method.

.. cv-compound::

  .. cv:: html

     <button id="animbutton">Chain animation</button> 
     <div id="animtarget">
        <li class="thinger">Item One</li>
        <li class="thinger">Item Two</li>
     </div>

  .. cv:: javascript

     <script type="text/javascript">
        dojo.require("dojo.NodeList-fx");
        dojo.addOnLoad(function(){
            dojo.query("#animbutton").onclick(function(){
                dojo.query("#animbuttontarget li").anim({ opacity:0 }).anim({ marginLeft:75 });
            });
        });
     </script>

This works with a known caveat: A ``dojo.anim`` Animation (and all Dojo Animations for that matter) are asynchronous. Calling 
