#format dojo_rst

Browser Sniffing
================

Dojo provides a number of ``is`` variables, defined at runtime based on the users current browser.

* dojo.isIE
* dojo.isMozilla
* dojo.isFF
* dojo.isOpera

.. codeviewer::

  <script type="text/javascript">
  function makeTemplate() {
    function makePair(n) { return "<dt>dojo.is" + n + "</dt><dd>" + dojo["is" + n].toString() + "</dd>"; }
    var pairs = dojo.map(["IE", "Mozilla", "FF", "Opera"], makePair);
    return "<dl>" + pairs.join() + "</dl>";
  }
  dojo.declare("sniffer", [dijit._Widget, dijit._Templated] , {
    templateString: makeTemplate()
  });
  </script>
  <div dojoType="sniffer"></div>

``TODOC: finish, and elaborate with examples``
