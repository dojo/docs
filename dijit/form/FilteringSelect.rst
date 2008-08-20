#format dojo_rst

dijit.form.FilteringSelect
==========================

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 3

The dijit FilteringSelect is the replacement for the native <select> element. A user is only allowed to select options which are provided by the FilteringSelect.

Examples
--------

Programmatic FilteringSelect using remote data
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.FilteringSelect");
      dojo.require("dojo.data.ItemFileReadStore");

      var store = new dojo.data.ItemFileReadStore({url: "http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/states.json"});       
      var filteringSelect = new dijit.form.FilteringSelect({id: "stateSelect", store: store}, "stateSelect");
    </script>

  .. cv:: html

    <div id="stateSelect"></div>
