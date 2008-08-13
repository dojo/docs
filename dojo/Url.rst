#format dojo_rst

dojo._Url
=============

:Status: Contributed, Draft
:Version: 1.2

Basics
-------

.. codeviewer::
  
  <style type="text/css">
    @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/widget/DocTester/DocTester.css"; 
  </style>
  <script type="text/javascript">dojo.require("dojox.widget.DocTester");</script>
  <div dojoType="dojox.widget.DocTester">
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
