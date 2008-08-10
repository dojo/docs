## page was renamed from 1.2/dijit/Dialog
#format dojo_rst

dijit.Dialog
============

:Status: Contributed, Draft
:Version: 1.0

Dijit's modal Dialog Box simulates a regular GUI dialog box. The contents can be arbitrary HTML, but are most often a form or a short paragraph. The user can close the dialog box without acting by clicking on the X button in the top-right corner.

Notes
-----

The Dialog and underlay append themselves to the ``<body>`` element, which requires you apply your theme className there (as no other elements parent the Dialog.domNode). You need ``<body class="tundra">`` (or some other applicable theme name) in order for the Dialog to be styled.

Examples
--------

1. The first example creates a Dialog dynamically from an existing DOM node:

.. cv-compound::

  A programmatic dialog with no content. First lets write up some simple HTML code because you need to define the place where your Dialog dhould be created.
  
  .. cv:: html
    :label: When pressing this button the dialog will popup 

    <div id="dialogOne" dojoType="dijit.Dialog">
    <div dojoType="dijit.layout.TabContainer" style="width: 200px; height: 300px;"><div dojoType="dijit.layout.ContentPane" title="foo">Hi</div><div dojoType="dijit.layout.ContentPane" title="boo">Hi</div></div>
    </div>
    <button id="showDialog" dojoType="dijit.form.Button">Show me!</button>

  .. cv:: javascript
    :label: The javascript, put this wherever you want the dialog creation to happen

    <script type="text/javascript">

    dojo.require("dijit.form.Button");
    dojo.require("dijit.Dialog");
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");

    dojo.addOnLoad(function(){	
      // create the dialog
      /*firstDlg = new dijit.Dialog({
          title: "Programatic Dialog Creation",
          style: "width: 300px",
	}, "dialogOne");
       */
      firstDlg = dijit.byId("dialogOne");
      // connect t the button so we display the dialog onclick
      dojo.connect(dijit.byId("showDialog"), "onClick", firstDlg, "show");
    });
    </script>

2. Now lets change the dialogs content dynamically

.. cv-compound::

  A programmatic dialog with no content. First lets write up some simple HTML code because you need to define the place where your Dialog dhould be created.
  
  .. cv:: html
    :label: When pressing this button the dialog will popup. Notice this time there is no dom Node with content for the dialog 

    <button id="showDialogTwo" dojoType="dijit.form.Button">Show me!</button>

  .. cv:: javascript
    :label: The javascript, put this wherever you want the dialog creation to happen

    <script type="text/javascript">

    dojo.require("dijit.form.Button");
    dojo.require("dijit.Dialog");

    dojo.addOnLoad(function(){	
      // create the dialog
      secondDlg = new dijit.Dialog({
          title: "Programatic Dialog Creation",
          style: "width: 300px"
	});

      // set the content of the dialog 
      secondDlg.setContent("Hey, I wasn't there before!");

      // connect t the button so we display the dialog onclick
      dojo.connect(dijit.byId("showDialogTwo"), "onClick", secondDlg, "show");
    });
    </script>

Coloring the Underlay
---------------------

If you wish to alter the default color for the underlay, you do so in CSS. The underlay receives an ID to match the Dialog, suffixed with ``_underlay``, which you can define a css class for:

.. cv-compound::
 
  .. cv:: html
    :label: When pressing this button the dialog will popup 

    <style type="text/css">
    #dialogColor_underlay {
        background-color:green; 
    }
    </style>
    <div id="dialogColor" title="Colorful" dojoType="dijit.Dialog">
         My background color is Green
    </div>
    <button id="showDialog2" dojoType="dijit.form.Button">Show me!</button>

  .. cv:: javascript

    <script type="text/javascript">

    dojo.require("dijit.form.Button");
    dojo.require("dijit.Dialog");

    dojo.addOnLoad(function(){	
      // create the dialog
      var firstDlg = dijit.byId("dialogColor");
      // connect t the button so we display the dialog onclick
      dojo.connect(dijit.byId("showDialog2"), "onClick", firstDlg, "show");
    });
    </script>
