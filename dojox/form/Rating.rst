.. _dojox/form/Rating:

===================
dojox.form.Rating
===================

:Authors: Wolfram Kriesing
:Developers: Wolfram Kriesing
:since: V1.2

.. contents ::
    :depth: 2

This widget allows users to rate items.

Usage
=====

By default it shows three stars. The star images are provided with dojox.

This is a form widget, which means that you can simply embed it inside a dojo form, which submits the value automatically too.
But it doesn't require to be inside a form.

Examples
========

Quick Start
-----------

The following example shows how the default widget works:

.. code-example ::
    
  .. css ::

    @import "{{baseUrl}}dojox/form/resources/Rating.css";

  .. js ::

    dojo.require("dojox.form.Rating");

  .. html ::

    <div data-dojo-type="dojox.form.Rating"></div>

You can **reset the number of stars to 0** by clicking on the currently selected star. For example, if two stars are currently selected click on the second star again and no star will be selected.


Standard options
----------------

This example shows how to use additional attributes to customize the widget. The attribute ``numStars="10"`` tells the widget to show ten stars, ``value="4"`` sets the initially selected number of stars.

.. code-example ::

  .. css ::
    
    @import "{{baseUrl}}dojox/form/resources/Rating.css";

  .. js ::

      dojo.require("dojox.form.Rating");

  .. html ::

    <div data-dojo-type="dojox.form.Rating" data-dojo-props="numStars:10,value:4"></div>


Events via inline script
------------------------

The following shows what events you can connect to and how to do this using inline script blocks.

.. code-example ::

  .. css ::
    
    @import "{{baseUrl}}dojox/form/resources/Rating.css";

  .. js ::

      dojo.require("dojox.form.Rating");

  .. html ::

      <p id="inlineEvents">
        <span data-dojo-type="dojox.form.Rating" data-dojo-props="numStars:10">
          <script type="dojo/event" data-dojo-event="onChange">
            dojo.query('#inlineEvents .value')[0].innerHTML = this.value;
          </script>
          <script type="dojo/event" data-dojo-event="onMouseOver" data-dojo-args="evt,value">
            dojo.query('#inlineEvents .hoverValue')[0].innerHTML = value;
          </script>
        </span>
        <br /><br />
        The value is: <b><span class="value">0</span></b><br />
        The mouse is over: <b><span class="hoverValue">0</span></b>
      </p>


Events via dojo.connect()
-------------------------

The next example shows how you can do the same as above, just using the default connect methods, which is the most common way and probably fits best when working in big projects and when you need a separation of markup and JavaScript source code.

.. code-example ::

  .. css ::

    @import "{{baseUrl}}dojox/form/resources/Rating.css";

  .. js ::

    dojo.require("dojox.form.Rating");

    dojo.ready(function(){
        var widget = dijit.byId("connectRating");
        dojo.connect(widget, "onChange", function(){
            dojo.query('#defaultConnect .value')[0].innerHTML = widget.value;
        });
        dojo.connect(widget, "onMouseOver", function(evt, value){
            dojo.query('#defaultConnect .hoverValue')[0].innerHTML = value;
        });
    });

  .. html ::

      <p id="defaultConnect">
        <span id="connectRating" data-dojo-type="dojox.form.Rating" data-dojo-props="numStars:10"></span>
        <br /><br />
        The value is: <b><span class="value">0</span></b><br />
        The mouse is over: <b><span class="hoverValue">0</span></b>
      </p>


Inside a dojo form
------------------

.. code-example ::

  .. css ::

    @import "{{baseUrl}}dojox/form/resources/Rating.css";

  .. js ::

    dojo.require("dojox.form.Rating");
    dojo.require("dijit.form.Form");
    dojo.require("dijit.form.FilteringSelect");
    dojo.require("dijit.form.Button");

  .. html ::

      <form data-dojo-type="dijit.form.Form">
        <select data-dojo-type="dijit.form.FilteringSelect">
          <option>Does</option>
          <option>this</option>
          <option>work?</option>
        </select>

        <br /><br />
        <div data-dojo-type="dojox.form.Rating" data-dojo-props="numStars:5,value:1"></div>
        <br /><br />
        <button data-dojo-type="dijit.form.Button">Click me</button>
      </form>



Customized stars
----------------

.. code-example ::

  .. css ::

    @import "{{baseUrl}}dojox/form/resources/Rating.css";

    #myRating .dojoxRatingStar{
      background-image:url({{baseUrl}}dijit/themes/tundra/images/dndCopy.png);
      background-position:center center;
      background-repeat:no-repeat;
      background-color:lightgrey;
      width:16px;
      height:16px;
      padding:0.5em;
    }

    #myRating .dojoxRatingStarChecked {
      background-image:url({{baseUrl}}dijit/themes/tundra/images/dndNoMove.png);
    }
    #myRating .dojoxRatingStarHover {
      background-image:url({{baseUrl}}dijit/themes/tundra/images/dndNoMove.png);
    }

  .. js ::

      dojo.require("dojox.form.Rating");

  .. html ::

      <div id="myRating">
        <div data-dojo-type="dojox.form.Rating" data-dojo-props="numStars:6,value:2"></div>
      </div>
