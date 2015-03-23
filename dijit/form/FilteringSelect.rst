.. _dijit/form/FilteringSelect:

==========================
dijit/form/FilteringSelect
==========================

:Authors: Doug Hays, Nikolai Onken
:Developers: Doug Hays, Bill Keese
:since: V1.0

.. contents ::
    :depth: 2

The FilteringSelect widget is a replacement for the native SELECT element.


Usage
=====

Like SELECT, you provide a list of acceptable value pairs consisting of text to be displayed in the INPUT box
and the hidden text value to be submitted to the server on FORM submit.
Unlike SELECT, the user can also freely type text and partially matched values will be shown in a pop-up menu below the INPUT text box.
Unlike a :ref:`ComboBox <dijit/form/ComboBox>` widget, unmatched user text will be flagged as an error.

On FORM submit, the hidden text value associated with the displayed value of a non-disabled FilteringSelect widget
is submitted using a hidden native INPUT text box if the *name* attribute was specified at widget creation time.
Invalid input will result in a blank submitted text value.

FilteringSelect widgets are dojo.data-enabled.
This means rather than embedding all the OPTION tags within the page, you can have dojo.data fetch them from a server-based store.
The unified dojo.data architecture can get its data from various places such as databases and web services.
See the :ref:`dojo.data <dojo/data>` section for complete details.

`Note:` When using a DataStore with FilteringSelect, the store must implement the :ref:`Identity API <dojo/data/api/Identity>`.


Examples
========

Programmatic example using a dojo.store
---------------------------------------

To set the default value for a programmatic FilteringSelect, include the *value* attribute (the hidden text value to be submitted) in the attribute list passed to the constructor.
To get the current value (the identity of the currently selected store item), get the *value* attribute.
To get the text currently displayed in the textbox (the value of the currently selected store item's attribute indicated by the FilteringSelect's ``searchAttr`` property), get the *displayedValue* attribute.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

        require([
            "dojo/store/Memory", "dijit/form/FilteringSelect",
            "dijit/registry", "dojo/domReady!"
        ], function(Memory, FilteringSelect, registry){
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

            var filteringSelect = new FilteringSelect({
                id: "stateSelect",
                name: "state",
                value: "CA",
                store: stateStore,
                searchAttr: "name"
            }, "stateSelect");
            filteringSelect.startup();
        });

  .. html ::

    <input id="stateSelect">
    <p>
        <button onclick="alert(registry.byId('stateSelect').get('value'))">Get value</button>
        <button onclick="alert(registry.byId('stateSelect').get('displayedValue'))">Get displayed value</button>
    </p>

Declarative markup using native select and option tags
------------------------------------------------------

Native SELECT combo-boxes always have value/description pairs, e.g.
the OPTION's *value* attribute is used as the submit value and the OPTION's child text node is used as the displayed value.
For FilteringSelect widgets, the OPTION's child text node is used as the displayed value and the OPTION's *value* attribute is used as the hidden submit value.
To set the default value when using OPTION tags, specify the *selected* attribute on 1 of the child OPTION tags.

NOTE: if you do not specify a selected option, the browser will select the first item by default.
If you want the FilteringSelect to start blank, use a different method to create it.

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/form/FilteringSelect", "dojo/domReady!"]);

  .. html ::

    <select data-dojo-type="dijit/form/FilteringSelect" id="fruit" name="fruit">
        <option value="AP">Apples</option>
        <option value="OR" selected>Oranges</option>
        <option value="PE" >Pears</option>
    </select>


Declarative markup using a dojo/store
-------------------------------------

To set the default value for this example, specify the *value* attribute (the hidden text value to be submitted) in the markup.

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/form/FilteringSelect", "dojo/store/Memory", "dojo/domReady!"]);

  .. html ::

    <div data-dojo-type="dojo/store/Memory"
        data-dojo-id="stateStore"
        data-dojo-props="data: [{id: 'y', name: 'yes'}, {id: 'n', name: 'no'}]"></div>
    <input data-dojo-type="dijit/form/FilteringSelect"
        value="y"
        data-dojo-props="store:stateStore, searchAttr:'name'"
        name="state"
        id="stateInput">

Custom displayed value/search text
----------------------------------

By default, FilteringSelect searches on the name attribute of objects in your dojo.data store.
But what if you want to search on a different attribute?
searchAttr enables you to do just that.

In this example, the FilteringSelect has been set to display the ids for states rather than their full names.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

        require([
            "dojo/_base/window", "dojo/store/Memory", "dijit/form/FilteringSelect", "dojo/domReady!"
        ], function(win, Memory, FilteringSelect){
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

            var filteringSelect = new FilteringSelect({
                id: "stateSelect",
                name: "state",
                value: "CA",
                store: stateStore,
                searchAttr: "id"
            }, "stateSelect");
            filteringSelect.placeAt(win.body());
            filteringSelect.startup();
        });

Codependent FilteringSelect/ComboBox widgets
--------------------------------------------

The city ComboBox sets the state FilteringSelect value,
and the state FilteringSelect filters the city ComboBox choices in this example.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    var states = [
        {name:"Alabama", state:"AL"},
        {name:"Alaska", state:"AK"},
        {name:"American Samoa", state:"AS"},
        {name:"Arizona", state:"AZ"},
        {name:"Arkansas", state:"AR"},
        {name:"Armed Forces Europe", state:"AE"},
        {name:"Armed Forces Pacific", state:"AP"},
        {name:"Armed Forces the Americas", state:"AA"},
        {name:"California", state:"CA"},
        {name:"Colorado", state:"CO"},
        {name:"Connecticut", state:"CT"},
        {name:"Delaware", state:"DE"},
        {name:"District of Columbia", state:"DC"},
        {name:"Federated States of Micronesia", state:"FM"},
        {name:"Florida", state:"FL"},
        {name:"Georgia", state:"GA"},
        {name:"Guam", state:"GU"},
        {name:"Hawaii", state:"HI"},
        {name:"Idaho", state:"ID"},
        {name:"Illinois", state:"IL"},
        {name:"Indiana", state:"IN"},
        {name:"Iowa", state:"IA"},
        {name:"Kansas", state:"KS"},
        {name:"Kentucky", state:"KY"},
        {name:"Louisiana", state:"LA"},
        {name:"Maine", state:"ME"},
        {name:"Marshall Islands", state:"MH"},
        {name:"Maryland", state:"MD"},
        {name:"Massachusetts", state:"MA"},
        {name:"Michigan", state:"MI"},
        {name:"Minnesota", state:"MN"},
        {name:"Mississippi", state:"MS"},
        {name:"Missouri", state:"MO"},
        {name:"Montana", state:"MT"},
        {name:"Nebraska", state:"NE"},
        {name:"Nevada", state:"NV"},
        {name:"New Hampshire", state:"NH"},
        {name:"New Jersey", state:"NJ"},
        {name:"New Mexico", state:"NM"},
        {name:"New York", state:"NY"},
        {name:"North Carolina", state:"NC"},
        {name:"North Dakota", state:"ND"},
        {name:"Northern Mariana Islands", state:"MP"},
        {name:"Ohio", state:"OH"},
        {name:"Oklahoma", state:"OK"},
        {name:"Oregon", state:"OR"},
        {name:"Pennsylvania", state:"PA"},
        {name:"Puerto Rico", state:"PR"},
        {name:"Rhode Island", state:"RI"},
        {name:"South Carolina", state:"SC"},
        {name:"South Dakota", state:"SD"},
        {name:"Tennessee", state:"TN"},
        {name:"Texas", state:"TX"},
        {name:"Utah", state:"UT"},
        {name:"Vermont", state:"VT"},
        {name: "Virgin Islands, U.S.",state:"VI"},
        {name:"Virginia", state:"VA"},
        {name:"Washington", state:"WA"},
        {name:"West Virginia", state:"WV"},
        {name:"Wisconsin", state:"WI"},
        {name:"Wyoming", state:"WY"}
    ];

    var cities =  [
        { name:"Albany", state:"NY" },
        { name:"Albuquerque", state:"NM" },
        { name:"Alexandria", state:"VA" },
        { name:"Amarillo", state:"TX" },
        { name:"Amherst", state:"MA" },
        { name:"Anaheim", state:"CA" },
        { name:"Anchorage", state:"AK" },
        { name:"Ann Arbor", state:"MI" },
        { name:"Annapolis", state:"MD" },
        { name:"Ashland", state:"OR" },
        { name:"Aspen", state:"CO" },
        { name:"Athens", state:"GA" },
        { name:"Atlanta", state:"GA" },
        { name:"Auburn", state:"AL" },
        { name:"Augusta", state:"GA" },
        { name:"Austin", state:"TX" },
        { name:"Baltimore", state:"MD" },
        { name:"Bangor", state:"ME" },
        { name:"Baton Rouge", state:"LA" },
        { name:"Bethlehem", state:"PA" },
        { name:"Beverly Hills", state:"CA" },
        { name:"Billings", state:"MT" },
        { name:"Biloxi", state:"MS" },
        { name:"Birmingham", state:"AL" },
        { name:"Bloomington", state:"IN" },
        { name:"Boca Raton", state:"FL" },
        { name:"Boise", state:"ID" },
        { name:"Boston", state:"MA" },
        { name:"Boulder", state:"CO" },
        { name:"Branson", state:"MO" },
        { name:"Buffalo", state:"NY" },
        { name:"Burbank", state:"CA" },
        { name:"Burlington", state:"VT" },
        { name:"Butte", state:"MT" },
        { name:"Cambridge", state:"MA" },
        { name:"Carmel", state:"CA" },
        { name:"Cedar Rapids", state:"IA" },
        { name:"Champaign-Urbana", state:"IL" },
        { name:"Chapel Hill", state:"NC" },
        { name:"Charleston", state:"SC" },
        { name:"Charleston", state:"WV" },
        { name:"Charlotte", state:"NC" },
        { name:"Chattanooga", state:"TN" },
        { name:"Chicago", state:"IL" },
        { name:"Cincinnati", state:"OH" },
        { name:"Clearwater Beach", state:"FL" },
        { name:"Cleveland", state:"OH" },
        { name:"Cody", state:"WY" },
        { name:"College Station", state:"TX" },
        { name:"Colorado Springs", state:"CO" },
        { name:"Columbia", state:"SC" },
        { name:"Columbus", state:"GA" },
        { name:"Columbus", state:"OH" },
        { name:"Concord", state:"NH" },
        { name:"Corpus Christi", state:"TX" },
        { name:"Dallas", state:"TX" },
        { name:"Dayton", state:"OH" },
        { name:"Daytona Beach", state:"FL" },
        { name:"Denver", state:"CO" },
        { name:"Des Moines", state:"IA" },
        { name:"Destin", state:"FL" },
        { name:"Detroit", state:"MI" },
        { name:"Dover", state:"DE" },
        { name:"Duluth", state:"MN" },
        { name:"Durham", state:"NC" },
        { name:"El Paso", state:"TX" },
        { name:"Erie", state:"PA" },
        { name:"Eugene", state:"OR" },
        { name:"Evansville", state:"IN" },
        { name:"Fairbanks", state:"AK" },
        { name:"Fargo", state:"ND" },
        { name:"Fayetteville", state:"NC" },
        { name:"Flagstaff", state:"AZ" },
        { name:"Fort Lauderdale", state:"FL" },
        { name:"Fort Wayne", state:"IN" },
        { name:"Fresno", state:"CA" },
        { name:"Ft. Worth", state:"TX" },
        { name:"Galveston", state:"TX" },
        { name:"Gatlinburg", state:"TN" },
        { name:"Grand Forks", state:"ND" },
        { name:"Greensboro", state:"NC" },
        { name:"Greenville", state:"SC" },
        { name:"Gulf Shores", state:"AL" },
        { name:"Hanover", state:"NH" },
        { name:"Harrisburg", state:"PA" },
        { name:"Hartford", state:"CT" },
        { name:"Hershey", state:"PA" },
        { name:"Hollywood", state:"CA" },
        { name:"Hot Springs", state:"AR" },
        { name:"Houston", state:"TX" },
        { name:"Huntsville", state:"AL" },
        { name:"Indianapolis", state:"IN" },
        { name:"Iowa City", state:"IA" },
        { name:"Ithaca", state:"NY" },
        { name:"Jackson", state:"MS" },
        { name:"Jacksonville", state:"FL" },
        { name:"Juneau", state:"AK" },
        { name:"Kalamazoo", state:"MI" },
        { name:"Kansas City", state:"KS" },
        { name:"Kansas City", state:"MO" },
        { name:"Kennebunkport", state:"ME" },
        { name:"Key West", state:"FL" },
        { name:"Knoxville", state:"TN" },
        { name:"Kodiak", state:"AK" },
        { name:"Laguna Beach", state:"CA" },
        { name:"Lansing", state:"MI" },
        { name:"Las Cruces", state:"NM" },
        { name:"Las Vegas", state:"NV" },
        { name:"Lexington", state:"KY" },
        { name:"Lincoln", state:"NE" },
        { name:"Little Rock", state:"AR" },
        { name:"Los Alamos", state:"NM" },
        { name:"Los Angeles", state:"CA" },
        { name:"Louisville", state:"KY" },
        { name:"Lynchburg", state:"VA" },
        { name:"Macon", state:"GA" },
        { name:"Madison", state:"WI" },
        { name:"Manchester", state:"NH" },
        { name:"Mankato", state:"MN" },
        { name:"Memphis", state:"TN" },
        { name:"Miami", state:"FL" },
        { name:"Milwaukee", state:"WI" },
        { name:"Minneapolis", state:"MN" },
        { name:"Mobile", state:"AL" },
        { name:"Moline", state:"IL" },
        { name:"Monterey", state:"CA" },
        { name:"Montgomery", state:"AL" },
        { name:"Montpelier", state:"VT" },
        { name:"Morgantown", state:"WV" },
        { name:"Myrtle Beach", state:"SC" },
        { name:"Naples", state:"FL" },
        { name:"Nashville", state:"TN" },
        { name:"New Haven", state:"CT" },
        { name:"New Orleans", state:"LA" },
        { name:"New York City", state:"NY" },
        { name:"Newark", state:"NJ" },
        { name:"Newport Beach", state:"CA" },
        { name:"Niagara Falls", state:"NY" },
        { name:"Norfolk", state:"VA" },
        { name:"Oakland", state:"CA" },
        { name:"Ogden", state:"UT" },
        { name:"Oklahoma City", state:"OK" },
        { name:"Olympia", state:"WA" },
        { name:"Omaha", state:"NE" },
        { name:"Orlando", state:"FL" },
        { name:"Palm Beach", state:"FL" },
        { name:"Palm Springs", state:"CA" },
        { name:"Palo Alto", state:"CA" },
        { name:"Panama City Beach", state:"FL" },
        { name:"Pasadena", state:"CA" },
        { name:"Pensacola", state:"FL" },
        { name:"Peoria", state:"IL" },
        { name:"Philadelphia", state:"PA" },
        { name:"Phoenix", state:"AZ" },
        { name:"Pierre", state:"SD" },
        { name:"Pigeon Forge", state:"TN" },
        { name:"Pittsburgh", state:"PA" },
        { name:"Pocatello", state:"ID" },
        { name:"Portland", state:"ME" },
        { name:"Portland", state:"OR" },
        { name:"Portsouth", state:"NH" },
        { name:"Princeton", state:"NJ" },
        { name:"Providence", state:"RI" },
        { name:"Raleigh", state:"NC" },
        { name:"Redondo Beach", state:"CA" },
        { name:"Reno", state:"NV" },
        { name:"Richmond", state:"VA" },
        { name:"Rochester", state:"MN" },
        { name:"Rochester", state:"NY" },
        { name:"Rockford", state:"IL" },
        { name:"Sacramento", state:"CA" },
        { name:"Salem", state:"OR" },
        { name:"Salt Lake City", state:"UT" },
        { name:"San Antonio", state:"TX" },
        { name:"San Diego", state:"CA" },
        { name:"San Francisco", state:"CA" },
        { name:"San Jose", state:"CA" },
        { name:"Santa Barbara", state:"CA" },
        { name:"Santa Cruz", state:"CA" },
        { name:"Santa Fe", state:"NM" },
        { name:"Santa Monica", state:"CA" },
        { name:"Sarasota", state:"FL" },
        { name:"Savannah", state:"GA" },
        { name:"Scottsdale", state:"AZ" },
        { name:"Scranton", state:"PA" },
        { name:"Seattle", state:"WA" },
        { name:"Shreveport", state:"LA" },
        { name:"Sioux Falls", state:"SD" },
        { name:"South Bend", state:"IN" },
        { name:"Spokane", state:"WA" },
        { name:"Springfield", state:"MA" },
        { name:"St. Louis", state:"MO" },
        { name:"St. Paul", state:"MN" },
        { name:"St. Petersburg", state:"FL" },
        { name:"State College", state:"PA" },
        { name:"Sun Valley", state:"ID" },
        { name:"Syracuse", state:"NY" },
        { name:"Tacoma", state:"WA" },
        { name:"Tallahassee", state:"FL" },
        { name:"Tampa", state:"FL" },
        { name:"Telluride", state:"CO" },
        { name:"Tempe", state:"AZ" },
        { name:"Terre Haute", state:"IN" },
        { name:"Toledo", state:"OH" },
        { name:"Topeka", state:"KS" },
        { name:"Traverse City", state:"MI" },
        { name:"Trenton", state:"NJ" },
        { name:"Tucson", state:"AZ" },
        { name:"Tulsa", state:"OK" },
        { name:"Vail", state:"CO" },
        { name:"Virginia Beach", state:"VA" },
        { name:"Washington", state:"DC" },
        { name:"Wheeling", state:"WV" },
        { name:"Wichita", state:"KS" },
        { name:"Williamsburg", state:"VA" },
        { name:"Wilmington", state:"DE" },
        { name:"Winston-Salem", state:"NC" },
        { name:"Worcester", state:"MA" },
        { name:"Yellowstone", state:"WY" },
        { name:"York", state:"PA" }
    ];

    require([
        "dojo/store/Memory",
        "dijit/form/ComboBox", "dijit/form/FilteringSelect",
        "dijit/registry", "dojo/domReady!"
    ], function(Memory, ComboBox, FilteringSelect, registry){

        var combobox = new ComboBox({
            id: "city",
            store: new Memory({ data: cities }),
            autoComplete: true,
            query: {state: /.*/},
            style: "width: 150px;",
            required: true,
            searchAttr: "name",
            onChange: function(city){
                console.log("combobox onchange ", city, this.item);
                registry.byId('state').set('value', this.item ? this.item.state : null);
            }
        }, "city");
        combobox.startup();

        var fs = new FilteringSelect({
            id: "state",
            store: new Memory({ idProperty: "state", data: states }),
            autoComplete: true,
            style: "width: 150px;",
            onChange: function(state){
                registry.byId('city').query.state = this.item.state || /.*/;
            }
        }, "state");
        fs.startup();
    });

  .. html ::

    <label for="city">City:</label>
    <input id="city">
    <label for="state">State:</label>
    <input id="state">

Displaying rich text menu labels with labelAttr and labelType
-------------------------------------------------------------

When users open a FilteringSelect menu, by default they see the `name` attribute of each item in the menu.
You can enrich the menu's content by supplying a different label.

This example demonstrates a FilteringSelect populated with 3 items: `Dojo core`, `Dijit`, and `Dojox`.
The user can type any 1 of these 3 values.
The autocomplete menu displays rich text representations (images from http://www.dojotoolkit.org) of each.
If you try this example with a screen reader, you will notice that the screen reader continues to announce
the autocompleted value in the textbox, as with other FilteringSelects, rather than trying to parse the rich text label.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require([
        "dojo/store/Memory", "dijit/form/FilteringSelect", "dojo/domReady!"
    ], function(Memory, FilteringSelect){
        var dojoStore = new Memory({data: [
            {id: 1, name:"we", label:"<i>we</i> <img src='http://placekitten.com/50/70'>"},
            {id: 2, name:"are", label:"<u>are</u> <img src='http://placekitten.com/50/60'>"},
            {id: 3, name:"kittens", label:"<b>kittens</b> <img src='http://placekitten.com/50/50'>"}
        ]});

       var fs = new FilteringSelect({
             id: "dojoBox",
             value: 3,
             store: dojoStore,
             searchAttr: "name",
             name: "xyz",
             labelAttr: "label",
             labelType: "html"
       }, "dojoBox");
       fs.startup();
    });

  .. html ::

    <input id="dojoBox">



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
In Dojo 1.1 the FilteringSelect was updated so that JAWS 9 will speak "editable combo" when the FilteringSelect gets focus.
However, there are some issues reading the highlighted choice.
Generally JAWS 9 with Firefox 2 will only speak the part of the word that is currently selected in the textbox.
For example, if you are working with a FilteringSelect containing the US state names and you type in an "I" to filter the list of states.
If the user arrows down and highlights "Iowa" in the drop down list, "Iowa" will be displayed in the textbox with the "owa" portion selected.
JAWS 9 will speak, "owa" rather than "Iowa".
This is not an issue with Firefox 3 and JAWS 9 and JAWS 10.

When using JAWS 10 with IE 8 all of the visible choices in the ComboBox are spoken as you arrow down through the items - the currently focused item is spoken last.
Event the hidden previous choices / more choices options are spoken.
This appears to be an issue with IE 8 and list items (which are uses to implement the option choices) and with IE 8 not honoring hidden items.


See Also
========

* There's a :ref:`Select <dijit/form/Select>` widget in the :ref:`dijit/form <dijit/form>` project that's similar to FilteringSelect but without the search ability. It can support rich text in both the drop down and in a closed state (to display the selected item).
