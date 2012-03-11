.. _dijit/form/ValidationTextBox-tricks:

=========================================================
dijit.form.ValidationTextBox Tips, Tricks, and Edge-Cases
=========================================================

.. contents ::
    :depth: 2

Custom Validation
=================

Sometimes, you want to do your own validation, such as checking with backend if an email has been registered in 
database.
This can be done using JavaScript like:

.. js ::
  
  dijit.byId("validationTextBoxNodeId").validator = function(value, constraints){

      // Check that email has not been used yet.
      if(some-checks){
          return true;
      }else{
          return false;
      }
  }

There is one small catch here: this validator will be called onType, meaning it will be sending requests to the 
backend on every key stroke.
If you do not want that to happen, you may want to add another check in the beginning
so that it always returns true if the validation text box is on focus.
