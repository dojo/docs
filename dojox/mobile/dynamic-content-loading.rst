.. _dojox/mobile/dynamic-content-loading:

=======================
Dynamic Content Loading
=======================

:Authors: Yoshiroh Kamiyama

.. contents ::
    :depth: 2

Before or after performing a view transition, sometimes you may want to create a new target view content dynamically using an ajax call. There are several ways to lazy-load contents to update or create a view.

The "url" property of _ItemBase
===============================

The _ItemBase class has a "url" property that allows you to specify an html fragment page or a JSON data that will become the new view content after performing the view transition. The content is loaded either with a sync XHR call or an async XHR call according to the value of the "sync" property. The _ItemBase class is a base class of ListItem, IconItem, TabBarButton, ToolBarButton, and IconMenuItem. You can use the url property from those subclasses.

If you perform a transition, a new view is created as a sibling of the current view by default. If you want to add it into another node, you can specify its node id with the urlTarget property.

Usage of the url property is as follows.

.. html ::

  <ul data-dojo-type="dojox/mobile/RoundRectList">
     <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='transition:"slide", url:"view1.html"'>
        External View #1 (sync)
     </li>
     <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='transition:"flip", url:"view2.html", sync:false'>
        External View #2 (async)
     </li>
  </ul>

Create a View from Html Fragment
--------------------------------

Below is an example of an html fragment that represents a view. A parser (dojo/parser or dojox/mobile/parser) is called to parse the html fragment. The top level widget must be dojox/mobile/View or its subclass, because the entire html fragment will become a new transition target view. The new view will be created as a sibling of the current view. <script> tags cannot be included in the html fragment.

Example of view html fragment:

.. html ::

  <div data-dojo-type="dojox/mobile/View">
      <h1 data-dojo-type="dojox/mobile/Heading" data-dojo-props='back:"Home", moveTo:"foo"'>view1.html</h1>
      <ul data-dojo-type="dojox/mobile/EdgeToEdgeList">
      <li data-dojo-type="dojox/mobile/ListItem">
          Jack Coleman
      </li>
      <li data-dojo-type="dojox/mobile/ListItem">
          James Evans
      </li>
      <li data-dojo-type="dojox/mobile/ListItem">
          Jason Griffin
      </li>
      </ul>
  </div>

Create a View from JSON data
----------------------------

Below is an example of JSON data that represents a view. It is equivalent to the above html fragment example, and thus you will get the same view. However, note that an html fragment cannot always be converted to JSON, because when some items are placed into a hash, the order information is lost. No such information loss occurs with the html format.

Example of view JSON data:

.. js ::

  {
    "dojox.mobile.View": {
      "dojox.mobile.Heading": {
        "@back": "Home",
        "@moveTo": "foo",
        "@label": "view1.json"
      },
      "dojox.mobile.EdgeToEdgeList": {
        "dojox.mobile.ListItem": [{
          "@label": "Jack Coleman"
        }, {
          "@label": "James Evans"
        }, {
          "@label": "Jason Griffin"
        }]
      }
    }
  }

ListItem Actions
================

ListItem can have an action handler by simply adding an onclick event handler as follows. You can control a view transition programmatically in your action handler. In that case, specify moveTo="#" to disable the default view transition while displaying the arrow icon at the right of the list item. (If you omit the moveTo attribute here, the default view transition is disabled, and the arrow icon disappears to indicate that this item does not perform a view transition.)

.. html ::

  <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='moveTo:"#", onClick:myAction'>
     Update View
  </li>

dojox/mobile/tests/test_ListItem-actions.html is a complete example.

Update Existing View Content and Perform Transition
---------------------------------------------------

In the action handler, you can update the transition target view, and then programmatically perform a transition to it as follows. The ListItem widget that initiated the action can be accessed via dijit.byNode(li). The transition can be performed by calling the transitionTo method of the source view.

.. js ::

  myAction1 = function(){
      var rect = registry.byId("rect1");
      rect.containerNode.innerHTML = new Date();
      this.transitionTo("view1");
  }

.. html ::

  <div id="view1" data-dojo-type="dojox/mobile/View">
     <h1 data-dojo-type="dojox/mobile/Heading" data-dojo-props='back:"Home", moveTo:"home"'>Current Status</h1>
     <h2 data-dojo-type="dojox/mobile/RoundRectCategory">Local Time</h2>
     <div id="rect1" data-dojo-type="dojox/mobile/RoundRect" data-dojo-props='shadow:true'></div>
  </div>

Load Content into Existing View and Perform Transition
------------------------------------------------------

In this example, the view content is loaded asynchronously, the destination view is updated with the loaded content, and then a transition is performed. The ProgressIndicator is used since the loading is async.

.. js ::

  myAction2 = function(){
      var view2 = registry.byId("view2"); // destination view
      var listItem = this;
      var prog = ProgressIndicator.getInstance();
      win.body().appendChild(prog.domNode);
      prog.start();
      view2.destroyDescendants();

      var url = "http://..."; // or var url = listItem.url;
      xhr(url, {
          handleAs: "text"
      }).then(function(response) {
          var container = view2.containerNode;
          container.innerHTML = response;
          parser.parse(container);
          prog.stop();
          listItem.transitionTo("view2");
      });
  }

.. html ::

  <div id="view2" data-dojo-type="dojox/mobile/View"></div>

Perform Transition and Load Content into Existing View
------------------------------------------------------

This example is almost the same as the previous one, but in this example, view transition is performed first, and then content loading is performed.

.. js ::

  myAction3 = function(){
      var view3 = registry.byId("view3"); // destination view
      var listItem = this;
      var prog = ProgressIndicator.getInstance();
      win.body().appendChild(prog.domNode);
      prog.start();
      view3.destroyDescendants();
      listItem.transitionTo("view3");

      var url = "http://..."; // or var url = listItem.url;
      xhr(url, {
          handleAs: "text"
      }).then(function(response) {
          var container = view3.containerNode;
          container.innerHTML = response;
          parser.parse(container);
          prog.stop();
      });
  }

.. html ::

  <div id="view3" data-dojo-type="dojox/mobile/View"></div>

Create a New View and Perform Transition
----------------------------------------

The above three examples are examples of updating an existing view. In this example, however, a view (and its content as well) is created programmatically, and then a view transition is performed.

.. js ::

  myAction4 = function(){
      if(!registry.byId("view4")){
          var view4 = new View({
              id: "view4",
              selected: true
          }, domConstruct.create("DIV", null, win.body()));
          view4.startup();

          var heading1 = new Heading({
              label: "Dynamic View",
              back: "Home",
              moveTo: "home"
          });
          heading1.placeAt(view4.containerNode);
          heading1.startup();

          var categ1 = new RoundRectCategory({
              label: "Documents"
          });
          categ1.placeAt(view4.containerNode);
          categ1.startup();

          var list1 = new RoundRectList();
          list1.placeAt(view4.containerNode);
          list1.startup();

          var counter = 4;
          for(var i = 1; i <= 3; i++){
              var item1 = new ListItem({
                  icon: "images/i-icon-"+i+".png",
                  label: "Document 000"+counter
              });
              item1.placeAt(list1.containerNode);
              item1.startup();
              counter++;
          }
      }
      this.transitionTo("view4");
  }

Update DataList
---------------

This example updates an existing RoundRectDataList via a dojo/data datastore, and then performs a transition.

.. js ::

  myAction5 = function(){
      var list1 = registry.byId("list1");
      if(!list1.store){
          var store1 = new ItemFileReadStore({data: static_data});
          list1.setStore(store1, {label: '*e'}); // items whose label ends with 'e'
      }
      this.transitionTo("view5");
  }

.. html ::

  <div id="view5" data-dojo-type="dojox/mobile/View">
     <h1 data-dojo-type="dojox/mobile/Heading">RoundRectDataList</h1>
     <ul id="list1" data-dojo-type="dojox/mobile/RoundRectDataList"></ul>
  </div>

Partial Update Using dojox/mobile/ContentPane
---------------------------------------------

In this example, there is a dojox/mobile/ContentPane widget in the transition target view. dojox/mobile/ContentPane is a very simple container widget, so it can be thought of as a <div> with the "href" attribute. This example updates the ContentPane with an external html fragment, and then performs a transition.

.. js ::

  myAction6 = function(){
      var pane1 = registry.byId("pane1");
      if(!pane1.domNode.innerHTML){ // nothing has been loaded yet
          pane1.on("load", lang.hitch(this, function(){
              // onLoad fires when the content is ready
              this.transitionTo("view6");
          }));
          pane1.set("href", "fragment1.html");
      }else{
          this.transitionTo("view6");
      }
  }

.. html ::

  <div id="view6" data-dojo-type="dojox/mobile/ScrollableView">
     <h1 data-dojo-type="dojox/mobile/Heading" data-dojo-props='back:"Home", moveTo:"home", fixed:"top"'>Partial Update</h1>
     <h2 data-dojo-type="dojox/mobile/RoundRectCategory">Dynamic Content</h2>
     <div id="pane1" data-dojo-type="dojox/mobile/ContentPane"></div>
     <ul data-dojo-type="dojox/mobile/RoundRectList">
         <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='moveTo:"home", transitionDir:-1'>
             Home
         </li>
     </ul>
  </div>
