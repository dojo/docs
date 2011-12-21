.. _build/transforms/hasFixup:

========================
Build Transform hasFixup
========================

:Author: Rawld Gill

.. contents ::
   :depth: 2

Summary
=======

Transforms has.js expressions that reference static has feature values as presented in a profile into expressions that
facilitate dead code removal by the Google Closure Compiler.

Description
===========

Profiles may contain the property ``staticHasFeatures`` a map from has feature name to booleanish. The presence of
a has feature name in the map indicates the resulting built code should assume the particular feature is either always
available (if truthy) or never available (if falsy). If multiple profile resources include a value for the property
``staticHasFeatures``, then each property value is mixed on a per-has-feature basis in the order they appear on
the command line. The special value of -1 indicates the feature is *not* known at build time and should be removed from
the final ``staticHasFeature`` map. For example, assume the following two profile resources exists

*profile-a*

.. js ::

  profile = {
      staticHasFeatures:{
          featureX:1,
          featureY:1,
          featureZ:0
      }
      // other profile properties, if any
  };


*profile-b*

.. js ::

  profile = {
      staticHasFeatures:{
          featureY:0,
          featureZ:-1,
          anotherFeature:1
    }
    // other profile properties, if any
  };

If these two profiles were provided on the command line as follows

.. code-block :: text

  ~/dev/dtk/util/buildscripts> ./build.sh -p profile-a -p profile-b

Then the aggregate profile would have the following value for the property ``staticHasFeatures``:

.. js ::

  staticHasFeatures:{
      featureX:1,       // only mentioned in profile-a
      featureY:0,       // profile-b value overrides profile-a value
      anotherFeature:1  // only mentioned in profile-b
  }

Notice that "featureZ" was removed because the profile-b which was mixed after profile-a contains the value of -1 for
that property.

Has feature values are used to transform two kinds of expressions:

.. js ::

  // adding a has test
  has.add("feature-value", // other stuff

  // resolving a has feature value
  has("feature-value")

These expressions are discovered by regular expression scanning of resources. The regular expressions have the following
characteristics:

* has.add must be presented without any white space around the dot

* white space (if any) around the left parenthesis is ignored

* white space (if any) around the right parenthesis in the has feature test expression is ignored

* quotes may be either single- or double-quotes

Given a has feature *x* where the profile property ``staticHasFeatures[`` *x* ``]`` is truthy, this profile will rewrite

``has.add(`` *x*

as

``true && had.add(`` *x*

The resulting code can then be processed by a subsequent transform, for example optimization by the Google Closure
Compiler, which will eliminate the dead code, while maintaining intended semantics (recall that has.add includes a
``now`` parameter that instructs the function to execute the test immediately and return result. For example, if the has
feature "featureX" is set to truthy in ``staticHasFeatures``, then the following code:

.. js ::

  if(has.add("featureX", function(){ /* some test */}, 1)){
      // do something
  }else{
      // don't do something
  }

would be transformed to:


.. js ::

  if(true || has.add("featureX", function(){ /* some test */}, 1)){
      // do something
  }else{
      // don't do something
  }

which would be reduced to:

.. js ::

      // do something

by the Google Closure Compiler in simple mode.

This design eliminates the need to determine the boundaries of the has.add argument list--a task that is impossible to
accomplish correctly without a proper parser.

Similarly, has feature tests with know values are replaced with the constant integers ``1`` (if the static value is
true) and ``0`` (if the static value if false). For example, for "featureX" set static true as described above, then the
following code

.. js ::

  if(has("featureX")){
      // do something
  }else{
      // don't do something
  }

Would be transformed to


.. js ::


  if(1){
      // do something
  }else{
      // don't do something
  }

Which would be reduced to

.. js ::

      // do something

By the Google Closure Compiler in simple mode.

Profile Knobs
=============

``staticHasFeatures`` (see below for default)

  * [*map from feature name to booleanish or -1*] If -1, then the has feature is removed from the ``staticHasFeatures``;
    otherwise, if truthy, then the feature is assumed to be always true in the built code and conversely. Multiple
    ``staticHasFeatures`` maps may be provided from multiple profile resources. If more than one ``staticHasFeatures``
    property value is provided, then they are mixed on a per-has-feature basis in the order they appear on the command line.

Source Location
===============

util/build/transforms/hasFixup.js
