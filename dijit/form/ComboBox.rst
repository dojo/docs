.. _dijit/form/ComboBox:

===================
dijit/form/ComboBox
===================

:Authors: Doug Hays, Nikolai Onken
:Developers: Doug Hays, Bill Keese
:since: V1.0

.. contents ::
    :depth: 2

The ComboBox is a hybrid between a SELECT combo-box and an INPUT text field.

Usage
=====

Like a SELECT combo-box, you provide a list of values.
However, this is merely a list of suggestions.
Like an INPUT text field, the user can type whatever text they want, regardless of whether or not it's in the drop down
menu.
As the user types, partially matched values will be shown in a pop-up menu below the INPUT text box.

On FORM submit, the displayed text value of a non-disabled ComboBox widget is submitted using a native INPUT text box if the *name* attribute was specified at widget creation time.

ComboBox widgets are :ref:`dojo.store <dojo/store>`-enabled.
This means rather than embedding all the OPTION tags within the page,
you can have dojo.store fetch them from a server-based store.
The unified dojo.store architecture can get its data from various places such as databases and web services.
See the :ref:`dojo.store <dojo/store>` section for complete details.

`Note:` ComboBox only has a single value that matches what is displayed
while :ref:`FilteringSelect <dijit/form/FilteringSelect>`
incorporates a hidden value that corresponds to the displayed value.

Examples
========

Programmatic example using a dojo.store
---------------------------------------

To set the default value for a programmatic ComboBox,
include the *value* attribute in the attribute list passed to the constructor.

.. code-example ::

  .. js ::

        require([
            "dojo/store/Memory", "dijit/form/ComboBox", "dojo/domReady!"
        ], function(Memory, ComboBox){
            var stateStore = new Memory({
                data: [
                    {name:"Alabama", id:"AL"},
                    {name:"Alaska", id:"AK"},
                    {name:"American Samoa", id:"AS"},
                    {name:"Arizona", id:"AZ"},
                    {name:"Arkansas", id:"AR"},
                    {name:"Armed Forces Europe", id:"AE"},
                    {name:"Armed Forces Pacific", id:"AP"},
                    {name:"Armed Forces the Americas", id:"AA"},
                    {name:"California", id:"CA"},
                    {name:"Colorado", id:"CO"},
                    {name:"Connecticut", id:"CT"},
                    {name:"Delaware", id:"DE"}
                ]
            });

            var comboBox = new ComboBox({
                id: "stateSelect",
                name: "state",
                value: "California",
                store: stateStore,
                searchAttr: "name"
            }, "stateSelect");
            comboBox.startup();
        });

  .. html ::

    <input id="stateSelect">
    <p><button onClick="alert(dijit.byId('stateSelect').get('value'))">Get value</button></p>

Declarative markup using native select and option tags
------------------------------------------------------

Native SELECT combo-boxes always have value/description pairs, e.g.
the OPTION's *value* attribute is used as the submit value and the OPTION's child text node is used as the displayed value.
For ComboBox widgets, only the OPTION's child text node is used as both the submit value and the displayed value.
To set the default value when using OPTION tags, specify the *selected* attribute on 1 of the child OPTION tags.

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/form/ComboBox"]);

  .. html ::

    <select data-dojo-type="dijit/form/ComboBox" id="fruit" name="fruit">
        <option>Apples</option>
        <option selected>Oranges</option>
        <option>Pears</option>
    </select>


Declarative markup using a dojo.store
-------------------------------------

To set the default value for this example, specify the *value* attribute in the markup.

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/form/ComboBox", "dojo/store/Memory"]);

  .. html ::

    <div data-dojo-type="dojo/store/Memory"
        data-dojo-id="stateStore"
        data-dojo-props="data: [{id: 'y', name: 'yes'}, {id: 'n', name: 'no'}]"></div>
    <input data-dojo-type="dijit/form/ComboBox"
        value="yes"
        data-dojo-props="store:stateStore, searchAttr:'name'"
        name="state"
        id="stateInput">


Codependent FilteringSelect/ComboBox widgets
--------------------------------------------

See an example where the city ComboBox sets the state FilteringSelect value,
and the state FilteringSelect filters the city ComboBox choices, on the
:ref:`dijit.form.FilteringSelect <dijit/form/FilteringSelect>` page.


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

JAWS 8 and Window-Eyes 6 may fail to read an option when it becomes highlighted.
In Dojo 1.1 the Combobox was updated so that JAWS 9 will speak "editable combo" when the Combobox gets focus.
However, there are some issues reading the highlighted choice.
Generally JAWS 9 with Firefox 2 will only speak the part of the word that is currently selected in the textbox.
For example, if you are working with a ComboBox containing the US state names and you type in an "I" to filter the list of states.
If the user arrows down and highlights "Iowa" in the drop down list, "Iowa" will be displayed in the textbox with the "owa" portion selected.
JAWS 9 will speak, "owa" rather than "Iowa".
This is not an issue with Firefox 3 and JAWS 9 or JAWS 10.

When using JAWS 10 with IE 8 all of the visible choices in the ComboBox are spoken as you arrow down through the items - the currently focused item is spoken last.
Event the hidden previous choices / more choices options are spoken.
This appears to be an issue with IE 8 and list items (which are used to implement the option choices) and with IE 8 not honoring hidden items.
