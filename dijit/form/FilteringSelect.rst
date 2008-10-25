#format dojo_rst

dijit.form.FilteringSelect
==========================

:Status: Draft
:Version: 1.0
:Authors: Doug Hays, Nikolai Onken
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2

The FilteringSelect widget is a replacement for the native SELECT element.


=====
Usage
=====

Like SELECT, you provide a list of acceptable value pairs consisting of text to be displayed in the INPUT box and the hidden text value to be submitted to the server on FORM submit. Unlike SELECT, the user can also freely type text and partially matched values will be shown in a pop-up menu below the INPUT text box. Unlike a ComboBox widget, unmatched user text will be flagged as an error.

On FORM submit, the hidden text value associated with the displayed value of a non-disabled FilteringSelect widget is submitted using a hidden native INPUT text box if the *name* attribute was specified at widget creation time. Invalid input will result in a blank submitted text value.

FilteringSelect widgets are dojo.data-enabled. This means rather than embedding all the OPTION tags within the page, you can have dojo.data fetch them from a server-based store. The unified dojo.data architecture can get its data from various places such as databases and web services. See the `dojo.data <dojo/data>`_ section for complete details.

`note:` When using a DataStore with FilteringSelect, the store must implement the `Identity API <dojo/data/api/Identity>`_

========
Examples
========

Programmatic example using a data store
---------------------------------------

To set the default value for a programmatic FilteringSelect, include the *value* attribute (the hidden text value to be submitted) in the attribute list passed to the constructor.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.FilteringSelect");
      dojo.require("dojo.data.ItemFileReadStore");
    </script>

     <script type="text/javascript">     
      dojo.addOnLoad(function(){
        var stateStore = new dojo.data.ItemFileReadStore({url: "http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/states.json"});       
        var filteringSelect = new dijit.form.FilteringSelect({id: "stateSelect", name: "state", value: "KY", store: stateStore, searchAttr: "name"}, "stateSelect");
      });
    </script>

  .. cv:: html

    <input id="stateSelect">
    <p><button onClick="alert(dijit.byId('stateSelect').attr('value'))">Get value</button></p>

Declarative markup using native select and option tags
------------------------------------------------------

Native SELECT combo-boxes always have value/description pairs, e.g. the OPTION's *value* attribute is used as the submit value and the OPTION's child text node is used as the displayed value. For FilteringSelect widgets, the OPTION's child text node is used as the displayed value and the OPTION's *value* attribute is used as the hidden submit value. To set the default value when using OPTION tags, specify the *selected* attribute on 1 of the child OPTION tags.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.FilteringSelect");
    </script>

  .. cv:: html

    <select dojoType="dijit.form.FilteringSelect" id="fruit" name="fruit">
      <option value="AP">Apples</option>
      <option value="OR" selected>Oranges</option>
      <option value="PE" >Pears</option>
    </select>


Declarative markup using a data store
-------------------------------------

To set the default value for this example, specify the *value* attribute (the hidden text value to be submitted) in the markup.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.FilteringSelect");
      dojo.require("dojo.data.ItemFileReadStore");
    </script>

  .. cv:: html

    <div dojoType="dojo.data.ItemFileReadStore" jsId="stateStore"
        url="http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/states.json"></div>
    <input dojoType="dijit.form.FilteringSelect"
                value="KY"
                store="stateStore"
                searchAttr="name"
                name="state"
                id="stateInput">


=============
Accessibility
=============

Keyboard
--------

+------------------------------------------------------+---------------+
| **Action**                                           | **Key**       |
+------------------------------------------------------+---------------+
| Open the menu of options (filtered by current input) | Down arrow    |
+------------------------------------------------------+---------------+
| Navigate through the options                         | Up/Down arrow |
+------------------------------------------------------+---------------+
| Pick an option                                       | Enter         |
+------------------------------------------------------+---------------+
| Close the menu of options without selection          | Esc           |
+------------------------------------------------------+---------------+

Known Issues
------------

JAWS 8 and Window-Eyes 6 may fail to read an option when it becomes highlighted. In Dojo 1.1 the FilteringSelect was updated so that JAWS 9 will speak "editable combo" when the FilteringSelect gets focus. However, there are some issues reading the highlighted choice. Generally JAWS 9 with Firefox 2 will only speak the part of the word that is currently selected in the textbox. For example, if you are working with a FilteringSelect containing the US state names and you type in an "I" to filter the list of states. If the user arrows down and highlights "Iowa" in the drop down list, "Iowa" will be displayed in the textbox with the "owa" portiion selected. JAWS 9 will speak, "owa" rather than "Iowa". This is not an issue with Firefox 3 and JAWS 9. 
