.. _dojox/mobile/app:

================
dojox.mobile.app
================

:Authors: Sébastien Le Ray
:Developers: multiple developers
:since: V1.5

.. contents ::
    :depth: 2

``dojox.mobile.app`` provides a simple framework to develop mobile web applications. It handles view definitions and resources in a declarative fashion.

Initialization
==============

First, you've to create a basic front page that will initialize information and starts the framework.


.. html ::

  <!DOCTYPE HTML PUBLIC "-// W3C// DTD HTML 4.01// EN" "http://www.w3.org/TR/html4/strict.dtd">
  <html>
    <head>
      <!-- this should be dynamically generated -->
      <link href="/js/dojox/mobile/themes/iphone/iphone-app.css" rel="stylesheet">
      <script type="text/javascript" src="/js/dojo/dojo.js" ></script>
      <script type="text/javascript" src="/js/dojox/mobile/app.js"></script>
      <script language="JavaScript" type="text/javascript">
        dojo.requireIf(!dojo.isWebKit, "dojox.mobile.app.compat");
      
        var appInfo = {
          id: "com.mycompany.myapp",
          title: "My Mobile application"
        };
        
        dojo.ready(dojox.mobile.app.init);
      </script>
    </head>
    <body>
    </body>
  </html>

Note that all JS inclusions are static because some browsers may fail on ``dojo.require`` (no support for sync XMLHttpRequest). The included theme stylesheet should depend on user-agent (server side work).

This simple examples defines an application whose main scene is "main". When calling ``dojox.mobile.app.init()``, the framework will try to fetch the scene template and its JS initialization code. By default templates are under ``app/views/[scene]/[scene]-scene.html`` and "Assistants" (that is, JS initialization code) is under ``app/assistants/[scene]-assistant.js``. If you want to modify this, you'll have to re-declare ``dojox.mobile.app.resolveTemplate`` and ``dojox.mobile.app.resolveAssistant``.

To load an initial scene other than 'main', set the 'initialScene' value in appInfo to the name of that scene, e.g.

.. html ::

  var appInfo = {
          id: "com.mycompany.myapp",
          title: "My Mobile application",
          initialScene: 'mycustomscene'
        };


View resources
==============

Application view resources are all JavaScript files needed to run the application. They should be accessible through ``view-resources.json`` under the same directory as the initialization page. It should provide an array of objects under the form of ``[ { scene: '', source: 'url', module: 'module.name' }, ... ]``. If ``source`` is set, it will be treated as an URL and fetched directly, if ``module`` is set it will be treated as a classic module name and transformed accordingly (dots become slashes and ``.js`` added). If no ``scene`` is specified, resource will be loaded at application startup, otherwise it will be loaded when a given scene is requested.

You should use view resources instead of ``dojo.require`` to support browsers without synchronous XMLHttpRequest.

Assistants do not have to be specified as view resource. They're implicitly loaded with each view.

Scenes
======

Scenes are simply HTML templates, they will not be parsed for widget automatically, you'll have to handle this in the scene assistant.

Assistants
==========

Each view should come with an assistant, which is responsible for the JS setup of the scene. It must extend ``dojox.mobile.app.SceneAssistant`` which provides three methods:

 * ``setup()``: called once the scene has been loaded but not displayed. If you want to parse your view, you'll have to do it there through the ``parse()`` method of the ``controller`` field of the assistant;
 * ``activate(data)``: called every time the view is made visible. Data will contains optional data transmitted by the previous view;
 * ``deactivate()``: called each time the view is hidden and when it is destroyed.

You can access to the SceneController of the assistant's scene through its field ``controller``, e.g. from any scene assistant use this.controller.

SceneController
===============

SceneController provides utilities for a scene assistant, and also takes care of instantiating an assistant and calling it's lifecycle methods. Assistants have a field ``controller`` which is set to their scene's controller.

 * ``parse((optional)node)``: Parses the current scene for widgets. As all scenes reside in the same DOM, you cannot call ``dojo.parser.parse()`` directly or you may instantiate widgets twice;
 * ``query(selector, (optional)node)``: calls ``dojo.query`` ensuring that results will belongs to the controller's scene if no ``node`` is provided;
 * ``showAlertDialog({title: '', text: '', buttons: [{btnClass: 'cssClass', label: ''}], defaultButtonLabel: '', onChose: function(pressedButton){} })``: Display an alert dialog, if no buttons are provided, a simple "OK" one is created.  You can alternatively show an alert dialog from anywhere by calling dojo.publish("/dojox/mobile/app/alert", params), where the params variable is the same as that passed to showAlertDialog;
 * ``popupSubMenu({ choices: [{className: 'cssClass', label: '', value: ''}], onChoose: function(value){}, fromNode: node})``: display a popup menu whose entries are ``choices``. ``onChoose`` with the selected value. If ``fromNode`` is null, menu will be displayed roughly on the top of the screen.

StageController
===============

Stage controller handle global application behavior and thus provide various application level methods. The application StageController is available through ``dojox.mobile.app.getStageController()`` or the ``stageController`` property of a SceneController.

 * ``pushScene(sceneName, params)``: Loads and execute scene ``sceneName``. ``params`` will be passed to the Assistant constructor, and also to the Assistant's activate() method the first time it is called. Transition effect between scenes can be controlled through the ``effect`` attribute of the StageController or predefined using ``dojoConfig.mobileAnim`` property;
 * ``popScene(data)``: goes back to the scene we were before the current one (if any). ``data`` will be passed to the ``activate`` method of the scene.  You can alternatively use dojo.publish to pop a scene, without needing access to the StageController, by calling dojo.publish("/dojox/mobile/app/goback");
 * ``popScenesTo(sceneName, data)``: "rewinds" the scenes until the current one is ``sceneName``.
