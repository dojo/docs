## page was renamed from 1.2/dojox/rpc
#format dojo_rst

dojox.rpc
=========

:Status: Contributed, Draft
:Version: 1.0

Examples
--------

This is an example of the Google API
Lets take at our result first

.. cv-compound::

  .. cv:: html

    <div id="loader"></div>
    <div id="json-rpc-container">
	<h2><a href="http://google.com"><img class="logo" src="http://www.google.com/logos/Logo_40wht.gif" alt="Google" /></a> Ajax API SMD</h2>
	<input id="test" name="test" type="text" size="30" value="The Dojo Toolkit"/><br>
	<select id="searchType">
		<option value="webSearch">web</option>
		<option value="localSearch">local</option>
		<option value="videoSearch">videos</option>
		<option value="blogSearch">blog</option>
		<option value="newsSearch">news</option>
		<option value="bookSearch">books</option>
		<option value="imageSearch">images</option>
	</select> &nbsp; 
	<button id="doit" type="submit" value="search">Search</button>

	<div id="current">
		<h3>Results:</h3>
		<ul id="top-results"></ul>
	</div>

	<div id="past">
		<h3>Old Searches:</h3>
		<ul id="archive"></ul>
	</div>	
    </div>

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojox.rpc.Service");
    dojo.require("dojo.io.script");

    var google, tehLoader = null;
    dojo.addOnLoad(function(){
        // define the service:
        google = new dojox.rpc.Service(dojo.moduleUrl("dojox.rpc","SMDLibrary/google.smd")); 
        // quick/easy loading indicator:
        tehLoader = dojo.hitch(dojo,"style","loader","visibility");

        dojo.query("#doit").onclick(function(e){

            tehLoader("visible");
            
            // move old results into the 'archive'
            dojo.query("li","top-results").forEach(function(item){
                dojo.byId("archive").appendChild(item);
            });

            // run the search
            var searchType = dojo.byId("searchType").value || "webSearch";
            google[searchType]({ q: dojo.byId("test").value })
                .addCallback(function(returned){
                    // create an <li> for each data part:
                    dojo.forEach(returned.responseData.results,function(item){
                        var li = dojo.doc.createElement('li');
                        li.innerHTML = "<a target='_new' hr"+"ef='"+ 
                            (item.unescapedUrl || item.url) +"'>" + item.title + 
                            "</a><br />" + "<span class='summary'>" + 
                            (item.content || item.streetAddress || "unknown") + 
                            "</span>"
                        ; 
                        dojo.byId("top-results").appendChild(li);
                    });
                    tehLoader("hidden");
                })
                .addErrback(function(err){
                    console.warn('ooops', err);
                    tehLoader("hidden");
                });
        });

    });
    </script>
