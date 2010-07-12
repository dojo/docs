#format dojo_rst

Getting the Code from Source Control
====================================

The Dojo team uses Subversion for source control. Those familiar with CVS will find the command line syntax for subversion to be very similar. Regardless, the following instructions are geared to those not familiar with CVS, or even source control in general.

Authoritative documentation on Subversion is available `here <http://svnbook.red-bean.com/>`_.

===================
Why Source Control?
===================
Source control is one of those things that one rarely notices they need until it's far too late, usually when you accidentally delete part of your source tree instead of simply moving it to a different location, or when you make a set of complex changes that leave you worse off than were you started (but you can't go back). A source control system solves these problems by keeping copies of each revision of a set of files on a server, while giving you access to a local copy of those files to make changes on. Good source control systems allow multiple people to modify a single file at once, and will try to automatically merge changes between differing sets of modifications. A good source control system will also let you browse the history of a file or set of files (allowing you to "go back in time") and allow you to have acccess to your code from as many systems as you like. Subversion is one of those good source control systems.

===================
General Information
===================
Across the gamut of source control systems, there is quite a bit of confusing (and non-portable) nomenclature surrounding the common actions that you as a developer will preform with the source control system. We will use the terms here that are commonly accepted by CVS and Subversion users and administrators. So what are those terms?

  * **Checkout**: a "checkout" is a local working copy of a "repository". This is the set of files that you will be working with when making modifications to Dojo.
  * **Repository**: the logical grouping of project-related files on the server. A subversion server may host multiple repositories, but it is quite likely that your changes will be constrained to a single repository.
  * **Checkin**: transmitting a set of changes from your local checkout to the server. Your changes will then be available to everyone else who has a checkout of that repository when they update their view.
  * **Head**: (also called the "main line") the most up-to-date version of the source control tree. Most of your checkins will be to the "head" of the tree, although in some more complex situations, you may be checking in to a "branch".
  * **Branch**: A clone of the source control repository from some point in time which contains a set of changes which are not shared with the "head" or main line. Branches are one way for a developer to work on a particular feature (usually a large feature) and have intermediate changes versioned without having to worry about whether or not his or her changes will break someone else's code. Changes can then be "merged" back back to the main line when the developer thinks they are stable.
  * **Merge**: merging is the process of taking several versions of a single file and turning them into one authoritative version. Merging in is often an automated process with Subversion, but you may at times be called upon to merge a set of files manually (when the server cannot automatically take care of it).

Unlike some other source control systems, Subversion manages files on your disk without interjecting itself obtrusively into your workflow. You can change large sets of files without worrying if anyone else is also modifying those files.

=======================
Browsing the repository
=======================
You may browser our subversion repository (http://svn.dojotoolkit.org/src/) directly using a web browser or browse using the `Bug tracker <http://bugs.dojotoolkit.org/browser>`_.

===================
Directory structure
===================
The code is structured with each subproject (dojo, dijit, dojox, util) as a separate directory. Within each subproject you will find the "trunk" as well as "branches" and "tags". You may pull these subprojects separately, or use a special svn "view" which links the subprojects and checks them out with a single command.

Note that the "trunk" directory at the top-level is obsolete. This was used prior to the 0.9 release, when the code was reorganized into the various subprojects.

To do an anonymous, read-only checkout of the Dojo development trunk:


::

   svn co http://svn.dojotoolkit.org/src/view/anon/all/trunk dojotoolkit

Or, to pull a particular release, such as Dojo 1.0.2:

::

   svn co http://svn.dojotoolkit.org/src/tags/release-1.0.2 dojo102

===============================
Branches in the Dojo repository
===============================
Most Dojo development takes place on the trunk. Branches may be used for development of experimental features or for code migration before being merged back into the trunk. Branches are also used to stabilize major releases.

================================
Making changes to the repository
================================
Anyone may access the Dojo Subversion server. Contributors are encouraged to access code directly from the repository and submit patches using the bug tracker. To submit changes, however, you must have committer status and have already received a system account from the administrator.

To access the repository as a committer, use this URL with subversion:

::

    svn co --username=YOURUSERNAME
        https://svn.dojotoolkit.org/src/view/committer/all/trunk dojotoolkit

=======================
Using Development Tools
=======================

Setup for Eclipse
-----------------
If you use Eclipse, we recommend the `Subclipse plugin <http://subclipse.tigris.org/>`_. Simply provide a URL for the Dojo repository as discussed above.

Setup for Windows
-----------------
To access our subversion repository on Windows, please install `TortoiseSVN <http://tortoisesvn.tigris.org/>`_. Installing Tortoise requires a reboot since it installs itself as a Windows Explorer shell extension.

Welcome back! Now that you have rebooted, open up a Windows Explorer window (Win-E, or right-click on the "Start" menu and select "Explore"), navigate to whatever directory you would like your Dojo source code to be placed under. Create a new directory there titled "dojo", and then navigate to it.

Right-click in the directory and select "SVN Checkout..." from the context menu. In the resulting dialog box, you will be prompted for a URL for the repository you want to check out. In this dialog box, place the following URL:

::

     Dojo development trunk
     https://svn.dojotoolkit.org/src/view/committer/all/trunk dojotoolkit

Click "ok" in the dialog box if a dialog box comes up discussing a host key. You will then be asked for your user login password at dojotoolkit.org. Provide it. You will then see a list of files being retreived from the server, and when it's finished, you will have your very own checkout!

Next, take a minute to update your svn config settings (see section below).

You can then check in your changes by right-clicking on the file(s) you want to check in, selecting providing a checkin comment (strongly encouraged). Other operations, including diffing and merging are also available from the context menu.

For more information about TortiseSVN or how to use it, see the documentation at:

http://tortoisesvn.tigris.org/docs/TortoiseSVN_en/index.html

Setup for Linux
---------------
Since you're running Linux, it is assumed that you're comfy with your systems package management system and the command line.

Making a checkout is straightforward from the command line. Provided you already have Subversion installed, simply run:

::

    Dojo development trunk
    svn co --username=YOURUSERNAME
    https://svn.dojotoolkit.org/src/view/committer/all/trunk dojotoolkit

Next, take a minute to update your svn config settings (see below).

This will create a local copy ("checkout") of the source tree (under a new directory called "dojotoolkit") in the current directory. Make edits to the files you want to change, then commit them back to the repository with:

::

    svn commit -m "Commit message here" names/of/files


Setup for OS X
--------------
We assume that you are on at least OS 10.3 (Panther).

You may need to install the Developer Tools package in order to get a the most up-to-date JDK (for running custom Dojo builds). It is assumed that operations will be preformed at the command line, and Project Builder/XCode configuration is not covered here. It is, however, recommended that you download the latest set of developer tools from http://connect.apple.com (free registration required).

Once you have the OS X developer tools installed, download the latest 1.x Subversion package (1.3 as of this writing) from: 
http://metissian.com/projects/macosx/subversion/

The downloads are an OS X installer package. Install it, at which point the instructions from the Linux section will be sufficient to get you up and running.

Next, take a minute to update your svn config settings.

===================
SVN Config Settings
===================
You'll need to add a couple config settings to your SVN config file. If you are on Windows, that's located at:

::

   C:\Documents and Settings\YourUserName\Application Data\Subversion\config

And on UNIX/Mac OS X:

::

    ~/.subversion/config

Open it up in your favorite text editor. Most configs have some default settings, so locate [miscellany] and enable-auto-props in the file. If they exist, make sure that they are uncommented (remove # from beginning of line), otherwise add them. They line should look like:

::

    [miscellany]
    enable-auto-props = yes

Next, located [auto-props]. If it doesn't exist, add it, otherwise you'll probably have to uncomment it. Add the following entries below [auto-props]:

::

    *.js = svn:eol-style=native
    *.htm = svn:eol-style=native
    *.html = svn:eol-style=native
    *.svg = svn:eol-style=native
    *.txt = svn:eol-style=native
    *.xml = svn:eol-style=native
    *.xsl = svn:eol-style=native
    *.dtd = svn:eol-style=native
    *.css = svn:eol-style=native
    *.rest = svn:eol-style=native
    *.php = svn:eol-style=native
    *.phps = svn:eol-style=native
    *.inc = svn:eol-style=native
    *.sh = svn:eol-style=native
    Makefile = svn:eol-style=native
    README = svn:eol-style=native
    CHANGELOG = svn:eol-style=native
    LICENSE = svn:eol-style=native
    INSTALL = svn:eol-style=native
    BUILD = svn:eol-style=native

Save that and you should be set! Continue on to committing directions above.
