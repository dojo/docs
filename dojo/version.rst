#format dojo_rst

dojo.version
============

:Status: Draft
:Version: 1.0
:Available: since V?

.. contents::
   :depth: 2

An object describing the current version of dojo.js


=====
Usage
=====

.. code-block :: javascript
  :linenos:

  >>> dojo.version;
  0.0.0dev (15278) major=0 minor=0 patch=0 flag=dev revision=15278
  >>> dojo.version.toString();
  "0.0.0dev (15278)"

0.0.0 indicates a "trunk" release, a non-complied version of Dojo. Typically you will see a real version, such as "1.2.0"

The members of the `dojo.version` object are integers, and can be checked individually:

.. code-block :: javascript

  var v = dojo.version;
  if(v.major > 1){ 
    // this is dojo 2.x
  }else{
    // this id dojo 1.x
    switch(v.minor){ 
       case 1: console.log("1.1.x specific code"); break;
       case 2: console.log("1.2.x specific code"); break;
       case 9: console.log("this is 0.9, as major is less than 1, but not 1"); break;
    }
  }

It is important to note the `dojo.version` value is easily set as part of the build process (`version=1.2.0`), and should not be relied upon in production code. It is meant as a simple utility for determining which particular version of Dojo is loaded on a page, mostly for debugging purposes.

The `revision` member refers to the SVN revision used to create the version. You can inspect individual changesets at `the Dojo bug tracker <http://bugs.dojotoolkit.org/changeset>`_

.. example ::

  :js:

    <script type="text/javascript">
        alert(dojo.version);
    </script>
