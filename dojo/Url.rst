#format dojo_rst

dojo._Url
=============

:Status: Contributed, Draft
:Version: 1.2


Working with the URL query
--------------------------

.. codeviewer::
  
  <style type="text/css">
    @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/widget/DocTester/DocTester.css"; 
  </style>
  <script type="text/javascript">dojo.require("dojox.widget.DocTester");</script>
  <div dojoType="dojox.widget.DocTester">
    >>> (new dojo._Url("http://localhost/?a=1&b=2")).query
    "a=1&b=2"
    >>> 1+1
    3
  </div>
