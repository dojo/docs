.. _dojox/calendar:

==============
dojox.calendar
==============

.. image :: calendar/columnView.png

dojox.calendar allows to display events in time and edit them.

.. contents ::
  :depth: 3

Introduction
=============

The dojox calendar widget displays events from a data store, and has several standard visual representations that allow the user to interactively edit the position the time and duration of these events.

**Note**: On supported versions of Internet Explorer, a standard doctype must be set on the page that includes the calendar for the calendar to be supported (see http://www.w3.org/QA/2002/04/valid-dtd-list.html).

**Terminology:** The "event" word can be interpreted in several ways in a calendar application context. So in this documentation we will use the following words to prevent confusion:
   * **data item**: item from the data store. A data item is the data representation of an event (e.g. Meeting at 9am to 10am).
   * **event**: Event dispatched by a widget or a DOM node.
   * **event listener** or **event handler**: Function registered on a particular event which is invoked when this event is dispatched by a widget or a DOM node.
   * **item renderer**: graphical representation of a data item.

**Important**: the DOM node that contains the calendar widget or a view widget **must** have a position style property set to "absolute" or "relative".

Creating a Calendar
===================

The calendar widget is available on the dojox.calendar package.

First you need to include the dojox Calendar theme by including the `dojox/calendar/themeName/Calendar.css` file
(one of `claro`, `tundra`, `nihilo`, or `soria`):

.. html ::

    <link rel="stylesheet" href="dojo/dojox/calendar/themes/claro/Calendar.css" />

Then, add a theme class name to the parent <body> element, like:

.. html ::

  <body class="claro">

It is recommended you include the theme CSS file **before** ``dojo.js`` to avoid any potential race conditions
where widgets start rendering before the theme has finished loading.

The skeleton of an application is like:

.. html ::

  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
	"http://www.w3.org/TR/html4/strict.dtd">
  <html>
  <head>
      <link rel="stylesheet" href="lib/dojox/calendar/themes/claro/Calendar.css">
      <script src="lib/dojo/dojo.js"></script>
      <script type="text/javascript">
        require(["dojox/calendar/Calendar"], function(Calendar){
          // javascript code
        });
      </script>
  </head>
  <body class="claro">
    <!-- html code -->
  </body>
  </html>


You can create a calendar widget either with markup or programmatically.

The following example shows how to declare a calendar widget in markup:

.. code-example::
  :width: 620
  :height: 620

  .. js ::

    require(["dojo/ready", "dojox/calendar/Calendar"]);

  .. html::

    <style type="text/css">
      .dojoxCalendar{ font-size: 12px; font-family:Myriad,Helvetica,Tahoma,Arial,clean,sans-serif; }
    </style>

    <div data-dojo-type="dojox/calendar/Calendar"
         data-dojo-props="dateInterval:'day'"
         style="position:relative;width:600px;height:600px">
    </div>


The following example shows how to declare a calendar widget programmatically:

.. code-example::
  :width: 620
  :height: 620

      .. js ::

      require(["dojo/parser", "dojo/ready", "dojox/calendar/Calendar"],
        function(parser, ready, Calendar){
          ready(function(){
            calendar = new Calendar({
                         dateInterval: "day",
                         style: "position:relative;width:600px;height:600px"
                      }, "someId");
                    }
                )}
        );

  .. html::

    <style type="text/css">
      .dojoxCalendar{ font-size: 12px; font-family:Myriad,Helvetica,Tahoma,Arial,clean,sans-serif; }
    </style>

    <div id="someId" >
    </div>

Configuring Calendar data
=========================

The calendar widget is populated with a list of data items using a store set on its store property.

The Calendar can connect to any implementation of the `dojo.store.api.Store` interface that implements get/query and id management (getIdentity). **A data item must have an unique identifier.**

If the Calendar is displaying live data (ie. data that can be edited by the Calendar itself or data that can change outside of the Calendar), the store must be a `dojo.store.Observable`.

Manage store errors
-------------------

You might want to listen to store query errors, for that you can use the promise returned by the store setter:

.. js::

  require(["dojox/calendar/Calendar", "dojo/_base/Deferred", ..], function(Calendar, Deferred, ...){
    var calendar= new Calendar(...);
    Deferred.when(calendar.set("store", mystore), function onOk() {}, function onFail() {});
  });


Data mapping
------------

In order to display the data items, the widget must determine for each data item its start and end time.
It will look by default at the "startTime" and "endTime" properties.


.. js ::

  var someData = [
    {
      id: 0,
      summary: "Event 1",
      startTime: new Date(2012, 0, 1, 10, 0),
      endTime: new Date(2012, 0, 1, 12, 0)
    }
  ];

  calendar = new Calendar({
    date: new Date(2012, 0, 1),
    store: new Observable(new Memory({data: someData})),
    dateInterval: "day",
    style: "position:relative;width:500px;height:500px"
  }, "someId");


The property names can be configured by setting the "startTimeAttr" and "endTimeAttr".

.. js ::

  var someData = [
    {
      id: 0,
      summary: "Event 1",
      begin: new Date(2012, 0, 1, 10, 0),
      end: new Date(2012, 0, 1, 12, 0)
    }
  ];

  calendar = new Calendar({
    date: new Date(2012, 0, 1),
    startTimeAttr: "begin",
    endTimeAttr: "end",
    store: new Observable(new Memory({data: someData})),
    dateInterval: "day",
    style: "position:relative;width:500px;height:500px"
  }, "someId");

The value retrieved can be a date directly usable by the calendar or must converted into a date.
Since Dojo 1.9, the calendar uses Date instances or directly converts from ISO format in a similar way than the following example.

In the latter case, the **decodeDate()** and **encodeDate()** functions must be set to respectively decode the object into a date and encode the date into a custom object after an editing.

In the following example, the date ISO format is used in the model to communicate with a distant server.
The decodeDate() will allow the calendar to manipulate Date instances.
The encodeDate() will allow to sent back a date in the ISO format after a data item editing.

.. js ::


 var someData = [
   {
     id: 0,
     summary: "Event 1",
     startTime: "2012-01-01T10:00",
     endTime: "2012-01-01T12:00"
   }
 ];

 calendar = new Calendar({
   date: new Date(2012, 0, 1),
   decodeDate: function(s){
     return stamp.fromISOString(s);
   },
   encodeDate: function(d){
     return stamp.toISOString(d);
   },
   store: new Observable(new Memory({data: someData})),
   dateInterval: "day",
   style: "position:relative;width:500px;height:500px"
 }, "someId");


In addition to the start and end time, a summary is retrieved on the data item, by default using the "summary" property name (use summaryAttr property to change the property name).


The data item can also be flagged "all day". An all-day data item represents a particular event that spans over one or several days and that starts at the beginning of a day to finish at the beginning of another day.

    All-day data items can be displayed differently: for example by default they are displayed in the secondary sheet of a column view. The editing behavior of an all-day data item is also different to keep the all-day constraint.
    The calendar looks at the "allDay" property of a data item to determine if it is an all day or not (boolean value expected). The property name can be configured by setting the allDayAttr property.


Time range definition
=====================

The displayed time range can be defined in two ways:
  * Set date, dateInterval, dateIntervalSteps properties,
  * Or set startDate and endDate properties.

The date property defines the reference date.

The dateInterval property defines the interval (day, week, month) and dateIntervalSteps the number of intervals.

So, depending on the value of dateInterval, if ‘n’ is the dateIntervalSteps value, the time range will be:
  * **"day"** - n days from the reference date,
  * **"week"** - n week from the first day of week that contains the reference date,
  * **"month"** - n months from the first day of the month that contains the reference date.

The following example shows how to display 2 weeks, whose first week contains the 1st of January 2012.

.. html ::

  <div data-dojo-type="dojox/calendar/Calendar"
       data-dojo-props="date: new Date(2012, 0, 1), dateInterval:'week', dateIntervalSteps:2"
       style="position:relative;width:500px;height:500px"></div>

When using the definition using the startDate and endDate properties, the date property must be explicitly null.
The time of day of these date are not taken into account and the date defined by endDate is included in the time range.


The following example shows how to define the time range from the 1st of January 2012 to the 9th of January 2012.

.. html ::

  <div data-dojo-type="dojox/calendar/Calendar"
       data-dojo-props="startDate: new Date(2012, 0, 1), endDate: new Date(2012, 0, 9)"
       style="position:relative;width:500px;height:500px"></div>


To the limit the time range, set the **minDate** and/or **maxDate** properties.

The behavior depends on the properties used to define the time range.

  * date properties is set:

    * minDate: The date that defines the minimum time range in the past,
    * maxDate: The date that defines the maximum time range is the future.

  * date is not set, startDate and endDate are used:

    * minDate: The minimum value of the startDate property,
    * maxDate: The maximum value of the endDate property.



Styling renderers
=================

A CSS class can be specified for each data item to be applied to the renderers for this particular event. Set the cssClassFunc function that returns the CSS class name for a data item.

For example, we can use this feature to change the color of an item renderer depending on a calendar property of the data item as displayed in the following example:

.. css ::

  .claro .dojoxCalendarEvent.Calendar1 .bg {
    background-color: #00AA00;
  }
  .claro .dojoxCalendarEvent.Calendar1.Hovered .bg {
    background-color: #00FF00;
  }
  .claro .dojoxCalendarEvent.Calendar1.Selected .bg {
    background-color: #004400;
  }
  .claro .dojoxCalendarEvent.Calendar2 .bg {
    background-color: #0000AA;
  }
  .claro .dojoxCalendarEvent.Calendar2.Hovered .bg {
    background-color: #0000FF;
  }
  .claro .dojoxCalendarEvent.Calendar2.Selected .bg {
    background-color: #000044;
  }

.. js ::

  var someData = [
    {
      id: 0,
      summary: "Event 1",
      startTime:  new Date(2012,0, 1, 10),
      endTime: new Date(2012,0, 1, 12),
      calendar: "Calendar1"
    },
    {
      id: 1,
      summary: "Event 2",
      startTime:  new Date(2012,0, 1, 14),
      endTime: new Date(2012,0, 1, 15),
      calendar: "Calendar2"
    }
  ];

  calendar = new Calendar({
    date: new Date(2012, 0, 1),
    cssClassFunc: function(item){
      return item.calendar;
    },
    store: new Observable(new Memory({data: someData})),
      dateInterval: "day",
      style: "position:relative;width:500px;height:500px"
  }, "someId");

.. image :: calendar/cssClassFunc.png

For further customization, custom item renderers can be created. See dedicated section of advanced configuration.

Views
=====

By default the calendar embeds two views:
  * the columns view for time ranges that last from one day to seven days.
  * the matrix view for time ranges that last more than seven days.

Another optional view is the month columns view that can be used to display one or several entire months.

See Advanced configuration to change this behavior.

Columns View
------------

.. image :: calendar/columnView.png

The columns view displays one column per day.

It view is made of two sheets:
  * A main sheet that shows all non all-day data items vertically.
  * A secondary sheet that displays, by default, all-day data items horizontally.

See Advanced configuration section to see how to change this behavior.

This view is accessible through the **columnView** property of  the calendar widget.

The main properties of the columns view are:
  * **startDate** * - The date of the first column,
  * **columnCount** * - The number of columns to display,
  * **minHours** - The first hour displayed by the main sheet,
  * **maxHours** - The last hour displayed (excluded),
  * **hourSize** - The desired size in pixels of one hour,
  * **timeSlotDuration** - The duration of minutes of the time slot (must be a divisor of 60),
  * **subColumns** - The definition of sub columns (See Advanced configuration).
  * **minColumnWidth** - The minumum width in pixels of a column (or a sub column if sub columns are set).

    * If set -1, the columns fill the width of the calendar.
    * If set to a fixed value and if there's not enough room to show the columns using this minimum width, the view becomes scrollable horizontally. Otherwise, the columns fill the width of the calendar.

Properties with an (*) are computed by the calendar widget.

See Advanced configuration for more advanced properties like layout properties and renderers.

To specify constructor parameters of the column view, set the columnViewProps property as show in the following example:

.. html ::

  <div data-dojo-type="dojox/calendar/Calendar"
       data-dojo-props="dateInterval:'day',columnViewProps:{minHours:6}"
       style="position:relative;width:500px;height:500px"></div>

The time of day displayed is defined by the minHours (8 by default) and maxHours (18 by default) properties. For example to show the entire day set minHours to 0 and maxHours to 24.

MinHours value must be in [0, 23] range and maxHours in the [1, 36] range.
To display a night working time, set minHours to 20 (8pm) and maxHours to 32 (8am, next day).

Note: The ColumnView can be replaced by the SimpleColumnView widget which is a columns view without the secondary sheet. See advanced configuration to see how to use this alternate view.

Matrix View
-----------

.. image :: calendar/matrixView.png

The matrix view displays a matrix in which each day is a cell. Time flows horizontally.

This view is accessible through the **matrixView** property of  the calendar widget.

The main properties of the columns view are:
  * **startDate** * - The date of the first cell,
  * **rowCount** * - The number of rows to display,
  * **columnCount** * - The number of columns to display,
  * **refStartTime** - (optional) Start time of the time range of interest,
  * **refEndTime** - (optional) end time of the time range of interest,
  * **expandDuration** - Duration in milliseconds of the row expand animation,
  * **expandEasing** - Easing of the row expand animation

Properties with an (*) are computed by the calendar widget.

See advanced configuration dedicated section for more advanced properties like layout properties and renderers.

To specify constructor parameters of the matrix view, set the matrixViewProps property as show in the following example:

.. html ::

  <div data-dojo-type="dojox/calendar/Calendar"
       data-dojo-props="matrixViewProps:{expandDuration:0}"
       style="position:relative;width:500px;height:500px"></div>


Overlapping item renderers are stacked vertically.

Sometimes there is not enough room to show all item renderers. In that case, an expand renderer (by default an arrow) is displayed at the bottom of the cell to indicate that some item renderers are not visible.

The matrix view is able to expand a row to see more events.

By default the calendar uses this feature when an expand renderer is clicked or when a row header cell is clicked.

.. image :: calendar/expandRenderer.png

In the following image the first row is expanded:

.. image :: calendar/matrixViewExpanded.png

Month Columns View
------------------

.. image :: calendar/monthColumnView.png

The month columns view displays one column per month.

This view is not in the calendar by default. See tests/ExtendedCalendar sample class and Advanced configuration for more information.

The main properties of the columns view are:
  * **startDate** * - The date of the first column,
  * **columnCount** * - The number of columns to display,
  * **daySize** - The desired size in pixels of one day.

Properties with an (*) are computed by the calendar widget.

By default, this view uses vertical item renderers to show all-day data items and data items longer than one day.

If a day contains one or several hidden data items (i.e. short data items by default), a decoration is displayed on the grid cell.

.. image :: calendar/monthColumnViewHidden.png


See Advanced configuration for more advanced properties like layout properties and renderers.


Interactions
============

There are two widget classes:
   * Calendar: allows mouse and keyboard interactions,
   * MobileCalendar: allows touch interactions.

For advanced development, views (see class diagram) can be mixed with Mouse and Keyboard or Touch classes to enable respective interactions.

Selection
---------

Properties
``````````

The selectionMode property controls the selection, this property can take the following values:
  * **"none"** - no selection is possible.
  * **"single"** - only one item can be selected at most.
  * **"multiple"** - zero or several items can be selected.

The selectedItems property contains the list of selected items from the data store.

The selectedItem property contains the last selected item.

These last two properties can read as well as programmatically set.

Using the mouse
```````````````

To select a data item, simply click on an item renderer.

To deselect a data item, press the control key and click on an item renderer.

If the selection mode is "multiple", you can extend the selection or deselect a data item by pressing the control key and click on an item renderer.

Using the keyboard
``````````````````

If the calendar widget has the focus, press the left or right arrow keys to select a data item.

To move only the focus on a data item and not select it at the same time, press left or right arrow keys while holding the control key.

To deselect a data item or extend selection (if selection mode is "multiple"), move the focus to an item renderer and press the space bar while holding the control key.

Using a touch device
````````````````````

To select a data item, simply tap on it.

Data item editing
-----------------

The calendar widget allows to move and resize a data item.

Only one data item can be edited at a time.

Note: for more information on data item editing behavior and events, See dedicated section of advanced configuration: `Editing flags`_

Using the mouse
```````````````

To move a data item, press the mouse button over the body of an item renderer, drag the event at the desired position and release the mouse button.

To resize a data item, press the mouse button over the start or end of an item renderer, drag it to the desired position and release the mouse button.

If you press the escape key while editing a data item, the editing gesture will be canceled.

Using the keyboard
``````````````````

If a data item has the focus (see selection section), press the enter key to edit it.

In editing mode:

  * press the arrow keys to move the data item,
  * press the up or down arrow keys while holding the control key to resize it by moving the end of this data item.
  * press the enter key to validate the changes and leaving the edit mode.
  * press the escape key to cancel the changes and leaving the edit mode.

Using a touch device
````````````````````

To enter in edit mode press an item renderer for a small amount of time, until the it visually change its state.

In editing mode:

  * press and move the body of the item renderer to move the event.
  * press and move one (or both) of the resize areas to resize the data item.
  * tap out of the item renderer to validate the changes and leave the edit mode.


Navigation buttons
------------------

.. image :: calendar/buttonBar.png

By default the calendar template defines 7 buttons to navigate in time.

========== ======
Button     Action
========== ======
Previous   Go the previous time range. For example if four days are displayed, show the four previous days.
Next       Go to the next time range. For example if four days are displayed, show the four next days.
Today      Show the current day.
Day        Shows the day defined by the "date" property or the current day if the date property is null.
Four days  Shows four days from the the day defined by the day property of  the current day if the date property is null.
Week       shows the week that contains the day defined by the "date" property.
Month      shows the month that contains the day defined by the "date" property.
========== ======

The following functions are also exposed to help navigation:

  * nextRange(): show next time range.
  * previousRange(): show previous time range.
  * goToday(): show the current day.

These buttons and methods are just shortcuts that define the date, dateInterval and dateIntervalSteps properties.

Interactive data item creation
------------------------------

Data items are retrieved in the data store. To programmatically add a new data item, the developer can use the store add() method (and *remove()* to delete it). If the store is an dojo.store.Observable store, the Calendar will automatically update its rendering.

The calendar lets you to interactively create a data item by pressing the mouse button on the grid and dragging the mouse to set the duration of the event.

Since Dojo 1.9, this interactive creation works with asynchronous stores, with the newly created data item being added at the end of the gesture.

To enable the creation, the createOnGridClick property of the calendar must be set to true (false by default).
Furthermore, a custom function creating the data item must be set on the createItemFunc property.

This custom function takes four arguments:
   * The current view,
   * The date of the clicked location,
   * The mouse event.
   * The sub column (Column view only, can be null)

The following example shows an implementation of `createItemFunc` that creates a data item if and only if the control key only is pressed during the interaction. The created event's initial position and duration depends on the current view.

.. js ::

  var createItem = function(view, d, e, subColumn){

    // create item by holding control key
    if(!e.ctrlKey || e.shiftKey || e.altKey){
      return;
    }

    var start, end;
    var colView = calendar.columnView;
    var cal = calendar.dateModule;

    if(view == colView){
      start = calendar.floorDate(d, "minute", colView.timeSlotDuration);
      end = cal.add(start, "minute", colView.timeSlotDuration);
    }else{
      start = calendar.floorToDay(d);
      end = cal.add(start, "day", 1);
    }

    var item = {
      id: id,
      summary: "New event " + id,
      startTime: start,
      endTime: end,
      allDay: view.viewKind == "matrix"
    };

    id++;

    return item;
  }

  calendar.set("createOnGridClick", true);
  calendar.set("createItemFunc", createItem);


No identifier use case
``````````````````````

If the data item return by the createItemFunc does not have an identifier, the calendar will create a temporary one internally to be able to manage this data item.

During the addition in the store, an identifier must be assigned to this data item. The calendar must be able to link the temporary identifier to the real one. The data item must contain the **temporaryId** property to make this link and clean its internal state. An implementation is to subclass the store like in the following example.

.. js ::

  var ExtJsonStore = declare(JsonRest, {
    add: function(object, options){
      var tempId = options && options.temporaryId;
      var def = new Deferred();
      when(this.inherited(arguments), function(item){
        item.temporaryId = tempId;
        def.resolve(item);
      });
      return def;
    }
  });

The calendar is not changing the data item so it uses the options to pass the temporary identifier.

Calendar events
===============

The calendar is the source of specific events.

The following table is listing these events:

======================= ============================================================ ===================== ===========
Event                   Description                                                  Main Properties       Mobile support
======================= ============================================================ ===================== ===========
itemClick               An item renderer of an event has been clicked                item                  Yes
itemDoubleClick         An item renderer of an event has been double-clicked         item                  Yes
itemRollOver            The mouse cursor has entered in an item renderer             item                  No
itemRollOut             The mouse cursor has left in an item renderer                item                  No
itemContextMenu         An item renderer event has been context-clicked              item                  No
gridClick               The grid (background of the calendar) has been clicked       date                  Yes
gridDoubleClick         The grid has been double-clicked                             date                  Yes
change                  The data item selection has changed                          item                  Yes
rowHeaderClick          (Matrix view) a cell of the row header has been clicked      index, date           Yes
expandRendererClick     (Matrix view) an expand renderer has been clicked            rowIndex, columnIndex Yes
onExpandAnimationEnd    (Matrix view) an expand or collapse row animation has ended  null                  Yes
columnHeaderClick       (Column views) a cell of the column header has been clicked  index, date           Yes
onItemEditBegin         The calendar enters into editing mode                        item                  Yes
onItemEditBeginGesture  An editing gesture of data item begins                       item,editKind         Yes
onItemEditMoveGesture   A data item is being moved                                   item                  Yes
onItemEditResizeGesture	A data item is being resized                                 item                  Yes
onItemEditEndGesture    An editing gesture has been finished                         item, editKind        Yes
onItemEditEnd           The calendar leaves editing mode                             item, completed       Yes
======================= ============================================================ ===================== ===========

Note: The change event is different than the itemClick event:
  * A change event with a null item value is sent if the grid is clicked.
  * If an already selected data item is clicked the change event is not dispatched but the itemClick event is.

To react on a calendar event use the on() method to register a listener as shown in the following event:

.. js ::

  calendar.on("itemClick", function(e){
    console.log("Item clicked", e.item.summary);
  });


Advanced configuration
======================

Class diagram
-------------

.. image :: calendar/MainCalendarDiagram.png


======================== ===========
Class                    Description
======================== ===========
ViewBase                 The base class of calendar views.
CalendarBase             The base calendar class that manages a set of calendar views and exposes time range definition properties.
Calendar                 The desktop specific calendar that defines a column view and a matrix view with keyboard and mouse interactions enabled and default renderers
MobileCalendar           The mobile specific calendar that defines a column view and a matrix view with touch interactions enabled and specific default renderers.

======================== ===========



.. image :: calendar/ViewCalendarDiagram.png



======================== ===========
Class                    Description
======================== ===========
MatrixView               The view that displays days as a matrix of days.
SimpleColumnView         The view that displays each day as a column.
ColumnView               A SimpleColumnView with a secondary sheet that shows all-day events.
ColumnViewSecondarySheet A MatrixView designed to be integrated as a secondary sheet of a ColumnView.
MonthColumnView          The view that displays each month as a column.
Mouse                    A mixin that enables interactions on events using the mouse.
Keyboard                 A mixin that enables interactions on events using the keyboard.
Touch                    A mixin that enables interactions on events using the touch events
_RendererMixin           Base class of item renderers.
VerticalRenderer         The default item renderer class of vertical renderers used in columns view main sheet.
MobileVerticalRenderer   The default vertical item renderer class for mobile environment.
HorizontalRenderer       The default item renderer class of horizontal renderers used in matrix view and in columns view secondary sheet.
MobileHorizontalRenderer The default horizontal item renderer class for mobile environment.
LabelRenderer            The default item renderer class for labels used in matrix view.
======================== ===========

Calendar
--------


Calendar views animations
`````````````````````````

On modern browsers, the calendar performs an animation when:
   * The displayed time interval changes and/or
   * The current view changes to display the time interval.

To disable this animation set the calendar animateRange property to false (true by default).

To change the duration of the animation set the animationRangeDuration property (400 by default).

For advanced customization, subclass the _animateRange() method to implement your own animation.

View management
```````````````

The default views are created in the _createDefaultViews() function.
To specify the views to use instead of the default views, set the views property.

The view switching is determined according to the displayed time interval.

The calendar goes through the following steps:

  * One or several properties that are defining the displayed time range are changed,
  * The new displayed time interval is computed,
  * The _computeCurrentView() function is called to determine which view should be used to properly display the time range.
  * The view is configured (setting startDate, columnCount etc) in the _configureView() function.
  * If the current view has changed, show the new view.

You can override these key function change the current and/or change the configuration of this view.

The following example shows the creation of custom views and a change the default view to display two weeks:

.. js ::

  var secondarySheetClass = declare([ColumnViewSecondarySheet, CalendarKeyboard, CalendarMouse]);

  var colView = declare([ColumnView, Keyboard, Mouse])({
    secondarySheetClass: secondarySheetClass,
    secondarySheetProps: {
      horizontalRendererHeight: 16
    },
    verticalRenderer: VerticalRenderer,
    horizontalRenderer: HorizontalRenderer,
    expandRenderer: ExpandRenderer
  });

  var matrixView = declare([MatrixView, Keyboard, Mouse])({
    horizontalRenderer: HorizontalRenderer,
    labelRenderer: LabelRenderer,
    expandRenderer: ExpandRenderer,
    verticalGap:4
  });

  var calendar = new CalendarBase({
    views: [colView, matrixView],
    columnView: colView,
    matrixView: matrixView,
    _computeCurrentView: function(startDate, endDate, duration){
      return duration <= 14 ? this.views[0] : this.views[1];
    },
    dateInterval: "week",
    dateIntervalSteps: 2
  }, "calendarNode");

Right-to-left
-------------

See http://dojotoolkit.org/reference-guide/quickstart/internationalization/bi-directional-text.html

To have a correct rendering in right-to-left display, you must import the calendar_rtl.css file in addition to the calendar.css file.

Bidi
----

The calendar is also supporting the "textDir" property.

Enable bidi in dojo config and set the "textDir" property to “rtl”, “ltr” or “auto” to set the contextual text direction.

.. html ::

	<script type="text/javascript"
		data-dojo-config="has: { 'dojo-bidi': true }"
		src="../../../dojo/dojo.js"></script>



Alternate calendars
-------------------

The calendar uses, by default, the Gregorian calendar to display time. However, alternate calendars defined in dojox.date package can be set on the calendar.

In the constructor, set the datePackage to change the calendar. Remember to use the corresponding date object in the input data store.

The following example shows to how to set the Hebrew calendar:

.. js ::

new Calendar({datePackage: "dojox.date.hebrew"}, "calendarNode");

Date/time formatting
--------------------

The displayed dates labels are formatted using dojo formatters. If no specific calendar is specified the dojo.date.locale object is used (formatting Gregorian calendar dates), otherwise it is the dojox.date.XXXX.locale (for other calendars).

The formatter uses the CLDR (http://cldr.unicode.org/) to determine according to the current locale the correct date format to use and how to properly format the date.

The date format patterns can be specified by setting view specific properties or functions defined in following view sections.

**See specific view section for a list of available date/time format properties of this view.**

The calendar exposes an formatItemTimeFunc property allowing to format the time displayed on renderers.

For example for a gregorian calendar, in en_US locale and default format length, a time label is formatted like that: “10:00 AM” or “8:15 AM”.

We can define a function to have a more compact display:

.. js ::

  new Calendar({
    formatItemTimeFunc: function(d, rd, view, item){
      return rd.dateLocaleModule.format(d, {
        selector: 'time',
        timePattern: d.getMinutes() == 0 ? "ha":"h:mma"
      }).toLowerCase();
    }
  });

This will result into “10am” and “8:15am” when using the previous examples.

Another example is to force the calendar to display the time in **24h** instead of **AM/PM** for all locales.
In that case, the time label on item renderers and the time displayed in the row header of the column view must be overridden.

.. js ::

  calendar.set("formatItemTimeFunc",
    function(d, rd, view, item){
      return rd.dateLocaleModule.format(d,
      {  selector: 'time',
         timePattern: d.getMinutes() == 0 ? "H'h'":"H'h'mm"
      }
    }
  );
  calendar.columnView.set("rowHeaderTimePattern", "H'h'");

if the calendar instance is already declared or in the calendar constructor:

.. js ::

  new Calendar({
    formatItemTimeFunc: function(d, rd, view, item){
      return rd.dateLocaleModule.format(d, {
        selector: 'time',
        timePattern: d.getMinutes() == 0 ? "ha":"h:mma"
      }).toLowerCase();
    },
    columnViewProps:{
      rowHeaderTimePattern: "H'h'"
    }
  });

This formatItemTimeFunc property can be set on the calendar or on a sub view.
If the property is set on the calendar and on a view, the one set on the view takes precedence.

Decorations
-----------

Decoration data items are items like data items that have a start and end time.
They are displayed in the calendar above the grid but below the data item renderers.
Decorations can be used to display free or busy times, vacations, etc.

If sub columns are set, the decoration data items can have a sub column associated.
If set, the decoration will be displayed in the sub column.
If no sub column is set, the decoration will be displayed in all sub columns.
The property to determine the sub column of a data item is also used for decoration data items (by default "calendar").

To set the decoration items, set a dojo.store.api.Store to the decorationStore property like the data item store.

.. js ::

  new Calendar({
    decorationStore: new Memory(
      {data:
        [
          {
            startTime: "2014-01-10T00:00:00Z",
            endTime: "2014-01-13T00:00:00Z",
            calendar: "cal1"
          }
        ]
      }
    )
  });

The default renderer for a decoration is dojox.calendar.DecorationRenderer. This is a simple DIV element with a semi transparent green background.

The cssClassFunc function is also applied to decoration renderers. So styling of a decoration renderer can be customize by associating a CSS class to the decoration item renderer and use CSS on the page to specify the style to use.

.. css ::

  .dojoxCalendarDecoration.Calendar1 {
    background-color: red !important;
  }

  .dojoxCalendarDecoration.Calendar1 {
    background-color: blue !important;
  }

.. js ::

  calendar.set("cssClassFunc",
    function(item){
      return item.calendar == "cal1" ? "Calendar1" : "Calendar2"
    });

This code associates a CSS class (Calendar1 or Calendar2) to a decoration data item according to the value stored in the calendar property of this decoration data item.
The CSS code changes the background color of the decoration renderer according to the CSS class applied.


Common properties
-----------------

This section describes properties and concepts that are common to the views classes.

Note: the views are first citizen widgets that can be use alone without enclosing them into a Calendar widget.

Renderer kind mapping
`````````````````````

The itemToRendererKindFunc properties allow to specify a mapping between a data item and a kind of item renderer (vertical, horizontal or label).

Setting this function allows to:
  * Filter out some data items, based on some of their properties,
  * Choose which kind of item renderer is more suited to display the data item.

The default function behavior on the ColumnView is:
  * If the data item is not an all day data item, use vertical item renderer,
  * otherwise, do not display the data item.

The all day data item are displayed on the secondary sheet which also have a function with the inverse behavior.

For example, to show all-day data item and all the data items whose duration is equal or greater than a usual day (1440 minutes) on the secondary sheet only:

.. js ::

  new ColumnView({
    itemToRendererKindFunc: function(item){
      return item.allDay ||
        this.dateFuncObj.difference(item.startTime, item.endTime, "minute") > 1440 ? "null" : "vertical";
      },
    secondarySheetProps: {
      itemToRendererKindFunc: function(item){
        return item.allDay ||
          this.dateFuncObj.difference(item.startTime, item.endTime, "minute") > 1440 ? "horizontal" : null;
      }
    }
  });

The default function behavior on the MatrixView is:
  * If the data item duration is equal or greater than a usual day (1440 minutes), use a horizontal item renderer,
  * otherwise use a label item renderer.


You can customize this behavior to show only horizontal item renderers, for example:

.. js ::

  new MatrixView({
    itemToRendererKindFunc: function(item){
      return "horizontal";
    }
  }, null);

Grid cell styling
`````````````````
The grid cells can be customized either by using CSS or programmatically.

Each cell of the calendar has some CSS classes depending on the date/time it displays:
   * "Sun", "Mon", "Tue", "Wed", "Thu", "Fri" or "Sat", depending on the day of week,
   * "H0" to "H23" according to the time of day (Column view only).
   * "Mxx" where *xx* is the minutes part of the time of day (Column view, depends on the the slot duration).

The following example specifies CSS classes to grey out Wednesdays and the time range between 12pm and 2pm for other days of week:

.. css ::

  .dojoxCalendar .dojoxCalendarGrid .Wed,
  .dojoxCalendar .dojoxCalendarGrid .H12,
  .dojoxCalendar .dojoxCalendarGrid .H13	{
    background-color: #F8F8F8 !important;
  }

For more advanced use cases, each view provides a **styleGridCellFunc** property that allows to customize a grid cell without subclassing a view.

The following example show how to install a CSS class to grey out Wednesdays and the time range between 12pm and 2pm for other days of week:

.. css ::

  .greyCell{
    background-color: #F8F8F8 !important;
  }

.. js ::

  calendar.columnView.set("styleGridCellFunc", function(node, date, hours, minutes){
    // grey out Wednesday & time range between 12pm and 2pm
    if(hours >= 12 && hours < 14 || date.getDay() == 3){
      domClass.add(node, "greyCell");
    }
    this.defaultStyleGridCell(node, date, hours, minutes);
  });

  var func = function(node, date){
    // grey out Wednesdays
    if(date != null && date.getDay() == 3){
      domClass.add(node, "greyCell");
    }
    this.defaultStyleGridCell(node, date);
  };
  calendar.columnView.secondarySheet.set("styleGridCellFunc", func);
  calendar.matrixView.set("styleGridCellFunc", func);
  calendar.monthColumnView.set("styleGridCellFunc", func);


Item renderer overlap
`````````````````````

When two item renderers are overlapping in time, the item renderers can either be displayed side by side (no overlap) or can overlap visually horizontally (vertical item renderers) or vertically (horizontal item renderers).

Note that the label item renderers cannot overlap visually.

To specify the overlap, set the percentOverlap property. A 0 value means no overlap, 50 means an overlapping of the half of item renderer size.

The following images show two overlapping events that are displayed by vertical item renderer.
The first one shows a percentOverlap of 70%, the second on a percentOverlap of 0%.

.. image :: calendar/overlap70.png

.. image :: calendar/overlap0.png

Layout priority
```````````````

During the layout process, the data items that are in the displayed time range are sorted according to the following comparison function:
  * Data items that start first are placed first,
  * If two data item have the same start time, the longest is placed first.

These simple rules allow to have nice looking layout when data items are overlapping  in time.

If you want to change this data item layout priority management, set a sorting function to the layoutPriorityFunction. One use case is to build a sort function based on a priority value set on the data item itself.

Renderers
`````````

The renderer classes (item renderer and others) are not set by default on the views.

The calendar widget sets the default renderers classes to the views. If a view is used alone, the renderers must be set explicitly.

Column View
-----------

The column view is available by default in the **columnView** property of a **Calendar** instance.

If the view is not used as a standalone, to set a property in constructor use this syntax:

.. js ::

  var calendar = new Calendar({
    columnViewsProps: {
      myColumnViewProperty: value
    }
  });


If the calendar instance is already declared, use this syntax:

.. js ::

  calendar.columnView.set(myColumnViewProperty, value);


Properties
``````````

The displayed time interval is defined by the startDate and columnCount properties. It is columnCount days from the startDate.

The time of day displayed is defined by the minHours (8 by default) and maxHours (18 by default)  properties. For example to show the entire day set minHours to 0 and maxHours to 24.

The desired size of an hour is defined in the hourSize property (100 by default). According to the value of time slot duration, the size may be slightly bigger.

The time slot duration can defined defined by setting the timeSlotDuration property (15 by default). For example, to show only half hours set the timeSlotDuration to 30.

The scroll position can be retrieved or set using the startTimeOfDay property. The value is an objet containing the following properties:

  * **hours** - The hours part of the time of day,
  * **minutes** - the minutes part of the time of day,
  * **duration** (setter) - the scroll animation duration to scroll from the minHours to the maxHours. The actual duration is computed according to the distance to scroll in order to scroll always at the same speed.
  * **easer** (setter) - if duration is greater than 0, the easing function to use to animate the scroll.

For example to programmatically scroll the view to 9 am using an animation, use the following code:

.. js ::

  columnView.set("startTimeOfDay", {hours:9, duration:1000});

The columns view uses a scroll bar, in right-to-left display, you can define the position of the scroll bar with respect to the sheet by setting the scrollBarRTLPosition property. Values are “left” (default) and “right”.


Row Header
``````````

The following properties allow to have a fine grained configuration of the row header:
  * **rowHeaderGridSlotDuration** (60) - The duration of a slot for the row header grid.
  * **rowHeaderLabelSlotDuration** (60) - The duration of a slot of the row header labels.
  * **rowHeaderLabelOffset** (2) - The offset in pixels of the labels from the top of the row header cell.
  * **rowHeaderFirstLabelOffset** (2) - The offset in pixels of the first label from the top of the first row header cell.

Using these properties, you can show a line every 15 minutes, a label every 30 min and center the label on the line (depend on font and font size) excepting the first one to be able to see it.

.. js ::

  new ColumnView({
    rowHeaderGridSlotDuration: 15,
    rowHeaderLabelSlotDuration: 30,
    rowHeaderLabelOffset: -7
  }, colViewNode);

Sub columns
```````````

The column can display several sub columns in a column displaying a day.

This is useful to show several calendars for example.

.. image :: calendar/subColumns.png

Definition
''''''''''

To display sub columns, the sub column values must be set on the **subColumns** property of the view which is an array of strings.

Each data item **must** have a sub column specified otherwise it will not be displayed.
The **subColumnAttr** property defines on which property the sub column value will be looked on the data item (default value is "calendar").

If the sub column value of a data item matches a sub column value defined in the **subColumns** property, the data item will appear on the sub column.

.. js ::

  colView.set("store", new Memory({data:[
    {
      summary: "My Event",
      startTime: new Date(2013, 0, 1, 10, 0),
      endTime: new Date(2013, 0, 1, 14, 0),
      calendar: "cal1"
    }
  ]});

  colView.set("subColumns", ["cal1", "cal2"]);

When several sub columns per column are displayed, each sub column width can be very small.
In that case, the **minColumnWidth** property can be used to set the minimun width of a sub column.
The view becomes hotizontally scrollable if there's not enough room/


Sub columns header
''''''''''''''''''

If sub columns are defined, a sub column header is displayed.

By default the sub column values are displayed in the header.

To defined a label, set the **subColumnLabelFunc** property.

This property value is function that takes a string as parameter (the sub column value from the subColumns property) and returns a string (the label displayed on the sub column header).

.. js ::

  colView.set("subColumnLabelFunc", function(v){
    if(v == "cal1"){ return "Calendar 1"; }
    if(v == "cal2"){ return "Calendar 2"; }
    return null;
  });


To customize the sub column header, the value of a sub column is set on the node.
For example, using the two previous code sample, we can set the following CSS to style the sub columns header:

.. css ::

  .dojoxCalendarSubHeaderLabel.cal1 {
    color: #8B0000 !important;
  }

  .dojoxCalendarSubHeaderLabel.cal2 {
    color: #253B91 !important;
  }


Item creation
'''''''''''''

The **createItemFunc** property fourth parameter is the sub column value when the mouse cursor was when the item creation was triggered.

The newly created data item must have this value in its sub column property to be displayed in the correct sub column.

Example:

.. js ::

  var createItem = function(view, d, e, subColumn){

    // create item by holding control key
    if(!e.ctrlKey || e.shiftKey || e.altKey){
      return;
    }

    var start, end;
    var colView = calendar.columnView;
    var cal = calendar.dateModule;

    if(view == colView){
      start = calendar.floorDate(d, "minute", colView.timeSlotDuration);
      end = cal.add(start, "minute", colView.timeSlotDuration);
    }else{
      start = calendar.floorToDay(d);
      end = cal.add(start, "day", 1);
    }

    var item = {
      id: id,
      summary: "New event " + id,
      startTime: start,
      endTime: end,
      allDay: view.viewKind == "matrix",
      calendar: subColumn
    };

    id++;

    return item;
  }

  calendar.set("createOnGridClick", true);
  calendar.set("createItemFunc", createItem);


Item editing
''''''''''''

The move gestures allow to change the sub column of a data item unless the **allowSubColumnMove** property is set to false on the column view.

Layout
``````

In addition to the properties defined in the common section, the column view also exposes the horizontalGap property (default is 4).

This value is used to specify the gap in pixels between each overlapping renderer if percentOverlap is 0.

Renderers
`````````

The column view uses several renderers:
  * vertical item renderers to show the data items in the main sheet.
  * horizontal item renderers and expand renderers for secondary sheet.

The vertical item renderer class can be set on the verticalRenderer property.

The secondary sheet is a custom matrix view, see matrix view renderers for more information on the horizontal and expand renderers.

Styling
```````

The styling of a column view  is defined in the themes/claro/ColumnView.css and themes/claro/ColumnView_rtl.css. The base CSS class name is dojoxCalendarColumnView.

Several functions are provided to style or set a style class on part of the view:
  * styleColumnHeaderCell(node, date, renderData): allows to style a column header cell. By default, it installs dojoxCalendarToday and dojoxCalendarWeekend CSS classes.
  * styleRowHeaderCell(node, hour, renderData): allows to style a row header cell. By default, does nothing.
  * styleGridCell(node, date, hours, minutes, renderData): allows to style a grid cell. By default, it installs dojoxCalendarToday and dojoxCalendarWeekend CSS classes.

The styleGridCellFunc property allows to customize a grid cell without subclassing a view.

Date formatting
```````````````

To change the default formatting of the a label, one can:
  * set a custom date pattern in a dedicated property or
  * override the function that formats the date.

The properties and function used by the column view are described in the following table:

================== ======================= ===================
Label              Custom pattern property Formatting function
================== ======================= ===================
row header cell	   rowHeaderTimePattern    _formatRowHeaderLabel()
column header cell columnHeaderDatePattern _formatColumnHeaderLabel()
================== ======================= ===================

Matrix View
-----------

The matrix view is available by default in the **matrixView** property of a **Calendar** instance.

If the view is not used as a standalone, to set a property in constructor use this syntax:

.. js ::

  var calendar = new Calendar({
    matrixViewsProps: {
      myMatrixViewProperty: value
    }
  });


If the calendar instance is already declared, use this syntax:

.. js ::

  calendar.matrixView.set(myMatrixViewProperty, value);



Properties
``````````

The displayed time range is defined by the startDate, columnCount and rowCount properties. The time range is columnCount x rowCount days from the startDate.

The refStartTime and refEndTime can be used to define a time range of interest. This time range must be included in the displayed time range. It allows to show days out of the time range of interest by greying their cells.

Expanded row
````````````

The matrix view can have one row expanded to show mode data items on this particular row (usually a week).

The following functions are available on the matrix view to manage this feature:

===================== ===========
Method	              Description
===================== ===========
expandRow()           Expands a row with an optional animation.
collapseRow()         Collapses a row with an optional animation.
getExpandedRowIndex() Returns the expanded row index if any, -1 otherwise.
===================== ===========

Renderers
`````````

The matrix view uses several renderers:

  * horizontal item renderers (horizontalRenderer property) to display data items that last at least a day,
  * label item renderers (labelRenderer property) to display the other data items.
  * expand renderer (expandRenderer property), which indicates visually that some data items are visibles on a cell.

Horizontal item renderers are placed and sized according to the start and end time of the data item.

Label items renderers a placed in a cell and takes the cell width. They cannot overlap and cannot be resized.

Layout
``````

The matrix view has several layout properties.

The roundToDay property (default true), indicates that horizontal items renderers that represent events whose start or end time is not the start or end of a day should fill the cells that they are overlapping.

The two following images show the same data items that starts at 8 am and finishes at the end of the next day. This first one shows the result when the roundToDay property is true and the next one is this property is false.

.. image :: calendar/roundToDayTrue.png

.. image :: calendar/roundToDayFalse.png

This property can also be set to false, if all the data items are displayed using horizontal items renderers (see itemToRendererKindFunc property).

The size of the renderers are defined by the following properties:

========== ======================== =============
Renderer   Property                 Default value
========== ======================== =============
horizontal horizontalRendererHeight 17
label      labelRendererHeight      14
expand     expandRendererHeight     15
========== ======================== =============

In addition all the renderers shifted vertically of the value of the cellPaddingTop property (16 by default) to show the cell header.

Styling
```````

The styling of a matrix view is defined in the themes/claro/MatrixView.css and themes/claro/MatrixView_rtl.css.

The base CSS class name is dojoxCalendarMatrixView.

Several functions are provided to style or set a style class on part of the view:
  * styleColumnHeaderCell(node, date, renderData): allows to style a column header cell. By default, it installs dojoxCalendarWeekend CSS classes.
  * styleRowHeaderCell(node, hour, renderData): allows to style a row header cell. By default, does nothing.
  * styleGridCell(node, date, renderData): allows to style a grid column. By default, it installs dojoxCalendarToday, dojoxCalendarWeekend and dojoxCalendarDisabled CSS classes.

The styleGridCellFunc property allows to customize a grid cell without subclassing a view.

Date formatting
```````````````

To change the default formatting of the a label, one can:
  * set a custom date pattern or a custom format length in a dedicated property or
  * override the view function that formats the date.

The properties and function used by the column view are described in the following table:

================== ========================== ========
Label              Formatting function        Property
================== ========================== ========
row header cell	   _formatRowHeaderLabel()    none
column header cell _formatColumnHeaderLabel() columnHeaderLabelLength
grid cell header   _formatGridCellLabel()     cellHeaderLongPattern (first visible day of month) and/or cellHeaderShortPattern (other days of month)
================== ========================== ========

Month Column View
-----------------

Properties
``````````

The displayed time interval is defined by the startDate and columnCount properties. It is columnCount months from the first day of month defined by the startDate.

The desired size of a day is defined by the daySize property (30 by default).

The scroll position can be retrieved or set using the scrollPosition property. The value is an objet containing the following properties:

  * **date** - The scroll position in day,
  * **duration** (setter) - the scroll animation duration to scroll from the minHours to the maxHours. The actual duration is computed according to the distance to scroll in order to scroll always at the same speed.
  * **easer** (setter) - if duration is greater than 0, the easing function to use to animate the scroll.

For example to programmatically scroll the view to the 10th using an animation, use the following code:

.. js ::

  monthColumnView.set("scrollPosition", {position:10, duration:1000});

The month columns view uses a scroll bar, in right-to-left display, you can define the position of the scroll bar with respect to the sheet by setting the scrollBarRTLPosition property. Values are “left” (default) and “right”.

Layout
``````

In addition to the properties defined in the common section, the month column view also exposes the horizontalGap property (default is 4).

This value is used to specify the gap in pixels between each overlapping renderer if percentOverlap is 0.

The hidden data items grid cell decoration can be not displayed by setting the showHiddenEvents property.

Renderers
`````````

The month columns view is only using item vertical renderers.

The vertical item renderer class can be set on the verticalRenderer property.

Styling
```````

The styling of a month columns view  is defined in the themes/claro/MonthColumnView.css and themes/claro/MonthColumnView_rtl.css. The base CSS class name is dojoxCalendarMonthColumnView.

Several functions are provided to style or set a style class on part of the view:
  * styleColumnHeaderCell(node, date, renderData): allows to style a column header cell.
  * styleGridCell(node, date, renderData): allows to style a grid cell. By default, it installs dojoxCalendarToday and dojoxCalendarWeekend CSS classes.

In an additional layout pass, the dojoxCalendarHiddenEvents CSS class is installed on grid cells if they are hidden data items in the corresponding date.

The styleGridCellFunc property allows to customize a grid cell without subclassing a view.

Date formatting
```````````````

To change the default formatting of the a label, one can:
  * set a custom date pattern in a dedicated property or
  * override the function that formats the date.

The properties and function used by the column view are described in the following table:

================== ======================= ===================
Label              Custom pattern property Formatting function
================== ======================= ===================
column header cell columnHeaderDatePattern _formatColumnHeaderLabel()
grid cell          gridCellPattern         _formatGridCellLabel()
================== ======================= ===================


Custom renderers
----------------

Several default item renderers are provided but you can develop your own renderer.

The item renderer must extend the dojox.calendar._RendererMixin class.

The main property is of course the item property. The item is an object that contains:

  * **item** - the store item.
  * **range** - the part of the event displayed by this item renderer. Sometimes several item renderers are needed to display one data item,
  * other layout properties.

The owner property contains a reference to the view that uses this item renderer.

This class provides the state management of the displayed item renderer. The values are computed by the view and passed to the renderer.

The state properties are: edited, focused, hovered, selected. If a state is set, a custom CSS class is added (same name with upper case first letter for example “Selected”).

Additional CSS classed are used to describe the data item state with respect to the store:

  * "Storing": The data item is being added/updated to the store.
  * "Unstored": The data item is not in the store yet (interactive data item create use case)

Finally the moveEnabled and resizeEnabled properties, define if the data item can be respectively moved or resized.

If the item renderer needs a substantial refresh, the updateRendering() function is called. It is used mainly to compute the visibility of sub-components of this item renderer.

Other utility functions are provided to format time and set text using Bidi text direction etc.

Data item editing
-----------------

Introduction
````````````

The calendar allows to interactively move or resize a data item.

Steps
`````

The data item editing process goes through the following steps:
  * The editing is initialized by a user interaction, the widget enters into edit mode.
  * The user does some move gestures or/and some resize gestures.
  * The user validate or cancel the changes, the widget leaves edit mode.

There are some specifics depending on the device used:
  * Using the mouse: only one gesture (move or resize) per editing.
  * Using touch events: cancellation is not possible (possible future improvement).

Editing flags
`````````````

The **editable** property allows to globally enable or disable the editing capability of the widget.

If the editable property is true, the **moveEnabled** and **resizeEnabled** properties allow to control respectively if a data item can be moved or resized.

To have a control of editing, move or resize at the data item level, override respectively the isItemEditable(), isItemMoveEnabled() or isItemResizeEnabled() functions of the Calendar class.

The following example shows how to subclass the Calendar to override these functions to:
  * allow resize of a data item if **editable** and **resizeEnabled** properties of the data item are resolved as *true*,
  * allow move of a data item if **editable** and **moveEnabled** properties of the data item are resolved as *true*.

.. css ::

  #calendarNode {
    position:absolute;
    left: 10px;
    right: 10px;
    top: 10px;
    bottom: 10px;
  }

.. js ::

  // subclass Calendar class
  var ECalendar = declare("extended.Calendar", Calendar, {

    isItemEditable: function(item, rendererKind){
      return item.editable;
    },

    isItemResizeEnabled: function(item, rendererKind){
      return this.isItemEditable(item, rendererKind) && item.resizeEnabled;
    },

    isItemMoveEnabled: function(item, rendererKind){
      return this.isItemEditable(item, rendererKind) && item.moveEnabled;
    }
  });

  var calendar = new ECalendar(null, "calendarNode");

.. html ::

  <div id="calendarNode"></div>


Editing behavior properties
```````````````````````````
To customize the event editing behavior, a set of properties are exposed by the views.

============================ ========================= ========================= =========================== ===============
Property                     Column view default value Matrix view default value Month Columns default value ViewDescription
============================ ========================= ========================= =========================== ===============
allDayKeyboardLeftRightSteps 1                         1                         1                            How many unit to add or removed when using the keyboard left or right keys when editing an all day data item.
allDayKeyboardLeftRightUnit  “day”                     “day”                     "month"                      Unit to add or remove when using the keyboard left or right keys when editing an all day data item.
allDayKeyboardUpDownSteps    0                         7                         1                            How many unit to add or remove when using the keyboard up or bottom keys when editing an all day data item.
allDayKeyboardUpDownUnit     “day”                     “day”                     "day"                        Unit to add or remove when using the keyboard up or down keys when editing an all day data item.
allowResizeLessThan24H       true                      false                     false                        Allow or not to resize a data item that is lasting more than 24 hours to a duration less than 24 hours. Matrix view is preventing this because by default two renderer kinds are used to display data items depending on their duration.
allowStartEndSwap            true                      true                      true                         Allows move the end of a data item before the start and vice  versa.
keyboardLeftRightSteps       1                         15                        1                            How many unit to add or remove when using the keyboard left or right keys.
keyboardLeftRightUnit        “day”                     “minute”                  "month"                      Unit to add or remove when using the keyboard left or right keys..
keyboardUpDownSteps          15                        7                         1                            How many unit to add or remove when using the keyboard up or down keys.
keyboardUpDownUnit           “minutes”                 “day”                     "day"                        Unit to add or remove when using the keyboard up or down keys..
liveLayout                   false                     false                     false                        If false, only the edited renderer position/size is updated during the editing gestures. Otherwise all the renderers are updates during the editing gesture (more CPU intensive).
minDurationSteps             15                        15                        1                            The number of unit used to define the minimum duration of an event.
minDurationUnit              “minute”                  “minute”                  "day"                        The unit used to define the minimum duration of an event.
snapSteps                    15                        15                        1                            The number of unit used to compute the snapping of edited dates.
snapUnit                     “minutes”                 “minute”                  "day"                        The used to compute the snapping of edited dates.
stayInView                   true                      true                      true                         Forces the event to stay in the view.
touchEndEditingTimer         5000                      5000                      5000                         The time out after a implicit validation of changes in touch environment.
touchStartEditingTimer       750                       750                       750                          The amount of time needed a renderer needs to be pressed before entering in edit mode.
triggerExtent                3                         3                         3                            The distance in pixels needed to trigger the editing using the mouse.
============================ ========================= ========================= =========================== ===============

For example to change the minimal duration of an event to 30 minutes.

.. js ::

  calendar.columnView.set("minDurationSteps", 30);
  calendar.columnView.set("minDurationUnit", "minute");

Editing event handlers
``````````````````````

In some advanced use cases, the editing properties are not sufficient, the editing events are used to have a specific behavior.


These events are listed in the following table:

===================== =================================== =====
Event                 Description                         Usage
===================== =================================== =====
itemEditBegin         The widget has entered in edit mode Store initial values.
itemEditBeginGesture  A gesture is beginning              Store initial values before gesture.
itemEditMoveGesture   A move gesture occurred             Snapping, view limit management.
itemEditResizeGesture A resize gesture occurred	          Snapping, view limit management, duration constraints enforcement.
itemEditEndGesture    A move or resize gesture has ended  Apply or cancel gesture.
itemEditEnd           The widget is leaving edit mode	  Apply changes to store item or cancel changes and revert start and end time.
===================== =================================== =====

All the editing events have the following properties:
   * **item**: an object that contains the start and end time during the event editing in the startTime and endTime properties. When the data item is moved or resized, new start and end time values are computed and put in these properties. The itemEditMoveGesture and itemEditResizeGesture default event handlers are then manipulating these properties to apply snapping, limits etc according to the editing properties values.

   * **storeItem**: The data item that is being edited. This object must not be changed excepting in itemEditEnd event.

To prevent the editing default behavior applied by the calendar, call in your handler of the item editing event preventDefault().

The following example is cancelling the editing gesture when the data item has a specific property and its start time is after 1pm (included)

.. js ::

  var ss, se;
  calendar.on("itemEditBegin", function(e){
    // save initial values
    ss = calendar.newDate(e.item.startTime);
    se = calendar.newDate(e.item.endTime);
  });

  calendar.on("itemEditEnd", function(e){
    // a condition using properties of the store item and the render item
    if(e.storeItem.calendar == "cal2" && e.item.startTime.getHours() >= 13){
      // cancel default behavior (i.e. applying changes to store)
      e.preventDefault();

      // set the previously values to revert changes on the render item
      e.item.startTime = ss;
      e.item.endTime = se;
    } // default behavior for other use cases
  });


See also
========

* A demo leveraging the Dojo calendar `here <http://demos.dojotoolkit.org/demos/calendar/>`_.
