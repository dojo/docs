#format dojo_rst

dojox.widget.Rating
===================

:Status: Contributed, Draft
:Version: 1.2

This widget allows users to rate items. By default it shows three stars, that are provided with dojox. 
This is a form widget, which means that you can simply embed it inside a dojo form, which submits the value automatically too.

Default widget
---------------
The following example shows how the default widget works, just use the attribute ``dojoType="dojox.form.Rating"`` on some standard node and you will get the following result as shown below. Make sure to import the CSS file too, otherwise it won't know how to style and what images to use.
You can reset the number of stars to 0 by clicking on the currently selected star. For example, if two stars are currently selected click on the second star again and no star will be selected.

.. codeviewer::
  
  <style type="text/css">
    @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/form/resources/Rating.css"; 
  </style>
  <script type="text/javascript">
    dojo.require("dojox.form.Rating");
  </script>

  <div dojoType="dojox.form.Rating"></div>


Standard options
----------------
This example shows how to use additional attribute to parametrize the widget. The attribute ``numStars="10"`` tells the widget to show ten stars, ``value="4"`` sets the initially selected number of stars. 

.. codeviewer::
  
  <style type="text/css">
    @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/form/resources/Rating.css"; 
  </style>
  <script type="text/javascript">
    dojo.require("dojox.form.Rating");
  </script>

  <div dojoType="dojox.form.Rating" numStars="10" value="4"></div>


Insode a dojo form
------------------

.. codeviewer::
  
  <style type="text/css">
    @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/form/resources/Rating.css"; 
  </style>
  <script type="text/javascript">
    dojo.require("dojox.form.Rating");
    dojo.require("dijit.form.Form");
    dojo.require("dijit.form.FilteringSelect");
    dojo.require("dijit.form.Button");
  </script>
  <form dojoType="dijit.form.Form">
    <select dojoType="dijit.form.FilteringSelect">
      <option>Does</option>
      <option>this</option>
      <option>work?</option>
    </select>

    <br /><br />
    <div dojoType="dojox.form.Rating" numStars="5" value="1"></div>
    <br /><br />
    <button dojoType="dijit.form.Button">Click me</button>
  </form>



Customized stars
----------------

.. codeviewer::
  
  <style type="text/css">
    @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/form/resources/Rating.css";
    #myRating .dojoxRatingStar{
      background-image:url(/moin_static163/js/dojo/trunk/release/dojo/dijit/themes/tundra/images/dndCopy.png);
      background-position:center center;
      background-repeat:no-repeat;
      background-color:lightgrey;
      width:16px;
      height:16px;
      padding:0.5em;
    }
		
    #myRating .dojoxRatingStarChecked {
      background-image:url(/moin_static163/js/dojo/trunk/release/dojo/dijit/themes/tundra/images/dndNoMove.png);
    }
    #myRating .dojoxRatingStarHover {
      background-image:url(/moin_static163/js/dojo/trunk/release/dojo/dijit/themes/tundra/images/dndNoMove.png);
    }

  </style>
  <script type="text/javascript">
    dojo.require("dojox.form.Rating");
  </script>
 
  <div id="myRating">
    <div dojoType="dojox.form.Rating" numStars="6" value="2"></div>
  </div>
