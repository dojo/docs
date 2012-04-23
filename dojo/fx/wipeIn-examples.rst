.. _dojo/fx/wipeIn-examples:

=======================
dojo.fx.wipeIn examples
=======================


.. contents ::
    :depth: 3

Wiping in a node with "display: none; position: absolute;"
----------------------------------------------------------

When you are trying to wipe in a node to a fixed height or width you have to use :ref:`dojox.fx.wipeTo <dojox/fx/wipeTo>`.
 
Note that the padding of the content which gets wiped in is set on a separate inner node. This ensures that you don't get weird x-browser behaviour.

.. code-example ::

  .. js ::

    // Dojo 1.7 (AMD)
    require(["dijit/form/Button", "dojo/fx", "dojo/parser"], function(button, fx){
      wipeInOne = function(){ 
        fx.wipeIn({ 
          node: "wipeDisplayNode", 
          duration: 300 
        }).play(); 
      } 
      wipeOutOne = function(){ 
        fx.wipeOut({ 
          node: "wipeDisplayNode", 
          duration: 300 
        }).play(); 
      }
    });

  .. html ::

    <div style="height: 110px;"> 
      <button data-dojo-type="dijit.form.Button" data-dojo-props="onClick:wipeInOne">Wipe in</button> 
      <button data-dojo-type="dijit.form.Button" data-dojo-props="onClick:wipeOutOne">Wipe out</button> 
      <div id="wipeDisplayNode" style="position: absolute; top: 50px; background: #ccc; display: none;"> 
        <div style=" padding: 10px;">Hi friends<br />We like dojofx. don't we?</div> 
      </div> 
    </div> 
