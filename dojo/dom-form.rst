.. _dojo/dom-form:

=============
dojo/dom-form
=============

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 3

This module defines form-processing functions.  The convention for the return variable for this module is ``domForm``.

The *deprecated* legacy features are set in :ref:`dojo/_base/xhr <dojo/_base/xhr>`.

Features
========

fieldToObject()
---------------

This function is one of many helpers used by the Dojo XHR subsystem for handling AJAX style requests. This particular
function takes a HTML form field and converts the field's value to a string or an array of strings. Disabled form
elements and unchecked radio and checkboxes are skipped. Multi-select elements are returned as an array of string
values.

This function is used internally by :ref:`formToObject() <dojo/dom-form#formtoobject>` to convert each form field to a
value.

Usage
~~~~~

Simply passing the ID of the field will return it's value.

.. js ::
 
  require(["dojo/dom-form"], function(domForm){
    var firstInputValue = domForm.fieldToObject("firstInput");
  });

Attributes
~~~~~~~~~~

========= =============== ===================================
Argument  Type            Description
========= =============== ===================================
inputNode String||DomNode The form field node to be converted
========= =============== ===================================

Examples
~~~~~~~~

This example uses ``fieldToObject()`` to get field values.

.. code-example ::
  
  Here is the JavaScript required, which also uses the ``dojo/dom`` and ``dojo/on`` modules to facilitate the example.
  
  .. js ::

    require(["dojo/dom-form", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(domForm, dom, on){
      on(dom.byId("convertFields"), "click", function(){
        var shape = domForm.fieldToObject("shape");
        var colors = domForm.fieldToObject(dom.byId("myform").color);
        
        // Attach it into the DOM as pretty-printed text.
        dom.byId("output").innerHTML = "Shape is: " + shape + ", Colors is an array: "+ colors;
      });
    });

  Here is our basic form and button:
  
  .. html ::

    <button id="convertFields">Click to convert the form to an object</button><br><br>
    <b>The FORM</b><br><br>
    <form id="myform">
       <input id="shape" type="text" name="shape" value="round">
       <select name="color" multiple>
          <option selected value="red">Red</option>
          <option value="blue">Blue</option>
          <option selected value="green">Green</option>
       </select>
    </form>
    <br><br>
    <b>The form as an object:</b>
    <pre id="output"></pre>

toObject()
----------

This function is one of many helpers used by the Dojo XHR subsystem for handling AJAX style requests. This particular
function takes a HTML form node and converts the form elements into a JavaScript object of name/value pairs. Disabled
form elements, buttons, elements with just an id attribute but no name attribute, and other non-valued HTML elements are
skipped. The resulting object can then be processed however you like. Note that the form can contain ``dijit.form.*``
items.

Usage
~~~~~

Usage is simple and straightforward, you pass the form node or the string id of a form node to convert:

.. js ::
 
  require(["dojo/dom-form"], function(domForm){
    var formObj = domForm.toObject("myId");
  });

Attributes
~~~~~~~~~~

========= =============== ===================================
Argument  Type            Description
========= =============== ===================================
formNode  String||DomNode The form node to be converted
========= =============== ===================================

Examples
~~~~~~~~

This example creates an object version of a form.

.. code-example::
  
  This code requires the ``dojo/json`` module in order to output the object in a human readable fashion.

  .. js ::

    require(["dojo/dom-form", "dojo/dom", "dojo/on", "dojo/json", "dojo/domReady!"],
    function(domForm, dom, on, JSON){
      on(dom.byId("convertForm"), "click", function(){
        var formObject1 = domForm.toObject("myform");
        dom.byId("output").innerHTML = JSON.stringify(formObject1);
      });
    });

  Here is our basic HTML form.  This could also contain Dijit Form widgets as well.

  .. html ::

    <p><button id="convertForm">Click to convert the form to an object</button></p>
    <p>The FORM</p>
    <form id="myform">
       <p>text1: <input type="text" name="text1" value="value1"><br>
       text2: <input type="text" name="text2" value="value2"><br>
       cb_group.foo: <input id="f6_checkbox1" type="checkbox" name="cb_group" value="foo" checked><br>
       cb_group.boo: <input id="f6_checkbox2" type="checkbox" name="cb_group" value="boo"><br>
       radio_group.baz: <input id="f6_radio1" type="radio" name="radio_group" value="baz"><br>
       radio_group.bam: <input id="f6_radio2" type="radio" name="radio_group" value="bam" checked><br>
       radio_group.baf: <input id="f6_radio3" type="radio" name="radio_group" value="baf"></p>
    </form>
    <p>The form as an object:</p>
    <pre id="output"></pre>

toQuery()
---------

This function is one of many helpers used by the Dojo XHR subsystem for handling AJAX style requests. This particular
function takes a HTML form node and converts the form elements into a query string suitable for passing on a URI. This
function is identical to doing the operation:

.. js ::

  require(["dojo/io-query", "dojo/dom-form"], function(ioQuery, domForm){
    ioQuery.objectToQuery(domForm.toObject("formid"));
  });

You can refer to the :ref:`toObject() <dojo/dom-form#toobject>` and :ref:`dojo/io-query::objectToQuery() <dojo/io-query#objecttoquery>` documentation for more details on the general behavior.

Usage
~~~~~

Usage is simple and straightforward, you pass the form node or the string id of a form node to convert. The function
will hand back a string of the name/value pairs in URI query string format.

.. js ::
 
  require(["dojo/dom-form"], function(domForm){
    var formQuery = domForm.toQuery("myId");
  });

Attributes
~~~~~~~~~~

========= =============== ===================================
Argument  Type            Description
========= =============== ===================================
formNode  String||DomNode The form node to be converted
========= =============== ===================================

Examples
~~~~~~~~

This example uses ``toQuery()`` to create an query string version of a form.

.. code-example ::

  Here is the JavaScript code:

  .. js ::

    require(["dojo/dom-form", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(domForm, dom, on){
      on(dom.byId("convertForm"), "click", function(){
        var formQuery = domForm.toQuery("myform");
        dom.byId("output").innerHTML = formQuery;
      });
    });

  And here is our simple form and button to convert:

  .. html ::

    <button id="convertForm" type="button">Click to convert the form to an query</button><br><br>
    <b>The FORM</b><br><br>
    <form id="myform">
       <input type="text" name="field1" value="value1">
       <input type="text" name="field2" value="value2">
       <input type="button" name="someButton" value="someValue">
    </form>
    <br><br>
    <b>The form as a query string:</b>
    <pre id="output"></pre>

toJson()
--------

This function is one of many helpers used by the Dojo XHR subsystem for handling AJAX style requests. This particular
function takes a HTML form node and converts the form elements into a JSON string. This function is identical to doing
the operation:

  .. js ::

    require(["dojo/dom-form","dojo/json", function(domForm, JSON){
      JSON.stringify(domForm.toObject("formid"));
    });

You can refer to the :ref:`formToObject() <dojo/dom-form#toobject>` and :ref:`dojo/json::stringify() <dojo/json#stringify>` documentation for more details.

Usage
~~~~~

Usage is simple and straightforward, you pass the form node or the string ID of a form node to convert. The function
will hand back a JSON string of the name/value pairs from the form elements.

.. js ::
 
  require(["dojo/dom-form"], function(domForm){
    var formJson = domForm.toJson("myId");
  });

Attributes
~~~~~~~~~~

========= =============== ===================================
Argument  Type            Description
========= =============== ===================================
formNode  String||DomNode The form node to be converted
========= =============== ===================================

Examples
~~~~~~~~

This example uses ``formToJson()`` to create an JSON version of a form.

.. code-example ::
  
  .. js ::

    require(["dojo/dom-form", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(domForm, dom, on){
      on(dom.byId("convertForm"), "click", function(){
        var formJson = domForm.toJson("myform");
        
        // Attach it into the DOM as a pretty-printed text.
        dom.byId("output").innerHTML = formJson;
      })
    });

  .. html ::

    <button id="convertForm">Click to convert the form to JSON</button><br><br>
    <b>The FORM</b><br><br>
    <form id="myform">
       <input type="text" name="field1" value="value1">
       <input type="text" name="field2" value="value2">
       <input type="button" name="someButton" value="someValue">
    </form>
    <br><br>
    <b>The form as JSON:</b>
    <pre id="output"></pre>

See also
========

* :ref:`dojo/dom <dojo/dom>` - Core DOM API

* :ref:`dojo/_base/html <dojo/_base/xhr>` - Legacy API aliases
