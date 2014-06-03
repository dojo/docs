.. _dojo/cldr/monetary:

==================
dojo/cldr/monetary
==================

Examples
========

The following example prints out the monetary data (places and round) for EUR (Euro):

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/cldr/monetary", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(cldrMonetary, dom, on){
      on(dom.byId("monetaryButton"), "click", function(){
        // the ISO 4217 currency code for Euro:
        var iso = "EUR";
        // get monetary data:
        var cldrMonetaryData = cldrMonetary.getData(iso);
      
        // print out places:
        dom.byId("places").innerHTML = "Places: " + cldrMonetaryData.places;
      
        // print out round:
        dom.byId("round").innerHTML = "Round: " + cldrMonetaryData.round;
      });
    });

  .. html ::

    <button id="monetaryButton" type="button">Get Monetary data for EUR (Euro)</button>
    <div id="places"></div>
    <div id="round"></div>

See also
========

* :ref:`dojo/cldr <dojo/cldr>`
