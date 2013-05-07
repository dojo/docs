.. _dojox/mobile/bookmarkable:

==================================
View navigation history management
==================================

:Authors: Yoshiroh Kamiyama

.. contents ::
    :depth: 2


The bookmarkable feature
------------------------

In Dojo Mobile 1.8, the bookmarkable function has been enhanced to be able to manage 
the state of multiple views. 
The bookmarkable feature is enabled if you require the module dojox/mobile/bookmarkable. 
When you make a view transition, dojox/mobile/bookmarkable 
searches for all the selected views in the page, and sets a new fragment id that consists 
of a comma-separated list of the found views (ex. #page2,bar3,view0) to the browser's 
current URL. When you move back to this page, dojox/mobile/bookmarkable sees the list 
of selected views and restores the selected state. Note that 'selected' does not 
necessarily mean the view is 'visible'. For example, there may be a currently hidden view 
that has child views. One of the child views is 'selected', but it is not 'visible' since 
its parent is currently hidden. Sibling views always have one and only one selected view.

Example:

.. js ::

  <script>
      require([
          "dojox/mobile",
          "dojox/mobile/bookmarkable",
          ....
      ]);
  </script>

.. html ::

  <div id="home" data-dojo-type="dojox/mobile/View">
      <ul data-dojo-type="dojox/mobile/RoundRectList">
          <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='moveTo:"#page1"'>
              Go to page 1
          </li>
          <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='moveTo:"#page2"'>
              Go to page 2
          </li>
      </ul>
  </div>

The bookmarkable feature should be able to handle cases where views are nested or split. However, 
it cannot support dynamic views created by ListItem and other _ItemBase-based 
item's 'url' property. Even if the created view's IDs are pushed to the browser URL's 
fragment id, dojox/mobile/bookmarkable can never know the URL of the external content from its view id.

If you set mblForceBookmarkable:true to dojoConfig or 
data-dojo-config, and require dojox/mobile/bookmarkable, all the view transitions are 
stored in the browser history regardless of whether the value of 'moveTo' has the '#' 
prefix or not. In this case, you can omit the '#' prefix as shown in the example below.

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

  <div id="home" data-dojo-type="dojox/mobile/View">
      <ul data-dojo-type="dojox/mobile/RoundRectList">
          <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='moveTo:"page1"'>
              Go to page 1
          </li>
          <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='moveTo:"page2"'>
              Go to page 2
          </li>
      </ul>
  </div>
