.. _dojox/mobile/dynamic-content-loading:

=======================
Dynamic Content Loading
=======================

:Authors: Yoshiroh Kamiyama

.. contents ::
    :depth: 2

Before or after making a view transition, sometimes you may want to create a new target view content dynamically using an ajax call. There are several ways to lazy-load contents to update or create a view.

The "url" property of _ItemBase
===============================

The _ItemBase class has the "url" property that allows you to specify an html fragment page or JSON data that will be a new view content after making a view transition. The content is loaded either with a sync XHR call or async XHR following the value of the "sync" property. The _ItemBase class is a base class of ListItem, IconItem, TabBarButton, and ToolBarButton. You can use the url property from those subclasses.

If you make a transition, a new view is created as a sibling of the current view by default. If you want to add it into the other node, you can specify its node id with the urlTarget property.

Usage of the url property is as follows.

.. html ::

  <ul data-dojo-type="dojox.mobile.RoundRectList">
     <li data-dojo-type="dojox.mobile.ListItem" transition="slide" url="view1.html">
        External View #1 (sync)
     </li>
     <li data-dojo-type="dojox.mobile.ListItem" transition="flip" url="view2.json" sync="false">
        External View #2 (async)
     </li>
  </ul>

Create a View from Html Fragment
--------------------------------

Below is an example of an html fragment that represent a view. A parser (dojo.parser or dojox.mobile.parser) is called to parse the html fragment. The top level widget must be dojox.mobile.View or its subclass, because the entire html fragment will become a new transition target view. The new view will be created as a sibling of the current view. <script> tags cannot be included in an html fragment.

Example of view html fragment:

.. html ::

  <div data-dojo-type="dojox.mobile.View">
      <h1 data-dojo-type="dojox.mobile.Heading" back="Home" moveTo="foo">view1.html</h1>
      <ul data-dojo-type="dojox.mobile.EdgeToEdgeList">
      <li data-dojo-type="dojox.mobile.ListItem">
          Jack Coleman
      </li>
      <li data-dojo-type="dojox.mobile.ListItem">
          James Evans
      </li>
      <li data-dojo-type="dojox.mobile.ListItem">
          Jason Griffin
      </li>
      </ul>
  </div>

Create a View from JSON data
----------------------------

Below is an example of JSON data that represent a view. It is equivalent to the above html fragment example, and thus you will get the same view. However, note that html fragment cannot always be converted to JSON, because when some items are placed into a hash, the order information is lost. No such information loss occurs with the html format.

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

ListItem can have an action handler by simply adding an onclick event handler as follows. You can control a view transition programmatically in your action handler. In that case, specify moveTo="#" to disable the default view transition while having the arrow icon at the right of the list item. (If you omit the moveTo attribute here, the default view transition is disabled, but the arrow icon disappears to indicate that this item does not make view transition.)

.. html ::

  <li data-dojo-type="dojox.mobile.ListItem" moveTo="#" onclick="myAction(this)">
     Update View
  </li>

dojox/mobile/tests/test_list-actions.html is the complete example.

Update Existing View Content and Make Transition
------------------------------------------------

In the action handler, you can update the transition target view, and then programmatically make a transition to it as follows. The ListItem widget that initiated the action can be accessed via dijit.byNode(li). A transition can be performed by calling the transitionTo method of the source view.

.. js ::

  function myAction1(li)
     var rect = dijit.byId("rect1"); // RoundRect in view1
     rect.containerNode.innerHTML = new Date();
     dijit.byNode(li).transitionTo("view1");
  }

.. html ::

  <div id="view1" data-dojo-type="dojox.mobile.View">
     <h1 data-dojo-type="dojox.mobile.Heading" back="Home" moveTo="home">Current Status</h1>
     <h2 data-dojo-type="dojox.mobile.RoundRectCategory">Local Time</h2>
     <div id="rect1" data-dojo-type="dojox.mobile.RoundRect" shadow="true"></div>
  </div>

Load Content into Existing View and Make Transition
---------------------------------------------------

In this example, view content is loaded asynchronously, the destination view is updated with the loaded content, and then a transition is performed. ProgressIndicator is used since the loading is async.

.. js ::

  function myAction2(li){
     var view2 = dijit.byId("view2"); // destination view
     var listItem = dijit.byNode(li);
     var prog = dojox.mobile.ProgressIndicator.getInstance();
     dojo.body().appendChild(prog.domNode);
     prog.start();
     view2.destroyDescendants();

     var url = "http://..."; // or var url = listItem.url;
     dojo.xhrGet({
         url: url,
         handleAs: "text",
         load: function(response, ioArgs){
             var container = view2.containerNode;
             container.innerHTML = response;
             dojo.parser.parse(container);
             prog.stop();
             listItem.transitionTo("view2");
         }
     });
  }

.. html ::

  <div id="view2" data-dojo-type="dojox.mobile.View"></div>

Make Transition and Load Content into Existing View
---------------------------------------------------

This example is almost the same as the previous one, but in this example, a view transition is performed first, and then content loading is performed.

.. js ::

  function myAction3(li){
     var view3 = dijit.byId("view3"); // destination view
     var listItem = dijit.byNode(li);
     var prog = dojox.mobile.ProgressIndicator.getInstance();
     dojo.body().appendChild(prog.domNode);
     prog.start();
     view3.destroyDescendants();
     listItem.transitionTo("view3");

     var url = "http://..."; // or var url = listItem.url;
     dojo.xhrGet({
         url: url,
         handleAs: "text",
         load: function(response, ioArgs){
             var container = view3.containerNode;
             container.innerHTML = response;
             dojo.parser.parse(container);
             prog.stop();
         }
     });
  }

.. html ::

  <div id="view3" data-dojo-type="dojox.mobile.View"></div>

Create a New View and Make Transition
-------------------------------------

The above three examples are examples of updating an existing view. In this example, however, a view (and its content as well) is created programmatically, and then a view transition is performed.

.. js ::

  function myAction4(li){
     if(!dijit.byId("view4")){
     var view4 = new dojox.mobile.View({
         id: "view4",
         selected: true
     }, dojo.create("DIV", null, dojo.body()));
     view4.startup();

     var heading1 = new dojox.mobile.Heading({
         label: "Dynamic View",
         back: "Home",
         moveTo: "home"
     });
     view4.addChild(heading1);

     var categ1 = new dojox.mobile.RoundRectCategory({
         label: "Documents"
     });
     view4.addChild(categ1);

     var list1 = new dojox.mobile.RoundRectList();
     view4.addChild(list1);

     var counter = 4;
     for(var i = 1; i <= 3; i++){
         var item1 = new dojox.mobile.ListItem({
         icon: "images/i-icon-"+i+".png",
         label: "Document 000"+counter
         });
         list1.addChild(item1);
         counter++;
     }
     }
     dijit.byNode(li).transitionTo("view4");
  }

Update DataList
---------------

This example updates an existing RoundRectDataList via a dojo.data datastore, and then makes a transition.

.. js ::

  function myAction5(li){
     var list1 = dijit.byId("list1");
     if(!list1.store){
         var store1 = new dojo.data.ItemFileReadStore({url: ".../data.json"});
         list1.setStore(store1, {label: '*e'}); // items whose label ends with 'e'
     }
     dijit.byNode(li).transitionTo("view5");
  }

.. html ::

  <div id="view5" data-dojo-type="dojox.mobile.View">
     <h1 data-dojo-type="dojox.mobile.Heading">RoundRectDataList</h1>
     <ul id="list1" data-dojo-type="dojox.mobile.RoundRectDataList"></ul>
  </div>

Partial Update Using dojox.mobile.ContentPane
---------------------------------------------

In this example, there is a dojox.mobile.ContentPane widget in the transition target view. dojox.mobile.ContentPane is a very simple container widget, so it can be thought as a <div> with the "href" attribute. This example updates the ContentPane with an external html fragment, and then make a transition.

.. js ::

  function myAction6(li){
     var pane1 = dijit.byId("pane1");
     if(!pane1.domNode.innerHTML){ // nothing has been loaded yet
         dojo.connect(pane1, "onLoad", null, function(){
             // onLoad fires when the content is ready
             dijit.byNode(li).transitionTo("view6");
         });
         pane1.set("href", "fragment1.html");
     }else{
         dijit.byNode(li).transitionTo("view6");
     }
  }

.. html ::

  <div id="view6" data-dojo-type="dojox.mobile.ScrollableView">
     <h1 data-dojo-type="dojox.mobile.Heading" back="Home" moveTo="home" fixed="top">Partial Update</h1>
     <h2 data-dojo-type="dojox.mobile.RoundRectCategory">Dynamic Content</h2>
     <div id="pane1" data-dojo-type="dojox.mobile.ContentPane"></div>
     <ul data-dojo-type="dojox.mobile.RoundRectList">
         <li data-dojo-type="dojox.mobile.ListItem" moveTo="home" transitionDir="-1">
             Home
         </li>
     </ul>
  </div>
