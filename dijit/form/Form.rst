#format dojo_rst

dijit.form.Form
===============

:Status: Draft
:Version: 1.0
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

    <div dojoType="dijit.form.Form" id="myForm" jsId="myForm"
    encType="multipart/form-data" action="" method="">
        <script type="dojo/method" event="onReset">
            return confirm('Press OK to reset widget values');
        </script>

        <script type="dojo/method" event="onSubmit">
            if(this.validate()){
                return confirm('Form is valid, press OK to submit');
            } else {
                alert('Form contains invalid data.  Please correct first');
                return false;
            }
            return true;
        </script>

        <table style="border: 1px solid #9f9f9f;" cellspacing="10">
            <tr>
                <td>
                    <label for="name">Name:
                </td>
                <td>
                    <input type="text" id="name" name="name" required="true" dojoType="dijit.form.ValidationTextBox"/>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="dob">Date of birth:
                </td>
                <td>
                    <input type="text" id="dob" name="dob" dojoType="dijit.form.DateTextBox"/>
                </td>
            </tr>
        </table>

        <button dojoType="dijit.form.Button" onClick="console.log(myForm.getValues())">Get Values from form!</button>
        <button dojoType="dijit.form.Button" type="submit" name="submitButton" value="Submit">Submit</button>
        <button dojoType="dijit.form.Button" type="reset">Reset</button>
    </div>

Note that it's using a <div> node instead of the obvious choice of a <form> node because of some `IE issues <http://bugs.dojotoolkit.org/ticket/8424>`_

Preparing and validating a form for XHR requests
------------------------------------------------

To validate a form you use the `isValid()` function. Lets take at a simple example using a declaratively created form:

.. cv-compound::

  .. cv:: javascript

    <script>
        dojo.require("dijit.form.Form");
        dojo.require("dijit.form.Button");
        dojo.require("dijit.form.ValidationTextBox");
        dojo.require("dijit.form.DateTextBox");

        dojo.addOnLoad(function(){
            var myForm = dijit.byId("myFormTwo");
            dojo.connect(myForm, "onSubmit", function(e){
                e.preventDefault();
                if (myForm.isValid()){
                    alert("Ready to submit data: "+dojo.toJson(myForm.attr("value")) );
                }
            });
        });
    </script>

  .. cv:: html

    <div dojoType="dijit.form.Form" id="myFormTwo" jsId="myFormTwo"
    encType="multipart/form-data" action="" method="">
        <table style="border: 1px solid #9f9f9f;" cellspacing="10">
            <tr>
                <td>
                    <label for="name">Name:
                </td>
                <td>
                    <input type="text" name="name" required="true" dojoType="dijit.form.ValidationTextBox"/>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="dob">Date of birth:
                </td>
                <td>
                    <input type="text" name="dob" dojoType="dijit.form.DateTextBox"/>
                </td>
            </tr>
        </table>

        <button dojoType="dijit.form.Button" onClick="console.log(myFormTwo.attr('value'))">Get Values from form!</button>
        <button dojoType="dijit.form.Button" type="submit" name="submitButtonTwo" value="Submit">Submit</button>
        <button dojoType="dijit.form.Button" type="reset">Reset</button>
    </div>

Using native form elements
--------------------------

dijit.form.Form can also handle any type of native form element, though you have to do validation yourself.  The Form widget below will validate only when you have entered both a name in the ValidationTextBox widget AND when you have selected 1 of the native HTML radio buttons.

.. cv-compound::

  .. cv:: javascript

    <script>
        dojo.require("dijit.form.Form");
        dojo.require("dijit.form.Button");
        dojo.require("dijit.form.ValidationTextBox");
    </script>

  .. cv:: html

    <div dojoType="dijit.form.Form" id="myFormThree" jsId="myFormThree"
    encType="multipart/form-data" action="" method="">
        <script type="dojo/method" event="validate">
           return dojo.query('INPUT[name=order]','myFormThree').filter(function(n){return n.checked}).length > 0 &&
           dijit.form.Form.prototype.validate.apply(this, arguments);
        </script>
        <script type="dojo/method" event="onSubmit">
            var f = dojo.byId("myFormThree");
            var s = "";
            for(var i = 0; i < f.elements.length; i++){
                var elem = f.elements[i];
                if(elem.name == "button"){ continue; }
                if(elem.type == "radio" && !elem.checked){ continue; }
                s += elem.name + ": " + elem.value + "\n";
            }
            alert("Unvalidated data that would be submitted:\n" + s);
            return false;
        </script>
        <table style="border: 1px solid #9f9f9f;" cellspacing="10">
            <tr>
                <td>
                    <label for="name">Name:
                </td>
                <td>
                    <input type="text" name="name" required="true" dojoType="dijit.form.ValidationTextBox"/>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="dob">Order
                </td>
                <td>
                    <input type="radio" name="order" value="Food"> Food  
                    <input type="radio" name="order" value="Drinks"> Drinks
                </td>
            </tr>
        </table>

        <button dojoType="dijit.form.Button" onClick="alert('Form is ' + (myFormThree.validate()?'':'not ') + 'valid');return false">
            Validate form
        </button>
        <button dojoType="dijit.form.Button" type="submit" name="submitButtonThree" value="Submit">Submit</button>
        <button dojoType="dijit.form.Button" type="reset">Reset</button>
    </div>


=============
Accessibility
=============

The Form widget acts as a container for other widgets and HTML elements and has no specific behaviors affecting accessibility.
