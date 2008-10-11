## Please edit system and help pages ONLY in the moinmaster wiki! For more
## information, please see MoinMaster:MoinPagesEditorGroup.
##master-page:HomepagePrivatePageTemplate
##master-date:Unknown-Date
## IMPORTANT NOTE:
## When you use this page as a template for creating your homepage's groups page:
##  * please remove all lines starting with two hashes (##)
##  * except the acl line, please keep that, but remove one hash, so it reads #acl ...
##  * the "ME" will be automatically replaced with your name when you save the page
##acl kiuma:read,write,delete,revert
#format dojo_rst

dojo.dnd.Source
===============

:Status: Draft
:Version: 1.0
:Authors: Kiuma
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2

A Source is a d&d container that may act both like a source and a target for d&d items.

If you have not to do particular requirements, you'll use this class most of the times when you need draggable items, but there are particular cases where you need subclassing and the dojo.dnd package does not always behave as you might expect.

.. codeviewer::

  <style type="text/css">
     .dndContainer {
        border: 1px solid gray;
        width: 120px;
        padding: 3px;
        height: 200px;
     }
  </style> 
  <script type="text/javascript">
    dojo.require("dojo.dnd.Source");
  </script>
  <div class="dndContainer" dojoType="dojo.dnd.Source">
    <div class="dojoDndItem">item1</div>
    <div class="dojoDndItem">item2</div>
    <div class="dojoDndItem">item3</div>
  </div>

What above is good if you want to reorder items, but is usually not sufficient because I think you want to transfer items from a place to another like, for eample a user-role definition.
So let's keep with another example:

.. codeviewer::

  <style type="text/css">
     fieldset.dndContainer {
        border: 1px solid gray;
        width: 120px;
        padding: 3px;
        height: 200px;
        position: relative;
        float: left;
        margin-right: 5px;
     }
  </style> 
  <script type="text/javascript">
    dojo.require("dojo.dnd.Source");
  </script>
  <div class="userRoleContainer"
    <fieldset class="dndContainer availableRoles" dojoType="dojo.dnd.Source">
      <legend>Available roles</legend>
      <div class="dojoDndItem">admin</div>
      <div class="dojoDndItem">guest</div>
      <div class="dojoDndItem">publisher</div>
    </fieldset>
    <fieldset class="dndContainer assignedRoles" dojoType="dojo.dnd.Source">
      <legend>Assigned roles</legend>
      <div class="dojoDndItem">user</div>
    </fieldset>
  </div>
