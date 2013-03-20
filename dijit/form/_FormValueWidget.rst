.. _dijit/form/_FormValueWidget:

===========================
dijit.form._FormValueWidget
===========================

dijit/form/_FormSelectWidget is a base class for widgets corresponding to native HTML elements such as
<input> or <select> that have user changeable values.

Each _FormValueWidget represents a single input value, and has a (possibly hidden) <input> element,
to which it serializes it's input value, so that form submission (either normal submission or via XHR etc.)
works as expected.
