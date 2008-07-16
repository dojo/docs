#format dojo_rst

Examples
--------

.. cv-compound::

  A programmatic dialog with no content. First lets write up some simple HTML code because you need to define the place where your Dialog dhould be created.
  
  .. cv:: html
    :label: This you can place anywhere in your code since a dialog will always be on top of everything else 

    <div id="firstDialog"></div>    

  .. cv:: javascript
    :label: The jscript, put this wherever you want the dialog creation to happen

    dojo.addOnLoad(function(){
      var pane = dojo.byId('firstDialog');
				pane.style.width = "300px"; 	
				thirdDlg = new dijit.Dialog({
					id: "dialog3",
					refocus:false,
					title: "Programatic Dialog Creation"
				},pane);
      thirdDlg.show();
    });


Usecases
--------
