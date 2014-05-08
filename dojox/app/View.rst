.. _dojox/app/View:

==============
dojox/app/View
==============

:since: V1.7 (``dojox/app/view``)

``dojox/app/View`` module provides the default View for ``dojox/app``. It supports the view definition logic and lifecycle (aka View controller) from ``dojox/app/ViewBase`` as well as a template rendering engine to load the view UI as a template and the ability to provide an internationalisation module for the view. For those who want to build their own views based on alternate templating system, or without a templating system they should directly extend ``dojox/app/ViewBase``.

Each View can have one parent view and optionally several children views. It provides a templated
container to host the DOM nodes for the children views. Its purpose is to allow the layout of the view to be provided
through an html template and to have a set of children views which the view transitions between. For example, to display a set of tabs, you would use a View with a child view for each tab. The view's template would define where within the view the children views are displayed and where any tab buttons and such are displayed.
In this case the  "template", for the base View is pretty simple. It is a simple HTML content. However, nodes within the template can be tagged with data-app-constraint="top" (bottom, left, right) to define where that node and its children should be displayed.

The models (``dojox/mvc`` based or not) loaded from the config are available through the ``loadedModels`` property on the view. And the stores loaded from the config are available through the ``loadedStores`` property on the view.  Similarly the loaded NLS will be available through the ``nls`` property. On a given view both the models, stores and the nls of the parent views (up to the application) are available as well.

For example:

.. html ::

  <div  style="background:#c5ccd3;" class="view mblView">
  	<div data-app-constraint="top" data-dojo-type="dojox/mobile/Heading">Tab View</div>
	<ul data-app-constraint="top" data-dojo-type="dojox/mobile/TabBar" barType="segmentedControl">
		<li data-dojo-type="dojox/mobile/TabBarButton" icon1="images/tab-icon-16.png"
			icon2="images/tab-icon-16h.png"
			transitionOptions='{title:"TabScene-Tab1",target:"tabscene,tab1",url: "#tabscene,tab1"}'
			selected="true">Tab 1</li>
		<li data-dojo-type="dojox/mobile/TabBarButton" icon1="images/tab-icon-15.png"
			icon2="images/tab-icon-15h.png"
			transitionOptions='{title:"TabScene-Tab2",target:"tabscene,tab2",url: "#tabscene,tab2"}'>Tab 2</li>
		<li data-dojo-type="dojox/mobile/TabBarButton" icon1="images/tab-icon-10.png"
			icon2="images/tab-icon-10h.png"
			transitionOptions='{title:"TabScene-Tab3",target:"tabscene,tab3",url: "#tabscene,tab3", duration: 1000}'>Tab 3</li>
	</ul>
  </div>


This template for the tabs view defines two areas with region top, a header and the tab buttons. The will be placed at
the top of this main view when rendered.

Normally, when using a BorderContainer, one would also have a data-app-constraint="center" section. In the case of a View however, the "center" region will be applied to the currently active view (the current tab for example).

The application can also provide view definition modules to implement the View lifecycle APIs which include ( init(), beforeActivate(), afterActivate(), beforeDeactivate(), afterDeactivate(), and destroy()).

* ``init()`` is called once after the view is created before it is shown for the first time.

* ``beforeActivate(previousView, data)`` is called before the view is shown each time it is being transitioned in.

* ``beforeDeactivate(nextView, data)`` is called before the view is hidden each time it is being transitioned out.

* ``afterActivate(previousView, data)`` is called after the view is shown each time it is being transitioned in.

* ``afterDeactivate(nextView, data)`` is called after the view is hidden each time it is being transitioned out.


This module can act as a view controller, synchronizing the data between the model and the view.

For example:

.. js ::

  define(["dojo/_base/lang", "dojo/dom", "dijit/registry"],
    function(lang, dom, registry){

	return {
		init: function(){
			console.log(this.name+" init called");
			registry.byId("mywidget").on("widgetEvent", lang.hitch(this, function(evt){
				// save the value back to the model
				this.loadedModels.myModel.value = ...;
			}));
		},

		beforeActivate: function(previousView, data){
			console.log(this.name+" beforeActivate called");
			// set the model value on the view
			var widget = registry.byId("mywidget");
			widget.set("value", this.loadedModels.myModel.value);
		},

		afterActivate: function(previousView, data){
			console.log(this.name+" afterActivate called");
		},

		beforeDeactivate: function(nextView, data){
			console.log(this.name+" beforeDeactivate called");
		},

		afterDeactivate: function(nextView, data){
			console.log(this.name+" afterDeactivate called");
		}
	};
  });


The data received in the activation and deactivation methods are the data passed in the data attributes of the
transition options of the transition that led to that view.

