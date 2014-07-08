.. _dojo/index:

====
dojo
====

.. contents ::
   :depth: 3


**dojo** is the foundation package of the Dojo Toolkit. Sometimes referred to as the "core", it contains the most
generally applicable packages and modules. The ``dojo`` package covers a wide range of functionality like AJAX, DOM
manipulation, class-type programming, events, promises, data stores, drag-and-drop and internationalization libraries.

dojo/dojo
=========

This is the bootstrap module for the toolkit.  It contains both the AMD and legacy loader that allows you to load other 
modules and it defines ``require()`` and ``define()``, the AMD functions.  For backwards compatibility reasons, the 
module defaults to a synchronous mode and automatically loads several modules the provide an API similar to releases 
prior to 1.7.  When the ``dojoConfig`` option of ``async`` is set to ``true`` the module then will operate 
asynchronously and loads the minimal amount of modules.

See :ref:`dojo/dojo <dojo/dojo>` for more information on the module, as well as there is in depth information about the 
Dojo :ref:`loader <loader/index>` available.

dojo/_base
==========

This package and associated modules break out the functionality that formally was contained in the base ``dojo/dojo`` 
module.  Many of the modules in this package define the "legacy" APIs for modules and packages that now sit in the root 
of the ``dojo`` package.

Areas of Functionality
======================

The following table provides an overview of the sub-packages and modules in the ``dojo`` package.

============================= ====================================================== ===================================
Functionality                 Packages/Modules                                       Description
============================= ====================================================== ===================================
Dojo Kernel                   :ref:`dojo/_base/kernel <dojo/_base/kernel>`           The bootstrap kernel that 
                                                                                     generates the ``dojo`` namespace
Dojo Configuration            :ref:`dojo/_base/config <dojo/_base/config>`           Configures Dojo and loads the 
                                                                                     default platform configuration
Module Loading                :ref:`dojo/_base/loader <dojo/_base/loader>`           The legacy and AMD module loader 
                                                                                     for Dojo
                              :ref:`dojo/require <dojo/require>` [1]_
Loader Plugins                :ref:`dojo/domReady <dojo/domReady>`                   AMD Loader Plugins
                              
                              :ref:`dojo/i18n <dojo/i18n>`
                              
                              :ref:`dojo/has <dojo/has>`
                              
                              :ref:`dojo/node <dojo/node>`
                              
                              :ref:`dojo/text <dojo/text>`
Feature Detection             :ref:`dojo/has <dojo/has>`                             Modules that provide 
                                                                                     cross-platform feature detection 
                              :ref:`dojo/sniff <dojo/sniff>`                         and management
                              
                              :ref:`dojo/uacss <dojo/uacss>`
                              
                              :ref:`dojo/_base/sniff <dojo/_base/sniff>` [1]_
Language                      :ref:`dojo/_base/lang <dojo/_base/lang>`               The foundation language extensions 
                                                                                     for Dojo
Classes                       :ref:`dojo/_base/declare <dojo/_base/declare>`         Dojo's class system
Deferreds and Promises        :ref:`dojo/promise <dojo/promise>`                     Asynchronous process management 
                                                                                     modules
                              :ref:`dojo/Deferred <dojo/Deferred>`
                              
                              :ref:`dojo/when <dojo/when>`
                              
                              :ref:`dojo/_base/Deferred <dojo/_base/Deferred>` [1]_
                              
                              :ref:`dojo/DeferredList <dojo/DeferredList>` [1]_
Events, Connections           :ref:`dojo/on <dojo/on>`                               Modules for handling events and 
                                                                                     modifying behaviors
                              :ref:`dojo/_base/connect <dojo/_base/connect>`
                              
                              :ref:`dojo/_base/event <dojo/_base/event>`
                              
                              :ref:`dojo/Evented <dojo/Evented>`
                              
                              :ref:`dojo/behavior <dojo/behavior>` [1]_
Aspect Oriented Programming   :ref:`dojo/aspect <dojo/aspect>`                       Providing aspect based advice to 
                                                                                     modify join points (methods)
Requests                      :ref:`dojo/request <dojo/request>`                     Handling of requests, the core of 
                                                                                     "AJAX" programming
                              :ref:`dojo/_base/xhr <dojo/_base/xhr>` [1]_
                              
                              :ref:`dojo/io/iframe <dojo/io/iframe>` [1]_
                              
                              :ref:`dojo/io/script <dojo/io/script>` [1]_
Properties                    :ref:`dojo/Stateful <dojo/Stateful>`                   Management of object and class 
                                                                                     properties
Topics/Publish/Subscribe      :ref:`dojo/topic <dojo/topic>`                         Dojo's Topic system
Data and Stores               :ref:`dojo/store <dojo/store>`                         Packages that provide client side 
                                                                                     data handling
                              :ref:`dojo/data <dojo/data>` [1]_
Router                        :ref:`dojo/router <dojo/router>`                       Allows mapping of hash based 
                                                                                     structures to callbacks
Parser                        :ref:`dojo/parser <dojo/parser>`                       Allows "decorated" HTML to be 
                                                                                     converted into instantiated objects
DOM and HTML                  :ref:`dojo/dom <dojo/dom>`                             Modules for manipulating and 
                                                                                     managing the DOM and HTML
                              :ref:`dojo/dom-attr <dojo/dom-attr>`
                              
                              :ref:`dojo/dom-class <dojo/dom-class>`
                              
                              :ref:`dojo/dom-construct <dojo/dom-construct>`
                              
                              :ref:`dojo/dom-form <dojo/dom-form>`
                              
                              :ref:`dojo/dom-geometry <dojo/dom-geometry>`
                              
                              :ref:`dojo/dom-prop <dojo/dom-prop>`
                              
                              :ref:`dojo/dom-style <dojo/dom-style>`
                              
                              :ref:`dojo/html <dojo/html>`
                              
                              :ref:`dojo/_base/html <dojo/_base/html>` [1]_
Query, NodeList and Selectors :ref:`dojo/query <dojo/query>`                         DOM querying and objective 
                                                                                     enhancements to DOM nodes
                              :ref:`dojo/NodeList <dojo/NodeList>`
                              
                              :ref:`dojo/NodeList-data <dojo/NodeList-data>`
                              
                              :ref:`dojo/NodeList-dom <dojo/NodeList-dom>`
                              
                              :ref:`dojo/NodeList-fx <dojo/NodeList-fx>`
                              
                              :ref:`dojo/NodeList-html <dojo/NodeList-html>`
                              
                              :ref:`dojo/NodeList-traverse <dojo/NodeList-traverse>`
                              
                              :ref:`dojo/selector <dojo/selector>`
                              
                              :ref:`dojo/_base/query <dojo/_base/query>` [1]_
                              
                              :ref:`dojo/_base/NodeList <dojo/_base/NodeList>` [1]_
DOM Effects                   :ref:`dojo/_base/fx <dojo/_base/fx>`                   DOM animation effects

                              :ref:`dojo/fx <dojo/fx>`
Browser Window                :ref:`dojo/window <dojo/window>`                       Cross-browser compatible 
                                                                                     references to the window
                              :ref:`dojo/_base/window <dojo/_base/window>` [1]_
Document Lifecycle            :ref:`dojo/ready <dojo/ready>`                         Document lifecycle modules

                              :ref:`dojo/domReady <dojo/domReady>`
                              
                              :ref:`dojo/_base/unload <dojo/_base/unload>`
Browser History               :ref:`dojo/back <dojo/back>`                           Module for managing the browsers 
                                                                                     history
                              :ref:`dojo/hash <dojo/hash>`
Cookies                       :ref:`dojo/cookie <dojo/cookie>`                       Cookie management module
Mouse, Touch and Keys         :ref:`dojo/mouse <dojo/mouse>`                         User input normalisation and 
                                                                                     management
                              :ref:`dojo/touch <dojo/touch>`
                              
                              :ref:`dojo/keys <dojo/keys>`
Drag and Drop                 :ref:`dojo/dnd <dojo/dnd>`                             Drag and Drop package
Testing                       :ref:`dojo/robot <dojo/robot>`                         Modules for simulating user input

                              :ref:`dojo/robotx <dojo/robotx>`
Arrays                        :ref:`dojo/_base/array <dojo/_base/array>`             Array routine enhancements
Strings                       :ref:`dojo/string <dojo/string>`                       String routine enhancements
JSON                          :ref:`dojo/json <dojo/json>`                           JSON handling modules

                              :ref:`dojo/_base/json <dojo/_base/json>` [1]_
Colors                        :ref:`dojo/_base/Color <dojo/_base/Color>`             Color classes/functions

                              :ref:`dojo/colors <dojo/colors>`
Dates                         :ref:`dojo/date <dojo/date>`                           Date routine enhancements
URL and Query Strings         :ref:`dojo/_base/url <dojo/_base/url>`                 URL and URL query string management

                              :ref:`dojo/io-query <dojo/io-query>`
Internationalization          :ref:`dojo/i18n <dojo/i18n>`                           Modules for handling 
                                                                                     internationalization of 
                                                                                     applications
                              
                              :ref:`dojo/cldr <dojo/cldr>`

                              :ref:`dojo/number <dojo/number>`
                              
                              :ref:`dojo/currency <dojo/currency>`
Accessibility                 :ref:`dojo/hccss <dojo/hccss>`                         Accessibility CSS enhancements
Remote Procedure Calls        :ref:`dojo/rpc <dojo/rpc>`                             Ability to invoke remote procedure 
                                                                                     calls
Miscellaneous                 :ref:`dojo/gears <dojo/gears>` [2]_
============================= ====================================================== ===================================

.. [1] This package/module is *deprecated*

.. [2] While the package/module is supported the technology it relies upon is deprecated
