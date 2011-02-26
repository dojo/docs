#format dojo_rst


Notes on how to use bug tracking
================================

.. warning ::

    This document is incomplete. 

.. contents ::

At the Dojo Project we use Trac for issue tracking. These are some notes about the conventions we use when filing, closing, updating, and triaging issues (tickets). 

Logging In
----------

The bug tracker (http://bugs.dojotoolkit.org) uses the LDAP information from the overall Dojo Foundation (http://my.dojofoundation.org). Register for a Dojo Foundation account, and login to Trac via the auth dialog using those credentials. **note** this username/password combination will work on all Dojo Sites, eg: http://docs.dojocampus.org

Getting Notified
~~~~~~~~~~~~~~~~

Trac maintains a separate mapping of usernames to email addresses, outside of LDAP. While unfortunate, it is very easy to remedy. Click "preferences" in the Trac header, and enter your email address into the appropriate field. If the name in the "Full Name" field is not your logged in username, make it so. When Trac sends out notification emails, it will look for usernames in the ``CC:`` field on the ticket and use the associated email address you've provided.

You are notified if you are the a) owner of a ticket b) filer of a ticket or c) listed as a CSV item in the ``CC:`` filed on a ticket.

Alternative, you can subscribe to the ``dojo-checkins`` mailing list, and be alerted for every change. (can be noisy some days)

Filing Tickets
--------------

Please search for duplicates prior to filing a ticket. If no duplicate is found, start a new issue by clicking "New Ticket" in the header. Fill in the following fields:

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
                has not be addressed and needs to. A target version will be set unless the ticket is closed as invalid/wontfix. 
:version:       Selects which version this bug appears in. Typically, all reports must come against a release version or trunk. If against a 
                released version, a test to verify it is not still broken in trunk is needed. 
:keywords:      Useful tags to help in searching. Eg: dojox, layout, FloatingPane.

If you have a patch, you should have indicated as such in the ``summary`` field. If you did, select the `I have files to attach` checkbox before continuing on to `Create Ticket`. 

Using the summary for good
~~~~~~~~~~~~~~~~~~~~~~~~~~

Various ``[meta]`` style tags can be added to the summary to assist in understanding the scope of the ticket. Some common tags are:

:[meta]:        A generic ticket to track all of a type of commit. eg: "[meta] Expand inline documentation" to prevent needing to file individual   
                tickets for repositories that require a post-commit ref. 
:[patch]:       Indicates a reported feature/bug has an associated patch file fixing the issue.
:[cla]:         Used in conjunction with ``[patch]``, indicates the attached patch is covered under an Individual CLA from the user.
:[ccla]:        Used in conjunction with ``[patch]``, indicates the attached patch is covered under a Corportate CLA
:[regression]:  Used to indicate the ticket reports a regressed bit of functionality.

When working in DojoX, if no Component is more accurate than the top level ``dojox``, use ``dojox`` and include a ``[meta]`` tag using the component name. Do this recursively in projects with components. eg: If a bug is against ``dojox.layout.FloatingPane``, the Component would be ``DojoX Layout`` and the meta tag would be: ``[FloatingPane]``, making the summary look something like:

.. code-block ::

    [patch][cla][FloatingPane] Fails to start when created in an iframe

This indicates to the ``FloatingPane`` owner a fix covered under CLA lives in this ticket.

Patches
-------
