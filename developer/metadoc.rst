.. _developer/metadoc:

==============================
Editing Dojo's Reference Guide
==============================

.. contents ::
  :depth: 2

The dojo reference documentation is stored at https://github.com/dojo/docs.  The documentation is all flat text files, 
in reStructuredText (reST) format.

General Style Notes
===================

The Reference Guide is a reference guide.  This means that it isn't a tutorial, it isn't the API documentation.  It is 
designed to provide a lookup reference describing packages and modules, their usage and examples.  Some general 
considerations you should make when editing the documentation:

* Be concise and brief.

* Cross-reference a lot.

* Avoid writing in the singular first person (e.g. *My example...* or *I would recommend...*).  This is technical 
  documentation not written by a single author.  It would be better to utilize *An example...* or *It is 
  recommended...*.

* Historically, there was a lot of "new in Dojo 1.4" notes.  These have quickly become dated.

* The foundation packages are Dojo, Dijit and DojoX.  Please note the capitalization.  The entire toolkit is referred 
  to as the Dojo Toolkit or DTK.  You can refer to Dojo Core and Dojo Base, although this is having less meaning and 
  may not be appropriate for Dojo 2.0.

* The preference is for US English spelling of English words (e.g. *color* not *colour*).

* When referring to a module, package, property, etc. utilize the double back ticks (\`\`) to mark the words as inline 
  code (e.g. ``dojo/_base/kernel``, ``dijit/layout/ContentPane`` or ``data-dojo-type``).

* Use a spellchecker!

Documentation Formatting
========================

A handy reference guide of reST syntax is available at http://docutils.sourceforge.net/docs/user/rst/quickref.html.

Here are some basics though, plus information on dojo's conventions, and our reST extensions like .. code-example.

Pages
-----

Each page must contain some basic information. When creating a page via the wiki interface, some skeletal reST is 
injected for you. The first and most important is the first line, a location to your document::

    .. _foo/bar/baz:

The above would point to a file at foo/bar/baz.rst

Next, include a top-level page heading. It can be anything, and serves as the document title. When documenting a 
package or module, the title should be the package or module (in *path* notation versus *dot*)::

    ===========
    foo/bar/baz
    ===========

The number of ``=`` characters must be equal or greater than the length of the title.  Common convention is to make 
them equal.

Next, provide a ``contents`` directive, to auto generate links to the various subsections::

    .. contents ::
      :depth: 2

Then continue on adding subsections, separated by headings. Using a top/bottom bar for your first heading, you could 
use the following syntax for sub-headings::

    =====
    Title
    =====

    Section 1
    =========

    Section 1.1
    -----------

    Section 1.1.1
    ~~~~~~~~~~~~~

    Section 1.2
    -----------

    Text under section 1.2

    Section 2
    =========

    Text under section 2

The reStructuredText parser will create each unique section separator character as a new level.  The preferred 
separators per level are:

======= ========================================
Level   Character
======= ========================================
Title   ``=`` top and bottom
Level 1 ``=`` bottom only
Level 2 ``-`` bottom only
Level 3 ``~`` bottom only
Level 4 ``'`` bottom only
Level 5 ``,`` bottom only and but please rethink 
        the structure of the document
======= ========================================

The depth of the sections is relevant, and can be previewed in the Table of Contents (which uses embedded 
unordered-lists as output).

Paragraphs
----------

The following text:

  ::

    Paragraphs are lines of text separated by a blank link.
    This will not become a new paragraph.

    But this will.

will format as:

  Paragraphs are lines of text separated by a blank link.
  This will not become a new paragraph.

  But this will.

Inline Text
-----------

The following text::

    **bold** ... *less bold* ... ``code`` ... `emphasis` ...

Will render as:

    **bold** ... *less bold* ... ``code`` ... `emphasis` ...


Links
-----

You can link to external pages, internal pages, and sections within the same page.

External links look like:

  ::

    `Text of Link <http://example.com/link.url.html>`_

This would become:

  `Text of Link <http://example.com/link.url.html>`_

Linking to other internal pages uses ``:ref:``:

  ::

    :ref:`Jump to Dijit! <dijit/index>`

This would become:

  :ref:`Jump to Dijit! <dijit/index>`

You should try to use the package/module name when linking to a package or module:

  ::

    :ref:`dojo/parser <dojo/parser>`

If you want to link to a arbitrary section of another document, you need to add another label.  But if you also want it to work with rstWiki (a.k.a. livedocs), then you need to create a label that maps to a hash target.  So lets say you wanted to link to ``forEach()`` in ``dojo/_base/array``.  You would need to have a created a header:

  ::

    forEach()
    =========

Which will create a hash target of ``#foreach`` on the page, which you would then create reference of:

  ::

    :ref:`dojo/_base/array::forEach() <dojo/_base/array#foreach>`

And then before the header in the target document you would need to add the label:

  ::

    .. _dojo/_base/array#foreach:

    forEach()
    =========

It is possible to cross-reference sections internally. If the section heading is a single word, you can simply 
add a trailing underscore to the word:

  ::

    Jump to Links_

This would create a link back to a major section:

  Jump to Links_

To reference a multi-word section header, surround the words with a single back-tick (`````) and add a following 
underscore:

  ::

    Jump to `Inline Text`_

Would result in:

  Jump to `Inline Text`_

Note that links are case insensitive. It is not possible to have two headings with the same wording, even if under  
different subheadings.

Images
------

Images can be referenced by an ``image`` directive::

  .. image :: pathtoimage.png

The location is relative::

  .. image :: /logo.png
  .. image :: logo.png

The former will look for an image in the root of the document tree, whereas the latter will look for an image in the 
current directory.

*Note:* When the guide is rendered for the official website, the documentation area is only 630 pixels wide, so while 
your image may fit appropriately on rstWiki/livedocs, it will overrun on the official website.

Directives
----------

rstWiki ships with a ``dojo.py`` collection of custom directives in addition to the standard formatting directives 
above. There 3 styles of code formatting names, shorthanded to ``js``, ``html``, and ``css``

To define a block of any of those type code snippets, include the following::

  .. js ::

    alert('this is code')

This will produce output like:

.. js ::

  alert('this is code')

Similarly for ``css`` and ``html``

.. css ::

  @import "/foo/bar/baz.css";
  #main { color: red }

.. html ::

  <div id="foobar"></div>

These three block types can be embedded in a ``code-example`` directive, which will produce a live/runnable example::

    .. code-example ::

        The Text between the blocks just renders inline.

        .. js ::

            require(["dojo/main", "dojo/ready"], function(dojo, ready){
                ready(function(){
                    alert("WE RAN");
                    dojo.byId("bar").innerHTML = "#winning";
                })

            });

        You don't have to put words about the subsections, but you can

        .. html ::

            <p id="bar">Test?</p>

        .. css ::

            #bar { color:green; }

The above example will produce

.. code-example ::

    The Text between the blocks just renders inline.

    .. js ::

        require(["dojo/main", "dojo/ready"], function(dojo, ready){
            ready(function(){
                alert("WE RAN");
                dojo.byId("bar").innerHTML = "#winning";
            })

        });

    You don't have to put words about the subsections, but you can

    .. html ::

        <p id="bar">Test?</p>

    .. css ::

        #bar { color:green; }

Indentation
-----------
reST is whitespace sensitive, like most python things. All `directives`_ need consistent indention.

The following text:

    ::

        .. js ::

            alert("I am 4 spaces indented from the first . in the previous directive");

        I align with the previous directive, and am not included in it.

        * list item 1
            * list item 1.1
            * list item 1.2
        * list item 2
            * list item 2.1
                * list item 2.1.1
        * list item 3

produces:

    .. js ::

        alert("I am 4 spaces indented from the first . in the previous directive");

    I align with the previous directive, and am not included in it.

    * list item 1
        * list item 1.1
        * list item 1.2
    * list item 2
        * list item 2.1
            * list item 2.1.1
    * list item 3


Unlike Dojo Toolkit, the docs use 4 spaces for indention, so please do not mix spaces/tabs.

Index Files
-----------

Most files can map directly to a/b/c.rst == a.b.c pages. Some, however, would have conflicting filenames if placed on a case-sensitive filesystem. Consider the following 3 files::

    dijit/Tree.rst
    dijit/tree.rst
    dijit/tree/subpage.rst

In JavaScript it is perfectly legal to have both a ``dijit.Tree`` and ``dijit.tree`` object, though when extracted into a case sensitive filesystem, only one of ``Tree.rst`` and ``tree.rst`` survive.

The solution in this case is the use an ``index`` file. Classes win, namespaces get the ``index``. The above example should be moved/fixed to become::

    dijit/Tree.rst
    dijit/tree/index.rst
    dijit/tree/subpage.rst

Documents linking to the Class would do so with a normal link::

    :ref:`Checkout the Tree Class <dijit/Tree>`

But documents linking to additional ``dijit.tree`` namespace information would link to the index::

    :ref:`More about dijit.tree <dijit/tree/index>`

**note:** some existing files may not follow this pattern consistently, though all current namespace/file conflicts 
have been resolved. New files added should follow this pattern.

**note:** the wiki attempts to discover ``index.rst`` files automatically and does not include them in the breadcrumb 
[currently] unless explicitly linked to. This could cause pages to link properly in the wiki but not in export. 
FIXME/confusing


Editing documentation online
============================

You can edit the documentation online, through http://livedocs.dojotoolkit.org (previously docs.dojocampus.org).
Changes will be pushed upstream to the master git repository.

Alternately, you can edit online through the github interface:

   1. Go to https://github.com/dojo/docs
   2. Select a file
   3. Click "Edit this file" or "Fork and edit this file"

If you don't have write permission into the dojo/docs github repository, this will create a fork of the dojo/docs
github repository.   After you have edited files in your fork, you can submit a push request to have your patch
integrated into the github repository.


Editing documentation locally
=============================

As an alternative to editing documentation online, you can clone the documentation repository from github, and edit it 
locally, pushing the changes back to github when you are finished.  If you don't have write permission on the github 
dojo/docs repository you can submit a pull request.

This strategy is ideal for large changes,
since you can use your favorite text editor / IDE to manage the files, and preview the content before committing it
(see next section for info on previewing).


Updating the documentation through pull requests
------------------------------------------------
If you don't have write permission on the github dojo/docs repository then follow these steps.

 * create a github fork of the dojo/docs github repo by pressing fork button on https://github.com/dojo/docs
 * create local fork of your github fork: git clone git@github.com:yourusername/docs.git
 * if working on a branch:  git checkout -b 1.7
 * edit and fix some files
 * git commit -a -m "typo in dijit/Button"
 * git push (sends changes to your github account)
 * open pull request on your github account to send your changes to
   upstream's master

If the upstream dojo/docs have changed then you will have to do some
merging and rebasing in your repository (after you've commited your changes):

 * git pull --rebase

Updating the documentation directly
-----------------------------------
If you do have write permission on the github dojo/docs repository then follow these steps:

 * create local fork of dojo/docs: git clone git@github.com:dojo/docs.git
 * if working on a branch:  git checkout -b 1.7
 * edit and fix some files
 * git commit -a -m "typo in dijit/Button"
 * git push

If the upstream dojo/docs have changed then you will have to do some
merging and rebasing in your repository (after you've commited your changes):

 * git pull --rebase

Previewing local changes before commit
======================================
In order to test your documentation changes, you should run rstwiki, the tool at http://livedocs.dojotoolkit.org,
locally, against your clone of the documentation repository.
In this case you will disable automatic commit and push to github.

Running rstwiki locally will allow you to make sure that code examples work and
to confirm the reST formatting of your files.

Alternately, you can do an export of the doc, as explained in the "Exporting the doc" section below.
However, that is not recommended since it takes a long time to build all the documentation.

Setup rstwiki on Mac
--------------------

Follow these instructions to setup on mac or another UNIX box:

1. Clone `rstwiki` somewhere

    ::

        $ cd ~/
        $ git clone git@github.com:phiggins42/rstwiki.git

    If you'd like to participate in the development of rstwiki itself (UI, backend, etc), ask for write permission on 
    that repo.

2. Install required python things (tested w/ Python 2.6 & 2.7)

    ::

        $ easy_install cheetah cherrypy docutils pygments gitdb==0.5.2 gitpython

3. Update submodules / dojo

    ::

        $ cd rstwiki
        $ git submodule init && git submodule update

4. Create wiki.conf

    Copy local.sample.conf to wiki.conf.   Edit and adjust paths.
    For this example, we'll set wiki.root to point to a dojodocs git clone, eg:

    ::

        [wiki]
        root = "/home/me/rstwiki/dojodocs"

5. Clone the "Dojo Docs" repository into that path

    ::

        $ cd ~/rstwiki
        $ git clone git@github.com:dojo/docs.git dojodocs

6. Run rstwiki

    ::

        $ export LC_CTYPE=""
        $ mkdir /tmp/rstwiki_sessions
        $ ./wiki.py

    A server should be listening on local port "4200". Point your web browser there. rstwiki will be a live preview of 
    files on disk, following a simple wiki format of a/b/c -> a/b/c.rst, with the exception of a/b/ -> a/b/index.rst 
    and a/b -> a/b.rst ...

Setup rstwiki on Windows
------------------------

Follow the general instructions above, but with these changes/notes:

  - If you have not installed ez_setup.py you will need to find it, download it and run it.

  - The %TMP% directory is not used for rstwiki_sessions. It seems to be hardcoded to c:\\tmp so you need to create 
    c:\\tmp\\rstwiki_sessions

  - I had to modify wiki.py to change

    ::

        sys.path.append(os.path.join(os.path.dirname(__file__), "_templates", "templates"))

    to

    ::

       sys.path.append(os.path.join(os.path.dirname(__file__), "templates"))

Updating Dojo Toolkit in rstwiki
--------------------------------

rstwiki has a checkout of the dojotoolkit from our github repo, managed as submodules. You can occasionally update this 
by calling:

::

    $ cd ~/rstwiki
    $ git submodule foreach git pull origin master
    $ git commit -a -m "update dojo to latest trunk"
    $ git push


Or you can replace the dijit/ dojox/ dojo/ and util/ folders with [links to] an svn checkout,
which would reflect a more recent "trunk".
(In that case, put them back to the originals before trying the commands above)

There is a `docs` namespace in rstwiki/_static/, and a build profile. This is used for both the wiki and the eventual 
reference-guide export.

Exporting the doc
=================

To create the HTML version of the documentation from the RST files, do

::

  $ cd rstwiki/export
  $ export LC_CTYPE=""
  $ mkdir build

If your documentation is in a non-standard place, first edit the makefile.   Search for "dojodocs" and replace it with 
the proper path.   Then:

::

  $ make data html

Look in build/warnings.txt for error/warning messages, such as misformatted tables or broken links.

Exporting the doc is necessary to put it on the dojotoolkit.org website, and it also generates a report about
errors/warnings in the documentation, which is useful for fixing problems.

Backporting trunk doc changes to a doc branch
=============================================

Normally in git you merge from the version branch (ex: 1.7) into the master (aka trunk).   However, with our 
documentation, at least for 1.7, we've been making all changes initially on   master, and then backporting the relevant 
ones to the 1.7 branch.    This is partly because the web interface (livedocs.dojotoolkit.org) checks into the trunk.

So these are instructions about how to copy relevant changes from the master (aka trunk) into a version branch.   They 
assume a local clone of the github docs repository, created by:

::

    $ git clone git@github.com:dojo/docs

First, get the latest doc on the trunk:

::

  $ cd [path to documentation]
  $ git pull

Then, follow one of the two paths below.

If the branch doesn't contain any branch-specific commits...
------------------------------------------------------------

Assuming that no changes have been made on the 1.7/ branch ever, other than copying commits from the trunk, the easiest 
way to "merge" trunk changes to the branch (according to 
http://stackoverflow.com/questions/1994463/how-to-cherry-pick-a-range-of-commits-and-merge-into-another-branch) is to 
do an interactive rebase:

::

  $ git checkout 1.7
  $ git rebase -i

This will bring up an editor with a list of commits, listing from oldest to newest.

Now, delete the lines for the commits that don't apply to the branch (i.e. new information about the 1.8 release).   
You can look up each commit on https://github.com/dojo/docs/commits/master to see the diff.  Then save the file and 
close the editor.

You can call

::

   $ git log

to check that the right changes were merged, plus check the files themselves.

Finally, push the branch changes on your local repository back to the master repository on github, and switch your 
local repository back to the trunk:

::

  $ git push
  $ git checkout master

If branch specific changes have already been made, or most trunk changes don't apply...
---------------------------------------------------------------------------------------

If someone has directly changed the 1.7 branch, or at some point when most of the changes to trunk don't need to be 
back ported, then should switch to using the cherry-pick command to merge, which is something like

::

  $ git checkout 1.7
  $ git cherry-pick -x commit1
  $ git cherry-pick -x commit2
  $ git cherry-pick -x commit3

commit1 should be the oldest, and commit3 should be the newest.

The -x flag is important to link the new commit with the old commit, for reference.   It adds a message to the new 
commit like "cherry picked from commit ...".

Starting with git 1.7.7.3 you can specify a range of commits to the cherry-pick command:

::

  $ git cherry-pick -x commit0..commit2

This syntax will *not* merge commit0, it starts at the commit *after* commit0.

Caution: once we run cherry-pick on the branch we can't go back to using rebase for merging changes.

Updating reference guide for Web site
=====================================

1. ``git clone --recursive git@github.com:phiggins42/rstwiki.git`` (recursive is important, build will not work if  
   submodules are not checked out)

2. Inside rstwiki, ``git clone git@github.com:dojo/docs.git dojodocs`` (edit the Makefile in ``export`` if you want these
   docs to come from somewhere else)

3. Go into ``dojodocs`` and ``git checkout 1.7`` (or whatever version you are generating documentation for)

4. Go into each of ``_static/{dojo,dijit,dojox,util}`` and ``git checkout 1.7`` (or whatever version you are
   generating documentation for)

5. ``cd export`` (in the rstwiki/ directory)

6. If you are adding reference doc for a new version of dojo (ex: 1.11), then update
``export/source/_templates/layout.html`` to set it to default to the new version.

7. Edit ``Makefile`` to contain the Dojo version you are generating documentation for

8. ``mkdir build``

9. ``export LC_CTYPE=""`` (this is necessary because if LC_CTYPE="UTF8", the build fails immediately)

10. ``make clean dojo data html``

11. To check in documentation for a new dojo version (ex: 1.11):

    - Move the ``export/build/html`` directory to ``/website-repo-path/reference-guide/1.11``
    - ``cd /website-repo-path/reference-guide/1.11``
    - Tell SVN about new files: ``find . -type f -print |xargs svn add``.  This complex command is to continue
      adding all the files after an SVN error adding ``dojox/editor/plugins/nls/th/SafePaste.js``.
    - Commit: ``svn ci -m "Add reference guide for version 1.11"``

12. To update the reference guide for an existing dojo version:

    - Copy over new and updated files: ``cd build/html; find . |cpio -p /website-repo-path/reference-guide/1.7``
    - ``cd /website-repo-path/reference-guide/1.7``
    - Tell SVN about new files, if any: ``svn add .``
    - Commit: ``svn ci -m "Updating reference guide for version 1.7"``

13. If you've checked in documentation for a new version of dojo (ex: 1.11), then you need to update the documentation
for all the previous versions of dojo, starting with 1.7.
This is necessary so the drop downs on each page (ex: ``https://dojotoolkit.org/reference-guide/1.7/``)
contain the new version.   Repeat these instructions for every old version of dojo.

14. Done, finally!

Updating rstWiki on livedocs
============================

Note: this is in ``tmpdocs.dojotoolkit.org`` on the fileserver at the moment. When it moves, init.d and apache2 conf 
need to be updated.

1. Make whatever changes you need to the repo at https://github.com/phiggins42/rstwiki

2. ``sudo -u website git pull && sudo -u website git submodule update`` on the server to retrieve the update

3. ``cd _static && sudo -u website ./build.sh`` if any CSS or JS changes were made

4. ``sudo /etc/init.d/rstwiki restart`` to pick up any Python changes
