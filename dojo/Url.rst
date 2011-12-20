.. _dojo/Url:

=============
dojo._Url
=============


FIXME

Note: Actually I would like to close http://bugs.dojotoolkit.org/ticket/6175 and http://bugs.dojotoolkit.org/ticket/5548 before writing this chapter. The result should be a dojo.Url class that can parse and build URLs. imho (Wolfram)

Basics
-------
Dojo 1.7(AMD)
-------------
.. js ::
  
        require(["dojo/_base/url", "dojo/dom", "dojo/ready"], function(url, dom, ready){
            ready(function(){
                dom.byId("scheme").innerHTML =(new url("http://localhost:8080/home/")).scheme  //  'http'
                dom.byId("host").innerHTML =     (new url("http://localhost:8080/home/")).host // 'localhost'
                dom.byId("port").innerHTML =     (new url("http://localhost:8080/home/")).port //  '8080'
                dom.byId("path").innerHTML =     (new url("http://localhost:8080/home/")).path // '/home/'
                dom.byId("authority").innerHTML = (new url("http://localhost:8080/home/")).authority // 'localhost:8080'
                dom.byId("user").innerHTML =     (new url("http://username:pwd@localhost:8080/home/")).user //  'username'
                dom.byId("pwd").innerHTML =  (new url("http://username:pwd@localhost:8080/home/")).password //  'pwd'
            });
        
        });

.. html ::

    <body class="tundra">
        <div id="scheme"></div><br/>
        <div id="host"></div><br/>
        <div id="path"></div><br/>
        <div id="authority"></div><br/>
            <div id="port"></div><br/>
            <div id="user"></div><br/>
            <div id="pwd"></div>
    </body>

Dojo <1.7
---------
.. html ::
  
  <style type="text/css">
    @import "dojox/widget/DocTester/DocTester.css";
  </style>
  <script type="text/javascript">dojo.require("dojox.widget.DocTester");</script>
  <div data-dojo-type="dojox.widget.DocTester">
    >>> (new dojo._Url("http://localhost:8080/home/")).scheme
    "http"
    >>> (new dojo._Url("http://localhost:8080/home/")).host
    "localhost"
    >>> (new dojo._Url("http://localhost:8080/home/")).port
    "8080"
    >>> (new dojo._Url("http://localhost:8080/home/")).path
    "/home/"
    >>> (new dojo._Url("http://localhost:8080/home/")).authority
    "localhost:8080"
    >>> (new dojo._Url("http://username:pwd@localhost:8080/home/")).user
    "username"
    >>> (new dojo._Url("http://username:pwd@localhost:8080/home/")).password
    "pwd"
  </div>
