#format dojo_rst

dojo.replace
============

:Status: Draft
:Version: 1.4
:Available: since V1.4

.. contents::
    :depth: 2

This function provides a sane light-weight foundation for substitution-based templating.

===========
Basic Usage
===========

dojo.replace accepts 3 arguments:

* String template to be interpolated.
* Object or a function to bu used for substitutions.
* Optional regular expression pattern to look for. By default all patterns "{abc}" are going to be found and replaced.

If the second argument is an object, all names within braces are interpreted as property names within this object. All "." will be interpreted as subobjects. This default behavior provides a great flexibility. Example:

.. code-block :: javascript
  :linenos:

  dojo.replace("Hello, {name.first} {name.last} AKA {nick}!",
    {
      name: {
        first:  "Robert",
        middle: "X",
        last:   "Cringely"
      },
      nick: "Bob"
    }
  );
