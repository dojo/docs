.. _dojox/grid/EnhancedGrid/plugins/Filter:

======================================
dojox.grid.EnhancedGrid.plugins.Filter
======================================

:Authors: Oliver Zhu
:Project owner: Evan Huang
:since: V.1.6

Filter plugin provides row filtering functionality for grid.

.. contents ::
    :depth: 2

Introduction
============

Filter is a plugin for dojox.grid.EnhancedGrid. It's designed to filter the grid data with a set of conditions. The grid data have types (number, string, date, time, and boolean) so, accordingly, users are able to specify filters with different conditions for different data types. This plugin not only provides a default client-side implementation, it also defines a simple protocol for server-side filtering to use where the data store is too large to be handled client-side. This plugin is independent of data store, just like grid itself. It only relies on the dojo.data.api.Read interface.

.. code-example::
  :toolbar: themes, versions, dir
  :width: 480
  :height: 500

  .. js ::

        dojo.require("dojo.data.ItemFileWriteStore");
        dojo.require("dojox.grid.EnhancedGrid");
        dojo.require("dojox.grid.enhanced.plugins.Filter");

        var data = {
            identifier: 'id',
            label: 'id',
            items: []
        };
        var data_list = [
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Bette Midler", "Year":2003, "Album":"Bette Midler Sings the Rosemary Clooney Songbook", "Name":"Hey There", "Length":"03:31", "Track":4, "Composer":"Ross, Jerry 1926-1956 -w Adler, Richard 1921-", "Download Date":"1923/4/9", "Last Played":"04:32:49"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Jimi Hendrix", "Year":1993, "Album":"Are You Experienced", "Name":"Love Or Confusion", "Length":"03:15", "Track":4, "Composer":"Jimi Hendrix", "Download Date":"1947/12/6", "Last Played":"03:47:49"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Andy Narell", "Year":1992, "Album":"Down the Road", "Name":"Sugar Street", "Length":"07:00", "Track":8, "Composer":"Andy Narell", "Download Date":"1906/3/22", "Last Played":"21:56:15"},
            {"Heard": true, "Checked": "True", "Genre":"Progressive Rock", "Artist":"Emerson, Lake & Palmer", "Year":1992, "Album":"The Atlantic Years", "Name":"Tarkus", "Length":"20:40", "Track":5, "Composer":"Greg Lake/Keith Emerson", "Download Date":"1994/11/29", "Last Played":"03:25:19"},
            {"Heard": true, "Checked": "True", "Genre":"Rock", "Artist":"Blood, Sweat & Tears", "Year":1968, "Album":"Child Is Father To The Man", "Name":"Somethin' Goin' On", "Length":"08:00", "Track":9, "Composer":"", "Download Date":"1973/9/11", "Last Played":"19:49:41"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Andy Narell", "Year":1989, "Album":"Little Secrets", "Name":"Armchair Psychology", "Length":"08:20", "Track":5, "Composer":"Andy Narell", "Download Date":"2010/4/15", "Last Played":"01:13:08"},
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Frank Sinatra", "Year":1991, "Album":"Sinatra Reprise: The Very Good Years", "Name":"Luck Be A Lady", "Length":"05:16", "Track":4, "Composer":"F. Loesser", "Download Date":"2035/4/12", "Last Played":"06:16:53"},
            {"Heard": true, "Checked": "True", "Genre":"Progressive Rock", "Artist":"Dixie dregs", "Year":1977, "Album":"Free Fall", "Name":"Sleep", "Length":"01:58", "Track":6, "Composer":"Steve Morse", "Download Date":"2032/11/21", "Last Played":"08:23:26"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Black Sabbath", "Year":2004, "Album":"Master of Reality", "Name":"Sweet Leaf", "Length":"05:04", "Track":1, "Composer":"Bill Ward/Geezer Butler/Ozzy Osbourne/Tony Iommi", "Download Date":"2036/5/26", "Last Played":"22:10:19"},
            {"Heard": true, "Checked": "True", "Genre":"Blues", "Artist":"Buddy Guy", "Year":1991, "Album":"Damn Right, I've Got The Blues", "Name":"Five Long Years", "Length":"08:27", "Track":3, "Composer":"Eddie Boyd/John Lee Hooker", "Download Date":"1904/4/4", "Last Played":"18:28:08"},
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Frank Sinatra", "Year":1991, "Album":"Sinatra Reprise: The Very Good Years", "Name":"The Way You Look Tonight", "Length":"03:23", "Track":5, "Composer":"D. Fields/J. Kern", "Download Date":"1902/10/12", "Last Played":"23:09:23"},
            {"Heard": true, "Checked": "True", "Genre":"World", "Artist":"Andy Statman & David Grisman", "Year":1995, "Album":"Songs Of Our Fathers", "Name":"Chassidic Medley: Adir Hu / Moshe Emes", "Length":"04:14", "Track":2, "Composer":"Shlomo Carlebach; Trad.", "Download Date":"2035/2/9", "Last Played":"00:11:15"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Jimi Hendrix", "Year":1968, "Album":"Electric Ladyland", "Name":"Long Hot Summer Night", "Length":"03:27", "Track":6, "Composer":"Jimi Hendrix", "Download Date":"1902/4/7", "Last Played":"16:58:08"},
            {"Heard": true, "Checked": "True", "Genre":"Progressive Rock", "Artist":"Dixie dregs", "Year":1978, "Album":"What if", "Name":"What if", "Length":"05:02", "Track":3, "Composer":"Steve Morse", "Download Date":"1992/3/28", "Last Played":"00:22:30"}
        ];

        var i, len;
        for(i=0, len = data_list.length; i < len; ++i){
            data.items.push(dojo.mixin({'id': i + 1 }, data_list[i % len]));
        }

        var layout = [
            { field: "id", datatype:"number"},
            { field: "Genre", datatype:"string"},
            { field: "Artist", datatype:"string",
                // Declare that we need the ComboBox for suggestions (autoComplete by default)
                autoComplete: true
            },
            { field: "Album", datatype:"string",
                // Declare that we need the ComboBox for suggestions
                autoComplete: true,
                // Configure the ComboBox, so that it does not auto-complete our input
                dataTypeArgs: {
                    autoComplete: false
                }
            },
            { field: "Name", datatype:"string",
                // Declare that we do not need the following conditions for this column
                disabledConditions: ["contains", "notcontains"]
            },
            { field: "Track", datatype:"number"},
            { field: "Download Date", datatype:"date",
                // Declare how the data in store should be parsed to a Date object.
                dataTypeArgs: {
                    datePattern: "yyyy/M/d"
                }
            },
            { field: "Last Played", datatype:"time",
                // Declare how the data in store should be parsed to a Date object.
                dataTypeArgs: {
                    timePattern: "HH:mm:ss"
                }
            }
        ];

        // In case you've close the filter bar, here's a way to bring it up.
        function showFilterBar(){
            dijit.byId('grid').showFilterBar(true);
        }

        dojo.ready(function(){

            var store = new dojo.data.ItemFileWriteStore({data: data});

            var grid = new dojox.grid.EnhancedGrid({
                id: 'grid',
                store: store,
                structure: layout,
                plugins: {
                    filter: {
                        // Show the closeFilterbarButton at the filter bar
                        closeFilterbarButton: true,
                        // Set the maximum rule count to 5
                        ruleCount: 5,
                        // Set the name of the items
                        itemsName: "songs"
                    }
                }
            });
            grid.placeAt('gridContainer');
            grid.startup();
        });

  .. html ::

    <div id="gridContainer" style="width: 100%; height: 400px;"></div>
    <button onclick='showFilterBar()'>Show Filter Bar</button>

  .. css ::

    @import "{{baseUrl}}dojo/resources/dojo.css";
    @import "{{baseUrl}}dijit/themes/claro/claro.css";
    @import "{{baseUrl}}dijit/themes/claro/document.css";
    @import "{{baseUrl}}dojox/grid/enhanced/resources/claro/EnhancedGrid.css";
    @import "{{baseUrl}}dojox/grid/enhanced/resources/EnhancedGrid_rtl.css";


Configuration
=============

Prerequisites
-------------

This filter plugin is only available for EnhancedGrid. Use the following statements in the head of your HTML file:

.. js ::
  
  dojo.require("dojox.grid.EnhancedGrid");
  dojo.require("dojox.grid.enhanced.plugins.Filter");


Plugin Declaration
------------------

The declaration name of this plugin is ``filter`` . It is declared in the ``plugins`` property of grid.

If your grid is created declaratively:

.. html ::

    <div id="grid" data-dojo-type="dojox.grid.EnhancedGrid"
      store="mystore" structure="mystructure"
      plugins="{
        filter: /* a Boolean value or an configuration object */{}
    }" ></div>

If your grid is created in JavaScript:

.. js ::
  
  var grid = new dojox.grid.EnhancedGrid({
    id:"grid",
    store:"mystore",
    structure:"mystructure",
    plugins:{
      filter: /* a Boolean value or an configuration object */{}
    }
  });

As shown in the above code, you can simply set the ``filter`` property to true or false (disabled), or further configure it in an configuration object.

All the available configuration properties are:

=============================  ========  ===============  ================================================================================================================
Property                       Type      Default Value    Description
=============================  ========  ===============  ================================================================================================================
itemsName                      String    "items"          The name of the items in the data store.
                                                          For example, if the data in the store are records of songs, you may set it to "songs",
                                                          so the filter bar will display "10 of 100 songs" instead of "10 of 100 items" when there's some filter applied.
closeFilterbarButton           Boolean   false            Whether to show the close-filterbar button.
ruleCount                      Number    3                The maximum rule count of a filter. Default to 3. If set to 0 or Infinity, infinite rules are supported.
ruleCountToConfirmClearFilter  Number    2                If the filter rule count is larger than or equal to this value, then a confirm dialog will show when
                                                          clearing filter. If set to less than 1 or null, then always show the confirm dialog. If set to Infinity,
                                                          then never show the confirm dialog. Default to 2.
disabledConditions             Object    undefined        Disable some condition for some type or "anycolumn", so the user will not see them in the condition Select box.
isServerSide                   Boolean   false            If this is true, the actual filtering work will be taken over by the server.
                                                          This is used to switch between client-side filter and server-side filter.
isStateful                     Boolean   false            If this is true, and isServerSide is set to true, the filter definition will only be sent when it is defined,
                                                          and it should be remembered at server side until it is changed.
url                            String    ""               When both isServerSide and isStateful are true, this is a place to set the server url,
                                                          if it cannot be retrieved by store.url.
setupFilterQuery               Function  undefined        If you'd like to use a stateless server side filter, you'll have to modify the request object, so as to add in
                                                          the filter definition. The signature of this function is setupFilterQuery(commands, request). See the last
                                                          section for details.
=============================  ========  ===============  ================================================================================================================

Column Configuration
--------------------

Filter provides different conditions for different data types, but the store does not have any information of types. So users should explicitly declare the data types in the structure of grid.
For example:

.. js ::
  
  var structure = [{
    cells:[
      {field: "Name", datatype: "string", autoComplete: true },
      {field: "Age", datatype: "number" },
      {field: "Register Date", datatype: "date" },
      {field: "dummy", filterable: false}, // set this column to be not filterable
      {field: "Register Time", datatype: "time", disabledConditions: ["startsWith", "notStartsWith"]}
    ]
  }];

The following properties are available for column configuration:

====================================  ===================================  ========================================  ============================================================================================
Property                              Type                                 Default Value                             Description
====================================  ===================================  ========================================  ============================================================================================
filterable                            Boolean                              true                                      To set whether this column can be filtered.
datatype                              String                               "string"                                  The data type of this column, determining what conditions could be applied.
autoComplete                          Boolean                              false                                     Only valid for "string" type. If set to true, a ComboBox instead of a TextBox will be used.
disabledConditions                    String[]                             []                                        To disable some conditions for this column. For a full list of condition names, see below.
dataTypeArgs                          Object                               {}                                        A place to put data type specific arguments.
dataTypeArgs(for date/time type)      dojo.date.locale.__FormatOptions     {}                                        Defines how to parse the date/time data shown in the grid.
dataTypeArgs(for boolean type)        Object                               {trueLabel: "True", falseLabel: "False"}  Set the label text for true value or false value.
====================================  ===================================  ========================================  ============================================================================================

Here is a list of all the condition names (case insensitive)

======================    ===================================
Condition Name            Available Data Types
======================    ===================================
equalTo                   number, string, date, time, boolean
lessThan                  number, date, time
lessThanOrEqualTo         number
largerThan                number, date, time
largerThanOrEqualTo       number
contains                  string
startsWith                string
endsWith                  string
notEqualTo                number, string
notContains               string
notStartsWith             string
notEndsWith               string
range                     date, time
isEmpty                   number, string, date, time, boolean
======================    ===================================

Usage
=====

The UI of this plugin consists of 3 components: a filter bar within the grid, a definition dialog, and a status tooltip.

Filter Bar
----------

.. image :: filterbar-1.png

Clicking the button on the filter bar will show the Filter Definition Dialog with a default value of "Any Column".

.. image :: filterbar-definefilterbtn-1.png

Clicking directly on the filter bar will also show the Filter Definition Dialog, but setting the value of the "Column" field to the column that the mouse is over.

.. image :: filterbar-somecolumn-1.png

Hovering over the filterbar for 300 msec will trigger the Filter Status Tooltip.

.. image :: filterbar-showtooltip-1.png

When there's a filter defined, the clear filter button will be shown, and the status tip will look like this:

.. image :: filterbar-clearbtn-1.png

If ``closeFilterbarButton`` is true, there will be a close-filterbar button at the right end of the filter bar.

.. image :: filterbar-closebtn-1.png

When the filter bar is hidden, there is a function to bring it out: ``showFilterBar``

Actually there's a set of APIs related to filterbar:

showFilterBar(toShow, useAnim, animArgs):
    Show/Hide filter bar

==============  ==================  ==========================  =============================================
Arguments       Type                Optional/Mandatory          Description
==============  ==================  ==========================  =============================================
toShow          Boolean             Mandatory                   To show or to hide
useAnim         Boolean             Optional(default to true)   When showing/hiding, whether to use animation.
animArgs        dojo.__AnimArgs     Optional                    Customized animation properties.
==============  ==================  ==========================  =============================================

toggleFilterBar(useAnim, animArgs):
    Toggle the filter bar. Will call ``showFilterBar``. Please refer to the useAnim/animArgs arguments for showFilterBar method.

isFilterBarShown():
    Check the visibility of filter bar. Return boolean.


Filter Definition Dialog
------------------------

.. image :: defdialog.png

The Filter Definition Dialog is designed to define filter conditions with either of the following structures:

1. [rule 1 for column A] and [rule 2 for column B] and [rule 3 for column C]

2. [rule 1 for column A] or [rule 2 for column B] or [rule 3 for column C]

.. image :: defdialog-rulerelation.png

Use the "Add Rule" button to add a rule. If there are already 3 rules, this button will be disabled.
Every rule is regarded as a simple sentence with the following structure:

``[Column] [Condition Verb] [Value]``

For example: ``Column "Age", "is less than", 26``

Different data types have different sets of conditions and different kinds of form widgets.

The value field for Number type only accepts number.

.. image :: defdialog-numbervaluebox-1.png

The value field for String type can have auto-complete capability (if set autoComplete in the grid structure).

.. image :: defdialog-stringvaluebox.png

DateTextBox and TimeTextBox are used for Date and Time types, respectively.

.. image :: defdialog-timevaluebox.png

And the ``range`` condition for ``date`` and ``time`` types represents a closed range.

.. image :: defdialog-rangevaluebox.png


Filter Status Tooltip
---------------------

.. image :: statustooltip-multirule.png

When a filter exists, the Filter Status Tooltip shows every rule of the current filter. If there are multiple rules, you can delete some of them by clicking the red 'X' at the right side of every rule.


Introduction to Server-Side Filtering
=====================================

If the store is too big to perform efficient client-side filtering, you can implement your own server-side filter logic along with your data store implementation.

To enable server-side filtering, just set the ``isServerSide`` property to true.

Basic Protocol
--------------

By default, the server side is assumed to be stateless (REST style). In this case, you should send the filter definition to server side along with the fetch request of the store.
You can do this by modifying the request object every time before store.fetch is called.

For example:

.. js ::
  
  var grid = new dojox.grid.EnhancedGrid({
    id:"grid",
    store:"mystore",
    structure:"mystructure",
    plugins:{
      filter: {
        isServerSide: true,
        setupFilterQuery: setupFilter
      }
    }
  });
  var setupFilter = function(commands, request){
    // the commands object here is the same as the POSTed commands object for stateful server, see below.
    if(commands.filter && commands.enable){
      // some filter is defined and valid. You can modify the request object here.
    }else{
      // no filter is valid.
    }
  };

Thus the filter definition will be sent to the server along with the request.
  
If you'd like to use a stateful server, which means the filter definition will only be sent when it is defined, and it should be remembered at serverside until it is changed, you can set the **isStateful** property:

.. js ::
  
  var grid = new dojox.grid.EnhancedGrid({
    id:"grid",
    store:"mystore",
    structure:"mystructure",
    plugins:{
      filter: {
        isServerSide: true,
        isStateful: true
      }
    }
  });

Then the filter store layer will send the commands via POST before normal store fetch. There are at most 4 fields in this posted data:

==========  ===========  =================  ===================  ==========================================================================================================
Name        Data Type    Always Available   Value For Example    Description
==========  ===========  =================  ===================  ==========================================================================================================
cmdlayer    String       Yes                "filter"             The name of the current store layer. In this case, it's always "filter".
enable      Integer      Yes                true                 A command to enable/disable the current store layer (in this case, the filter layer).
                                                                 If it is false, the server-side should not filter the data. This field is always valid.
clear       Boolean      No                 true                 Only meaningful for stateful server. A command to clear the filter definition.
                                                                 When this field exists and equals to true, it means the user has cleared the filter,
                                                                 so the server should return unfiltered data in later fetches.
                                                                 This field should not co-exist with the "filter" field.
                                                                 If they both exist, the "filter" field has higher priority
filter      JSON String  No                 {...}                A command to set the filter definition.
                                                                 When this field exists, it means the user has defined a new filter,
                                                                 so the server should re-filter the data using this new filter, and return filtered data in later fetches.
                                                                 This field should not co-exist with the "clear" field. If they both exist, this field has higher priority.
==========  ===========  =================  ===================  ==========================================================================================================

When the web page loads, the first POST that the server receives is the ``clear`` command. It ensures that there's no filter defined in the session.

Every time the user defines a filter, the server will receive a ``filter`` command. This command contains a JSON string representing the filter definition, which is covered in the next section.

After receiving the filter command, the server should respond with the count of filtered rows in this format:

.. js ::
  
  200,1000

The first number is the count of the filtered rows, while the second is the total count of rows in store.

Note that stateless servers don't need to do this, because the filter definition is sent together with the fetch arguments.


The Filter Definition
---------------------

The Filter plugin will create a JSON object for the defined filter with the following recursive structure:

.. image :: serverfilter-datastruct.png

This structure represents an expression, which consists of operators and operands (data). The operands can further contain expressions, that is, deeper level of operators and operands.

All available properties in this filter definition JSON are listed below:

=====  ==========  =================  ==================  =====================================================================================================================================
Name   Data Type   Always Available   Value For Example   Description
=====  ==========  =================  ==================  =====================================================================================================================================
op     String      Yes                "equal"             The name of an operator or a data type. Currently supported operators are:
                                                          and | or | not | all | any | equal | less | lessEqual | larger | largerEqual | contains | startsWith | endsWith
                                                          Currently supported datatypes are:
                                                          string | number | date | time | boolean
data   Object      Yes                {...}               The data of the corresponding "op".
                                                          If "op" is actually an operator, this field must be an array, which contains a list of deeper level filter expressions.
                                                          If "op" is a data type, and there is no "isCol" field, this "data" field is a value of this type.
isCol  Boolean     No                 true                If "op" is a datatype, and the property "isCol" is true, this "data" field represents the field name of a column in the data store,
                                                          so the server implementer can get the value of this field, and transform it to the specified datatype.
=====  ==========  =================  ==================  =====================================================================================================================================


So the JSON object is nothing more than an object with 2 fields: ``op`` and ``data``. For example, The following filter definition means:

The data of the "Field Name" column, whose data type is string, equals to "some message".

.. js ::
  
  {
    // op: String
    // The name of an operator or a data type. Currently supported operators are:
    //  and | or | not | all | any | equal | less | lessEqual | larger | largerEqual | contains | startsWith | endsWith
    // Currently supported datatypes are:
    //  string | number | date | time
    op: "equal",
    
    // data: Array | string | number
    // The data of the corresponding "op". If "op" is actually an operator, this field must be an array,
    // which contains a list of deeper level filter expressions.
    data: [
      {
        op: "string",
        
        // data: Array | string | number
        // If "op" is a datatype, and there is no "isCol" field, this "data" field is a value of this type.
        data: "some message"
      },
      {
        op: "string",
        
        // isCol: Boolean
        // If this field exists and is, or can be converted to, true,
        // then this expression represents a column in the store,
        // and the corresponding "data" field represents the field name of this column.
        isCol: true,
        
        // data: Array | string | number
        // If "op" is a datatype, and the property "isCol" is true,
        // this "data" field represents the field name of a column in the data store,
        // so the server implementer can get the value of this field, and transform it to the specified datatype.
        data: "Field Name"
      }
    ]
  }

Supported Operators
-------------------

Here is a summary of all supported operators used in filter definition. The "Name" of each operator is passed as the ``op`` field in the filter definition.

===========  ====================================  =======================  ================================================================================
Name         Valid Data Types                      Number of Operands       Meaning
===========  ====================================  =======================  ================================================================================
and          boolean                               2                        Logic AND
or           boolean                               2                        Logic OR
not          boolean                               1                        Logic NOT
all          boolean                               1 ~ ruleCount            A general version of "and"
any          boolean                               1 ~ ruleCount            A general version of "or"
equal        string, number, date, time, boolean   2                        The value of 2 operands are equal
less         number, date, time                    2                        The value of the 1st operand is less than that of the 2nd operand
lessEqual    number                                2                        The value of the 1st operand is less than or equal to that of the 2nd operand
larger       number, date, time                    2                        The value of the 1st operand is larger than that of the 2nd operand
largerEqual  number                                2                        The value of the 1st operand is larger than or equal to that of the 2nd operand
contains     string                                2                        The value of the 1st operand contains that of the 2nd operand
startsWith   string                                2                        The value of the 1st operand starts with that of the 2nd operand
endsWith     string                                2                        The value of the 1st operand ends with that of the 2nd operand
isEmpty      string, number, date, time, boolean   1                        The value is empty
===========  ====================================  =======================  ================================================================================


See Also
========

* :ref:`dojox.grid.DataGrid <dojox/grid/DataGrid>` - The base grid
* :ref:`dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>` - The enhanced grid supporting plugins
* :ref:`dojox.grid.EnhancedGrid.plugins <dojox/grid/EnhancedGrid/plugins>` - Overview of the plugins of enhanced grid
* :ref:`dojox.grid.TreeGrid <dojox/grid/TreeGrid>` - Grid with collapsible rows and model-based (:ref:`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`) structure
