#format rst


The Official Dojo Documentation
===============================

.. contents::
    :depth: 2

.. image:: http://media.dojocampus.org/images/docs/logodojocdocssmall.png
   :alt: Dojo Documentation
   :class: logowelcome;


===============================
`Getting started <quickstart>`_
===============================

Getting up-and-running with Dojo couldn't be easier. Just include this line in your web page:

.. code-block :: html

    <script type="text/javascript"
        src="http://ajax.googleapis.com/ajax/libs/dojo/1.2/dojo/dojo.xd.js">
    </script>   


Dojo's now included on your page, no install, no fuss. So what do you get for all that had work? 

.. cv-compound::

  .. cv:: javascript

    <script>
        dojo.addOnLoad(function(){
            dojo.query("#showMe").onclick(function(e){
                dojo.anim(e.target, {
                    backgroundColor: "yellow",
                    color: "white",
                    padding: "10px"
                });
            });
        });
    </script>

  .. cv:: html

    <div id="showMe">
        click here to see how it works
    </div>


`Installation instructions & Tutorials <quickstart/index>`_


===========================
`Reference Guide <manual>`_
===========================

`The programmers manual for Dojo, Dijit, DojoX with more than 300 examples <manual/index>`_


================
`About <about>`_
================

`All about Dojo Toolkits new official documentation pages <about/index>`_ and how you can contribute. It's a wiki, so dive in help us make it awesome!
