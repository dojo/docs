#format dojo_rst

dojox.app
=========

:Status: Draft
:Version: 1.7


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
