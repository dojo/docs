.. _dijit/_TimePicker:

=================
dijit._TimePicker
=================

:Authors: Bill Keese
:since: 1.0

.. contents ::
    :depth: 2

Introduction
============

_TimePicker is a widget internally used by :ref:`dijit/form/TimeTextBox <dijit/form/TimeTextBox>`.

Usage
=====

Standard Time Format
--------------------

To prevent the ambiguity in specifying time formats, TimeTextBox allows only one time format ``THH:MM:SS`` when
specifying times declaratively in HTML markup or when communicating with a server:

* T00:00:30 means 30 seconds after midnight
* T17:30:00 means 5:30 PM

However, when you get the widget's current ``value`` programmatically on the client, the returned value will be the
native JavaScript Date object.
The date portion of this value should be ignored.


Examples
========

Programmatic example
--------------------

.. code-example ::

  .. js ::

    require(["dijit/_TimePicker", "dojo/domReady!"], function(_TimePicker){
        new _TimePicker({name: "progval", value: new Date(),
            constraints: {
                timePattern: 'HH:mm:ss',
                clickableIncrement: 'T00:15:00',
                visibleIncrement: 'T00:15:00',
                visibleRange: 'T01:00:00',
                style: "height: 200px; width: 200px;"
            }
        }, "progval");
    });

  .. html ::

     <label for="progval">_TimePicker:</label>
     <div id="progval"></div>

Declarative example
-------------------

.. code-example ::

  .. js ::

    require(["dijit/_TimePicker", "dojo/parser"]);

  .. html ::

    <label for="time1">Drop down Time box:</label>
    <div id="time1" value="T15:00:00" style="height: 200px; width: 200px;"
        data-dojo-type="dijit/_TimePicker"
       ></div>

Accessibility
=============

The time picker widget is not accessible, unless it is used as the popup of the
:ref:`dijit/form/TimeTextBox <dijit/form/TimeTextBox>`.