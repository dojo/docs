.. _dojox/app/View:

==============
dojox/app/View
==============

:since: V1.7 (``dojox/app/view``)

``dojox/app/View`` module provides a View class to construct View instances, a template rendering engine to render view
template and view lifecycle APIs. Each View can have one parent view and optionally several children views. It provides a templated
container to host the domNodes for the children views. Its purpose is to allow the layout of the view to be provided
through an html template and to have a set of children views which the view transitions between. For example, to display
a set of tabs, you would use a View with a child view for each tab. The view's template would define where within the view
the children views are displayed and where any tab buttons and such are displayed.
In this case the  "template", for the base View is pretty simple. It is a simple HTML content. However, nodes within the
template can be tagged with data-app-region="top" (bottom, left, right) to define where that node and its children should be displayed.

For example:

.. html ::

  <div  style="background:#c5ccd3;" class="view mblView">
  	<div data-app-region="top" data-dojo-type="dojox/mobile/Heading">Tab View</div>
	<ul data-app-region="top" data-dojo-type="dojox/mobile/TabBar" barType="segmentedControl">
		<li data-dojo-type="dojox/mobile/TabBarButton" icon1="images/tab-icon-16.png" icon2="images/tab-icon-16h.png"
			transitionOptions='{title:"TabScene-Tab1",target:"tabscene,tab1",url: "#tabscene,tab1"}'
			selected="true">Tab 1</li>
		<li data-dojo-type="dojox/mobile/TabBarButton" icon1="images/tab-icon-15.png" icon2="images/tab-icon-15h.png"
			transitionOptions='{title:"TabScene-Tab2",target:"tabscene,tab2",url: "#tabscene,tab2"}'>Tab 2</li>
		<li data-dojo-type="dojox/mobile/TabBarButton" icon1="images/tab-icon-10.png" icon2="images/tab-icon-10h.png"
			transitionOptions='{title:"TabScene-Tab3",target:"tabscene,tab3",url: "#tabscene,tab3"}'>Tab 3</li>
	</ul>
  </div>


This template for the tabs view defines two areas with region top, a header and the tab buttons. The will be placed at
the top of this main view when rendered.

Normally, when using a BorderContainer, one would also have a data-app-region="center" section. In the case of a View however,
the "center" region will be applied to the currently active view (the current tab for example).

The application can also provide view definition modules to implement the View lifecyle APIs (like init(), destroy(),...).
This module can act as a view controller, synchronizing the data between the model and the view.

For example:

.. js ::

  define(["dojo/_base/lang", "dojo/dom", "dijit/registry"],
    function(lang, dom, registry){

	return {
		init: function(){
			registry.byId("mywidget").on("widgetEvent", lang.hitch(this, function(evt){
				// save the value back to the model
				this.loadedModels.myModel.value = ...;
			}));
		},

		beforeActivate: function(){
			// set the model value on the view
			var widget = registry.byId("mywidget");
			widget.set("value", this.loadedModels.myModel.value);
		},

		destroy: function(){
			// _WidgetBase.on listener is automatically destroyed when the Widget itself his.
		}
	}
  });




