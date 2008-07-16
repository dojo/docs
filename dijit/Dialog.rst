#format dojo_rst

Examples
--------

.. cv-compound::

  A programmatic dialog with no content. First lets write up some simple HTML code because you need to define the place where your Dialog dhould be created.

  .. cv:: css

    <style type="text/css"></style>
  
  .. cv:: html
    :label: This you can place anywhere in your code since a dialog will always be on top of everything else 

    <div id="firstDialog"></div>    
    <button id="showDialog" dojoType="dijit.form.Button">Show me!</button>

  .. cv:: javascript
    :label: The jscript, put this wherever you want the dialog creation to happen

    <script type="text/javascript">

    dojo.require("dijit.form.Button");
    dojo.require("dijit.Dialog");

    dojo.addOnLoad(function(){	
      // create the dialog
      thirdDlg = new dijit.Dialog({
          id: "dialog3",
          refocus:false,
          title: "Programatic Dialog Creation"
	},dojo.byId('firstDialog'));

      // connect t the button so we display the dialog onclick
      dojo.connect(dijit.byId("showDialog"), "onclick", thirdDlg, "show");
    });
    </script>

Usecases
--------
