#format dojo_rst

dijit.form.DateTextBox
======================

:Status: Draft
:Version: 1.0
:Author: CraigRiecke

dijit.form.DateTextBox:

* is a `mapped form control <dijit/form#mapped>`_
* validates against locale-sepcific i18n rules
* also validates against developer-provided constraints like min, max, valid days of the week, etc.

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
        <label for="date1">Drop down Date box</label>


TODO 


Sending and Receiving Server Formats
------------------------------------

Patterns given as constraints in a DateTextBox or NumberBox only apply to the on-screen value, not the value received or sent to the server. Dojo encourages the use of standard, locale-neutral formats when marshalling data as best practice.  In some cases, the receiving application may have special requirements.  A shim on the server can do the necessary translation, but it is also possible to create a custom widget to use a different format.  For example when Oracle database processes dates, by default it insists on dd-MMM-yyyy format in English, as in 01-APR-2006.  If you wish to send it in this format, you can override the serialize method of DateTextBox.  Here's an example:

.. code-block:: javascript
   :linenos:

       dojo.require("dijit.form.DateTextBox");
       dojo.declare("OracleDateTextBox",[dijit.form.DateTextBox], {
          serialize: function(d, options) {
             return dojo.date.locale.format(d, {selector:'date', datePattern:'dd-MMM-yyyy'}).toLowerCase();
           }
       });

.. code-block:: javascript
   :linenos:
       
       <input dojoType="OracleDateTextBox" name="mydate" value="2006-04-01"/>

You can also pull the OracleDateTextBox widget into a module and dojo.require it in your pages.  Similar customization is possible with numbers, although the default Javascript number representation tends to be less of an issue.

Since Dojo is open source and the widgets are fully customizable, if you really want to use a custom protocol to communicate to and from a server, you can simply override the necessary methods.  Here's an example
of a DateTextBox subclass that uses a custom date format.

.. code-block:: javascript
   :linenos:

        dojo.require("dijit.form.DateTextBox");
        // subclass DateTextBox to allow the initial value to be specified
        // as MM/dd/y instead of yyyy-MM-dd in the markup
        dojo.addOnLoad(function(){
                dojo.declare("altDateTextBox", dijit.form.DateTextBox, {
                        serialize: function(value, constraints){
                                // overrides to send the date to the server with a format of constraints.datePattern
                                // instead of calling dojo.date.stamp.toISOString
                                return dojo.date.locale.format(value, constraints);
                        },

                        postMixInProperties: function(){
                                this.inherited(arguments);
                                this.constraints.datePattern = "MM/dd/y";
                                if(this.srcNodeRef){
                                        // reparse the value attribute using constraints.datePattern
                                        // instead of calling dojo.date.stamp.fromISOString
                                        var item = this.srcNodeRef.attributes.getNamedItem('value');
                                        if(item){
                                                this.value = dojo.date.locale.parse(item.value, this.constraints);
                                        }
                                }
                        }
                });
                dojo.parser.parse();
        });

.. code-block:: html
   :linenos:
	
        <input id="markup" dojoType="altDateTextBox" value="12/31/2007">
        <button onclick="alert('value serialized to ' + dijit.byId('markup').toString());return false">Serialize</button>
