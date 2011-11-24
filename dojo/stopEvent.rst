.. _dojo/stopEvent:

dojo.stopEvent
==============


Prevents propagation and clobbers the default action of the passed event. The same as calling ``event.preventDefault()`` and ``event.stopPropagation()`` on some passed event.

Dojo 1.7 (AMD)
--------------

.. html ::

    <script type="text/javascript">
    require(["dojo/ready", "dojo/dom", "dojo/_base/connect", "dojo/_base/event"], function(ready, dom, connect, event) {
        ready(function() {
            var node = dom.byId("delete");
            connect.connect(node, "onclick", function(e){
                event.stop(e); //prevents default link execution
                //some code custom execution
            });
        });
    });
    </script>
    <a href="/delete" id="delete">Delete</a>


Dojo < 1.7
----------

.. html ::

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


dojo.fixEvent
==============


TO DOC

See Also:
=========

* :ref:`The event QuickStart <quickstart/events>`
