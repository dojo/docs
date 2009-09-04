#format dojo_rst

dijit.form.FilteringSelect
==========================

:Status: Draft
:Version: 1.3
:Authors: Doug Hays, Nikolai Onken
:Developers: Doug Hays, Bill Keese
:Available: since V1.0

.. contents::
    :depth: 2

The FilteringSelect widget is a replacement for the native SELECT element.


=====
Usage
=====

Like SELECT, you provide a list of acceptable value pairs consisting of text to be displayed in the INPUT box and the hidden text value to be submitted to the server on FORM submit. Unlike SELECT, the user can also freely type text and partially matched values will be shown in a pop-up menu below the INPUT text box. Unlike a `ComboBox <dijit/form/ComboBox>`_ widget, unmatched user text will be flagged as an error.

On FORM submit, the hidden text value associated with the displayed value of a non-disabled FilteringSelect widget is submitted using a hidden native INPUT text box if the *name* attribute was specified at widget creation time. Invalid input will result in a blank submitted text value.

FilteringSelect widgets are dojo.data-enabled. This means rather than embedding all the OPTION tags within the page, you can have dojo.data fetch them from a server-based store. The unified dojo.data architecture can get its data from various places such as databases and web services. See the `dojo.data <dojo/data>`_ section for complete details.

`note:` When using a DataStore with FilteringSelect, the store must implement the `Identity API <dojo/data/api/Identity>`_.


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
            var stateStore = new dojo.data.ItemFileReadStore({
                url: "http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/states.json"
            });
            var filteringSelect = new dijit.form.FilteringSelect({
                id: "stateSelect", 
                name: "state", 
                value: "KY", 
                store: stateStore, 
                searchAttr: "name"
            }, "stateSelect");
        });
    </script>

  .. cv:: html

    <input id="stateSelect">
    <p>
        <button onClick="alert(dijit.byId('stateSelect').attr('value'))">Get value</button>
    </p>

Declarative markup using native select and option tags
------------------------------------------------------

Native SELECT combo-boxes always have value/description pairs, e.g. the OPTION's *value* attribute is used as the submit value and the OPTION's child text node is used as the displayed value. For FilteringSelect widgets, the OPTION's child text node is used as the displayed value and the OPTION's *value* attribute is used as the hidden submit value. To set the default value when using OPTION tags, specify the *selected* attribute on 1 of the child OPTION tags.

NOTE: if you do not specify a selected option, the browser will select the first item by default. If you want the FilteringSelect to start blank, use a different method to create it.

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

    <div dojoType="dojo.data.ItemFileReadStore" 
        jsId="stateStore"
        url="http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/states.json"></div>
    <input dojoType="dijit.form.FilteringSelect"
        value="KY"
        store="stateStore"
        searchAttr="name"
        name="state"
        id="stateInput">

Custom displayed value/search text
----------------------------------

By default, FilteringSelect searches on the name attribute of objects in your dojo.data store. But what if you want to search on a different attribute? searchAttr enables you to do just that.

In this example, the FilteringSelect has been set to display the abbreviations for states rather than their full names.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.FilteringSelect");
        dojo.require("dojo.data.ItemFileReadStore");
    </script>

  .. cv:: html

    <!--stateStore definition omitted; see above examples-->
    <input dojoType="dijit.form.FilteringSelect"
        value="KY"
        store="stateStore"
        searchAttr="abbreviation"
        name="abbreviatedstate">

Codependent FilteringSelect/ComboBox widgets
--------------------------------------------

The city ComboBox sets the state FilteringSelect value, and the state FilteringSelect filters the city ComboBox choices in this example.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.FilteringSelect");
        dojo.require("dojo.data.ItemFileReadStore");
        dojo.addOnLoad(function(){
        var cityJson = {
            label: 'name',
            items: [
            { name:'Albany', state:'NY' },
            { name:'Albuquerque', state:'NM' },
            { name:'Alexandria', state:'VA' },
            { name:'Amarillo', state:'TX' },
            { name:'Amherst', state:'MA' },
            { name:'Anaheim', state:'CA' },
            { name:'Anchorage', state:'AK' },
            { name:'Ann Arbor', state:'MI' },
            { name:'Annapolis', state:'MD' },
            { name:'Ashland', state:'OR' },
            { name:'Aspen', state:'CO' },
            { name:'Athens', state:'GA' },
            { name:'Atlanta', state:'GA' },
            { name:'Auburn', state:'AL' },
            { name:'Augusta', state:'GA' },
            { name:'Austin', state:'TX' },
            { name:'Baltimore', state:'MD' },
            { name:'Bangor', state:'ME' },
            { name:'Baton Rouge', state:'LA' },
            { name:'Bethlehem', state:'PA' },
            { name:'Beverly Hills', state:'CA' },
            { name:'Billings', state:'MT' },
            { name:'Biloxi', state:'MS' },
            { name:'Birmingham', state:'AL' },
            { name:'Bloomington', state:'IN' },
            { name:'Boca Raton', state:'FL' },
            { name:'Boise', state:'ID' },
            { name:'Boston', state:'MA' },
            { name:'Boulder', state:'CO' },
            { name:'Branson', state:'MO' },
            { name:'Buffalo', state:'NY' },
            { name:'Burbank', state:'CA' },
            { name:'Burlington', state:'VT' },
            { name:'Butte', state:'MT' },
            { name:'Cambridge', state:'MA' },
            { name:'Carmel', state:'CA' },
            { name:'Cedar Rapids', state:'IA' },
            { name:'Champaign-Urbana', state:'IL' },
            { name:'Chapel Hill', state:'NC' },
            { name:'Charleston', state:'SC' },
            { name:'Charleston', state:'WV' },
            { name:'Charlotte', state:'NC' },
            { name:'Chattanooga', state:'TN' },
            { name:'Chicago', state:'IL' },
            { name:'Cincinnati', state:'OH' },
            { name:'Clearwater Beach', state:'FL' },
            { name:'Cleveland', state:'OH' },
            { name:'Cody', state:'WY' },
            { name:'College Station', state:'TX' },
            { name:'Colorado Springs', state:'CO' },
            { name:'Columbia', state:'SC' },
            { name:'Columbus', state:'GA' },
            { name:'Columbus', state:'OH' },
            { name:'Concord', state:'NH' },
            { name:'Corpus Christi', state:'TX' },
            { name:'Dallas', state:'TX' },
            { name:'Dayton', state:'OH' },
            { name:'Daytona Beach', state:'FL' },
            { name:'Denver', state:'CO' },
            { name:'Des Moines', state:'IA' },
            { name:'Destin', state:'FL' },
            { name:'Detroit', state:'MI' },
            { name:'Dover', state:'DE' },
            { name:'Duluth', state:'MN' },
            { name:'Durham', state:'NC' },
            { name:'El Paso', state:'TX' },
            { name:'Erie', state:'PA' },
            { name:'Eugene', state:'OR' },
            { name:'Evansville', state:'IN' },
            { name:'Fairbanks', state:'AK' },
            { name:'Fargo', state:'ND' },
            { name:'Fayetteville', state:'NC' },
            { name:'Flagstaff', state:'AZ' },
            { name:'Fort Lauderdale', state:'FL' },
            { name:'Fort Wayne', state:'IN' },
            { name:'Fresno', state:'CA' },
            { name:'Ft. Worth', state:'TX' },
            { name:'Galveston', state:'TX' },
            { name:'Gatlinburg', state:'TN' },
            { name:'Grand Forks', state:'ND' },
            { name:'Greensboro', state:'NC' },
            { name:'Greenville', state:'SC' },
            { name:'Gulf Shores', state:'AL' },
            { name:'Hanover', state:'NH' },
            { name:'Harrisburg', state:'PA' },
            { name:'Hartford', state:'CT' },
            { name:'Hershey', state:'PA' },
            { name:'Hollywood', state:'CA' },
            { name:'Hot Springs', state:'AR' },
            { name:'Houston', state:'TX' },
            { name:'Huntsville', state:'AL' },
            { name:'Indianapolis', state:'IN' },
            { name:'Iowa City', state:'IA' },
            { name:'Ithaca', state:'NY' },
            { name:'Jackson', state:'MS' },
            { name:'Jacksonville', state:'FL' },
            { name:'Juneau', state:'AK' },
            { name:'Kalamazoo', state:'MI' },
            { name:'Kansas City', state:'KS' },
            { name:'Kansas City', state:'MO' },
            { name:'Kennebunkport', state:'ME' },
            { name:'Key West', state:'FL' },
            { name:'Knoxville', state:'TN' },
            { name:'Kodiak', state:'AK' },
            { name:'Laguna Beach', state:'CA' },
            { name:'Lansing', state:'MI' },
            { name:'Las Cruces', state:'NM' },
            { name:'Las Vegas', state:'NV' },
            { name:'Lexington', state:'KY' },
            { name:'Lincoln', state:'NE' },
            { name:'Little Rock', state:'AR' },
            { name:'Los Alamos', state:'NM' },
            { name:'Los Angeles', state:'CA' },
            { name:'Louisville', state:'KY' },
            { name:'Lynchburg', state:'VA' },
            { name:'Macon', state:'GA' },
            { name:'Madison', state:'WI' },
            { name:'Manchester', state:'NH' },
            { name:'Mankato', state:'MN' },
            { name:'Memphis', state:'TN' },
            { name:'Miami', state:'FL' },
            { name:'Milwaukee', state:'WI' },
            { name:'Minneapolis', state:'MN' },
            { name:'Mobile', state:'AL' },
            { name:'Moline', state:'IL' },
            { name:'Monterey', state:'CA' },
            { name:'Montgomery', state:'AL' },
            { name:'Montpelier', state:'VT' },
            { name:'Morgantown', state:'WV' },
            { name:'Myrtle Beach', state:'SC' },
            { name:'Naples', state:'FL' },
            { name:'Nashville', state:'TN' },
            { name:'New Haven', state:'CT' },
            { name:'New Orleans', state:'LA' },
            { name:'New York City', state:'NY' },
            { name:'Newark', state:'NJ' },
            { name:'Newport Beach', state:'CA' },
            { name:'Niagara Falls', state:'NY' },
            { name:'Norfolk', state:'VA' },
            { name:'Oakland', state:'CA' },
            { name:'Ogden', state:'UT' },
            { name:'Oklahoma City', state:'OK' },
            { name:'Olympia', state:'WA' },
            { name:'Omaha', state:'NE' },
            { name:'Orlando', state:'FL' },
            { name:'Palm Beach', state:'FL' },
            { name:'Palm Springs', state:'CA' },
            { name:'Palo Alto', state:'CA' },
            { name:'Panama City Beach', state:'FL' },
            { name:'Pasadena', state:'CA' },
            { name:'Pensacola', state:'FL' },
            { name:'Peoria', state:'IL' },
            { name:'Philadelphia', state:'PA' },
            { name:'Phoenix', state:'AZ' },
            { name:'Pierre', state:'SD' },
            { name:'Pigeon Forge', state:'TN' },
            { name:'Pittsburgh', state:'PA' },
            { name:'Pocatello', state:'ID' },
            { name:'Portland', state:'ME' },
            { name:'Portland', state:'OR' },
            { name:'Portsouth', state:'NH' },
            { name:'Princeton', state:'NJ' },
            { name:'Providence', state:'RI' },
            { name:'Raleigh', state:'NC' },
            { name:'Redondo Beach', state:'CA' },
            { name:'Reno', state:'NV' },
            { name:'Richmond', state:'VA' },
            { name:'Rochester', state:'MN' },
            { name:'Rochester', state:'NY' },
            { name:'Rockford', state:'IL' },
            { name:'Sacramento', state:'CA' },
            { name:'Salem', state:'OR' },
            { name:'Salt Lake City', state:'UT' },
            { name:'San Antonio', state:'TX' },
            { name:'San Diego', state:'CA' },
            { name:'San Francisco', state:'CA' },
            { name:'San Jose', state:'CA' },
            { name:'Santa Barbara', state:'CA' },
            { name:'Santa Cruz', state:'CA' },
            { name:'Santa Fe', state:'NM' },
            { name:'Santa Monica', state:'CA' },
            { name:'Sarasota', state:'FL' },
            { name:'Savannah', state:'GA' },
            { name:'Scottsdale', state:'AZ' },
            { name:'Scranton', state:'PA' },
            { name:'Seattle', state:'WA' },
            { name:'Shreveport', state:'LA' },
            { name:'Sioux Falls', state:'SD' },
            { name:'South Bend', state:'IN' },
            { name:'Spokane', state:'WA' },
            { name:'Springfield', state:'MA' },
            { name:'St. Louis', state:'MO' },
            { name:'St. Paul', state:'MN' },
            { name:'St. Petersburg', state:'FL' },
            { name:'State College', state:'PA' },
            { name:'Sun Valley', state:'ID' },
            { name:'Syracuse', state:'NY' },
            { name:'Tacoma', state:'WA' },
            { name:'Tallahassee', state:'FL' },
            { name:'Tampa', state:'FL' },
            { name:'Telluride', state:'CO' },
            { name:'Tempe', state:'AZ' },
            { name:'Terre Haute', state:'IN' },
            { name:'Toledo', state:'OH' },
            { name:'Topeka', state:'KS' },
            { name:'Traverse City', state:'MI' },
            { name:'Trenton', state:'NJ' },
            { name:'Tucson', state:'AZ' },
            { name:'Tulsa', state:'OK' },
            { name:'Vail', state:'CO' },
            { name:'Virginia Beach', state:'VA' },
            { name:'Washington', state:'DC' },
            { name:'Wheeling', state:'WV' },
            { name:'Wichita', state:'KS' },
            { name:'Williamsburg', state:'VA' },
            { name:'Wilmington', state:'DE' },
            { name:'Winston-Salem', state:'NC' },
            { name:'Worcester', state:'MA' },
            { name:'Yellowstone', state:'WY' },
            { name:'York', state:'PA' }
        ]};

        new dijit.form.ComboBox(
        {   store: new dojo.data.ItemFileReadStore({ data: cityJson }),
            autoComplete: true,
            query: {state: "*"},
            style: "width: 150px;",
            required: true,
            id: "city",
            onChange: function(city){
                dijit.byId('state').attr('value', (dijit.byId('city').item || {state: ''}).state);
            }
        }, "city");

        new dijit.form.FilteringSelect(
        {   store: new dojo.data.ItemFileReadStore(
                { url: 'http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/states.json' }
            ),
            autoComplete: true,
            style: "width: 150px;",
            id: "state",
            onChange: function(state){
                dijit.byId('city').query.state = state || "*";
            }
        }, "state");
        });
    </script>

  .. cv:: html

    <label for="city">City:</label>
    <input id="city">
    <label for="state">State:</label>
    <input id="state">

Displaying rich text menu labels with labelAttr and labelType
-------------------------------------------------------------

When users open a FilteringSelect menu, by default they see the `name` attribute of each item in the menu. You can enrich the menu's content by supplying a different label.

This example demonstrates a FilteringSelect populated with 3 items: `Dojo core`, `Dijit`, and `Dojox`. The user can type any 1 of these 3 values. The autocomplete menu displays rich text representations (images from http://www.dojotoolkit.org) of each. If you try this example with a screen reader, you will notice that the screen reader continues to announce the autocompleted value in the textbox, as with other FilteringSelects, rather than trying to parse the rich text label.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.FilteringSelect");
        dojo.require("dojo.data.ItemFileReadStore");
        var richData={
                identifier:"name",
                label:"label",
                items:[
                        {name:"Dojo core", label:"<img src='http://www.dojotoolkit.org/sites/all/themes/dtk/img/core-home.png' />"},
                        {name:"Dijit", label:"<img src='http://www.dojotoolkit.org/sites/all/themes/dtk/img/dijit-home.png' />"},
                        {name:"Dojox", label:"<img src='http://www.dojotoolkit.org/sites/all/themes/dtk/img/dojox-home.png' />"}
                ]
        };
 
        dojo.addOnLoad(function(){
           var dojoStore = new dojo.data.ItemFileReadStore({data:richData});

           var fs = new dijit.form.FilteringSelect({
                 id: "dojoBox",
                 value: "Dojo core",
                 store: dojoStore,
                 searchAttr: "name",
                 name: "dojo",
                 labelAttr: "label",
                 labelType: "html"
           }, dojo.byId("dojoBox"));
        });
    </script>

  .. cv:: html

    <input id="dojoBox">



Transforming the displayed value using labelFunc
------------------------------------------------

The labelFunc attribute of FilteringSelect enables you to transform the text that appears in the textbox after the user selects a value from the menu or types in a value manually. labelFunc takes two arguments: a dojo.data item representing the option the user selected and the store the item came from; hence, myLabelFunc will not fire for invalid text. labelFunc is expected to return the text you want to display.

In this example, the FilteringSelect takes a labelFunc attribute pointing to a function named myLabelFunc in the JavaScript. myLabelFunc receives two arguments: a dojo.data item, and the store it came from (FilteringSelects built from OPTION tags automatically generate a store). myLabelFunc returns an all lowercase string that then displays in the FilteringSelect.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.FilteringSelect");
        dojo.require("dojo.data.ItemFileReadStore");
	function myLabelFunc(item, store){
		var label=store.getValue(item, 'name');
		// DEMO: uncomment to chop off a character
		//label=label.substr(0, label.length-1);
		// DEMO: uncomment to set to lower case
		label = label.toLowerCase();
		return label;
	}
        dojo.addOnLoad(function(){
          var stateStore = new dojo.data.ItemFileReadStore({
              url: "http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/_data/states.json"
          });
          dijit.byId("fs").store = stateStore;
        });

    </script>

  .. cv:: html

    <!--stateStore definition omitted; see above examples-->
    <input dojoType="dijit.form.FilteringSelect"
        id="fs"
        value="KY"
        store="stateStore"
        searchAttr="name"
        name="state"
        labelFunc="myLabelFunc">



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

JAWS 8 and Window-Eyes 6 may fail to read an option when it becomes highlighted. In Dojo 1.1 the FilteringSelect was updated so that JAWS 9 will speak "editable combo" when the FilteringSelect gets focus. However, there are some issues reading the highlighted choice. Generally JAWS 9 with Firefox 2 will only speak the part of the word that is currently selected in the textbox. For example, if you are working with a FilteringSelect containing the US state names and you type in an "I" to filter the list of states. If the user arrows down and highlights "Iowa" in the drop down list, "Iowa" will be displayed in the textbox with the "owa" portiion selected. JAWS 9 will speak, "owa" rather than "Iowa". This is not an issue with Firefox 3 and JAWS 9 and JAWS 10.

When using JAWS 10 with IE 8 all of the visible choices in the ComboBox are spoken as you arrow down through the items - the currently focused item is spoken last.  Event the hidden previous choices / more choices options are spoken. This appears to be an issue with IE 8 and list items (which are uses to implement the option choices) and with IE 8 not honoring hidden items.


========
See Also
========

* There's a `DropDown Select <dojox/form/DropDownSelect>`_ widget in the `dojox.form <dojox/form>`_ project that's similar to FilteringSelect but without the search ability. It can support rich text in both the drop down and in a closed state (to display the selected item).
