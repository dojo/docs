#format dojo_rst

dijit.form.ComboBox
===================

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 3

The dijit ComboBox is an enhanced version of the native <select> element. ComboBox provides the user with a pre-defined selection of options, but allows the user to enter custom values as well.

Examples
--------

Programmatic using remote data
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.ComboBox");
      dojo.require("dojo.data.ItemFileReadStore");
      
      dojo.addOnLoad(function(){
        var store = new dojo.data.ItemFileReadStore({url: "http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/states.json"});       
        var filteringSelect = new dijit.form.ComboBox({id: "stateSelect", store: store, searchAttr: "name"}, "stateSelect");
      });
    </script>

  .. cv:: html

    <div id="stateSelect"></div>

Declarative using native select
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.ComboBox");
    </script>

  .. cv:: html

    <select dojoType="dijit.form.ComboBox" id="stateSelect">
      <option>Apples</option>
      <option>Peers</option>
    </select>
