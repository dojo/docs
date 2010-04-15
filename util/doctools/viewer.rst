#format dojo_rst

Viewing the Generated API Docs
===============================

:Status: Draft
:Version: 1.0
:Project owner: Tom Trenka, Sam Foster
:Available: since V1.4

.. contents::
   :depth: 2

Setup and population of the viewer app with API data 

============
Introduction
============

Running the api docs extraction/generation tool (generate.php) produces either json or xml output - this is the raw data. To format and process this data into useful, browseable documentation you need a viewer application. This page steps you through the process to setup a web app like `dojotoolkit.org/api http://dojotoolkit.org/api/`_ and how to populate it with your docs data

=============
Prerequisites
=============

`dojotoolkit.org/api http://dojotoolkit.org/api/`_ is a PHP-based web application, using XSLT to transform the XML output from generate.php and to create a readable and usable documentation UI. You will need: 

* A **web server**, with **PHP 5** installed and configured. 
* A Subversion (svn) client. This walkthrough will assume a command-line svn client

This process will be easier if we mimic the paths and directory structure of dojotoolkit.org. So our app will end up in a directory called 'api', which is a sub-directory of the web root. That's going to get created for us (and need to not exist yet). For now,  we'll make sure PHP is working by creating a test.php file in the web root directory, with the contents: 

.. code-block :: php
  :linenos:
    
  <?php phpinfo(); ?>

If you point your browser at http://localhost/test.php (or whatever hostname you are using) you should see the PHP info page. Confirm the **xsl** module is available and enabled.

===================
Get the viewer code
===================

We're going to get a copy of the code behind dojotoolkit.org/api and customize that lightly to create our own API viewer. Lets start by getting an export. In your terminal/shell/cmd-prompt, move into your 'api' directory, and type:

.. code-block :: php
  :linenos:
    
  svn export http://svn.dojotoolkit.org/website/trunk/api api

That should create the 'api' sub-directory, and fill it with a load of php file and other assets. Note, we're doing an export here, not a checkout, so its divorced from the SVN copy. That means its yours to change, but if you prefer you can use svn checkout for those parts you want to be able to update with any changes from the remote repository. 

Point your browser at http://localhost/api/, you should see (TODO: screenshot)

====================
Configure the Viewer
====================

TODOC: Necessary changes to config.php, potential path changes in index.php (sfoster)


====================
Import API Data
====================

TODOC: Using lib/upload.php and cli-upload.php (sfoster)

======================
Customizing the Viewer
======================

Point out theme contents for title, welcome page text

See Also
========
- `Dojo documentation tools overview <util/doctools>`_
- `API doc syntax <util/doctools/markup>`_ - how to markup API documentation in your code
- `Running the generation tools <util/doctools/generate>`_ - directories setup, defining custom namespaces, configuring and running the generation tools
- `Viewing the API output data <util/doctools/viewer>`_ - how to setup and load the extracted API data into a web-based viewer
