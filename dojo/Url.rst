#format dojo_rst

dojo._Url
=============

:Status: Contributed, Draft
:Version: 1.2


Working with the URL query
--------------------------

.. codeviewer::

  <script type="text/javascript">dojo.require("dojox.widget.DocTestRunner");</script>
  <div dojoType="dojo.widget.DocTestRunner">
    >>> (new dojo._Url("http://localhost/?a=1&b=2")).query
    "a=1&b=2"
  </div>
