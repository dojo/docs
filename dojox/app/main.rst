.. _dojox/app/main:

==============
dojox/app/main
==============

:since: V1.7

``dojox/app/main`` (Application) is used to create a ``dojox/app`` Application object using a configuration object.

The Application class itself doesn't currently exist as an exported class. This module only exports a function, which when provided with a configuration JSON object will declare & instantiate the Application class that will actually be used on a page. Additional modules provided in the configuration file are mixed into the Application object. By default the lifecycle module is included and will fire a topic event when the application is ready. You can listen to that topic by using the dojo/topic module as follows:

.. js ::

  require(["dojox/json/ref", "dojox/app/main", "dojo/text!app/config.json", "dojo/topic",
           "dojox/app/module/lifecycle"],
    function(json, Application, config, topic, lifecycle){
    topic.subscribe("/app/status", function(evt){
      if(evt == lifecycle.lifecycle.STARTED){
        // the application is ready
      }
    }
    Application(json.parse(config));
  });



