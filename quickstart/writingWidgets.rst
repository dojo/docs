#format dojo_rst

Writing Your Own Widget
=======================

:Status: Contributed, Draft
:Version: 1.0

It's hard for you to leave well-enough alone. We give you widgets, and now you want to change them. Or you want to make your own.

No problem! Dijit components are extendible, so you can make changes without touching the source code. In a way, you already do this by specifying your own attributes - e.g. sliders that go from 0-100 look different than those going from 0-200. But sometimes you need to go further. Maybe you need to create different behavior for onClick, or substitute a custom validation routine. This kind of modification uses extension points described in Common Attributes. You can add your own code to extension points through markup or through pure JavaScript calls to dojo.declare.

You can also create Dijit classes from scratch. Again, you can do this either through markup - using the dijit.Declaration dojoType attribute - or through dojo.declare.

A simple extension
------------------
These pages explain the basics of templates and widget declaration by showing how to extend AccordionContainer to use images instead of text for the titles of each AccordionPane.

- `Understanding templates <quickstart/writingWidgets/templates>`_
- `Declaring a widget programatically <quickstart/writingWidgets/dojoDeclare>`_
- `Declaring a widget in markup <quickstart/writingWidgets/dijitDeclaration>`_
- Testing the Widget - TODO: don't create this page; tests should be rolled into above two sections

More topics
-----------
These pages list some more information you need for writing widgets from scratch, or making more complicated changes.

- `The Widget Life-cycle <quickstart/writingWidgets/lifecycle>`_
- `More on attributes <quickstart/writingWidgets/attributes>`_
- `Widgets In Template <quickstart/writingWidgets/widgetsInTemplate>`_
- `Example: File Upload Dialog Box <quickstart/writingWidgets/example>`_

Accessibility
-------------
These pages list how to make your widgets accessible to people with poor/no vision, etc.

- `Creating Accessible Widgets <quickstart/writingWidgets/a11y>`_
- `Testing Widgets for Accessibility <quickstart/writingWidgets/a11yTesting>`_
