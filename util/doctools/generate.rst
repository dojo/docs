.. _util/doctools/generate:

============================
Generating API Documentation
============================

:Project owner: Neil Roberts
:since: V1.3

.. contents ::
   :depth: 2

Deprecated, see https://github.com/wkeese/api-viewer/blob/master/README.rst for latest instructions.

Running the doctools parser to extract API documentation data

Introduction
============

In :ref:`Dojo Inline Documentation <developer/markup>` we detailed the markup syntax and conventions available to document your API inline in your code. These inline docs can be extracted using the doctools parser - a php-based script available in util/docscripts in your svn checkout of the Dojo Toolkit. The parser generates xml and/or json of the entirety of the configured namespaces (dojo, dijit and dojox by default).

Defining Namespaces
===================

The namespaces are defined in util/docscripts/modules, using a simple properties file. This should be named ``your_namespace.module.properties`` (e.g. ``util/docscripts/modules/mycompany.module.properties``) and it contains a simple namespace to path mapping:

.. js ::

    location = ../mycompany

The path is relative to the directory docscripts directory (the directory generate.php is located in). You may also use an fully qualified, absolute path to your namespace's directory.

Sanity Checks
=============

For quick sanity checks of your docs you can load up util/docscripts/_browse2.php in your browser to run the parser over a single file at a time.

Parser Usage
============

The parser is typically run from the command-line. It is invoked like so:

.. js ::

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

    # Specifies storage type. "file" (default) and "resource" currently supported.
    # Since dojo 1.7, a faster "hash" storage is added, which becomes the default.
    php generate.php --store=file
    php generate.php --store=mysql --db_host=localhost --db_user=api --db_password=password --db_name=api


Use the ``outfile`` argument to place the output in the directory/file of your choice. You'll need to create any interceding directories.

Parsing a large codebase (like dojo/dijit/dojox) may take several minutes.


See Also
========

- :ref:`Dojo documentation tools overview <util/doctools>`
- :ref:`API doc syntax <developer/markup>` - how to markup API documentation in your code
- :ref:`Viewing the API output data <util/doctools/viewer>` - how to setup and load the extracted API data into a web-based viewer
