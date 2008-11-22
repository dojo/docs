#format dojo_rst

dijit.popup
===============

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

The Dijit popup code is part of Base Dijit (dijit.dijit, or dijit/_base) 


============
Introduction
============

TODO: introduce the component/class/method


=====
Usage
=====

TODO: how to use the component/class/method

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // your code
 </script>



========
Examples
========

.. code-block :: html
  :linenos:

		<body class="tundra">
	
			<h1>Welcome to my site</h1>
	
			<a class="loginLink" href="login.html">login</a>
	
			<div style="display:none">
				<div id="tt">
					<form id="loginForm" action="login.php">
			
						<span>Name: </span><input size="5"><br>
						<span>Password: </span><input type="password" size="5" ><br><br>
			
						<button id="submitter" type="submit">Login</button>
						<button id="cancel" type="reset">Cancel</button>

					</form>
				</div>
			</div>

			<script type="text/javascript">
	
				dojo.require("dijit.Dialog");
				dojo.addOnLoad(function(){
			
					dojo.query(".loginLink").forEach(function(n){
			
						dojo.query("#tt span").addClass("dijitInline");
				
						var myDialog = new dijit.TooltipDialog({}, "tt");
						myDialog.startup();
				
						dojo.connect(n, "onclick", function(e){
							e.preventDefault();
							dijit.popup.open({
								popup: myDialog, around: n
							});
						});
				
						dojo.query("#cancel").onclick(function(e){
							dijit.popup.close(myDialog);
						});
				
						dojo.query("#loginForm").onsubmit(function(e){
							e.preventDefault();
							dojo.xhrPost({ 
								form:"loginForm",
								handle: function(data){
									console.log(data, typeof data);
								} 
							})
						})
					});
				});
			</script>

	
		</body>



========
See also
========

* TODO: links to other related articles
