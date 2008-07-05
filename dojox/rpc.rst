#format dojo_rst

Dojox.rpc
=========

Examples
--------

This is an example of the Google API
Lets take at our result first

.. codeviewer::

		<div id="loader"></div>
		<div id="json-rpc-container">
			<h2><a href="http://google.com"><img class="logo" src="http://www.google.com/logos/Logo_40wht.gif" alt="Google" /></a> Ajax API SMD</h2>

			<input id="test" name="test" type="text" size="30" value="The Dojo Toolkit"/> &nbsp;
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

			<hr>
			
			<p>There are many per-serivce options available. This demo just pulls data and tries ...</p>
			<p>That's all folks. Unit tests to come when we address the io.script issue.</p>
			
			
		</div>

and now at the js code

.. codeviewer::

  <script type="text/javascript">
		dojo.require("dojox.rpc.Service");
		dojo.require("dojo.io.script");

		// FIXME: we do this because Google API passes a list of params instead of just an object
		// this affects other io.script transports
		dojo.mixin(dojo.io.script,{
			_jsonpCallback:function(json){
				this.ioArgs.json = arguments.length > 0 ? arguments : json;
			}
		});
  </script>

This part is a bit tricky

.. codeviewer::

  <script type="text/javascript">

		var google, showLoader, hideLoader = null;
		function init(){

			google = new dojox.rpc.Service(dojo.moduleUrl("dojox.rpc","SMDLibrary/google.smd")); 
			
			showLoader = dojo.hitch(dojo,"style","loader","visibility","visible");
			hideLoader = dojo.hitch(dojo,"style","loader","visibility","hidden");

			dojo.connect(dojo.byId("doit"),"onclick", function(e){

				showLoader();
				dojo.style("loader","visibility","visible");
				
				dojo.query("li","top-results").forEach(function(item){
					dojo.byId("archive").appendChild(item);
				});

				var searchType = dojo.byId("searchType").value || "webSearch";
				google[searchType]({ q: dojo.byId("test").value,  })
					// generic succes handler:
					.addCallback(function(returned){
						var info = returned[1].cursor; 
						var data = returned[1].results || [];
						dojo.forEach(data,function(item){
							var li = dojo.doc.createElement('li');
							li.innerHTML = "<a target='_new' hr"+"ef='"+ (item.unescapedUrl || item.url) +"'>" + item.title + "</a><br />" +
								"<span class='summary'>" + (item.content || item.streetAddress || "unknown") + "</span>"; 
							
							//console.log(item);
							dojo.byId("top-results").appendChild(li);
						});
						hideLoader();
					})
					// something bad happened:
					.addErrback(function(err){
						console.warn('ooops', err);
						hideLoader();
					});
			});

		}
		dojo.addOnLoad(init);

	</script>
