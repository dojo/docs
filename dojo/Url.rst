#format dojo_rst

dojo._Url
=============

:Status: Contributed, Draft
:Version: 1.2

FIXME

Note: Actually I would like to close http://bugs.dojotoolkit.org/ticket/6175 and http://bugs.dojotoolkit.org/ticket/5548 before writing this chapter. The result should be a dojo.Url class that can parse and build URLs. imho (Wolfram)

Basics
-------

.. codeviewer::
  
  <style type="text/css">
    @import "dojox/widget/DocTester/DocTester.css"; 
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
