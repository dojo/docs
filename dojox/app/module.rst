.. _dojox/app/module:

================
dojox/app/module
================

:since: V1.7

This package contains application modules that will be mixed into the Application class when ``dojox/app/main`` builds it. You can either create your own module or leverage on of the existing one.

The predefined modules are the following:


* ``dojox/app/module/lifecycle`` - A module that allows you to listen to the lifecycle state of the application. It is included by default.
* ``dojox/app/module/env`` – A reserved module to store the application environment (mobile vs desktop...).