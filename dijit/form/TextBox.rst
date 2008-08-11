#format dojo_rst

dijit.form.TextBox Family
=========================

:Status: Draft
:Version: 1.0
:Author: CraigRiecke

TextBox
-------

TextBox provides some neat options, but what if you need none of them?  Can't you just use a plain HTML &lt;input&gt; tag?  You can, but they will not follow the Dijit theme, and will stick out like a sore thumb amongst other nicely-colored widgets.  So a good rule of thumb: if you use any Dijit form controls, you should make every control a Dijit control.  It's simple to do and makes everything look nice.

ValidatingTextBox
-----------------

A ValidatingTextBox by itself '''will not''' prevent invalid entries from submission.  To ensure they're not, simply surround your form with a dijit.form.Form widget


<h4>dijit.form.TextBox</h4>

.. cv-compound::

   The following demonstrates different types of text boxes and their use.

  ..cv:: javascript
  :label: After the customary require statements, the ``after5`` procedure handles some custom validation.

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

  
  ..cv:: html
  :label:

       <input type="text" name="firstname" value="testing testing"
		dojoType="dijit.form.TextBox"
		trim="true"
		propercase="true" />
	<input type="text" name="date1" value="2005-12-30"
		dojoType="dijit.form.DateTextBox"
		required="true" />
	<input type="text" name="income1" value="54775.53"
		dojoType="dijit.form.CurrencyTextBox"
		required="true"
		constraints="{fractional:true}"
		currency="USD"
		invalidMessage="Invalid amount.  Include dollar sign, commas, and cents." />
	<input id="q05" type="text"
		dojoType="dijit.form.NumberTextBox"
		name= "elevation"
		value="3000"
		constraints="{min:-20000,max:20000,places:0}"
		promptMessage= "Enter a value between -20000 and +20000"
		required= "true" 
		invalidMessage= "Invalid elevation."
		/>
	<input type="text" name="phone" class="medium" value="someTestString"
		dojoType="dijit.form.ValidationTextBox"
		regExp="[\w]+"
		required="true"
		invalidMessage="Invalid Non-Space Text.">
	<input type="text" name="zip" value="00000"
		dojoType="dijit.form.ValidationTextBox"
		regExp="\d{5}"
		required="true"
		invalidMessage="Invalid zip code.">
	<input type="text" name="zip" value="00000"
		dojoType="dijit.form.ValidationTextBox"
		regExpGen="after5"
		required="true"
		invalidMessage="Zip codes after 5, county name before then." />

<p>The <CODE>value</CODE> attribute is a floating point number.  
This means that you can easily build CurrencyTextBoxes for a wide range of currencies without having to set a different value for each currency format.  
<CODE>fractional</CODE> is still set to true, but it is set inside the constraints object instead of on the widget.</p>

<p>ValidationTextBoxes usually use Regular Expression validation, as in the following example:</p>

<p>The regular expression syntax comes directly from JavaScript.  
The start and ending qualifiers of the regular expression, ^ and $, are implicit - you do not need 
to include them.  This code demonstrates a ValidationTextBox that only accepts a 5 digit zip code.</p>

<p>ValidationTextBox also supports functions that generate regular expressions.  Having a generating function enables you to write much more dynamic Web applications.  ValidationTextBox passes its constraints object to the generating function.  The following code demonstrates a dynamic ValidationTextBox that only accepts a 5 digit zip code after 5:00PM, and only accepts a county name before then.</p>


<h3>Sending and Receiving Server Formats</h3>

<p>Patterns given as constraints in a DateTextBox or NumberBox only apply to the on-screen value, not the value received or sent to the server. Dojo encourages the use of standard, locale-neutral formats when marshalling data as best practice.  In some cases, the receiving application may have special requirements.  A shim on the server can do the necessary translation, but it is also possible to create a custom widget to use a different format.  For example when Oracle database processes dates, by default it insists on dd-MMM-yyyy format in English, as in 01-APR-2006.  If you wish to send it in this format, you can override the serialize method of DateTextBox.  Here's an example:</p>

       dojo.require("dijit.form.DateTextBox");
       dojo.declare("OracleDateTextBox",[dijit.form.DateTextBox], {
          serialize: function(d, options) {
             return dojo.date.locale.format(d, {selector:'date', datePattern:'dd-MMM-yyyy'}).toLowerCase();
           }
       });

       <input dojoType="OracleDateTextBox" name="mydate" value="2006-04-01"/>

<p>You can also pull the OracleDateTextBox widget into a module and dojo.require it in your pages.  Similar customization is possible with numbers, although the default Javascript number representation tends to be less of an issue.</p>

<p>Since Dojo is open source and the widgets are fully customizable, if you really want to use a custom protocol to communicate to and from a server, you can simply override the necessary methods.  Here's an example
of a DateTextBox subclass that uses a custom date format.</p>

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

        <input id="markup" dojoType="altDateTextBox" value="12/31/2007">
        <button onclick="alert('value serialized to ' + dijit.byId('markup').toString());return false">Serialize</button>

<h4>Screen Readers</h4>
<p>
If an invalid value is entered into a validating Text Box the "state" of the Text box changes, i.e. its background color changes.   To accomodate users who are blind, the Text Box's <a href="/node/1577">ARIA state</a> is changed to "invalid" so a screen reader can notify the screen reader user.  In addition to the "state" change, a pop-up appears.  When the pop-up appears screen readers should read the contents of the pop-up.  The pop-up text comes from the "invalidMessage" parameter.
</p>

<h4>Known Issues</h4>
<p>
Sometimes the popup message supplied by invalidMessage attribute may be
unnecessary.  For example, omitting a required field already displays an icon
when the cursor leaves the field.  In these cases
you can omit the "invalidMessage" parameter, but keep in mind that good labels and instructions
are still necessary for accessibility, i.e. if the invalid popup will not be displayed then there must be clear instructional text indicating the field is required.
</p>
<p>UPDATED for 1.0: Window-Eyes 6.1 speaks "read only" for fields that have been marked with the ARIA property invalid=true even though the field is still editable. </p>
