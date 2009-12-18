#format dojo_rst

dijit.form.ValidationTextBox (Tips, Tricks and the Edge-Cases)
==============================================================

:Status: Draft
:Version: 1.3.2

=================
Custom Validation
=================

Sometimes, you want to do your own validation, such as checking with backend if an email has been registered in database. This can be done using javascript like:

.. code-block :: javascript
  :linenos:

  dijit.byId("validationTextBoxNodeId").validator = function (value, constraints) {

      // Check that email has not been used yet.
      if (some-checks) {
          return true;

      } else {
          return false;
      }
  }

There is one small catch here: this validator will be called onType, meaning it will be sending requests to the backend on every key stroke. If you do not want that to happen, you may want to add another check in the beginning so that it always returns true if the validation text box is on focus.
