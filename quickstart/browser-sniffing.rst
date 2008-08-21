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
  function makeAnswer(who){
    if(dojo["is" + who]) return "Yes, it's version " + dojo["is" + who];
    else return "No";
  }

  dojo.addOnLoad(function(){
    dojo.forEach(["IE", "Mozilla", "FF", "Opera"],
                 function(n) {
                   dojo.byId("answerIs" + n).innerHTML = makeAnswer(n);
                 });
  });
  </script>
  <dl>
    <dt>Is this Internet Explorer?</dt>
    <dd id="answerIsIE"></dd>
    <dt>Is this Firefox?</dt>
    <dd id="answerIsIE"></dd>
    <dt>Is this Mozilla?</dt>
    <dd id="answerIsIE"></dd>
    <dt>Is this Opera?</dt>
    <dd id="answerIsIE"></dd>
  </dl>

``TODOC: finish, and elaborate with examples``
