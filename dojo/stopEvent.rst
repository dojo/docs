#format dojo_rst

dojo.stopEvent
==============


---- /!\ '''Edit conflict - other version:''' ----
Prevents propagation and clobbers the default action of the passed event. The same as calling ``event.preventDefault()`` and ``event.stopPropagation()`` on some passed event.

.. code-block :: html
    <script type="text/javascript">
    dojo.addOnLoad(function(){
        var node = dojo.byId("delete");
        dojo.connect(node, "onclick", function(e){
            dojo.stopEvent(e); //prevents default link execution
            //some code custom execution
        });
    });
    </script>
    <a href="/delete" id="delete">Delete</a>

---- /!\ '''Edit conflict - your version:''' ----
Prevents propagation and clobbers the default action of the passed event. The same as calling ``event.preventDefault()`` and ``event.stopPropagation()`` on some passed event.

.. code-block :: html
   <script type="text/javascript">
   dojo.addOnLoad(function(){
       var node = dojo.byId("delete");
       dojo.connect(node, "onclick", function(e){
           dojo.stopEvent(e); //prevents default link execution
           //some code custom execution
       });
   });
   </script>
   <a href="/delete" id="delete">Delete</a>

---- /!\ '''End of edit conflict''' ----

See Also:
=========

* `The event QuickStart <quickstart/events>`_
