## page was renamed from 1.2/dojo/event
#format dojo_rst

dojo/_base/event
================

:Status: Draft
:Version: 1.2
:Available: since V0.3

.. contents::
  :depth: 2

**dojo._base.event** contains functions to handle DOM events.

As with all dojo._base components, these functions are included within Dojo Base. You get this functionality by just including dojo.js or dojo.xd.js in your page.

See `Dojo's Event System <quickstart/events>`__ for information on the event system.

dojo.stopEvent
==============


Prevents propagation and clobbers the default action of the passed event. The same as calling ``event.preventDefault()`` and ``event.stopPropagation()`` on some passed event.

Dojo 1.7 (AMD)
--------------

.. code-block :: html

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

dojo.fixEvent
==============


TO DOC


Migration issues
================

Since V0.9 most of the functionality from the dojo.event package has moved to dojo base so it is always available. Users of older releases will find more details within the `Dojo Porting Guide: 0.4x to 0.9.x <http://dojotoolkit.org/book/dojo-porting-guide-0-4-x-0-9/event-system>`__.


See also
========

* `Dojo's Event System <quickstart/events>`__
* `dojo.behavior with Events <dojo/behavior#behaviors-with-events>`__
