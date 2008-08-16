#format dojo_rst

dijit.form.TextBox Family
=========================

:Status: Draft
:Version: 1.0
:Author: CraigRiecke

Examples
--------

.. cv-compound::

  .. cv:: javascript

     <script type="text/javascript">
     dojo.require("dijit.form.TextBox");
     dojo.require("dijit.form.DateTextBox");
     dojo.require("dijit.form.CurrencyTextBox");
     dojo.require("dijit.form.NumberTextBox");
     dojo.require("dijit.form.ValidationTextBox");
     function after5(constraints){
	   var date=new Date();
	   if(date.getHours() >= 17){
		  return "\\d{5}";
	   }else{ 
		  return "\\D+";
	   }
	}
     </script>

  .. cv:: html

        <input type="text" name="firstname" value="testing testing"
		dojoType="dijit.form.TextBox"
		trim="true" id="firstname"
		propercase="true" />
        <label for="firstname">Auto-trimming, Proper-casing Textbox:</label>
	<br/>
	<input type="text" name="date1" id="date1" value="2005-12-30"
		dojoType="dijit.form.DateTextBox"
		required="true" />
        <label for="date1">Drop down Date box</label>
	<br/>
	<input type="text" name="income1" id="income1" value="54775.53"
		dojoType="dijit.form.CurrencyTextBox"
		required="true"
		constraints="{fractional:true}"
		currency="USD"
		invalidMessage="Invalid amount.  Include dollar sign, commas, and cents." />
        <label for="income1">U.S. Dollars, comma is allowed</label>
	<br/>
	<input id="q05" type="text"
		dojoType="dijit.form.NumberTextBox"
		name= "elevation"
		value="3000"
		constraints="{min:-20000,max:20000,places:0}"
		promptMessage= "Enter a value between -20000 and +20000"
		required= "true" 
		invalidMessage= "Invalid elevation." />
        <label for="q05">Integer between -20000 to +20000</label>
	<br/>
	<input type="text" name="phone" id="phone" value="someTestString"
		dojoType="dijit.form.ValidationTextBox"
		regExp="[\w]+"
		required="true"
		invalidMessage="Invalid Non-Space Text." />
        <label for="phone">Phone number, no spaces</label>
	<br/>
	<input type="text" name="zip" value="00000"
		dojoType="dijit.form.ValidationTextBox"
		regExp="\d{5}"
		required="true"
		invalidMessage="Invalid zip code." />
        <label for="zip">Also 5-Digit U.S. Zipcode only</label>
	<br/>
	<input type="text" name="zip" value="00000" id="zip2"
		dojoType="dijit.form.ValidationTextBox"
		regExpGen="after5"
		required="true"
		invalidMessage="Zip codes after 5, county name before then." />
        <label for="zip2">Also 5-Digit U.S. Zipcode only</label>
	<br/>

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

Screen Readers
--------------

If an invalid value is entered into a validating Text Box the "state" of the Text box changes, i.e. its background color changes.   To accomodate users who are blind, the Text Box's <a href="/node/1577">ARIA state</a> is changed to "invalid" so a screen reader can notify the screen reader user.  In addition to the "state" change, a pop-up appears.  When the pop-up appears screen readers should read the contents of the pop-up.  The pop-up text comes from the "invalidMessage" parameter.


Known Issues
------------

Sometimes the popup message supplied by invalidMessage attribute may be
unnecessary.  For example, omitting a required field already displays an icon
when the cursor leaves the field.  In these cases
you can omit the "invalidMessage" parameter, but keep in mind that good labels and instructions
are still necessary for accessibility, i.e. if the invalid popup will not be displayed then there must be clear instructional text indicating the field is required.

UPDATED for 1.0: Window-Eyes 6.1 speaks "read only" for fields that have been marked with the ARIA property invalid=true even though the field is still editable. 
