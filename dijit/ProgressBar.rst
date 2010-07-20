#format dojo_rst

dijit.ProgressBar
=================

A ProgressBar gives dynamic feedback on the progress of a long-running operation. The progress can be updated by JavaScript function calls. This method works best for long-running JavaScript operations, or a series of JavaScript XHR calls to the server.


========
Examples
========

Declarative markup
------------------

.. cv-compound::

  .. cv:: javascript

     <script type="text/javascript">
        dojo.require("dijit.ProgressBar");
        dojo.require("dojo.parser");
        
 	var i=0;
        function download() {
			jsProgress.update({maximum: 10, progress: ++i});
			if(i < 10){
				setTimeout(download, 100 + Math.floor(Math.random() * 100));
			}
        }
     </script>

  .. cv:: html

    <div dojoType="dijit.ProgressBar" style="width:300px" 
         jsId="jsProgress" id="downloadProgress" maximum="10"></div>
    
    <br /><input type="button" value="Go!" onclick="download();" />


=============
Accessibility
=============

The progress bar is made accessible by providing a solid border around the visual progress indicator. This border is visible in high contrast mode as well as when images are turned off.

The internalProgress div is assigned the ARIA role of progressbar The valuenow attribute is updated as the progress is updated. In releases prior to 1.0 no valuemin and valuemax values are provided since the valuenow attribute may be a string provided by the Web developer. In 1.0 and later releases The ARIA valuenow property is set to the ProgressBar's progress value. The valuemin and valuemax properties are set to 0 and the ProgressBar's maximum, respectively.

Note: The hot key for the Window-Eyes screen reader to speak progress bar information is ctrl-ins-b. JAWS provides the hot key ins-tab for announcing progress bar name and status. JAWS also has a setting to select the frequency of progress bar announcements. Go to the Configuration Manager, Select Set Options, then User Options and select the desired announcement frequency.
