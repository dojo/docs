.. _dojox/mobile/bookmarkable:

==================================
View navigation history management
==================================

:Authors: Yoshiroh Kamiyama

.. contents ::
    :depth: 2

The bookmarkable feature in 1.7
-------------------------------

Dojo Mobile 1.7 has a simple bookmarkable functionality based on dojo.hash. If you require dojo.hash in your application, the bookmarkable function is enabled. If a transition destination value (the value of the moveTo property) has a hash sign ('#') before the id (ex. #view1), the view transition updates the hash in the browser URL so that the user can bookmark the destination view. Also, in this case, the user can use the browser's back/forward button to navigate through the views in the browser history.

Example for Dojo Mobile 1.7 or older:

.. js ::

  <script>
      dojo.require("dojo.hash");
      dojo.require("dojox.mobile");
      ....
  </script>

.. html ::

  <div id="home" dojoType="dojox.mobile.View">
      <ul dojoType="dojox.mobile.RoundRectList">
          <li dojoType="dojox.mobile.ListItem" moveTo="#page1">
              Go to page 1
          </li>
          <li dojoType="dojox.mobile.ListItem" moveTo="#page2">
              Go to page 2
          </li>
      </ul>
  </div>

Note that bookmarkable can only support simple navigations between the top level sibling views. It cannot support more complex UI layout scenarios such as nested views, splitted views, or dynamically created views, because the hash fragment value is only a single identifier.

The bookmarkable feature in 1.8
-------------------------------

In Dojo Mobile 1.8, the bookmarkable function has been enhanced to be able to manage the state of multiple views. The new bookmarkable function is enabled if you require dojox.mobile.bookmarkable. When you make a view transition, dojox.mobile.bookmarkable searches for all the selected views in the page, and sets a new fragment id that consists of a comma-separated list of the found views (ex. #page2,bar3,view0) to the browser's current URL. When you move back to this page, dojox.mobile.bookmarkable sees the list of selected views and restore the selected state. Note that 'selected' does not necessarily mean the view is 'visible'. For example, there may be a currently hidden view that has child views. One of the child views is 'selected', but it is not 'visible' since its parent is currently hidden. Sibling views always have one and only one selected view.

Example for Dojo Mobile 1.8:

.. js ::

  <script>
      require([
          "dojox/mobile",
          "dojox/mobile/bookmarkable",
          ....
      ]);
  </script>

.. html ::

  <div id="home" data-dojo-type="dojox.mobile.View">
      <ul data-dojo-type="dojox.mobile.RoundRectList">
          <li data-dojo-type="dojox.mobile.ListItem" data-dojo-props='moveTo:"#page1"'>
              Go to page 1
          </li>
          <li data-dojo-type="dojox.mobile.ListItem" data-dojo-props='moveTo:"#page2"'>
              Go to page 2
          </li>
      </ul>
  </div>

With this enhancement, the bookmarkable function should be able to handle cases where views are nested or split.

However, it cannot support dynamic views created by ListItem and other _ItemBase-based item's url property. Even if the created view's IDs are pushed to the browser URL's fragment id, dojox.mobile.bookmarkable can never know the URL of the external content from its view id.

Another new enhancement is that if you set mblForceBookmarkable:true to djConfig or data-dojo-config, and require dojox.mobile.bookmarkable, all the view transitions are stored in the browser history regardless of whether the value of moveTo has the '#' prefix or not. In this case, you can omit the '#' prefix as shown in the example below.

.. js ::

  <script src="../dojo.js" data-dojo-config="..., mblForceBookmarkable: true"></script>
  <script>
      require([
          "dojox/mobile",
          "dojox/mobile/bookmarkable",
          ....
      ]);
  </script>

.. html ::

  <div id="home" data-dojo-type="dojox.mobile.View">
      <ul data-dojo-type="dojox.mobile.RoundRectList">
          <li data-dojo-type="dojox.mobile.ListItem" data-dojo-props='moveTo:"page1"'>
              Go to page 1
          </li>
          <li data-dojo-type="dojox.mobile.ListItem" data-dojo-props='moveTo:"page2"'>
              Go to page 2
          </li>
      </ul>
  </div>
