#format dojo_rst

dojox.NodeList.delegate
=======================

.. contents::
    :depth: 2

:author: Bill 
:since: 1.6.0

========
Overview
========

A module providing an event delegation API to `dojo.NodeList <dojo/NodeList>`_

Delegate() monitors nodes in this NodeList for [bubbled] events on nodes that match a given selector.

This allows an app to setup a single event handler on a high level node, rather than many
event handlers on subnodes. For example, to monitor clicks on any <a> in your navigation section:

.. code-block :: javascript
  :linenos:

  dojo.query("#navbar").delegate("a", "onclick", function(evt){ ... } )

Since setting up many event handlers is expensive, using delegate() can increase performance.

Also, since the handler (in this example) is on navbar, it will report clicks on any <a> nodes added to navbar in the future
(in addition to the <a> nodes in navbar at the time of the delegate() call).

Note that delegate() will not work for events that don't bubble, like focus.
onmouseenter/onmouseleave also don't currently work.


=======
Example
=======

.. code-example::
  :type: inline

  .. html::
    :label: a navigation bar

    <div id="navbar">
        <a href="#" id="home">home</a>
        <a href="#" id="mail">mail</a>
        <a href="#" id="calendar">calendar</a>
    </div>

  .. javascript::
    :label: dojo.delegate in action

    <script type="text/javascript">
    dojo.addOnLoad(function(){
      dojo.query("#navbar").delegate("a", "onclick", function(evt){
          alert("clicked " + dojo.attr(this, "id"));
          dojo.stopEvent(evt);
      });
    </script>

========
See Also
========

* `dojo.NodeList <dojo/NodeList>`_
* `dojox.NodeList <dojox/NodeList>`_
