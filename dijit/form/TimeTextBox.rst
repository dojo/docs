.. _dijit/form/TimeTextBox:

======================
dijit/form/TimeTextBox
======================

:Authors: Doug Hays, Nikolai Onken, Marcus Reimann, Craig Riecke
:Developers: ?-
:since: V?

.. contents ::
    :depth: 2

TimeTextBox widgets are time input controls that allow either typing or choosing a time from any time-picker widget.

Introduction
============

``dijit/form/TimeTextBox``:

* is a :ref:`mapped form control <dijit/form>`
* validates against locale-specific :ref:`i18n <dojo/i18n>` rules
* also validates against developer-provided ``constraints`` like ``min``, ``max``, etc.

:ref:`Options defined by the dojo.date package <quickstart/numbersDates>` to alter the way times are formatted and parsed can be specified in the TimeTextBox ``constraints`` object.

Usage
=====

Standard Time Format
--------------------

To prevent the ambiguity in specifying time formats, TimeTextBox allows only one time format ``THH:MM:SS`` when specifying times declaratively in HTML markup or when communicating with a server:

* T00:00:30 means 30 seconds after midnight
* T17:30:00 means 5:30 PM

However, when you get the widget's current ``value`` programmatically on the client, the returned value will be the native JavaScript Date object.
The date portion of this value should be ignored.


Examples
========

Programmatic example
--------------------

.. code-example ::

  .. js ::

    require(["dijit/form/TimeTextBox", "dojo/domReady!"], function(TimeTextBox){
        var timeTextBox = new TimeTextBox({name: "progval", value: new Date(),
            constraints: {
                timePattern: 'HH:mm:ss',
                clickableIncrement: 'T00:15:00',
                visibleIncrement: 'T00:15:00'
            }
        }, "progval");
        timeTextBox.startup();
    });

  .. html ::

     <label for="progval">Drop down Time box:</label>
     <input id="progval">

Declarative example
-------------------

.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/form/TimeTextBox"]);

  .. html ::

    <label for="time1">Drop down Time box:</label>
    <input type="text" name="date1" id="time1" value="T15:00:00"
        data-dojo-type="dijit/form/TimeTextBox"
        onChange="require(['dojo/dom'], function(dom){dom.byId('val').value=dom.byId('time1').value.toString().replace(/.*1970\s(\S+).*/,'T$1')})"
        required="true">
    <br>string value: <input id="val" value="value not changed" readonly="readonly" disabled="disabled">

Accessibility
=============

See the Accessibility Section in :ref:`dijit.form.ValidationTextBox <dijit/form/ValidationTextBox>`

The time picker popup associated with the TimeTextBox is not yet fully accessible.
However, the TimeTextBox will still meet accessibility requirements as long as the developer provides the validation parameters promptMessage and invalidMessage when creating the TimeTextBox.  These messages are implemented in a format that is accessible to all users.  Additionally, navigating and selecting a time in the drop down widget with JAWS screen reader is not supported. However, equivalent functionality is available for users by tabbing into the TimeTextBox and typing in the time.