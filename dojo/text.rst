.. _dojo/text:

=========
dojo/text
=========

dojo/text is an AMD plugin that loads string data from a file. It is the replacement for ``dojo.cache`` from earlier versions of dojo.

.. js ::
 
  define(["dojo/_base/declare", "dijit/_Widget", "dojo/text!dijit/templates/Dialog.html"],
    function(declare, _Widget, template){

      return declare(_Widget, {
        templateString: template
      });
  });
