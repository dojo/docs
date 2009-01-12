#format dojo_rst

build profiles
==============

:Status: Draft
:Version: 1.0
:Project owner: (docs) Scott Jenkins
:Available: 1.0

.. contents::
   :depth: 3

The build profile is a simple JavaScript file containing an object which provides the parameters driving the build.

============
Introduction
============

The builder reads its parameters from a profile, which is a JavaScript file named *something*.``profile.js``, typically containing a ``dependencies`` object matching the structure described in this article.

The builder automatically appends ``.profile.js`` to the name of the profile specified on the build command line, so this naming convention is mandatory.

==============
Empty Profiles
==============

If you specify an empty profile containing no ``dependencies`` object (such as the ``base.profile.js`` file shipped with the Dojo distribution), all defaults will be applied to the build.  In this case, the builder will create a single layer, ``dojo.js``, which contains only Dojo Base.  All other resources will be loaded from the distribution on demand via ``dojo.require``.

===================
Dependencies Object
===================

The top level object in the profile should be of the general format:

.. code-block : javascript 

  dependencies: {
     layers: [
        // Individual layer objects...
     ],
     prefixes: [
        // Individual prefix objects...
     ]
  }

dependencies
  An object, possibly containing ``layers`` and ``prefixes`` members.  By convention, the ``layers`` member comes first in the next.


TODO: how to use the component/class/method

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // your code
 </script>



========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
