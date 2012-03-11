.. _build/transforms/dojoPragmas:

===========================
Build Transform dojoPragmas
===========================

:Author: Rawld Gill

.. contents ::
   :depth: 2

Summary
=======

Applies dojo pragmas to a resource.

Description
===========

Dojo pragmas are instructions contained in a resource that cause a particular build system feature to be invoked. All
Dojo pragmas are expressed with the following syntax

**//>>** *pragma* *pragma-arguments*

Some pragmas do not have arguments. A Dojo pragma expression must be contained on a single line.

The **//>>** sequence may appear anywhere, including within a block comment, which may be desirable, as well as within
a string or regular expression, where it is usually not intended to be interpreted as a pragma. In this latter
defective case, if the word following the **//>>** sequence is not a valid dojo pragma, a warning will be issued and the
sequence will be ignored.

Currently there are five pragmas:

**includeStart(** *tag* **,** *condition* **)**
  indicates a block should be conditionally removed if *condition* is falsy; identical to
  ``excludeStart`` except that *condition* is interpreted conversely.

**includeEnd(** *tag* **)**
  block terminator for ``includeStart`` with equivalent *tag*

**excludeStart(** *tag* **,** *condition* **)**
  indicates a block should be conditionally removed if *condition* is truthy; identical to
  ``includeStart`` except that *condition* is interpreted conversely.

**excludeEnd(** *tag* **)**
  block terminator for ``excludeStart`` with *tag*

**pure-amd**
  indicates a module is a proper AMD module; used by the depsScan transform

**Warning**: The has.js API which allows code blocks and/or entire modules to be conditionally included/excluded at
run-time and/or build-time should be used in place of the ``includeStart`` and ``excludeStart`` pragmas.

For ``includeStart`` and ``excludeStart``, *condition* is evaluated with the following variables in scope:

``kwargs``
  references the profile object

``filename``
  holds the source filename of the resource that is being processed

For example, assume a build is executed with a profile defined as follows:

.. js ::

  var profile = {
    myVariable = "myValue",

    // remainder of profile
  };

A block of code could be included if and only if myVariable is "myValue". For example, in the following code fragment,
the first block is untouched while the second block would be deleted from the built resource.

.. js ::

 //>>includeStart("firstBlock", kwargs.myVariable=="myValue")
  console.log("block one");
  //>>includeEnd("firstBlock")

  //>>includeStart("secondBlock", kwargs.myVariable=="yourValue")
  console.log("block two");
  //>>includeEnd("secondBlock")

By changing the value of the profile property ``myVariable`` to "yourValue" the first block would be deleted and the
second block left untouched; by failing to define ``myVariable`` or defining it to some value other then either
"myValue" or "yourValue", both blocks would be deleted.

Whitespace between/around the **//>>** sequence, pragma name, parenthesis, and comma is ignored.

Tag names may be reused. They can be used to indicate the intended semantics. For example,

.. js ::

  //>>includeStart("myBlocks", kwargs.myBlock)
  console.log("my block");
  //>>includeEnd("myBlocks")


  //>>includeStart("myBlocks", kwargs.myBlock)
  console.log("yet another one of my blocks");
  //>>includeEnd("myBlocks")

Notice that this example simply used the value of the profile property ``myBlock`` rather than a binary expression. The
text between the comma and the last parenthesis is evaluated and this text may be arbitrarily simple or complex so long as
it remains on the single line that contains the pragma and is legal JavaScript that returns a booleanish value.

Profile Knobs
=============

The entire profile object is placed in the lexical variable ``kwargs`` when thea condition associated with the pragmas
``includeStart`` and ``excludeEnd`` is evaluated. Any property in the profile may be used to affect these conditions.

Source Location
===============

util/build/transforms/dojoPragmas.js
