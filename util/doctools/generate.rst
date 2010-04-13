#format dojo_rst

Generating API Documentation
============================

:Status: Draft
:Version: 1.0
:Project owner: Neil Roberts
:Available: since V1.3

.. contents::
   :depth: 2

Running the doctools parser to extract API documentation data

============
Introduction
============

In `Dojo Inline Documentation <util/doctools/markup>`_ we detailed the markup syntax and conventions available to document your API inline in your code. These inline docs can be extracted using the doctools parser - a php-based script available in util/docscripts in your svn checkout of the Dojo Toolkit. The parser generates xml and/or json of the entirety of the configured namespaces (dojo, dijit and dojox by default). 

===================
Defining Namespaces
===================

The namespaces are defined in util/docscripts/modules, using a simple properties file. This should be named ``your_namespace.module.properties`` (e.g. ``util/docscripts/modules/mycompany.module.properties``) and it contains a simple namespace to path mapping: 

.. code-block :: javascript
	:linenos:
	
	location = ../mycompany

The path is relative to the directory docscripts directory (the directory generate.php is located in). You may also use an fully qualified, absolute path to your namespace's directory. 

=============
Sanity Checks
=============

For quick sanity checks of your docs you can load up util/docscripts/_browse2.php in your browser to run the parser over a single file at a time.

============
Parser Usage
============

The parser is typically run from the command-line. It is invoked like so: 

.. code-block :: javascript

	# Runs everything in the modules directory
	php generate.php

	# Only parses the 'dojo' and 'dijit' namespaces/directories
	php generate.php dojo dijit

	# Only parses the 'mycompany' namespace and directory
	php generate.php mycompany

	# Comma-separated list of serializations. "xml" and "json" supported
	php generate.php --serialize=xml,json

	# Runs only the custom namespace, 
	# serializes to mycompany.xml in the util/mycompany directory
	php generate.php --outfile=../../apiout/mycompany mycompany

Use the ``outfile`` argument to place the output in the directory/file of your choice. You'll need to create any interceding directories. 

Parsing a large codebase (like dojo/dijit/dojox) may take several minutes. 
