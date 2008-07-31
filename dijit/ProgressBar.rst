#format dojo_rst

dijit.ProgressBar
=================

:Status: Draft
:Version: 1.2

A ProgressBar gives dynamic feedback on the progress of a long-running operation. The progress can be updated by JavaScript function calls. This method works best for long-running JavaScript operations, or a series of JavaScript XHR calls to the server.

Examples
--------

.. cv-compound::

  .. cv:: javascript

     <script type="text/javascript">
        dojo.require("dijit.ProgressBar");
        dojo.require("dojo.parser");
        
        function download(){
            // Split up bar into 7% segments
            numParts = Math.floor(100/7);
            jsProgress.update({ maximum: numParts, progress:0 });
            for (var i=0; i<=numParts; i++){
                // This plays update({progress:0}) at 1nn milliseconds, 
                // update({progress:1}) at 2nn milliseconds, etc.
                setTimeout(
                   "jsProgress.update({ progress: " + i + " })",
                   (i+1)*100 + Math.floor(Math.random()*100)
                );
            }
        }
     </script>

  .. cv:: html

    <div dojoType="dijit.ProgressBar" style="width:300px" 
         jsId="jsProgress" id="downloadProgress"></div>
    <input type="button" value="Go!" onclick="download();" />
