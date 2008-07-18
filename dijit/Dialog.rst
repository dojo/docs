#format dojo_rst

:Status: Contributed, Draft
:Version: 1.0

Dijit's modal Dialog Box simulates a regular GUI dialog box. The contents can be arbitrary HTML, but are most often a form or a short paragraph. The user can close the dialog box without acting by clicking on the X button in the top-right corner.

Examples
--------

1. The first example creates a Dialog dynamically from an existing DOM node:

.. cv-compound::

  A programmatic dialog with no content. First lets write up some simple HTML code because you need to define the place where your Dialog dhould be created.
  
  .. cv:: html
    :label: When pressing this button the dialog will popup 

    <div id="dialogOne">This is my dialog content</div>
    <button id="showDialog" dojoType="dijit.form.Button">Show me!</button>

  .. cv:: javascript
    :label: The javascript, put this wherever you want the dialog creation to happen

    <script type="text/javascript">

    dojo.require("dijit.form.Button");
    dojo.require("dijit.Dialog");

    dojo.addOnLoad(function(){	
      // create the dialog
      firstDlg = new dijit.Dialog({
          title: "Programatic Dialog Creation"
	}, "dialogOne");

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
          title: "Programatic Dialog Creation"
	});

      // set the content of the dialog 
      secondDlg.setContent("Hey, I wasn't there before!");

      // connect t the button so we display the dialog onclick
      dojo.connect(dijit.byId("showDialogTwo"), "onClick", secondDlg, "show");
    });
    </script>

Usecases
--------
