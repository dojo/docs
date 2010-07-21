#format dojo_rst

dojo.back
=========

:Available: since V1.0

.. contents::
    :depth: 2

dojo.back allows you to update the browser history, so that it's possible to use the Back- and Forward-buttons of a Browser without leaving the web application.

**NOTE**: There are problems with using dojo.back with semantically-named fragment identifiers ("hash values" on an URL). In most browsers it will be hard for dojo.back to know distinguish a back from a forward event in those cases. For back/forward support to work best, the fragment ID should always be a unique value (something using new Date().getTime() for example). If you want to detect hash changes using semantic fragment IDs, then consider using `dojo.hash <dojo/hash>`_ instead (in Dojo 1.4+).

=====
Usage
=====

Initialization
--------------

To use dojo.back:

1. Add the appropriate require statement:

   .. code-block :: javascript

      dojo.require("dojo.back");
   ..

2. Register the initial state of the page by calling:

   .. code-block :: javascript

       dojo.back.setInitialState(state);
   ..

   This state object will be called when the user clicks Back all the way back to the start of the web application. If the user clicks Back once more, they will go back in the browser to wherever they were before loading the web application.

   The state object should have the following functions defined:

   * For receiving Back notifications: back(), backButton() or handle(type), where type will either be the string "back" or "forward".
   * For receiving Forward notifications: forward(), forwardButton() or handle(type), where type will either be the string "back" or "forward".

   Example of a very simple state object:

   .. code-block :: javascript

       var state = {
           back: function() { alert("Back was clicked!"); },
           forward: function() { alert("Forward was clicked!"); }
       };
   ..

3. Call dojo.back.init(); inside a script tag that is inside the <body> tag:

   .. code-block :: javascript

       <body>
         <script type="text/javascript">dojo.back.init();</script>
         (rest of the body here)
       </body>

   ..

**WARNING:** dojo.back.init() must be called before the page's DOM is finished loading. Otherwise it will not work. Be careful with xdomain loading or djConfig.debugAtAllCosts scenarios, in order for this method to work, dojo.back will need to be part of a build layer.

Register a state object
-----------------------

To register a state object that represents the result of a user action, use the following call:

.. code-block :: javascript

  dojo.back.addToHistory(state);


Change the URL in the location bar
----------------------------------

To change the URL in the browser's location bar, include a **changeUrl** property on the state object.

* If this property is set to true, dojo.back will generate a unique value for the fragment identifier. 
* If it is set to any other value (except undefined, null, 0 or empty string), then that value will be used as the fragment identifier. 

This will allow users to bookmark the page.

========
Examples
========

TODO


bookmarkable
------------

A simple demo of dojo.back - it's bookmarkable and based on the tests/back.html

**BROKEN**
**this isn't working in the sandbox - needs to be a fullblown page ... leaving it here till i figure out if it can be done**

dojo.back needs either a local dojo.js or a local iframe_history.html


.. code-example::

  .. javascript::

        <script type="text/javascript">
            djConfig.dojoIframeHistoryUrl = "{{dataUrl}}/dojo/back?action=AttachFile&do=get&target=iframe_history.html";
            dojo.require("dojo.back");

            ApplicationState = function(stateData, outputDivId, backForwardOutputDivId, bookmarkValue){
                this.stateData = stateData;
                this.outputDivId = outputDivId;
                this.backForwardOutputDivId = backForwardOutputDivId;
                this.changeUrl = bookmarkValue || false;
            }
	
            dojo.extend(ApplicationState, {
                back: function(){ this.showStateData( "we got here going back" ); },
                forward: function(){ this.showStateData( "we got here going forward" ); },
                showStateData: function(msg){
                    dojo.byId(this.outputDivId).innerHTML = "msg: " + msg + '<br />';
                    dojo.byId(this.outputDivId).innerHTML += this.stateData + '<br />';
                }
            });

            var data = {
                link0: "This is the initial state (page first loaded)",
                "link with spaces": "This is data for a state with spaces",
                "link%20with%20encoded": "This is data for a state with encoded bits",
                "link+with+pluses": "This is data for a state with pluses",
                link1: "This is data for link 1",
                link2: "This is data for link 2",
                link3: "This is data for link 3",
                link4: "This is data for link 4",
                link5: "This is data for link 5",
                link6: "This is data for link 6",
                link7: "This is data for link 7"
            };

            function goNav(id){
                var appState = new ApplicationState(data[id], "output", "dataOutput", id);
                appState.showStateData( "we got here by clicking" );
                dojo.back.addToHistory(appState);
            }

            dojo.addOnLoad(function(){
                var link = unescape( new dojo._Url( document.URL ).fragment || "link0" );
                var appState = new ApplicationState(data[ link ], "output", "dataOutput");
                appState.showStateData( "initial state" );
                dojo.back.setInitialState(appState);
            });

            dojo.back.init();
        </script>

  .. html::

        <div style="padding-bottom: 20px; width: 100%; border-bottom: 1px solid gray">
            <h3>dojo.back test</h3>
        </div>
        <div style="float:left; padding: 20px">
            <button onclick="goNav('link1')">Link 1</button><br />
            <button onclick="goNav('link with spaces')">Link with Spaces</button><br />
            <button onclick="goNav('link%20with%20encoded')">Link with Encoded</button><br />
            <button onclick="goNav('link+with+pluses')">Link with Pluses</button><br />
            <button onclick="goNav('link3')">Link 3</button><br />
            <button onclick="goNav('link4')">Link 4</button><br />
            <button onclick="goNav('link5')">Link 5</button><br />
            <button onclick="goNav('link6')">Link 6</button><br />
            <button onclick="goNav('link7')">Link 7</button><br />
        </div>
        <div style="float: left; padding: 20px">
            <b>Data Output:</b><br />
            <div id="output"></div>
            <hr />
            <i>Back/Forward Info:</i><br />
            <div id="dataOutput"></div>
        </div>
