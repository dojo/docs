#format dojo_rst

Writing Your Own Widget
=======================

:Status: Contributed, Draft
:Version: 1.0

It's hard for you to leave well-enough alone. We give you widgets, and now you want to change them. Or you want to make your own.

No problem! Dijit components are extendible, so you can make changes without touching the source code. In a way, you already do this by specifying your own attributes - e.g. sliders that go from 0-100 look different than those going from 0-200. But sometimes you need to go further. Maybe you need to create different behavior for onClick, or substitute a custom validation routine. This kind of modification uses extension points described in Common Attributes. You can add your own code to extension points through markup or through pure JavaScript calls to dojo.declare.

You can also create Dijit classes from scratch. Again, you can do this either through markup - using the dijit.Declaration dojoType attribute - or through dojo.declare.

- `The Template <quickstart/writingWidgets/templates>`_
- `More on attributes <quickstart/writingWidgets/attributes>`_
- `Dijit.Declaration <quickstart/writingWidgets/dijitDeclaration>`_
- `Direct Extension <quickstart/writingWidgets/dojoDeclare>`_
- `The Widget Life-cycle <quickstart/writingWidgets/lifecycle>`_
- `Widgets In Template <quickstart/writingWidgets/widgetsInTemplate>`_
- `Testing the Widget <quickstart/writingWidgets/testing>`_
- `Example: File Upload Dialog Box <quickstart/writingWidgets/example>`_
- `Creating Accessible Widgets <quickstart/writingWidgets/a11y>`_
- `Testing Widgets for Accessibility <quickstart/writingWidgets/a11yTesting>`_
