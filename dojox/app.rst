#format dojo_rst

dojox.app
=========

:Status: Draft
:Version: 1.0
:Available: since V1.7


Implements application framework using dojox.mvc for web application on desktop/mobile platforms.


============
Introduction
============
dojox.app is an application frame work designed to allow simple configuration
of nested scenes and views and to facilitate the transitioning between these
views.  It is similar in function to the dojox.mobile.app framework, but will 
not be limited to use on mobile devices.  Applications for desktops, mobiles,
and tablets will be configurable and buildable for easy and fast deployment.
There are two core libraries that will need to work together to accomplish these goals

dojox.app - A library that provides high-level application controllers, defined by metadata which describes the overall structure and navigation of the application and it’s views.

dojox.mvc - A library that provides the ability to have view concerns separated from model or data concerns but have simple bindings or connections between them that can keep either side in sync, as well as respond to events or actions.  The library also provides the ability to generate data-bound forms and views dynamically, built on key elements of mvc and app. 

=============
Usage
=============
Application structure overview.

.. image:: /Diagram1.png

dojox.app.view
dojox.app.view provides a view like dojox.mobile.View. It contains a template string which will be rendered with user defined template segments. A view should have no child view. 

dojox.app.bind
dojox.app.bind used to query dojox.mvc widgets, get and set binding data for each widgets with  "ref" or data-dojo-props="ref: xxx" tag. dojoType, data-dojo-type, ref and data-dojo-props are compatible in a view.

dojox.app.model
dojox.app.model create statefulModel data source with JSON data or dojo data store. The data model can be binded to a dojox.mvc widget by dojox.app.bind.

dojox.app.scene
dojox.app.scene used to create the layout for each view, transition to next view, resize layout to fit the display area. A scene can contains more than one views or child scenes. The difference between scene and view is that scene can have multiple children scenes views but view does not have child.

dojox.app.module.env
dojox.app.module.env provides dojo, dijit, dojox environment.

dojox.app.module.histroy
dojox.app.module.histroy used to cache transition history which can back to the latest view. A view can use 'transitionOptions' or 'href' to configure transition to next view, and the next view also can back to the original one. 

dojox.app.main – Application
dojox.app.main(Application) used to create a dojox.ap application by the configuration in config.json. The main function includes: load configuration, load data from data source, create views, create data models, bind data models to views by dojox.app.bind, create scenes between views, parse application by dojo.parser.parse. The application can be started by doing this.

============
Sample
============

================================
Comparison with dojox.mobile.app
================================

The main difference between dojox.app and dojox.mobile.app is listed as following.
dojox.app enables the model binding 
dojox.app uses scene/view structure to enable the nested scene or view which resembles the composite design pattern. It does not mean dojox.mobile.app cannot do that but it needs coding to implement that.
dojox.app contains the layout mechanism to ensure the content at different application/scene/view level work well together
dojox.mobile.app manage the navigation history in StageController by using a history stack. dojox.app manage the navigation history through HTML5 pushState standard and delegate it to browser enabled history management.

.. image:: /Diagram3.png

.. image:: /Diagram1.png

Here is the sequence diagram to reflect the difference in the navigation management.

.. image:: /Diagram4.png
