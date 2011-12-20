.. _dojo/NodeList-fx:

================
dojo.NodeList-fx
================

.. contents ::
   :depth: 2

This module incorporates :ref:`dojo.fx <dojo/fx>` functionality into :ref:`dojo.query <dojo/query>` by extending the :ref:`dojo.NodeList <dojo/NodeList>` Class.

API
===

:anim:
  Animate one or more CSS properties for all nodes in this list. The returned animation object will already be playing when it is returned. See the docs for :ref:`dojo.anim <dojo/anim>` for full details.
:fadeIn:
  Fade in all elements of this NodeList via :ref:`dojo.fadeIn <dojo/fadeIn>`
:fadeOut:
  Fade out all elements of this NodeList via :ref:`dojo.fadeOut <dojo/fadeOut>`
:slideTo:
  Slide all elements of the node list to the specified place via :ref:`dojo.fx.slideTo <dojo/fx/slideTo>`
:wipeIn:
  Wipe in all elements of this NodeList via :ref:`dojo.fx.wipeIn <dojo/fx/wipeIn>`
:wipeOut:
  Wipe out all elements of this NodeList via :ref:`dojo.fx.wipeOut <dojo/fx/wipeOut>`
:animateProperty:
  Animate all elements of this NodeList across the properties specified. Syntax is identical to :ref:`dojo.animateProperty <dojo/animateProperty>`

Example
-------

The first most important thing to do is require the module into your page:

.. js ::

  // [ Dojo 1.6 and earlier ]
  dojo.require("dojo.NodeList-fx");
  // [ Dojo 1.7 AMD ]
  require(["dojo/NodeList-fx"], function(nodeListFx){
    // your codes here
  });

To use your newly created functions in NodeList, issue a ``dojo.query()`` call:

.. code-example ::

  .. html ::

     <button id="fadebutton">Fade Them Out</button>
     <div id="fadebuttontarget">
        <li class="thinger">Item One</li>
        <li class="thinger">Item Two</li>
     </div>

  .. js ::

        dojo.require("dojo.NodeList-fx");
        dojo.ready(function(){
            dojo.query("#fadebutton").onclick(function(){
                dojo.query("#fadebuttontarget li").fadeOut().play();
            });
        });

The most important thing to note is `NodeList <dojo/NodeList>` animations return an instance of a :ref:`dojo.Animation <dojo/Animation>`, the foundation for all Dojo FX. This prevents further chaining, as you have to explicitly call ``.play()`` on the returned animation. **New** Dojo 1.4 introduced a way to allow continued chaining with the caveat you cannot obtain a reference to the animations after they have begun. Simply pass the *auto* parameter.

// [ Dojo 1.6 and earlier ]

.. js ::
  
  dojo.require("dojo.NodeList-fx");
  dojo.ready(function(){
       dojo.query("li.evens")
           .fadeOut({
              duration:1000,
              onEnd: function(){ ... },
              // begin playing immediately, and return the nodeList for further iteration
              auto:true
           })
           .onclick(doSomething)
       ;
  });

[ Dojo 1.7 AMD ]

.. js ::
  
  require(["dojo/ready",
    "dojo/query",
    "dojo/NodeList-fx"], function(ready, query, nodeListFx){
      ready(function(){
        query("li.evens")
          .fadeOut({
            duration:1000,
            onEnd: function(){ ... },
            // begin playing immediately, and return the nodeList for further iteration
            auto:true
          })
          .onclick(doSomething);
      };
  });

The parameters you can specify to each animation provided are identical to their :ref:`dojo.fx <dojo/fx>` counterparts, omitting the ``node:`` parameter, as each node in the NodeList is passed for you.

There are more NodeList animations provided by the :ref:`dojox.fx.ext-dojo.NodeList <dojox/fx/ext-dojo/NodeList>` module, in the :ref:`dojox.fx <dojox/fx>` project.

.. _dojo.fx: dojo/fx
.. _dojox.fx: dojox/fx
