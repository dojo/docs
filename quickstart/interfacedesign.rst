.. _quickstart/interfacedesign:

UI Development with the Dojo Toolkit
====================================

:Status: Draft
:Version: 1.0
:Authors: Nikolai Onken

.. contents::
    :depth: 2

The Dojo Toolkit comes with many amazing modules which all are trying to make your life as a developer many times easier.
This short introduction to UI Development will introduce you to the main Dojo layout and form widgets.


===================
Why use Dojo/Dijit?
===================

One of the great features of dijit is the fact that it is all ready for a11y (accessibility) and i18n (internationalization).
Imagine you are working on a new product, your current market is the one of your country and you are not too concerned about delivering your product in several different languages. Thinking about making your product accessible for people with disabilities is way down the list of your priorities. 

Now imagine your product becomes really successful, you want to expand, you want to target a bigger market. 
Using Dojo you will see that implementing another language is not a matter of rewriting your entire code, making it accessible doesn't require highly specialized knowledge and even enabling bidi (bi-directional) is as simple as adding a few extra bytes of code.
Last but not least, dijit comes with different awesome themes and it is very easy to create your own theme.

Now if you are still doubting, let's go ahead and dive right into a simple UI we will use to retrieve the latest news from a news service provider. What will we use? 


===============
Our ingredients
===============

dijit.layout
------------

Dijit includes a sub namespace dijit.layout which contains very powerful layout widgets. You can use those to create complex window-style (Note, not MS Windows ;) ) UIs but also to just enhance pages with single functionality such as tabs or content panes to load content dynamically.

dijit.form
----------

For all your form-related needs you are best helped by dijit.form. All native form elements are covered and even more advanced elements such as a ComboBox are available in dijit.form

dojox.grid
----------

The grid is the ultimate data visualizer. We can retrieve thousands of results, display them, filter them, sort them, and of course view their contents.

A few other helper widgets
--------------------------

We'll also use a Tree widget to navigate through different news categories and we'll use a fancy set of icons (free, opensource) to make our app look like we want it to look.


=============
The interface
=============

We'll go for a simple left/top/bottom interface. 

.. cv-compound:: 

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.layout.BorderContainer");
      dojo.require("dijit.layout.ContentPane");
      
      dojo.addOnLoad(function(){
        var outerBc = new dijit.layout.BorderContainer({
          "design": "sidebar",
          "style": "height: 400px;"
        }, "uiContainer");

        var leftSidebar = new dijit.layout.ContentPane({
          "region": "leading",
          "style": "width: 200px;",
          "splitter": "true"
        });
        outerBc.addChild(leftSidebar);
        
        var rightContent = new dijit.layout.BorderContainer({
          "id": "uiContent",
          "region": "center"
        });

        var topContent = new dijit.layout.ContentPane({
          "region": "center",
          "splitter": "true"
        });
        rightContent.addChild(topContent);

        var bottomContent = new dijit.layout.ContentPane({
          "region": "bottom",
          "style": "height: 100px;",
          "splitter": "true"
        });  
        rightContent.addChild(bottomContent);      

        outerBc.addChild(rightContent);
        //rightContent.startup();
        outerBc.startup();
      });
    </script>

  .. cv:: html

    <div id="uiContainer" style="border: 1px solid #ccc"></div>

Lets fill it up with content. Out left pane will contain a Tree which will get its data right from our service provider.
You might have asked yourself who that service provider is, we'll use Google.
