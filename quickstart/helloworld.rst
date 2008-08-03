#format dojo_rst

Hello, World!
=============

:Status: Draft
:Version: 1.2
:Author: JChimene

The purpose of this tutorial is to provide a starting point for users who are new to Dojo. Whilst every effort is made to introduce as much as possible about Dojo, it is impossible to include more of the detailed information since to do so would be counterproductive and confusing to new users. For more information on the concepts introduced here, please see the links to other resources at the end of this document (Finding More Resources).

Requirements
------------

Obviously, you need Dojo first!  You can get the latest stable build from <a href="http://dojotoolkit.org/downloads">http://download.dojotoolkit.org</a>.  Next you need a web server.  Whether it's hosted offsite or onsite, on Linux or Windows or Mac ... matters naught.  The Dojo JavaScript library is simply pulled from your web server to the browser as needed.  However, the AJAX examples in this document require a server-side scripting language like PHP or ASP.

The Dojo and Dijit code, which runs on the client browser, is certified to run on IE 6 and 7, Firefox 2, and Safari.

Setting Up Dojo
---------------

First, you should create a directory on the web server.  We'll call ours HelloWorldTutorial.  Then create a directory called dojoroot underneath it.  Finally, use your favorite unzipping tool to unzip Dojo into /HelloWorldTutorial/dojoroot.  It'll look like this when you're done:

{{attachment:debugging9.png|sample directory structure}}


<h2>Getting Started</h2>

<p>Once we have setup the directory and file structure for the tutorial, we will need to setup the JavaScript component of our HTML page. Have a look at the code below:</p>

<code lang="html4strict">
<html>
  <head>
    <title>Dojo: Hello World!</title>

    <!-- SECTION 1 -->
    <style type="text/css">
        @import "dojoroot/dijit/themes/tundra/tundra.css";
        @import "dojoroot/dojo/resources/dojo.css"
    </style>
    <script type="text/javascript" src="dojoroot/dojo/dojo.js" 
      djConfig="parseOnLoad: true"></script>
  </head>

  <body class="tundra">
  </body>
</html>
</code>
<br/>
<p>As it can be seen above, the page is a just a standard HTML skeleton with three things:</p>

<ul>
<li>A couple of CSS style sheets.  The one marked Tundra is the <i>theme</i> we will use from Dijit for this example.  There
are other themes available.</li>
<li>A script element inserted into the head section. This script element is responsible for loading the base Dojo script that provides access to all the other Dojo functionality that we will use.</li>
<li>Lastly, we place the tundra CSS class in the body tag.</li>
</ul>

<h2>Creating a Button Widget</h2>

<p>Ok, now for the exciting part! In this example we're going to create a Button widget with the text 'Hello World!'. In the case of the Button widget, three visual states (mouseOut, mouseOver, and mouseDown) are available which means that we are able to enhance the user's experience somewhat.</p>

<p>The first step in creating the widget is telling Dojo to load the appropriate modules. In the header, add another section (hereafter referred to as section 2) below section 1 as follows:

<code lang="html4strict">
    <!-- SECTION 2 -->
    <script type="text/javascript">
       // Load Dojo's code relating to the Button widget
       dojo.require("dijit.form.Button");
    </script>
</code>
<br/>

<p>The dojo.require line instructs Dojo to load the Button widget. If you were to omit this line, the markup code for the button would not be evaluated by Dojo upon loading, resulting in a plain HTML button instead of what you expect.</p>

<p>After making the changes, insert the following code into the body section of the HTML:</p>

<code lang="html4strict">
    <button dojoType="dijit.form.Button" id="helloButton">Hello World!</button>
</code>


<p>The key attribute of this HTML element to notice is the dojoType attribute. The dojoType attribute is responsible for instructing Dojo on how to process the element when the page is loading. In this case we've used a button element for the button though we could have used an input element - Dojo will work with either as long as the dojoType attribute is present. It is worth noting that if we did use an input element, we would have to specify the button's text by using adding a caption attribute that contained the desired text.</p>

<h2>Connecting an Event to the Widget</h2>

<p>A button is all well and good, but what about getting it to do something when it's clicked? We could just specify an onClick event handler for the button, but there's another, more efficient way - the Dojo event system!</p>

<p>The easiest way to attach an event to a button is through a script tag.  But not just any script tag ... this one has a type of dojo/method, like this:</p>

<code lang="html4strict">
    <button dojoType="dijit.form.Button" id="helloButton">
        Hello World!
        <script type="dojo/method" event="onClick">
           alert('You pressed the button');
        </script>
    </button>
    }
</code>
<br/>

<p>Pretty simple, eh?  Putting the script inside the tag body makes a good deal of sense.  And you can harness the full power of DOM Level 2 events inside the script.  That means you can detect SHIFT and CTRL keys, get all sorts of event properties, and bubble events up through the HTML tree.  If you've ever used Level 2 events, you know how IE and Firefox use different syntax.  In Dojo, the same functions work in any supported browser.  That's powerful stuff!</p>

<h2>Reading Data from the Server</h2>

<p>Having an alert pop up when we press the button is great, but what if we want to retrieve some data from the server? Again, Dojo comes to the rescue with an easy method of accomplishing this - dojo.xhrGet. For easy reference, the code for this section is available as HelloWorld-Section5.html and response.txt in the attachments section.</p>

<p>To get started, we first need a callback function to handle the data to be returned from the server. Insert the following code into the header:

<code lang="html4strict">
<script>
       function helloCallback(data,ioArgs) {
          alert(data);
       }       
       function helloError(data, ioArgs) {
          alert('Error when retrieving data from the server!');
       }
</script>
</code>
<br/>

<p>The two arguments to the functions (data, and ioArgs) are important - don't leave any of them out! The first argument (data) contains the data sent back from the server, whilst the second argument contains a Dojo I/O Bind object.  Only the first concerns us right now.</p>

<p>The next step is to link the click of the button to the server request. To do this, modify the following code:</p>

<code lang="html4strict">
<script type="dojo/method" event="onClick">
    alert('You pressed the button');
</script>
</code>
<br/>

<p>To this:</p>

<code lang="html4strict">
<script type="dojo/method" event="onClick">
   dojo.xhrGet({
        url: 'response.txt',
        load: helloCallback,
        error: helloError
   });
</script>
</code>
<br/>

<p>The above code basically tells Dojo to query the URL specified by url and to use the function specified by handler to process the response from the server.</p>

<p>Finally, we need to create another file in the same directory as HelloWorld.html called response.txt. In this file, place the text 'Welcome to the Dojo Hello World Tutorial'.</p>

<p>Now, when the button is clicked, a JavaScript alert should display the text from the response.txt file. Dojo-Easy!</p>

<p>Next, we'll look at doing something meaningful with that server request.</p>

<h2>Sending Data to the Server Using GET</h2>

<p>It's all well and good retrieving static data from the server, but it is hardly a widely used situation in real life. So, instead of simply requesting data from the server we also will send it some information for it to process. In this section, we'll use the GET method whilst in the next section we'll use the POST method. For easy reference, the code for this section is available as HelloWorld-Section6.html in the attachments section. Server side code is also available as HelloWorldResponseGET.<type> where type is ASP ('.asp'), PHP ('.php'), ColdFusion ('.cfm'), or Java ('.jsp').</p>

<p>Firstly, in the markup section of the HelloWorld.html file (i.e. the body section), we need to add another element - an input element. So, change the code in this section from:</p>

<code lang="html4strict">
<button dojoType="Button" widgetId="helloButton">
    <script type="dojo/method" event="onClick">
    dojo.xhrGet({
        url: 'response.txt',
        load: helloCallback,
        error: helloError
    });
    </script>
</button>
</code>
<br/>

<p>to:</p>

<code lang="html4strict">
     <button dojoType="dijit.form.Button" id="helloButton">
        Hello World!
        <script type="dojo/method" event="onClick">
        dojo.xhrGet({
           url: 'HelloWorldResponseGET.php',
           load: helloCallback,
           error: helloError,
           content: {name: dojo.byId('name').value }
        });
        </script>
     </button>
     Please enter your name: <input type="text" id="name">
</code>
<br/>

<p>Before we go any further - it is important to mention that the url property in the dojo.xhrGet function call must be set to the file that is appropriate to your environment. If you are using an ASP server then the value must read 'HelloWorldResponseGET.asp' instead of 'HelloWorldResponseGET.php' Likewise, if you are using a ColdFusion server then the value must read 'HelloWorldResponseGET.cfm' instead of 'HelloWorldResponseGET.php'. Finally, if you are using a Java server (JSP) then the value must read 'HelloWorldResponseGET.jsp' instead of 'HelloWorldResponseGET.php', or if you are using a Perl server then the value must read 'HelloWorldResponseGET.pl' instead of 'HelloWorldResponseGET.pl'. The code for these files is in the sections below, and is also available as attachments to this tutorial.</p>

<p>In the code above, you will notice that there is a new property that has been passed to the dojo.xhrGet function. This property - content - allows the programmer to send arbitary values to the server as parameters. In this case, since we are using the default method of dojo.io.bind which is GET, the server side script will have the value of the textbox available to it as a the GET parameter 'name'. It is worth mentioning that if the script expected the parameter under a different name (such as 'myName'), we would simply change the content property to be (note the change of 'name' to 'myName' on the left of the assignment operator ':'):</p>

<code lang="js">
    content: {myName: dojo.byId('name').value }
</code>
<br/>

<p>Since we've not used it before, it is also worth noting the call dojo.byId('name').value. Quite simply, this call is a shortcut for the standard document.getElementById(..) function.</p>

<p>Finally, if you enter your name into the text box and you click the 'Hello World' button, an alert box should appear with the message 'Hello <name>, welcome to the world of Dojo!' where <name> is the name you entered into the text box.</p>

<p>Here are the server side scripts.  A few of them are downloadable at the bottom of this page (the website content management system doesn't allow .jsp or .cfm files).</p>

<h3>Using a PHP Server</h3>

<code lang="php">
<?php
  /*
  * HelloWorldResponseGET.php
  * --------
  *
  * Print the name that is passed in the
  * 'name' $_GET parameter in a sentence
  */

  header('Content-type: text/plain');
  print "Hello {$_GET['name']}, welcome to the world of Dojo!\n";
?>
</code>


<h3>Using an ASP Server</h3>

<code lang="asp">
<%
  '
  ' HelloWorldResponseGET.asp
  ' --------
  '
  ' Print the name that is passed in the
  ' 'name' GET parameter in a sentence
  '

  response.ContentType="text/plain"
  response.write("Hello " & request.querystring("name") & ", welcome to the world of Dojo!\n")
%>
</code>


<h3>Using a ColdFusion Server</h3>

<code lang="cf">
<!---
  /*
  * HelloWorldResponseGET.cfm
  * --------
  *
  * Print the name that is passed in the
  * 'name' GET parameter in a sentence
  */
--->
<cfsetting showDebugOutput="No">
Hello, #url.name#, welcome to the world of Dojo!
</cfsetting>
</code>


<h3>Using a Java Server (JSP)</h3>

<code lang="jsp">
<%
  /*
  ' HelloWorldResponseGET.jsp
  ' --------
  '
  ' Print the name that is passed in the
  ' 'name' GET parameter in a sentence
  */

  response.setContentType("text/plain");
%>
Hello <%= request.getParameter("name") %> , welcome to the world of Dojo!
</code>


<h3>Using a Perl Server</h3>

<code lang="perl">
#!/usr/bin/perl
#
#  ' HelloWorldResponseGET.pl
#  ' --------
#  '
#  ' Print the name that is passed in the
#  ' 'name' GET parameter in a sentence
#
use strict;
use CGI;
my $cgi = CGI::new();
print $cgi->header(-type => "text/html; charset=utf-8");
print "Hello " . $cgi->param('name') . ", welcome to the world of Dojo!\n";
</code>


<h2>Sending Data to the Server Using POST</h2>

<p>Using GET data is all well and good, but sometimes you want to use Dojo to improve the user's experience when using a traditional HTML form. As usual, Dojo has a very nice way of making this easier. Again, the code for these files is in the sections below, and are also available as attachments to this tutorial. Additionally, as with the last section, you will need to change the 'url' property to point to the file that is appropriate to your environment.</p>

<p>First, we need to change the markup in the body of HelloWorld.html from:</p>

<code lang="html4strict">
    <br>
    Please enter your name: <input type="text" id="name">
</code>
<br/>
<p>to:</p>

<code lang="html4strict">
    <br>
    <form id="myForm" method="POST">
      Please enter your name: <input type="text" name="name">
    </form>
</code>
<br/>

<p>Next we need to change the dojo/method:</p>

<code lang="html4strict">
<script type="dojo/method" event="onClick">
        dojo.xhrGet({
           url: 'HelloWorldResponseGET.php',
           load: helloCallback,
           error: helloError,
           content: {name: dojo.byId('name').value }
        });
</script>
</code>
<br/>

<p>to:</p>

<code lang="html4strict">
<script type="dojo/method" event="onClick">
   // Don't forget to replace the value for 'url' with
   // the value of appropriate file for your server
  // (i.e. 'HelloWorldResponsePOST.asp') for an ASP server
    dojo.xhrPost({
        url: 'HelloWorldResponsePOST.php',
        load: helloCallback,
        error: helloError,
        form: 'myForm'
   });
</script>
</code>
<br/>

<p>As can be seen from the code above, we've changed dojo.xhrGet to dojo.xhrPost.  We removed the 'content' property and replaced it with a new property 'form'. This basically informs the dojo.xhrPost function that it needs to use the form 'myForm' as the source for the data in the call. </p>

<p>As with the last section, entering your name and clicking 'Hello World!' should yield a message such as 'Hello <name>, welcome to the world of Dojo!' where <name> is the name you entered into the text box.</p>

<h3>Using a PHP Server</h3>

<code lang="php">
<?php
  /*
  * HelloWorldResponsePOST.php
  * --------
  *
  * Print the name that is passed in the
  * 'name' $_POST parameter in a sentence
  */

  header('Content-type: text/plain');
  print "Hello {$_POST['name']}, welcome to the world of Dojo!\n";
?>
</code>


<h3>Using an ASP Server</h3>

<code lang="asp">
<%
  '
  ' HelloWorldResponsePOST.asp
  ' --------
  '
  ' Print the name that is passed in the
  ' 'name' $_POST parameter in a sentence
  '

  response.ContentType="text/plain"
  response.write("Hello " & request.form("name") & ", welcome to the world of Dojo!\n")
%>
</code>


<h3>Using a ColdFusion Server</h3>

<code lang="cf">
<!---
  /*
  * HelloWorldResponsePOST.cfm
  * --------
  *
  * Print the name that is passed in the
  * 'name' POST parameter in a sentence
  */
--->
<cfsetting showDebugOutput="No">
Hello, #form.name#, welcome to the world of Dojo!
</cfsetting>
</code>


<h3>Using a Java Server (JSP)</h3>

<code lang="jsp">
<%
  /*
  ' HelloWorldResponsePOST.jsp
  ' --------
  '
  ' Print the name that is passed in the
  ' 'name' POST parameter in a sentence
  */

  response.setContentType("text/plain");
%>
Hello <%= request.getParameter("name") %> , welcome to the world of Dojo!
</code>


<h3>Using a Perl Server</h3>

<code lang="perl">
#!/usr/bin/perl
#
#  ' HelloWorldResponsePOST.pl
#  ' --------
#  '
#  ' Print the name that is passed in the
#  ' 'name' POST parameter in a sentence
#
use strict;
use CGI;
my $cgi = CGI::new();
print $cgi->header(-type => "text/html; charset=utf-8");
print "Hello " . $cgi->param('name') . ", welcome to the world of Dojo!\n";
</code>


<h2>Finding more resources</h2>

<p>I hope you've enjoyed this tutorial and found it informative. No doubt though, you will need more information on Dojo and how it and it's widgets work. Below is a list of links that will point you in the right direction.

<ul>

    <li><a href="http://dojotoolkit.org/docs/">The documentation page</a> for Dojo. Has links to all documentation. </li>

    <li><a href="http://www.dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/event-system">The Dojo event system</a>. How you can link functions to the normal JS events the Dojo way. </li>

    <li><a href="http://www.dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/ajax-transports"> Dojo XmlHttpRequest</a> - The foundation for AJAX in Dojo.</li>

    <li><a href="http://www.dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/manipulating-widgets-through-code/writing-yo-0">The File Upload Widget</a> - Widgets! Components! Does the complete tour of the creation of a fully functional UI component and it's usage. </li>

    <li><a href="http://svn.dojotoolkit.org/dojo/dojo/trunk/tests/">Dojo Unit Tests</a> from current nightly build (good for learning how things work) </li>

    <li><a href="http://svn.dojotoolkit.org/dojo/dijit/trunk/tests/">Dijit Unit Tests</a> from the current nightly build (good for learning how widgets work) </li>
</ul>

<h2>Contacting the Author</h2>

<p>Thinking of making modifications to this document? Want to make suggestions / constructive criticism?</p>

<p>If so, please contact me (Lance Duivenbode) at dojo AT duivenbode DOT id DOT au. Feedback is always welcome since it helps me improve my documentation - both now and in the future. Thanks!</p>


<h2>Changelog</h2>

<ul>
<li>17th November 2007 - Pulled kicking and screaming into the Dojo 1.0 era (Craig Riecke)</li>
<li>28th June 2006 - Addition of Perl Server examples for GET and POST (courtesy of Gareth Tansey)</li>
<li>21th June 2006 - Modification for compatibility with 0.3.x release (Bill Keese)</li>
<li>22th May 2006 - Addition of Java Server (JSP) examples for GET and POST (courtesy of Kexi)</li>
<li>19th May 2006 - Addition of ColdFusion examples for GET and POST (courtesy of Matthew Reinbold)</li>
<li>8th May 2006 - Initial Public Release </li>
</ul>
