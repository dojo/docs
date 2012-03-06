.. _developer/rstwiki:

======================================
Editing Dojo's Reference Documentation
======================================

.. contents ::


The dojo reference documentation is stored at https://github.com/dojo/docs.  The documentation is all flat text files, in reST format.

Documentation Formatting Rules
==============================

A handy reference guide is available: http://docutils.sourceforge.net/docs/user/rst/quickref.html.

Here are some basics though:

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

Inline text
-----------

The following text:

  ::

    **bold** ... *less bold* ... ``code`` ... `emphasis` ...

will format as


    **bold** ... *less bold* ... ``code`` ... `emphasis` ...

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

Links
-----

You can link to external pages, internal pages, and sections within the same page.

External links look like::

    `Text of Link <http://example.com/link.url.html>`_

This would become: `Text of Link <http://example.com/link.url.html>`_

Linking to other internal pages uses `ref` ::

    :ref:`Jump to Somewhere! <somewhere/else>`

This would become: :ref:`Jump to Dijit! <somewhere/else>`

Finally, it is possible to cross-reference sections internally. If the section heading is a single word, you can simply add a trailing underscore to the word::

    Jump to Links_

This would create a link back to a major section: Links_

To reference a multi-word section header, surround the words with **`** and add a following underscore::

    Jump to `the basics`_

This would become: Jump to `the basics`_ (notice the case insensitivity here. It is not possible to have two headings with the same wording, even if under different subheadings)

Pages
-----

Each page must contain some basic information. When creating a page via the wiki interface, some skeletal reST is injected for you. The first and most important is the first line, a location to your document::

    .. _foo/bar/baz:

The above would point to a file at foo/bar/baz.rst

Next, include a top-level page heading. It can be anything, and serves as the document title. Many Dojo pages simply use the module as the first title::

    ===========
    foo.bar.baz
    ===========

The number of ``=`` characters must be equal or greater than the length of the title.

Next, provide a ``contents`` directive, to auto generate links to the various subsections::

    .. contents ::
        :depth: 2

Then continue on adding subsections, separated by headings. Using a top/bottom bar for your first heading, you could use the following syntax for sub-headings::

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

The depth of the sections is relevant, and can be previewed in the table of contents (which uses embedded unordered-lists as output)

Directives
----------

rstWiki ships with a ``dojo.py`` collection of custom directives in addition to the standard formatting directives above. There 3 styles of code formatting names, shorthanded to ``js``, ``html``, and ``css``

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

        You don't have to put words about the subsections

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

    You don't have to put words about the subsections

    .. html ::

        <p id="bar">Test?</p>

    .. css ::

        #bar { color:green; }


Images
------

Images can be referenced by an ``image`` directive::

    .. image :: pathtoimage.png

The location is relative::

    .. image :: /logo.png
    .. image :: logo.png

The former will look for an image in the root of the document tree, whereas the latter will look for an image in the current directory.

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

**note:** some existing files may not follow this pattern consistently, though all current namespace/file conflicts have been resolved. New files added should follow this pattern.

**note:** the wiki attempts to discover ``index.rst`` files automatically and does not include them in the breadcrumb [currently] unless explicitly linked to. This could cause pages to link properly in the wiki but not in export. FIXME/confusing


Editing documentation online
============================

You can edit the documentation online, through http://livedocs.dojotoolkit.org (previously docs.dojocampus.org).  Changes will be pushed upstream to the master git repository.

Editing documentation locally
=============================

As an alternative to editing documentation online, you can clone the documentation repository from github, and edit it locally, pushing the changes back to github when you are finished.   (If you don't have write permission on the github dojo/docs repository you can submit a pull request).

In this case, in order to test your documentation changes, you should run rstwiki, the tool at http://livedocs.dojotoolkit.org, locally, against your clone of the documentation repository. In this case you will disable automatic commit and push to github.

This strategy is ideal for testing large changes, and being able to use your favorite text editor / IDE to manage the files, while giving you a simple preview of the content.

Setup for mac
-------------

1. clone `rstwiki` somewhere:

.. code :: shell

    $ cd ~/
    $ git clone git@github.com:phiggins42/rstwiki.git

If you'd like to participate in the development of rstwiki itself (UI, backend, etc), ask for write permission on that repo.

2. install required python things (tested w/ Python 2.6 & 2.7):

.. code :: shell

    $ easy_install cheetah cherrypy docutils pygments gitdb==0.5.2 gitpython

3. update submodules / dojo:

.. code :: shell

    $ cd rstwiki
    $ git submodule init && git submodule update

4. copy local.sample.conf to wiki.conf, edit. adjust paths. For this example, we'll set wiki.root to point to a dojodocs git clone, eg:

.. code :: script

    [wiki]
    root = "/home/me/rstwiki/dojodocs"

5. clone the "Dojo Docs" repository into that path:

.. code :: shell

    $ cd ~/rstwiki
    $ git clone git@github.com:dojo/docs.git dojodocs

6. run rstwiki:

.. code :: shell

    $ export LC_CTYPE=""
    $ mkdir /tmp/rstwiki_sessions
    $ ./wiki.py

A server should be listening on local port "4200". Point your web browser there. rstwiki will be a live preview of files on disk, following a simple wiki format of a/b/c -> a/b/c.rst, with the exception of a/b/ -> a/b/index.rst and a/b -> a/b.rst ...

Notes to Windows Users:
  - The %TMP% directory is not used for rstwiki_sessions. It seems to be hardcoded to c:\\tmp so you need to create c:\\tmp\\rstwiki_sessions
  - I had to modify wiki.py to change

.. code :: python

    sys.path.append(os.path.join(os.path.dirname(__file__), "_templates", "templates"))

to

.. code :: python

   sys.path.append(os.path.join(os.path.dirname(__file__), "templates"))

I have no python knowledge so I don't know if that is a good move, but it makes it work ;) It's fine, you are just appending something to the path. Not sure why you'd need to for templates, but it's windows.

Updating Toolkit
----------------

rstwiki has a checkout of the dojotoolkit from our github repo, managed as submodules. You can occasionally update this by calling:

.. code :: shell

    $ cd ~/rstwiki
    $ git submodule foreach git pull origin master

Or you can replace the dijit/ dojox/ dojo/ and util/ folders with [links to] an svn checkout, which would reflect a more recent "trunk".

There is a `docs` namespace in rstwiki/_static/, and a build profile. This is used for both the wiki and the eventual reference-guide export.


Sending documentation updates as pull requests
----------------------------------------------
 * fork a dojo/docs repo: https://github.com/dojo/docs
 * git clone git@github.com:yourusername/docs.git
 * git remote add upstream git://github.com/dojo/docs.git
 * git config branch.master.remote upstream
 * git checkout -b your-new-branch upstream/master
 * git add .
 * git commit -m "typo in dijit/Button"
 * git push origin your-branch
 * open pull request on your github account and send your-branch to
   upstream's master

Note: github has also online file editing capabilites.

 If the upstream dojo/docs have changed then you will have to do some
 merging and rebasing in your-branch (after you've commited your changes):
 * git pull --rebase

Example for editing the 1.7 docs branch without rstwiki
-------------------------------------------------------
 * fork a dojo/docs repo: https://github.com/dojo/docs
 * git clone git@github.com:yourusername/docs.git
 * git remote add upstream git://github.com/dojo/docs.git
 * git config branch.master.remote upstream
 * git checkout -b my-contribution-branch-to-1.7 upstream/1.7
 * make changes in rst files
 * git add .
 * git commit -m "my contribution"
 * git push origin my-contribution-branch-to-1.7
 * open pull request on your github account and send my-contribution-branch-to-1.7 to
   upstream's 1.7

 If the upstream dojo/docs have changed then you will have to do some
 merging and rebasing in your-branch (after you've commited your changes):
 * git pull --rebase

Testing and Exporting the doc
=============================

To create the HTML version of the documentation from the RST files, do

.. code :: shell

  $ cd rstwiki/export
  $ export LC_CTYPE=""
  $ mkdir build

If your documentation is in a non-standard place, first edit the makefile.   Search for "dojodocs" and replace it with the proper path.   Then:

.. code :: shell

  $ make data html

Look in build/warnings.txt for error/warning messages, such as misformatted tables or broken links.

Backporting trunk doc changes to a doc branch
=============================================

Normally in git you merge from the version branch (ex: 1.7) into the master (aka trunk).   However, with our documentation, at least for 1.7, we've been making all changes initially on   master, and then backporting the relevant ones to the 1.7 branch.    This is partly because the web interface (livedocs.dojotoolkit.org) checks into the trunk.

So these are instructions about how to copy relevant changes from the master (aka trunk) into a version branch.   They assume a local clone of the github docs repository, created by:

.. code :: shell

    $ git clone git@github.com:dojo/docs

First, get the latest doc on the trunk:

.. code :: shell

  $ cd [path to documentation]
  $ git pull

Then, follow one of the two paths below.

If the branch doesn't contain any branch-specific commits...
------------------------------------------------------------

Assuming that no changes have been made on the 1.7/ branch ever, other than copying commits from the trunk, the easiest way to "merge" trunk changes to the branch (according to http://stackoverflow.com/questions/1994463/how-to-cherry-pick-a-range-of-commits-and-merge-into-another-branch) is to do an interactive rebase:

.. code :: shell

  $ git checkout 1.7
  $ git rebase -i

This will bring up an editor with a list of commits, listing from oldest to newest.

Now, delete the lines for the commits that don't apply to the branch (i.e. new information about the 1.8 release).   You can look up each commit on https://github.com/dojo/docs/commits/master to see the diff.  Then save the file and close the editor.

You can call

.. code :: shell

   $ git log

to check that the right changes were merged, plus check the files themselves.

Finally, push the branch changes on your local repository back to the master repository on github, and switch your local repository back to the trunk:

.. code :: shell

  $ git push
  $ git checkout master

If branch specific changes have already been made, or most trunk changes don't apply...
---------------------------------------------------------------------------------------

If someone has directly changed the 1.7 branch, or at some point when most of the changes to trunk don't need to be back ported, then should switch to using the cherry-pick command to merge, which is something like

.. code :: shell

  $ git checkout 1.7
  $ git cherry-pick -x commit1
  $ git cherry-pick -x commit2
  $ git cherry-pick -x commit3

commit1 should be the oldest, and commit3 should be the newest.

The -x flag is important to link the new commit with the old commit, for reference.   It adds a message to the new commit like "cherry picked from commit ...".

Starting with git 1.7.7.3 you can specify a range of commits to the cherry-pick command:

.. code :: shell

  $ git cherry-pick -x commit0..commit2

This syntax will *not* merge commit0, it starts at the commit *after* commit0.

Caution: once we run cherry-pick on the branch we can't go back to using rebase for merging changes.



Creating reference guide for Web site
=====================================

1. ``git clone --recursive git@github.com:phiggins42/rstwiki.git`` (recursive is important, build will not work if submodules are not checked out)
2. Inside there, ``git clone git@github.com:dojo/docs.git dojodocs`` (edit the Makefile in ``export`` if you want these docs to come from somewhere else)
3. Go into ``dojodocs`` and ``git checkout 1.7`` (or whatever the latest RELEASE branch is; this repo tracks trunk by default!)
4. Go into each of ``_static/{dojo,dijit,dojox,util}`` and ``git checkout 1.7.1`` (or whatever the latest RELEASE version of DTK is; rstwiki tracks some version of trunk by default!)
5. ``cd export``
6. Edit ``Makefile`` to contain the correct Dojo version
7. ``mkdir build``
8. ``export LC_CTYPE=""`` (not sure why this is necessary, but it was in the original docs!)
9. ``make clean dojo data html``
10. In the dtk repo, ``svn rm reference-guide && svn ci -m "Replacing old reference guide"``
11. Move the ``export/build/html`` directory to ``reference-guide`` in the DTK repo
12. ``svn add reference-guide && svn ci -m "Adding new reference guide"``
13. Done, finally!

Updating rstWiki on livedocs
============================

Note: this is in tmpdocs.dojotoolkit.org on the fileserver at the moment. When it moves, init.d
and apache2 conf need to be updated.

1. Make whatever changes you need to the repo at https://github.com/phiggins42/rstwiki
2. ``sudo -u website git pull && sudo -u website git submodule update`` on the server to retrieve the update
3. ``cd _static && sudo -u website ./build.sh`` if any CSS or JS changes were made
4. ``sudo /etc/init.d/rstwiki restart`` to pick up any Python changes
