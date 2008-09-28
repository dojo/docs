#format dojo_rst

dijit.form.DateTextBox
======================

:Status: Draft
:Version: 1.0
:Author: CraigRiecke

DateTextBox widgets are handy, easy-to-use date entry controls that allow either typing or choosing a date from any calendar widget.

``dijit.form.DateTextBox``:

* is a `mapped form control <dijit/form#mapped>`_
* validates against locale-sepcific `i18n <dojo/i18n>`_ rules
* also validates against developer-provided ``constraints`` like ``min``, ``max``, valid days of the week, etc.

Example
-------

.. cv-compound::

  .. cv:: javascript

     <script type="text/javascript">
     dojo.require("dijit.form.DateTextBox");
     </script>

  .. cv:: html

	<input type="text" name="date1" id="date1" value="2005-12-30"
		dojoType="dijit.form.DateTextBox"
		required="true" />
        <label for="date1">Drop down Date box.  Click inside to display the calendar.</label>

Standard Date Format
--------------------
One universal problem with dates is they can be written so many different ways.  In Great Britain, "5/8/2008" means August 5th where in the U.S. 
it means May 8th.  Fortunately, Dojo respects the browser's locale so that the date will be properly parsed.  

The trouble is your application does not have a locale.  If you write the attribute ``value='5/8/2008'``, how does DateTextBox know what you mean?  To prevent this ambiguity, DateTextBox allows only one date format: the familiar UNIX date format  ``yyyy-mm-dddThh:mm:ss``.  For example:

* 2007-12-25T00:00:30 means 30 seconds after midnight on December 25, 2007.
* 2007-05-08T17:30:00 means 5:30 PM on May 8, 2007
* 2003-04-22 means midnight April 22, 2003 

UNIX date format values sort properly as strings, which make them nice for things like `dojox.grid <dojox/grid>`_.

Sending and Receiving Server Formats
------------------------------------

Ideally, your server application will send and receive dates in the UNIX standard format.  But you may not be in control of that piece, so how do you get around it?  For example when Oracle database processes dates, by default it insists on dd-MMM-yyyy format in English, as in 01-APR-2006. 

To accept dates from the server in this format, you can create your own widget class which overrides the setValue method of DateTextBox.  (See `dijit <dijit>`_ for details on creating your own widgets).  Here's an example:

.. code-block:: javascript
   :linenos:

   dojo.declare("OracleDateTextBox", [dijit.form.DateTextBox],
      setValue: function(unparsedValue) {
          this.value = dojo.date.locale.parse(
              unparsedValue,
              {selector: 'date', datePattern: 'dd-MMM-yyyy'}
          );
      })
      // more to come...

To do the reverse - writing back to the server in Oracle format - you override the serialize method:

.. code-block:: javascript
   :linenos:

      serialize: function(d, options) {
        return dojo.date.locale.format(d, {selector:'date', datePattern:'dd-MMM-yyyy'}).toLowerCase();
      }
   });

Finally, you can use this new widget class programmatically or declaratively

.. code-block:: html
   :linenos:
       
   <input dojoType="OracleDateTextBox" name="mydate"/>

In all cases, the DateTextBox looks and works exactly the same to the user.

One common anti-solution is to set the datePattern constraint:

.. code-block :: html
   :linenos:

   <!-- DOESN'T WORK!!  -->
   <input dojoType="dijit.form.DateTextBox" name="effectiveDateOfChange" 
          id="effectiveDateOfChange" constraints="{datePattern:'dd-MMM-yyyy'}"/> 

Unfortunately, this only affects how the date is parsed and formatted in the box itself. As such, it's not very wise because it forces
people from every country to use the same format, which may be totally unfamiliar.  So, bad idea.
          
Changing Constraints on the Fly
-------------------------------
DateTextBox obeys the constraints you give, much like `dijit.form.NumberTextBox <dijit/form/NumberTextBox>`_  Sometimes you may need to change these constraints based on
user input.  To do this, you can set new constraints on the widget, but the catch is you must use JavaScript dates.

TODO: For example, this DateTextBox will not allow you to enter a day before today:


Two-Digit Year Format
---------------------

TODO: http://dojotoolkit.org/forum/dijit-dijit-0-9/dijit-support/datetextbox-datepattern-constraint-2-digit-year-possible
