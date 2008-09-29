#format dojo_rst

dijit.form.Form
===============

:Status: Draft
:Version: 1.0
:Authors: ?--
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2

**dijit.form.Form** is the dijit equivalent of the <form> node, and it provides various methods for serializing/deserializing form data, and checking whether or not a form is valid.

========
Examples
========

Declarative example
-------------------

.. cv-compound::

  .. cv:: javascript

     <script>
         dojo.require("dijit.form.Form");
         dojo.require("dijit.form.Button");
         dojo.require("dijit.form.ValidationTextBox");
         dojo.require("dijit.form.DateTextBox");
     </script>

  .. cv:: html

	<form dojoType="dijit.form.Form" id="myForm" jsId="myForm"
		encType="multipart/form-data" action="" method="">
		<script type="dojo/method" event="onReset">
			return confirm('Press OK to reset widget values');
		</script>
		<script type="dojo/method" event="onSubmit">
			console.debug('Attempting to submit form w/values:\n',
				dojo.toJson(this.getValues(),true)
			);
			if(this.validate()){
				return confirm('Form is valid, press OK to submit');
			}else{
				alert('Form contains invalid data.  Please correct first');
				return false;
			}
			return true;
		</script>
		<script type="dojo/method" event="onReset">
			return confirm('reset Form?');
		</script>
		<table style="border: 1px solid #9f9f9f;" cellspacing="10">

				<tr>
					<td><label for="name">Name:</td>
					<td>
						<input type="text" id="name" name="name" dojoType="dijit.form.ValidationTextBox"/>
					</td>
				</tr>
				<tr>
					<td><label for="dob">Date of birth:</td>
					<td>
						<input type="text" id="dob" name="dob" dojoType="dijit.form.DateTextBox"/>
					</td>
				</tr>
		</table>

		<button dojoType="dijit.form.Button" onClick="console.log(myForm.getValues())">Get Values from form!</button>
		<button dojoType="dijit.form.Button" type="submit" name="submitButton" value="Submit">Submit</button>
		<button dojoType="dijit.form.Button" type="reset">Reset</button>
	</form>
