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

Running the api docs extraction/generation tool (generate.php) produces either json or xml output - this is the raw data. To format and process this data into useful, browseable documentation you need a viewer application. This page steps you through the process to setup a web app like `dojotoolkit.org/api <http://dojotoolkit.org/api/>`_ and how to populate it with your docs data

=============
Prerequisites
=============

Dojo's `API Viewer <http://dojotoolkit.org/api/>`_ is a PHP-based web application, using XSLT to transform the XML output from generate.php and to create a readable and usable documentation UI. You will need: 

* A **web server**, with **mod_rewrite** enabled and **PHP 5** installed and configured. 
* A Subversion (**svn**) client. This walkthrough will assume a command-line svn client

Our viewer app is going to end up in a directory called 'api', which for the purposes of this walkthrough we'll assume is a sub-directory of the web root. That's going to get created for us (and needs to not exist yet). For now,  we'll make sure PHP is working by creating a test.php file in the web root directory, with the contents: 

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

====================
Configure the Viewer
====================

To work right out of the box there's a couple steps to complete. 

* In your api/data/1.4 directory (at time of writing) create a 'cache' directory, so you have api/data/1.4/cache. 
* Open up config.php and change the line 

  .. code-block :: php

    $basePath = "/"

to read: 

  .. code-block :: php

    $basePath = "/api/"

* To get permalinks working, we have to make a similar change in the .htaccess file. We'll change the RewriteBase directive to '/api'. (If your server doesnt mod_rewrite by the way, permalinks are the only casualty.) 

  .. code-block :: php

    #  Set the prefix for all matches
    RewriteBase   /api


Now, you can point your browser at http://localhost/api/, (or whatever hostname you are using) and you should see a working API viewer. 


====================
Import API Data
====================

Now to get our own API data into the viewer. If you've followed the `generation <util/doctools/generate>`_ steps, you should be in possession of an xml file, which is the API data for your namespace. We need to import that data, so navigate (in your browser) to lib/upload.php. 

This barebones upload page asks for two variables: a version number, and a URL to your XML file.
Note that it must be a URL and NOT a straight-up file.  The URL can be anything (cURL is used
to fetch it), and the version can also be any string. The version number is one that is meaningful to you - it will likely be the number that you use when you run a dojo build of your code.

Once you have the two fields filled in, hit the process button.

The site will grab your XML file, run it through a number of XSL transforms, and create a directory
in /data with the version number you entered.  Note that if the version number already exists, it
will reuse that directory and replace any existing XML files within it.

The site will also (again, if it doesn't exist) create a /cache directory within the /data/[version]
directory; if the cache directory already exists, it will delete everything inside of it.  Again,
note that this directory MUST be writable (this is the caching mechanism for the site).
  
That's it! Navigate back to /api/ and you should see your code's API in the viewer. 

======================
Customizing the Viewer
======================

Though everything should work at this point, you will probably want to do a little customization. If you look again in config.php, you'll notice: 

  .. code-block :: php

    #  Set the prefix for all matches
    $theme = "dtk";

That value is referring to a subdirectory name of the 'themes' directory. Peek in there and you'll find and index.php that corresponds to the initial welcome screen, as well as header, footer includes, images and css and so on. A minimum you'll probably want to duplicate the dtk directory and edit index.php to update the message to reflect the project or namespace you have imported.  



See Also
========
- `Dojo documentation tools overview <util/doctools>`_
- `API doc syntax <util/doctools/markup>`_ - how to markup API documentation in your code
- `Running the generation tools <util/doctools/generate>`_ - directories setup, defining custom namespaces, configuring and running the generation tools
- `Viewing the API output data <util/doctools/viewer>`_ - how to setup and load the extracted API data into a web-based viewer
