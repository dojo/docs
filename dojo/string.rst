#format dojo_rst

dojo.string
===========

:Status: Draft
:Version: 1.0

.. contents::
   :depth: 2

dojo.string provides some simple string manipulation utilities

============
Introduction
============

String utilities for the Dojo toolkit include trim, pad, rep, and substitute.  This common functionality is used often in applications, so performance was carefully considered when implementing these methods.

trim() trims whitespace off both ends of a string using an efficient regular expression.  It now passes through to native String.prototype.trim defined by EcmaScript-5, if one is provided.

pad() and rep() help construct strings.  pad() can extend a string to a certain length by padding at the front or end, using a character of your choice.  rep() simply constructs a string by replicating a sequence n times.

substitute() is a workhorse and the basis for dijit's templating.  It performs parameterized substitution in the form of ${name} with a variety of advanced options.  An object is provided as the hashtable to lookup when doing these substitutions. The expression in the curly braces may be a simple property, like 'name' or a dotted expression like 'data.employee.name'.  The expression may be further qualified by a colon and the name of a format function, to run the output each lookup through a property, such as mylib.formatName.   A 'this' reference may be provided for the format function, otherwise it will be scoped to the global namespace.  Lastly, an optional transform function can be run on all properties just prior to substitution, such as one to escape HTML entities.


.. cv-compound::
  
  .. cv:: javascript

    <script type="text/javascript">
        dojo.addOnLoad(function(){
            console.log(dojo.string.trim(dojo.byId("foo").innerHTML));
        });
    </script>

  .. cv:: html

    <div id="foo">  Hi dojo.beercamp </div>

  .. cv:: css

    <style type="text/css">
      #foo {
          color: red;
      }    
    </style>
