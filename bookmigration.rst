## page was copied from welcome
#format rst

Dojo Book Migration
==============================================================

:Status: Draft

The Dojo Book on dojotoolkit.org has had a lot of work poured into it, and its been widely linked to, bookmarked and indexed. We dont want to lose that. This page exists to manage the mapping of old page(s) to new page(s). Please put your name against any pages you can volunteer to migrate and/or maintain, as well as any notes you might have on the content and comments.

----

=================
Dojo Book Outline
=================

`The Book of Dojo <http://dojotoolkit.org/book/dojo-book-1-0>`_.

* `Quick Installation <http://dojotoolkit.org/book/dojo-book-0-9/part-1-life-dojo/quick-installation>`_. 
  maps to: `How to Install the Dojo Toolkit <quickstart/install>`_
* `Hello World - Dojo for the Attention-Impaired <http://dojotoolkit.org/book/dojo-book-0-9/hello-world-tutorial>`_. maps to: `Hello world <quickstart/helloworld>`_ -- [[JChimene]] <<DateTime(2008-08-01T11:36:45-0700)>>
* `Debugging Tutorial <http://dojotoolkit.org/book/book-dojo/part-4-meta-dojo-making-your-dojo-code-run-faster-and-better/debugging-facilities/deb>`_.  maps to: `Debugging <quickstart/debugging>`_ (1/2 done: sfoster)
* `Dojo Introduction <http://dojotoolkit.org/book/dojo-book-0-9/introduction>`_.  maps to: `Introduction <quickstart/introduction>`_ (do we still need this?)

  * `Dojo Licensing <http://dojotoolkit.org/book/dojo-book-0-9/introduction/licensing>`_.  maps to: `Licensing <quickstart/introduction/licensing>`_ 
  * `Dojo History <http://dojotoolkit.org/book/dojo-book-0-9/introduction/history>`_. maps to: `History <quickstart/introduction/history>`_ (done: sfoster)
  * `Why Dojo? <http://dojotoolkit.org/book/dojo-book-0-9/introduction/why-dojo>`_. maps to: `Why Dojo <quickstart/introduction/whydojo>`_ (done: sfoster)

* `Part 2: Dijit - The Dojo Widget Library <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit-0>`_. maps to: `dijit <dijit>`_ (complete)

  * `Dijit at a Glance <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/dijit-glance>`_.
  * `Common Features <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/common-attributes>`_.
  * `Form, Validation, Specialized Input <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/form-validation-specialized-input>`_. maps to: `dijit.form <dijit/form>`_ [[CraigRiecke]]

    * `Form Widget <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/form-validation-specialized-input/form-widget>`_. maps to: `Form <dijit/form/Form>`_  (complete)
    * `CheckBox, RadioButton, ToggleButton <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/form-validation-specialized-input/checkbox-radiobutton>`_. maps to: `Checkbox <dijit/form/CheckBox>`_, `RadioButton <dijit/form/RadioButton>`_, `ToggleButton <dijit/form/ToggleButton>`_
    * `Dijit ComboBox <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/form-validation-specialized-input/auto-completer>`_. maps to: `ComboBox <dijit/form/ComboBox>`_ (done: doughays)
    * `Dijit FilteringSelect <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/form-validation-specialized-input/select>`_. maps to: `FilteringSelect <dijit/form/FilteringSelect>`_ (done: doughays)
    * `Dijit NumberSpinner <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/form-validation-specialized-input/number-spinner>`_. maps to `NumberSpinner <dijit/form/NumberSpinner>`_ [[CraigRiecke]].
    * `Dijit Slider <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/form-validation-specialized-input/slider>`_. maps to: `Slider <dijit/form/Slider>`_ (done: doughays)
    * `Dijit Textarea <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/form-validation-specialized-input/resizeable-text-area>`_. maps to: `Textarea <dijit/form/Textarea>`_ (complete)
    * `Dijit TextBox family - Validation, Currency, Number, Date, Time <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/form-validation-specialized-input/textbox-validating-currency-number>`_. maps to: `Textbox <dijit/form/TextBox>`_,  
       `ValidationTextbox <dijit/form/ValidationTextBox>`_, `CurrencyTextbox <dijit/form/CurrencyTextBox>`_, `NumberTextbox <dijit/form/NumberTextBox>`_, (all complete)
       `DateTextbox <dijit/form/DateTextBox>`_ and `TimeTextbox <dijit/form/TimeTextBox>`_ [[CraigRiecke, complete]]

  * `Dijit Layout <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/layout>`_. maps to: `dijit.layout <dijit/layout>`_ (complete)

    * `Dijit AccordionContainer <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/layout/accordion-container>`_. maps to: `AccordionContainer <dijit/layout/AccordionContainer>`_
    * `Dijit BorderContainer <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/layout/border-container>`_. maps to: `BorderContainer <dijit/layout/BorderContainer>`_ (complete)
    * `Dijit ContentPane <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/layout/content-pane>`_. maps to: `ContentPane <dijit/layout/ContentPane>`_ (complete)
    * `Dijit StackContainer <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/layout/stack-container>`_. maps to: `StackContainer <dijit/layout/StackContainer>`_ (complete)
    * `Dijit TabContainer <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/layout/tab-container>`_. maps to: `TabContainer <dijit/layout/TabContainer>`_ (complete)

  * `Command Control <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/command-control>`_.

    * `Button, ComboButton, DropDownButton <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/form-validation-specialized-input/buttons-dropdown-combo-checkbox-ra>`_. maps to 

          * `Button <dijit/form/Button>`_ (complete)
          * `DropDownButton <dijit/form/DropDownButton>`_ (complete)
          * `ComboButton <dijit/form/ComboButton>`_ (complete)

    * `Dijit Menu <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/command-control/popup-menus-dijit-menu>`_. maps to: `Menu <dijit/Menu>`_ (complete)
    * `Dijit Toolbar <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/command-control/toolbar>`_. maps to: `Toolbar <dijit/Toolbar>`_ (complete)

  * `User Assistance and Feedback <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/user-assistance-and-feedback>`_.

    * `Dijit ProgressBar <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/user-assistance-and-feedback/progress-bar>`_. maps to: `ProgressBar <dijit/ProgressBar>`_ (complete)
    * `Dijit Tooltip <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/user-assistance-and-feedback/tooltip>`_. maps to: `Tooltip <dijit/Tooltip>`_ (complete)
    * `Dijit Dialog and TooltipDialog <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/layout/dialog>`_. maps to: 
         * `Dialog <dijit/Dialog>`_ (complete)
         * and `TooltipDialog <dijit/TooltipDialog>`_ (complete)
    * `Dijit TitlePane <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/layout/title-pane>`_. maps to: `TitlePane <dijit/TitlePane>`_ (complete)

  * `Advanced Editing and Display <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/advanced-editing-and-display>`_.

    * `Dijit ColorPalette <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/advanced-editing-and-display/color-palette>`_. maps to: `ColorPalette <dijit/ColorPalette>`_ (complete)
    * `Dijit InlineEditBox (1.0) <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/advanced-editing-and-display/inlineeditbox>`_. maps to: `InlineEditBox <dijit/InlineEditBox>`_ (complete)
    * `Dijit Editor <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/advanced-editing-and-display/editor-rich-text>`_. maps to `Editor <dijit/Editor>`_ [[complete]
    * `Dijit Tree <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/advanced-editing-and-display/tree>`_. maps to `Tree <dijit/Tree>`_ [[complete]]

  * `Themes and Design <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/themes-and-design>`_.

    * `Common Elements <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/themes-and-design/tundra-theme>`_.
    * `Overriding and Combining Themes <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/themes-and-design/overriding-and-combining-themes>`_.
    * `Writing Your Own Theme <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/themes-and-design/writing-your-own-theme>`_.

  * `Accessibility  <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/a11y>`_. maps to: `dijit-a11y <dijit-a11y>`_ (complete)

    * `Web Accessibility Issues <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/a11y/web-accessibility-issues>`_. maps to: `dijit-a11y <dijit-a11y>`_ (complete)
    * `Dojo Accessibility Strategy <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/a11y/dojo-accessibility-strategy>`_. maps to: `dijit-a11y-strategy <dijit-a11y-strategy>`_ (complete)
    * `Dojo Accessibility Resources <http://dojotoolkit.org/book/dojo-book-0-9/part-2-dijit/a11y/dojo-accessibility-resources>`_. maps to: `dijit-a11y-resources <dijit-a11y-resources>`_ (complete)

* `Part 3: JavaScript Programming With Dojo and Dijit <http://dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo-0>`_.

  * `Functions Used Everywhere <http://dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/functions-used-everywhere>`_. maps to: `Functions Used Everwhere <quickstart/dojo-basics>`_
  * `Object Orientation <http://dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/object-orientation>`_. maps to: `dojo.declare <dojo/declare>`_
  * `Modules <http://dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/modules-and-namespaces>`_.
  * `Creating and Scripting Widgets <http://dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/manipulating-widgets-through-code>`_.
  * `Writing Your Own Widget Class <http://dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/manipulating-widgets-through-code/writing-your>`_ maps to `Writing your own Widget <quickstart/writingWidgets>`_.
  * `The Event System <http://dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/event-system>`_. maps to: `Events <quickstart/events>`_ (complete, all children with the exception of `dojo.keys <dojo/keys>`_ being moved out)
  * `XMLHttpRequest (XHR) <http://dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/ajax-transports>`_. maps to: `dojo.xhr <dojo/xhr>`_
  * `Drag and Drop <http://dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/drag-and-drop>`_.
  * `Using dojo.data <http://dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/data-retrieval-dojo-data-0>`_.
  * `Selecting DOM Nodes with dojo.query <http://dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/selecting-dom-nodes-dojo-query>`_.
  * `Internationalization (i18n) <http://dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/i18n>`_ maps to `Formatting, Parsing, and Validating <quickstart/numberDates>`_ [CraigRiecke].
  * `Back Button <http://dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/back-button-undo>`_. maps to: `dojo.back <dojo/back>`_
  * `Other Functions <http://dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/other-miscellaneous-function>`_.
  * `Multiple Versions of Dojo in a Page <http://dojotoolkit.org/book/book-dojo/part-3-javascript-programming-dojo-and-dijit/multiple-versions-dojo-page>`_.

* `Part 4: Testing, Tuning and Debugging <http://dojotoolkit.org/book/dojo-book-0-9/part-4-meta-dojo-0>`_.

  * `Getting the Code from Source Control <http://dojotoolkit.org/book/dojo-book-0-9/part-4-meta-dojo/using-subversion>`_.  maps to: `SVN <quickstart/svn>`_
  * `Development Tools <http://dojotoolkit.org/book/dojo-book-0-9/part-4-meta-dojo/development-tools>`_.  maps to: `Tools <quickstart/tools>`_
  * `Debugging Facilities <http://dojotoolkit.org/book/dojo-book-0-9/part-4-meta-dojo/debugging-facilities>`_.
  * `D.O.H. Unit Testing <http://dojotoolkit.org/book/dojo-book-0-9/part-4-meta-dojo/d-o-h-unit-testing>`_.  maps to: `Unit testing <quickstart/unittesting>`_
  * `Performance Optimization <http://dojotoolkit.org/book/dojo-book-0-9/part-4-meta-dojo/performance-optimization>`_.  maps to: `Performance <quickstart/performance>`_
  * `The Package System and Custom Builds <http://dojotoolkit.org/book/dojo-book-0-9/part-4-meta-dojo/package-system-and-custom-builds>`_.  maps to: `Packaging <quickstart/packaging>`_

* `Part 5: DojoX - Extensions <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox-extensions-dojo-0>`_ maps to: `DojoX <dojox>`_.

  * `Cometd (client) <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/cometd-client>`_. maps to: `Cometd <dojox/cometd>`_
  * `DojoX Charting <http://dojotoolkit.org/book/book-dojo/part-5-dojox-experimental-and-specialized-extensions/dojox-charting>`_.  maps to: `Charting <dojox/charting>`_
  * `DojoX Collections <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-collections>`_. maps to: `Collections <dojox/collections>`_
  * `DojoX Cryptography <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-cryptography>`_.  maps to: `Encoding/Cryptography <dojox/encoding>`_
  * `DojoX Data <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-data>`_. maps to: `Data <dojox/data>`_
  * `DojoX DTL (Django Template Language) <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-dtl>`_. maps to: `DTL <dojox/dtl>`_ (TODO: perhaps should map to `DTL under writingWidgets <quickstart/writingWidgets/dtl>`_
  * `DojoX FX <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-fx>`_. maps to: `Fx <dojox/fx>`_
  * `DojoX GFX <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-gfx>`_. maps to: `Gfx <dojox/gfx>`_
    Initial draft is in place, needs to be split into sub sections
  * `DojoX Grid <http://dojotoolkit.org/book/dojo-book-0-9-1-0/part-5-dojox-experimental-and-specialized-extensions/dojox-grid>`_. maps to: `Grid <dojox/grid>`_
  * `DojoX I/O <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-i-o>`_. maps to: `I/O <dojox/io>`_
  * `DojoX Image <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-image>`_. maps to: `Image <dojox/image>`_
  * `DojoX Layout <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-layout>`_. maps to: `Layout <dojox/layout>`_
  * `DojoX Offline <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojo-offline>`_. maps to: `Offline <dojox/off>`_
  * `DojoX Presentation <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-presentation>`_. maps to: `Presentation <dojox/presentation>`_
  * `DojoX String Utilities <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-string-utilities>`_. maps to: `String <dojox/string>`_
  * `DojoX Timing <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-timing>`_. maps to: `Timing <dojox/timing>`_
  * `DojoX UUID <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-uuid>`_. maps to: `UUID <dojox/uuid>`_
  * `DojoX Validate <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-validate>`_. maps to: `Validate <dojox/validate>`_
  * `DojoX Widgets <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-widgets>`_. maps to: `Widgets <dojox/widget>`_
  * `DojoX Wire <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-wire>`_. maps to: `Wire <dojox/wire>`_
  * `DojoX XML Utilities <http://dojotoolkit.org/book/dojo-book-0-9/part-5-dojox/dojox-xml-utilities>`_. maps to: `XML Utilities <dojox/xml>`_



----

Chapters to be discussed whether they are still current enough to be ported

* `Part 1: Life With Dojo - Dojo and Dijit Application Examples <http://dojotoolkit.org/book/dojo-book-0-9/part-1-life-dojo-0>`_.

  * `Example 1: Why Doesn't Anyone Fill Out Their Tax Forms? <http://dojotoolkit.org/node/600>`_.
  * `Example 2: The Postman Always Clicks Twice <http://dojotoolkit.org/node/3151>`_.
  * `Example 3: Chatting With Tech Support <http://dojotoolkit.org/book/book-dojo/part-1-life-dojo-dojo-and-dijit-application-examples/example-4-chatting-tech-support>`_.
