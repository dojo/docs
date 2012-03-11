.. _quickstart/writingWidgets/example:

==============================
Building a widget from scratch
==============================

So now, we'll build a widget to solve a practical problem. Your site is all neatly designed and feng-shui'ed ... except this one <input type="file"> tag. The user clicks on the button, and all of a sudden gets an operating system-styled box that doesn't look right, and is completely out of your control. Ugggh.

This is a perennial thorn-in-the-side for web developers. A Google search finds the ever-useful web site quirksmode, and they have a pretty simple solution: hide the file input, put a real input directly beneath where it would be, and make your own button off to the side. Logical enough. How hard would that be to make a widget?

Not hard at all, it turns out. Here's the plan:

- Hide the input boxes and draw our own
- Use Dojo to handle all my connections and fancy stuff
- Wrap it all up using dijit.form._FormWidget and diijt._Templated to take care of everything else

Hiding the Built-In File Upload Box
-----------------------------------
We'll use the programmatic method here. First we'll need a location on-disk for our widget. Since others have expressed interest in this widget, and we hope to contribute it to dojox, we'll place the widget in dojox/widget/FileInput.js. This means we'll be able to require() and provide() the module "dojox.widget.FileInput" as per the package system conventions. To get additional behavior we'll need to require() mixin classes, in case we don't already have them. So here's a stub for the class:

.. js ::

  dojo.provide("dojox.widget.FileInput");
  dojo.require("dijit.form._FormWidget");
  dojo.require("dijit._Templated");
  dojo.declare("dojox.widget.FileInput",
        [dijit.form._FormWidget, dijit._Templated],
        {
        // summary: A styled input type="file"
        //
        // description: A input type="file" form widget, with a button for uploading to be styled via css,
        //      a cancel button to clear selection, and FormWidget mixin to provide standard
        //      dijit.form.Form
        //
  });

Next we'll need a template, a label for our submit button, a label for our cancel button, and the name of the input:

.. js ::

        // label: String
        //      the title text of the "Browse" button
        label: "Browse ...",
  
        // cancelText: String
        //      the title of the "Cancel" button
        cancelText: "Cancel",
  
        // name: String
        //      ugh, this should be pulled from this.domNode
        name: "uploadFile",
  
        templatePath: dojo.moduleUrl("dojox.widget", "FileInput/FileInput.html"),


Also note that whenever we use template variables , it's good practice to supply a default, e.g. "Browse ..." for the label. Otherwise, if your widget user omits the label attribute, the parser will complain.

As we said earlier, it's preferable to separate the template out into a different file. Ours will look like the following, placed in dojox/widget/FileInput/FileInput.html:


.. html ::

  <div class="dijitFileInput">
        <input id="${id}" class="dijitFileInputReal" type="file"
                   data-dojo-attach-point="fileInput" name="${name}" />
        <div class="dijitFakeInput">
                <input class="dijitFileInputVisible" type="text"
                           data-dojo-attach-point="focusNode, inputNode" />
                <span class="dijitFileInputText"
                           data-dojo-attach-point="titleNode">${label}</span>
                <span class="dijitFileInputButton" data-dojo-attach-point="cancelNode"
                        data-dojo-attach-event="onclick:_onClick">
                        ${cancelText}
                </span>
        </div>
  </div>

Note how we assign classes to each major part, so we can apply design as CSS styles. We're also using data-dojo-attach-point="aString" so the parser makes these nodes available to us in code at the location this.fileInput.

There's one more thing: the base class _Widget automatically copies certain attributes like `id` and `name` to the widget's top level node.
Since we don't want that functionality in this case, we should override it, by adding the following code to the widget's
JavaScript:

.. js ::

    _setIdAttr: null,
    _setNameAttr: null


OK, let's make sure our widget starts up, and looks right. Let's make some simple css rules using the class names we set in our template:

.. css ::

  .dijitFileInput {
        position:relative;
        height:1.3em;
        padding:2px;
  }
  .dijitFileInputReal {
        position:absolute;
        z-index:2;
        opacity:0;
        filter:alpha(opacity:0);
  }
  .dijitFileInputButton,
  .dijitFileInputText {
        border:1px solid #333;
        padding:2px 12px 2px 12px;
        cursor:pointer;
  }
  .dijitFileInputButton {
        opacity:0;
        filter:alpha(opacity:0);
        z-index:3;
        visibility:hidden;
        
  }
  .dijitFakeInput { position:absolute; top:0; left:0; z-index:1; }

Looks good!

Connecting the Elements with Events
-----------------------------------
data-dojo-attach-event="onclick: _onClick" connects the onclick event of this.cancelNode to this._onClick, the method we are about to define (otherwise dojo.hitch will throw an error mentioning something about _onClick not having properties). We'll get to the onClick handler for the cancel button, and the reasons for having to do it later.

We also need to implement a simple onchange listener, like the article hints, so that when our onchange is detected in on our real file input (this.fileInput), we will call this._matchValue() to steal the value from it, and populate our visible input:

.. js ::

        startup: function(){
                // summary:
                //     Listen for changes on our real file input
                this.inherited(arguments);
                this._listener = dojo.connect(this.fileInput, "onchange", this, "_matchValue");
                this._keyListener = dojo.connect(this.fileInput, "onkeyup", this, "_matchValue");
        },
        _matchValue: function(){
                // summary:
                //     Set the content of the upper input based on the semi-hidden file input
                this.inputNode.value = this.fileInput.value;
                if(this.inputNode.value){
                        this.cancelNode.style.visibility = "visible";
                        dojo.fadeIn({ node: this.cancelNode, duration:275 }).play();
                }
        }

You've probably also noticed we added an onkeyup connection, running the same code. This way, if we type in the input, our changes will be reflected after each key press. Fortunately for this example, we'll ignore little nitpicks like "holding backspace doesn't fire onkeyup".

The _matchValue() function simply steals the file input value, sets it to the visible input value and fades in the cancel button (which we set earlier to visibility:hidden in FileInput.css).

So next, we need a reset button. Unfortunately because we're faking HTML out a bit, a plain old Reset button won't work. Since we aren't allowed write access to the file input, we can't just null the data. So our _onClick method actually destroys the <input type="file"> and reads it.

.. js ::

  _onClick: function(/*Event*/ e){
        // summary: on click of cancel button, since we can't clear the input because of
        //      security reasons, we destroy it, and add a new one in it's place.
        // Disconnect the listeners so they're not orphaned, and cleanly remove the tag
        dojo.disconnect(this._listener);
        dojo.disconnect(this._keyListener);
        this.domNode.removeChild(this.fileInput);
        // Fade our the cancel button so we no longer can press it
        dojo.fadeOut({ node: this.cancelNode, duration:275 }).play();
        // Create an identical input tag
        this.fileInput = document.createElement('input');
        this.fileInput.setAttribute("type", "file");
        this.fileInput.setAttribute("id", this.id);
        this.fileInput.setAttribute("name", this.name);
        dojo.addClass(this.fileInput, "dijitFileInputReal");
        // this.domNode is the root DOM node of the widget
        this.domNode.appendChild(this.fileInput);
        // Finally, connect the listeners to this new node.
        this._keyListener = dojo.connect(this.fileInput, "onkeyup", this, "_matchValue");
        this._listener = dojo.connect(this.fileInput, "onchange", this, "_matchValue");
        this.inputNode.value = "";
  }

Wiring It All Together
----------------------
So now we have our widget and our basic styles. We include this widget in our page declaratively by:

.. html ::

  <input type="file" name="uploadFile" data-dojo-type="dojox.widget.FileInput">

The real file input tag in the DOM goes away our templated input gets put in it's place. But if JavaScript is not present, it stays a regular HTML input tag, so it degrades nicely. Here is a sample test page to work with:

.. html ::

  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
        "http://www.w3.org/TR/html4/strict.dtd">
  <html>
  <head>
        <title>dojox.widget.FileInput | The Dojo Toolkit</title>
        <style type="text/css">
                @import "../../../dojo/resources/dojo.css";
                @import "../../../dijit/themes/dijit.css";
                @import "../FileInput/FileInput.css";
        </style>
        <script type="text/javascript" src="../../../dojo/dojo.js"
                   data-dojo-config="isDebug:true, parseOnLoad: true"></script>
        <script type="text/javascript">
                dojo.require("dojox.widget.FileInput");
                dojo.require("dojo.parser");    // scan page for widgets and instantiate them
        </script>
  </head>
  <body>
        <h3>A standard file input:</h3>
        <input type="file" id="normal" name="inputFile" />
        <h3>The default dojox.widget.FileInput:</h3>
        
        <input data-dojo-type="dojox.widget.FileInput" id="default" name="uploadFile" />
  </body>
  </html>

In theory, it will work inside of a tag just as the original element did.

Because we're big fans of re-using code, we can steal some CSS stuff from tundra.css and soria.css to provide theme-specific styles, so our input nodes look like they would in with all the other dijit.form Widgets (like ComboBox, FilteringSelect, ValidationTextBox, etc):

.. css ::

  /*tundra*/
  .tundra .dijitProgressOverlay {
        border:1px solid #84a3d1;
        background-color:#cad2de;
  }
  .tundra .dijitFakeInput input {
        font-size: inherit;
        background:#fff
            url("../../../dijit/themes/tundra/images/validationInputBg.png")
            repeat-x top left;
        border:1px solid #9b9b9b;
        line-height: normal;
        padding: 0.2em 0.3em;
  }
  .tundra .dijitFileInputButton,
  .tundra .dijitFileInputText {
        border:1px solid #9b9b9b;
        padding:2px 12px 2px 12px; /* .3em .4em .2em .4em; */
        background:#e9e9e9
            url("../../../dijit/themes/tundra/images/buttonEnabled.png")
            repeat-x top;
  }
  
  /*Soria*/
  .soria .dijitProgressOverlay {
        border:1px solid #333;
        background-color:#cad2de;
  }
  .soria .dijitFakeInput input {
        border:1px solid #333;
        background:#fff
            url("../../../dijit/themes/soria/images/gradientInverseTopBg.png")
            repeat-x top left;
        line-height:normal;
        background-position:0 -30px;
        padding:0.2em 0.3em;
  }
  .soria .dijitFileInputButton,
  .soria .dijitFileInputText {
        border:1px solid #333;
        padding:2px 12px 2px 12px;
        background:#b7cdee
            url('../../../dijit/themes/soria/images/gradientTopBg.png') repeat-x;
  }


Future Plans
------------
If you've been paying attention all this way, you probably noticed a class up there that we didn't define. .dijitProgressOverlay ... it doesn't exist anywhere in the dojox.widget.FileInput template or code.

The Dojo folks are building an extension to this widget called dojox.widget.FileInputAuto. It works like FileInput except it submits itself after a delay following a blur() on the element. For details (as yet undocumented), get the latest nightly build of Dojo and look for it in dojox.widget.
