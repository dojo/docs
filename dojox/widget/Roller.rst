.. _dojox/widget/Roller:

===================
dojox.widget.Roller
===================

.. contents ::
    :depth: 2

The Roller is a degradable, unobtrusive widget to convert an unordered list (``<ul>``) of styled items into a single item, and loop through the display. There are no additional CSS requirements, or any heavy dependencies.

Usage
=====

To use in your page, simply require in the needed module:

.. js ::
  
  dojo.require("dojox.widget.Roller");

The module provides dojox.widget.Roller, which fades through the items, as well as dojox.widget.RollerSlide, which "slides" in the new element during the transition.

Creating A Roller
-----------------

The most simple way of creating a Roller is by using the data-dojo-type attribute:

.. html ::

    <ul data-dojo-type="dojox.widget.Roller">
        <li>Item 1</li>
        <li>Item 2</li>
        <li>Item 3</li>
    </ul>

You can of course convert an existing ``<ul>`` into a roller programmatically, most easily accomplished by using an id="" attribute:

.. js ::

        dojo.ready(function(){
            new dojox.widget.Roller({}, "myRoller");
        });

.. html ::

    <ul id="myRoller">
        <li>Item 1</li>
        <li>Item 2</li>
        <li>Item 3</li>
    </ul>


Or, create one entirely programmatically, by passing an ``items:`` Array

.. js ::

   var n = dojo.place("<ul></ul>", dojo.body(), "last");
   // make the roller:
   var roller = new dojox.widget.Roller({
      items:["Item 1", "Item 2", "Item 3"]
   }, n);
 
The Items are just the labels used when showing the item, and can contain complex markup. Styling them individually to 
meet your needs is your responsibility.

The Roller Class supports two basic configuration options. ``delay`` is the time between rolls (in ms), and ``autoStart`` 
is true or false, and determines if the widget should start rolling immediately.

Adding Items
------------

Adding and removing items from a Roller is very easy. The ``items`` property is just an ordinary Array, which you can manipulate with either Dojo's Array functions, or standard JavaScript methods.

To add a new item to a Roller with id="myRoller":

.. js ::

   dijit.byId("myRoller").items.push("I am a NEW Item");

You can do this as much as you like, the Roller will continue looping through the available items.

Controlling A Roller
--------------------

The Roller instance responds to several simple methods being called. ``.stop()`` will stop the animation in place, and ``.start()`` will start or resume the Roller. The configuration parameter ``autoStart`` (which defaults to 'true') causes ``.start()`` to be called upon instantiation.

The default behavior to locate items in a declarative list is to locate first-children LI items. This can be changed by modifying the ``itemSelector`` attribute, which defaults to ``"> li"``.

Roller from dojo.data
---------------------

``TODOC``

Custom Transitions
==================

The dojox.widget.Roller acts as a baseClass for other Roller transitions. This is possible because all of the transition-animation code is wrapped in a single function meant for being overridden. Simply create a subclass, overriding the ``makeAnims`` function, creating your own set of "in" and "out" transitions. The animations are stored in a "private" object: ``this._anim`` as "in" and "out".

First, declare your subclass:

.. js ::

  dojo.declare("my.CustomRoller", dojox.widget.Roller, {
      makeAnims: function(){
          /* setup your animations */
          ...
          this._setupConnects();
      }
  });

**note:** you *must* call ``this._setupConnects()`` after having created your new animations, otherwise no looping will take place.

The animations can do whatever your creativity will permit. Just name the "show item" transition ``this._anim["in"]`` and the "hide item" transition ``this._anim.out``. The most simple example can be shown by copying the makeAnims function directly from dojox.widger.Roller:

.. js ::
 
  makeAnims: function(){
    // summary: Animation creator function. Need to create an 'in' and 'out'
    //      _Animation stored in _anim Object, which the rest of the widget
    //      will reuse.
    var n = this.domNode;
    dojo.mixin(this, {
        _anim: {
            "in": dojo.fadeIn({ node:n, duration: 400 }),
            "out": dojo.fadeOut({ node:n, duration: 275 })
        }
    });
    this._setupConnects();
  }

Remember to only *create* the Animation object, as ``.play()`` is called by the Widget based on the timings in :ref:`setupConnects()`. The container Node for the Roller is named ``this.domNode``, and the single child (and container for the visible label) is named ``this._roller``.

Custom Styles
=============

``TODOC``
