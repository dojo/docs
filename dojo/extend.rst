.. _dojo/extend:

===========
dojo.extend
===========

Dojo extend works much like :ref:`dojo.mixin <dojo/mixin>`, though works directly on an object's prototype. Following the same pattern as mixin, dojo.extend mixes members from the right-most object into the first object, modifying the object directly.

We can use dojo.extend to extend functionality into existing classes. Consider the following:

.. js ::
  
  // Dojo 1.7+ (AMD)
  require(["dojo/_base/lang", "dijit/TitlePane"], function(lang, TitlePane){
    lang.extend(TitlePane, {
      randomAttribute:"value"
    });
  });

  // Dojo < 1.7
  dojo.require("dijit.TitlePane");
  dojo.extend(dijit.TitlePane, {
      randomAttribute:"value"
  });

The way the :ref:`dojo.parser <dojo/parser>` works, a custom attribute on the node will be recognized, as in the interest of performance, only declared members are mixed as part of the parsing process. Before the above dojo.extend() call, this sample would not recognize the follow markup:

.. html ::
    
     <div data-dojo-type="dijit.TitlePane" data-dojo-props="randomAttribute:'newValue'"></div>

After the extend, any new instances of a TitlePane will have the 'randomAttribute' member mixed into the instance. dojo.extend affects all future instances of a Class (or rather, any object with a .prototype).

Extending _Widget
=================

A potentially confusing result of the above actually provides us a lot of flexibility. All Dijit widgets inherit from ``dijit._WidgetBase`` in one way or another. Some widgets, like the :ref:`BorderContainer <dijit/layout/BorderContainer>` can contain arbitrary widgets, though require a 'region' parameter on the contained widget, though rather than manually adding a "region" parameter to each declaration across Dijit, BorderContainer simply extends _WidgetBase with the member, and anyone using any widget within a BorderContainer can specify a region:

.. js ::
  
  // Dojo 1.7+ (AMD)
  require(["dojo/_base/lang", "dijit/_WidgetBase"], function(lang, _WidgetBase){
    lang.extend(_WidgetBase, {
      region:"center"
    });
  });

  // Dojo < 1.7
  dojo.extend(dijit._WidgetBase, {
      region:"center"
  });

The side-effect of this is a documentation nightmare. Now ``every`` Dijit appears to have a region variable, when in fact it is just there for the benefit of BorderContainer.

Example: dojo.extend vs dojo.mixin
==================================

[ Dojo 1.7+ (AMD) ]

.. js ::
  
    require(["dojo/_base/lang", "dojo/json"], function(lang, json){
        // define a class
        var myClass = function(){
            this.defaultProp = "default value";
        };
        myClass.prototype = {};
        console.log("the class (unmodified):", json.stringify(myClass.prototype));
    
        // extend the class
        lang.extend(myClass, {"extendedProp": "extendedValue"});
        console.log("the class (modified with lang.extend):", json.stringify(myClass.prototype));
    
        var t = new myClass();
        // add new properties to the instance of our class
        lang.mixin(t, {"myProp": "myValue"});
        console.log("the instance (modified with lang.mixin):", json.stringify(t));
    });


[ Dojo < 1.7 ]

.. js ::
  
    // define a class
    var myClass = function(){
        this.defaultProp = "default value";
    };
    myClass.prototype = {};
    console.log("the class (unmodified):", dojo.toJson(myClass.prototype));
    
    // extend the class
    dojo.extend(myClass, {"extendedProp": "extendedValue"});
    console.log("the class (modified with dojo.extend):", dojo.toJson(myClass.prototype));
    
    var t = new myClass();
    // add new properties to the instance of our class
    dojo.mixin(t, {"myProp": "myValue"});
    console.log("the instance (modified with dojo.mixin):", dojo.toJson(t));
