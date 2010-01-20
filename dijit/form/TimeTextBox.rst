#format dojo_rst

dijit.form.TimeTextBox
======================

:Authors: Doug Hays, Nikolai Onken, Marcus Reimann, Craig Riecke
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2

TimeTextBox widgets are time input controls that allow either typing or choosing a time from any time-picker widget.

============
Introduction
============

``dijit.form.TimeTextBox``:

* is a `mapped form control <dijit/form#mapped>`_
* validates against locale-sepcific `i18n <dojo/i18n>`_ rules
* also validates against developer-provided ``constraints`` like ``min``, ``max``, etc.


=====
Usage
=====

Standard Time Format
--------------------

To prevent the ambiguity in specifying time formats, TimeTextBox allows only one time format ``THH:MM:SS`` when specifying times declaritively in HTML markup or when communicating with a server:

* T00:00:30 means 30 seconds after midnight
* T17:30:00 means 5:30 PM

However, when you get the widget's current ``value`` programmatically on the client, the returned value will be the native JavaScript Date object. The date portion of this value should be ignored.


========
Examples
========

Programmatic example
--------------------

.. cv-compound::

  .. cv:: javascript

     <script type="text/javascript">
       dojo.require("dijit.form.TimeTextBox");
       dojo.addOnLoad(function(){
         new dijit.form.TimeTextBox({name:"prog_val", value:new Date(),
           constraints:{timePattern:'HH:mm:ss', clickableIncrement:'T00:15:00', visibleIncrement:'T00:15:00', visibleRange:'T01:00:00'}
         }, "prog_val");
       });
     </script>

  .. cv:: html

     <input id="prog_val"/>
     <label for="prog_val">Drop down Time box. Click inside to display the time picker.</label>

Declarative example
-------------------

.. cv-compound::

  .. cv:: javascript

     <script type="text/javascript">
       dojo.require("dijit.form.TimeTextBox");
     </script>

  .. cv:: html

     <input type="text" name="date1" id="time1" value="T15:00:00"
       dojoType="dijit.form.TimeTextBox"
       onChange="dojo.byId('val').value=arguments[0].toString().replace(/.*1970\s(\S+).*/,'T$1')"
       required="true" />
     <label for="time1">Drop down Time box. Click inside to display the time picker.</label>
     <br>string value: <input readonly disabled id='val' value='value not changed' />

=============
Accessibility
=============

See the Accessibility Section in `dijit.form.ValidationTextBox <dijit/form/ValidationTextBox>`_

The time picker popup associated with the TimeTextBox is not yet fully accessible.  However, the TimeTextBox will still meet accessibility requirments as long as the developer provides the validation parameters promptMessage and invalidMessage when creating the TimeTextBox.  These messages are implemented in a format that is accessible to all users.   
