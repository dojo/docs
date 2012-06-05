.. _developer/bugs:

================================
Notes on how to use bug tracking
================================

.. warning ::

    This document is incomplete.

.. contents ::

At the Dojo Project we use Trac for issue tracking.
These are some notes about the conventions we use when filing, closing, updating, and triaging issues (tickets).

Logging In
==========

The `bug tracker <http://bugs.dojotoolkit.org>`_ uses the LDAP information from the overall `Dojo Foundation <http://dojofoundation.org>`_. `Register for a Dojo Foundation account <http://my.dojofoundation.org>`_ and login to Trac via the auth dialog using those credentials. **note** this username/password combination will work on all Dojo Sites, eg: http://livedocs.dojotoolkit.org

Getting Notified
================

Trac maintains a separate mapping of usernames to email addresses, outside of LDAP.
While unfortunate, it is very easy to remedy.
Click "preferences" in the Trac header, and enter your email address into the appropriate field.
If the name in the "Full Name" field is not your logged in username, make it so.
When Trac sends out notification emails, it will look for usernames in the ``CC:`` field on the ticket and use the associated email address you've provided.

You are notified if you are the a) owner of a ticket b) filer of a ticket or c) listed as a CSV item in the ``CC:`` filed on a ticket.

Alternative, you can subscribe to the ``dojo-checkins`` mailing list, and be alerted for every change. (can be noisy some days)

Filing Tickets
==============

Please search for duplicates prior to filing a ticket.
If no duplicate is found, start a new issue by clicking "New Ticket" in the header.
Fill in the following fields:

:summary:       Some short text describing the issue. Be concise and accurate. Sensational summaries like "The sky has fallen, dojo.io.script..."
                are often overlooked.
:reporter:      Should be prefilled with your name
:description:   Long text description, including expansion on ``summary`` text, steps to reproduce, links to testcases, etc. Light wiki syntax
                is permitted in this field. Buttons above the field help to show what type of markdown is permitted.
:assign to:     Unless otherwise asked, or are certain you know who the module owner is, leave this field blank. It will be populated based on the
                "Component" selection.
:priority:      Unless life-threatening, leave as ``normal``. Release blockers and regressions can be bumped higher.
:component:     Dropdown to select the closest related subject matter for the ticket. eg: dojo.byId bug would be in "Dojo Core", documentation
                bugs would be filed under "Documentation". Some DojoX projects have Components of their own, eg: DojoX Grid.
:cc:            Additional usernames to include in the notification. This can only be changed by non-committers at creation time. After filed,
                a committer must adjust the field.
:type:          One of Defect, Enhancement, Task. If it's broken and needs fixed, Defect. If it's a "nice to have" functionality, Enhancement.
                Everything else (such as writing this document) is a Task.
:milestone:     Non-committers should leave this as ``tbd``, or "To be determined". This milestone indicates to the committers a particular bug
                has not been addressed and needs to. A target version will be set unless the ticket is closed as invalid/wontfix.
:version:       Selects which version this bug appears in. Typically, all reports must come against a release version or trunk. If against a
                released version, a test to verify it is not still broken in trunk is needed.
:keywords:      Useful tags to help in searching. Eg: dojox, layout, FloatingPane.

If you have a patch, you should have indicated as such in the ``summary`` field.
If you did, select the `I have files to attach` checkbox before continuing on to `Create Ticket`.

Using the summary for good
--------------------------

Various ``[meta]`` style tags can be added to the summary to assist in understanding the scope of the ticket.
Some common tags are:

:[meta]:        A generic ticket to track all of a type of commit. eg: "[meta] Expand inline documentation" to prevent needing to file individual
                tickets for repositories that require a post-commit ref.
:[patch]:       Indicates a reported feature/bug has an associated patch file fixing the issue.
:[cla]:         Used in conjunction with ``[patch]``, indicates the attached patch is covered under an Individual CLA from the user.
:[ccla]:        Used in conjunction with ``[patch]``, indicates the attached patch is covered under a Corporate CLA
:[regression]:  Used to indicate the ticket reports a regressed bit of functionality.

When working in DojoX, if no Component is more accurate than the top level ``dojox``, use ``dojox`` and include a ``[meta]`` tag using the component name.
Do this recursively in projects with components.
eg: If a bug is against ``dojox.layout.FloatingPane``, the Component would be ``DojoX Layout`` and the meta tag would be: ``[FloatingPane]``, making the summary look something like:

::

    [patch][cla][FloatingPane] Fails to start when created in an iframe

This indicates to the ``FloatingPane`` owner a fix covered under CLA lives in this ticket.

Dijit prefers the module name be included in the summary, when in the "component" ``Dijit``, eg:

::

    [regression] TabContainer: Title Heights collapse when ...
    
Owning a ticket
===============

There are two states for tickets.
Every ticket is "assigned to" a user (though sometimes the user is listed as ``anonymous``).
Component owners are automatically "assigned" the ticket, with a milestone of ``tbd``.
If you have ``tbd`` tickets, they need to be examined.
A cursory scan of a ticket can sometimes resolve issues very quickly.

If the ticket indicates a bug, a working test case is required.
Live links are discouraged, as they typically rot.
Standalone html pages including the minimal steps to reproduce the issue should be attached.
Leave in the ``tbd`` state, but request a followup from the user.

If the ticket is a feature request, use your discretion.
If the feature is reasonable and you are willing to create a patch (or the user has supplied a patch and documentation for said feature), mark the milestone to the next major version and close upon committing.
New features **do not** go into branch releases, as they are reserved for critical bugs only.

If the ticket is a feature request and is beyond the scope of the current version goals, requires further discussion or design, mark the ticket in whatever version you plan to complete the task, or the more generic ``future`` milestone.

``future`` means: "I like this idea but [for this reason] it can't happen now." Patches are **always** welcome, and greatly increase the likelihood of a request being filled.

There should be **absolutely no** tickets in the ``tbd`` state when a major release is cut.
This ensures we've **at least** inspected every incoming ticket to determine the severity of the report.

Tickets assigned but not "accepted" are considered fair game.
A patch submission can come from anywhere.
A Component owner "owns" the tickets, but can simply reassign should another developer want to work on said ticket.

When you "accept" a ticket for a given milestone, you are indicating you are or will be focused on that item.
Unless the ticket requests further contribution, it is likely you will receive none.
It is your duty to ensure all your "accepted" tickets are marked in an appropriate milestone prior to every major release.

Patches
=======

Patches should be attached to tickets in unified diff format, with a ``.patch`` or ``.diff`` extension.

Creating
--------

To create a patch, use `svn diff`:

.. code-block :: bash

    $ svn up
    At revision [xxxx].
    $ svn st
    M dojox/layout/FloatingPane.js
    $ svn diff > floatingpane.patch

Merging
-------
    
To apply a user supplied patch (from commandline):

.. code-block :: bash

    $ svn up
    At revision [xxxx]
    $ patch < floatingpane.patch

Using the ``-pN`` command line argument allows you to strip paths from the original diff.
For example, the above structure would require you strip two levels of the patch.
This needs to align based on where you apply the patch from in the tree versus from where the user was when creating the patch.

.. code-block :: bash

    $ svn up
    At revision [xxxx]
    $ cd dojox/layout
    $ patch -p 2 < floatingpane.patch
    
Many IDE's have SVN integration and can easily apply patches from this format.

``TODOC:`` anyone use an IDE to do this?

Commit Messages
===============

All commit messages should be descriptive of the change. "Fixed it" is generally considered a bad commit message. "Fixed layout regression in FooBar" would suffice.

The ``dojo``, ``dijit``, and ``util`` repositories require tickets to reference.
When you commit with a ``refs`` keyword, the commit message will be put in a comment on the ticket with a link to the changeset.

.. code-block :: bash

    $ svn commit -m "refs #12345 - added updated thinger to the dohicky that was conflicting with DoHickyConflictr"
    
To use a commit message to close a ticket, use the ``fixes`` keyword:

.. code-block :: bash

    $ svn commit -m "fixes #12345 - thanks for all the fish UserWhoSubmittedThePatch"
    
This will mark the ticket as ``closed`` linking the changeset to the ticket as ``refs`` would.
Do **not** close a ticket in a ``tbd`` milestone.

A form of JSLint is being run as a pre-commit hook.
Your commit will be denied if this linting fails.
You can override this by including ``!strict`` in your commit message.

.. code-block :: bash

    $ svn commit -m "refs #90210, the thing was broken before and apparently is very sloppy. lint is unhappy. \!strict"
    
You may or may not have to escape the ``!`` depending on your terminal.
