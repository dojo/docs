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

1. The first example creates a Dialog via markup from an existing DOM node:

.. cv-compound::

  A dialog created via markup. First let's write up some simple HTML code because you need to define the place where your Dialog sdhould be created.
  
  .. cv:: html
    :label: When pressing this button the dialog will popup 

    <div id="dialogOne" dojoType="dijit.Dialog">
      <div dojoType="dijit.layout.TabContainer" style="width: 200px; height: 300px;">
        <div dojoType="dijit.layout.ContentPane" title="foo">Hi</div>
        <div dojoType="dijit.layout.ContentPane" title="boo">Hi</div>
      </div>
    </div>
    <button id="buttonOne" dojoType="dijit.form.Button">Show me!</button>

  .. cv:: javascript
    :label: The javascript, put this wherever you want the dialog creation to happen

    <script type="text/javascript">

    dojo.require("dijit.form.Button");
    dojo.require("dijit.Dialog");
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");

    dojo.addOnLoad(function(){	
      firstDlg = dijit.byId("dialogOne");
      // connect to the button so we display the dialog on click
      dojo.connect(dijit.byId("buttonOne"), "onClick", firstDlg, "show");
    });
    </script>

2. Now lets create a dialog programmatically, and change the dialog's content dynamically

.. cv-compound::

  A programmatically created dialog with no content. First lets write up some simple HTML code because you need to define the place where your Dialog dhould be created.
  
  .. cv:: html
    :label: When pressing this button the dialog will popup. Notice this time there is no dom Node with content for the dialog 

    <button id="buttonTwo" dojoType="dijit.form.Button" onClick="showDialogTwo">Show me!</button>

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

      function showDialogTwo(){
           // set the content of the dialog
            secondDlg.attr("content", "Hey, I wasn't there before, I was added at " + new Date() + "!");
            secondDlg.show();
      }
    });
    </script>

Getting Dialog Results
----------------------
Often a Dialog is used to collect user data.   Like the Form widget,
Dialog will return the user data as a javascript object.

.. cv-compound::

  
  .. cv:: html
    :label: When pressing this button the dialog will popup 

	<div dojoType="dijit.Dialog" id="formDialog" title="Form Dialog"
			execute="alert('submitted w/args:\n' + dojo.toJson(arguments[0], true));">
		<table>
			<tr>
				<td><label for="name">Name: </label></td>
				<td><input dojoType=dijit.form.TextBox type="text" name="name" id="name"></td>
			</tr>
			<tr>
				<td><label for="loc">Location: </label></td>
				<td><input dojoType=dijit.form.TextBox type="text" name="loc" id="loc"></td>
			</tr>
			<tr>
				<td><label for="date">Start date: </label></td>
				<td><input dojoType=dijit.form.DateTextBox type="text" name="sdate" id="sdate"></td>
			</tr>
			<tr>
				<td><label for="date">End date: </label></td>
				<td><input dojoType=dijit.form.DateTextBox type="text" name="edate" id="edate"></td>
			</tr>
			<tr>
				<td><label for="date">Time: </label></td>
				<td><input dojoType=dijit.form.TimeTextBox type="text" name="time" id="time"></td>
			</tr>
			<tr>
				<td><label for="desc">Description: </label></td>
				<td><input dojoType=dijit.form.TextBox type="text" name="desc" id="desc"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button dojoType=dijit.form.Button type="submit">OK</button></td>
			</tr>
		</table>
	</div>
       <button id="buttonThree" dojoType="dijit.form.Button">Show me!</button>

  .. cv:: javascript
    :label: The javascript, put this wherever you want the dialog creation to happen

    <script type="text/javascript">

    dojo.require("dijit.form.Button");
    dojo.require("dijit.Dialog");
    dojo.require("dijit.form.TextBox");
    dojo.require("dijit.form.DateTextBox");
    dojo.require("dijit.form.TimeTextBox");

    dojo.addOnLoad(function(){	
      formDlg = dijit.byId("formDialog");
      // connect to the button so we display the dialog on click
      dojo.connect(dijit.byId("buttonThree"), "onClick", formDlg, "show");
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
    <button id="button4" dojoType="dijit.form.Button">Show me!</button>

  .. cv:: javascript

    <script type="text/javascript">

    dojo.require("dijit.form.Button");
    dojo.require("dijit.Dialog");

    dojo.addOnLoad(function(){	
      // create the dialog
      var dialogColor = dijit.byId("dialogColor");
      // connect t the button so we display the dialog onclick
      dojo.connect(dijit.byId("button4"), "onClick", dialogColor, "show");
    });
    </script>

Confirming Dialog Contents
--------------------------

To prevent the user from dismissing the dialog if there are errors in the form, add an onSubmit handler to your submit button:

TODO: copy example from test_Dialog.html
