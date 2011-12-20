.. _quickstart/gettingstarted:

======================================
Getting started with some simple steps
======================================

:Authors: Alex Russell

.. contents ::
   :depth: 2

Getting up-and-running with Dojo couldn't be easier. Just include this line in your web page:

.. html ::

    <script src="http://ajax.googleapis.com/ajax/libs/dojo/1.7/dojo/dojo.js"></script>


Dojo's now included on your page, no install, no fuss. So what do you get for all that hard work?


As the example below shows, animations, event handling, and a wealth of other utilities are instantly available:

Example
=======

.. code-example ::

  .. js ::

        dojo.ready(function(){
            dojo.query("#showMe").onclick(function(e){
                var node = e.target;

                var a = dojo.anim(node, {
                    backgroundColor: "#363636",
                    color: "#f7f7f7"
                }, 1000);

                dojo.connect(a, "onEnd", function(){
                    dojo.anim(node, { color: "#363636" }, null, null, function(){
                        node.innerHTML = "wow, that was easy!";
                        dojo.anim(node, { color: "white" });
                    });
                });
            });
        });

  .. html ::

    <div id="showMe" style="padding: 10px;">
        click here to see how it works
    </div>

See also
========

* :ref:`Using Dojo from a CDN <quickstart/cross-domain>`
* :ref:`Installation instructions & Tutorials <quickstart/index>`
* `Dojo Base API CheatSheet <http://download.dojotoolkit.org/current-stable/cheat.html>`_ - covers all the API's provided from including ``dojo.js`` on a page.
