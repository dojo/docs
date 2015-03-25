.. _dojo/regexp:

===========
dojo/regexp
===========

.. contents ::
  :depth: 2

**dojo/regexp** provides Regular Expression utilities that enhance the RegExp capabilities of JavaScript.

Usage
=====

.. js ::

  require["dojo/regexp"], function(regexp){
    // Escape regular expression strings
    var str = regexp.escapeString(someString);

    // Build Regular Expression Groups
    var str = regexp.buildGroupRE(arrayOfStrings, reFunction);

    // Add a group match to an expression
    var str = regexp.group(someString);
  });
