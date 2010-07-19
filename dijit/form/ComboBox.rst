#format dojo_rst

dijit.form.ComboBox
===================

:Authors: Doug Hays, Nikolai Onken
:Developers: Doug Hays, Bill Keese
:Available: since V1.0

.. contents::
    :depth: 2

The ComboBox is a hybrid between a SELECT combo-box and an INPUT text field. 

=====
Usage
=====

Like a SELECT combo-box, you provide a list of acceptable values. But like an INPUT text field, the user can also type whatever they want. As the user types, partially matched values will be shown in a pop-up menu below the INPUT text box.

On FORM submit, the displayed text value of a non-disabled ComboBox widget is submitted using a native INPUT text box if the *name* attribute was specified at widget creation time.

ComboBox widgets are dojo.data-enabled. This means rather than embedding all the OPTION tags within the page, you can have dojo.data fetch them from a server-based store. The unified dojo.data architecture can get its data from various places such as databases and web services. See the `dojo.data <dojo/data>`_ section for complete details.

`note:` ComboBox only has a single value that matches what is displayed while `FilteringSelect <dijit/form/FilteringSelect>`_ incorporates a hidden value that corresponds to the displayed value.  

========
Examples
========

Programmatic example using a data store
---------------------------------------

To set the default value for a programmatic ComboBox, include the *value* attribute in the attribute list passed to the constructor.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.ComboBox");
      dojo.require("dojo.data.ItemFileReadStore");
    </script>

     <script type="text/javascript">     
      dojo.addOnLoad(function(){
        var stateStore = new dojo.data.ItemFileReadStore({url: "{{ dataUrl }}dijit/tests/_data/states.json"});       
        var filteringSelect = new dijit.form.ComboBox({id: "stateSelect", name: "state", value: "Kentucky", store: stateStore, searchAttr: "name"}, "stateSelect");
      });
    </script>

  .. cv:: html

    <input id="stateSelect">
    <p><button onClick="alert(dijit.byId('stateSelect').attr('value'))">Get value</button></p>

Declarative markup using native select and option tags
------------------------------------------------------

Native SELECT combo-boxes always have value/description pairs, e.g. the OPTION's *value* attribute is used as the submit value and the OPTION's child text node is used as the displayed value. For ComboBox widgets, only the OPTION's child text node is used as both the submit value and the displayed value. To set the default value when using OPTION tags, specify the *selected* attribute on 1 of the child OPTION tags.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.ComboBox");
    </script>

  .. cv:: html

    <select dojoType="dijit.form.ComboBox" id="fruit" name="fruit">
      <option>Apples</option>
      <option selected>Oranges</option>
      <option>Pears</option>
    </select>


Declarative markup using a data store
-------------------------------------

To set the default value for this example, specify the *value* attribute in the markup.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.ComboBox");
      dojo.require("dojo.data.ItemFileReadStore");
    </script>

  .. cv:: html

    <div dojoType="dojo.data.ItemFileReadStore" jsId="stateStore"
        url="{{dataUrl}}dijit/tests/_data/states.json"></div>
    <input dojoType="dijit.form.ComboBox"
                value="Kentucky"
                store="stateStore"
                searchAttr="name"
                name="state"
                id="stateInput">


Codependent FilteringSelect/ComboBox widgets
--------------------------------------------

`The city ComboBox sets the state FilteringSelect value, and the state FilteringSelect filters the city ComboBox choices in this example. <dijit/form/FilteringSelect#codependent-filteringselect-combobox-widgets>`_


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

JAWS 8 and Window-Eyes 6 may fail to read an option when it becomes highlighted. In Dojo 1.1 the Combobox was updated so that JAWS 9 will speak "editable combo" when the Combobox gets focus. However, there are some issues reading the highlighted choice. Generally JAWS 9 with Firefox 2 will only speak the part of the word that is currently selected in the textbox. For example, if you are working with a ComboBox containing the US state names and you type in an "I" to filter the list of states. If the user arrows down and highlights "Iowa" in the drop down list, "Iowa" will be displayed in the textbox with the "owa" portiion selected. JAWS 9 will speak, "owa" rather than "Iowa". This is not an issue with Firefox 3 and JAWS 9 or JAWS 10.

When using JAWS 10 with IE 8 all of the visible choices in the ComboBox are spoken as you arrow down through the items - the currently focused item is spoken last.  Event the hidden previous choices / more choices options are spoken. This appears to be an issue with IE 8 and list items (which are used to implement the option choices) and with IE 8 not honoring hidden items.  
