.. _dojo/cldr/monetary:

==================
dojo.cldr.monetary
==================

Examples
========

The following example prints out the monetary data (places and round) for EUR (Euro):

.. code-example ::

  .. js ::

        dojo.require("dijit.form.Button");
        // load monetary data:
        dojo.require("dojo.cldr.monetary");

  .. html ::

    <button id="monetaryButton" data-dojo-type="dijit.form.Button" type="button">Get Monetary data for EUR (Euro)
        <script type="dojo/method" data-dojo-event="onClick">
            // the ISO 4217 currency code for Euro:
            var iso = 'EUR';
            // get monetary data:
            var cldrMonetary = dojo.cldr.monetary.getData(iso);

            // print out places:
            dojo.byId("places").innerHTML = "Places: " + cldrMonetary.places;

            // print out round:
            dojo.byId("round").innerHTML = "Round: " + cldrMonetary.round;
        </script>
    </button>
    <div id="places"></div>
    <div id="round"></div>

.. api-inline :: dojo.cldr.monetary

See also
========

* :ref:`dojo.cldr <dojo/cldr>`
