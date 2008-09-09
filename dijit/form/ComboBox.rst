#format dojo_rst

dijit.form.ComboBox
===================

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 3

The ComboBox is a hybrid between a SELECT combo-box and an INPUT text field.  Like a SELECT combo-box, you provide a list of acceptable values.  But like an INPUT text field, the user can also type whatever they want.  

On FORM submit, the displayed text value of a non-disabled ComboBox widget is submitted using a native INPUT text box if the *name* attribute was specified at widget creation time.

ComboBox widgets are dojo.data-enabled.  This means rather than embedding all the OPTION tags within the page, you can have dojo.data fetch them from a server-based store.  The unified dojo.data architecture can get its data from various places such as databases and web services.  See the `dojo.data <dojo/data>`_ section for complete details.


Examples
--------

Programmatic example using a data store
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To set the default value for a programmatic ComboBox, include the *value* attribute in the attribute list passed to the constructor.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Button"); // only to make the demo look fancy
      dojo.require("dijit.form.ComboBox");
      dojo.require("dojo.data.ItemFileReadStore");
    </script>

     <script type="text/javascript">     
      dojo.addOnLoad(function(){
        var stateStore = new dojo.data.ItemFileReadStore({url: "http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/states.json"});       
        var filteringSelect = new dijit.form.ComboBox({id: "stateSelect", name: "state", value: "Kentucky", store: stateStore, searchAttr: "name"}, "stateSelect");
      });
    </script>

  .. cv:: html

    <input id="stateSelect">
    <p><button dojoType="dijit.form.Button" onClick="alert(dijit.byId('stateSelect').getValue())">Get value</button></p>

Declarative markup using native select and option tags
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Native SELECT combo-boxes always have value/description pairs, e.g. the OPTION's *value* attribute is used as the submit value and the OPTION's child text node is used as the displayed value. For ComboBox widgets, only the OPTION's child text node is used as both the submit value and the displayed value.  To set the default value when using OPTION tags, specify the *selected* attribute on 1 of the child OPTION tags.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.ComboBox");
    </script>

  .. cv:: html

    <select dojoType="dijit.form.ComboBox" id="fruit" name="fruit">
      <option>Apples</option>
      <option selected>Oranges</option>
      <option>Peers</option>
    </select>


Declarative markup using a data store
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To set the default value for this example, specify the *value* attribute in the markup.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.ComboBox");
      dojo.require("dojo.data.ItemFileReadStore");
    </script>

  .. cv:: html

    <div dojoType="dojo.data.ItemFileReadStore" jsId="stateStore"
        url="http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/states.json"></div>
    <input dojoType="dijit.form.ComboBox"
                value="Kentucky"
                store="stateStore"
                searchAttr="name"
                name="state"
                id="stateInput">
