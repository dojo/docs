#format dojo_rst

ShrinkSafe 
==========

:Status: Draft
:Version: 2.0
:Project owner: Alex Russell
:Available: since V0.4

.. contents::
   :depth: 2

ShrinkSafe is a standalone Java-based JavaScript compressor which utilizes Rhino to parse code and safely shorten the results.  ShrinkSafe renames local references to short names prefixed with an underscore.  This saves bytes on the wire and also provides some obfuscation of the code.  It also eliminates whitespace and comments when generating the new code.  Global references and property names remain unchanged such that external file references to the compressed code should be safe.

================
Getting the Code
================

While ShrinkSafe is available as an `online service <http://shrinksafe.dojotoolkit.org/>`_ and part of the tool chain for the `Dojo Build system <build/index>`_, it is also possible to use ShrinkSafe independent of Dojo.

ShrinkSafe comes bundled with the ``-src`` releases of the Dojo Toolkit in the folder ``util/shrinksafe/``. Alternately, you can download ShrinkSafe standalone from `http://download.dojotoolkit.org <http://download.dojotoolkit.org/current-stable/>`_ by selecting the ``-shrinksafe`` archive. 


=====
Usage
=====


  java -jar shrinksafe.jar bigcode.js > smallercode.js   Compresses bigcode.js to smallercode.js

  java -jar shrinksafe.jar file1.js file2.js file3.js > combined.js   Compresses three files into one

  cat /mydir/*.js | java -jar shrinksafe.jar

  java -jar shrinksafe.jar http://myhost/mypath/foo.js > bar.js

  java -jar shrinksafe.jar -?   Get the usage message with information on optional arguments.


=====================
Developer information
=====================

ShrinkSafe has its own jar file, ``shrinksafe.jar``, which utilizes an unmodified Rhino jar, ``js.jar``.  Note that the linkage requiresr the same version of Rhino used to build the shrinksafe.jar.  In versions prior to Dojo 1.3, ShrinkSafe was bundled into Rhino by way of patch, and shipped as ``custom_rhino.jar``. 


==========
Known bugs
==========

Forward references are not always resolved properly.  See ticket #nnnn

========
See also
========

* `Dojo Builds <build/index>`_
