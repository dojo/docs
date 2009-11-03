#format dojo_rst

dojo.trim
=========

:Status: Final
:Version: 1.4
:Available: since V1.2
:Author: Eugene Lazutkin

.. contents::
    :depth: 2

This function implements a frequently required functionality: it removes white-spaces from both ends of a string. This functionality is part of ECMAScript 5 standard and implemented by some browsers. In this case dojo.trim delegates to the native implementation. More information can be found here: `String.trim() at MDC <https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Global_Objects/String/Trim>`_.

Dojo's implementation was informed by `Steven Levithan's blog post <http://blog.stevenlevithan.com/archives/faster-trim-javascript>`_. We chose to implement the compact yet performant version. If your application requires even more speed, check out `dojo.string.trim <dojo/string/trim>`_, which implements the fastest version.

===========
Basic Usage
===========

dojo.trim accepts the only argument: a string to be trimmed.

Examples:

.. code-block :: javascript
  :linenos:
  
  function show(str){
    return "|" + dojo.trim(str) + "|";
  }
  
  var output1 = show("   one");
  var output2 = show("two ");
  var output3 = show("   three ");
  var output4 = show("\tfour\r\n");
  var output5 = show("\f\n\r\t\vF I V E\f\n\r\t\v");

You can see the result here:

.. code-example::
  :toolbar: none
  :width:  600
  :height: 400
  :djConfig: parseOnLoad: false

  Examples of dojo.trim().

  .. javascript::
    :label: Object example

    <script>
      function show(str){
        return "|" + dojo.trim(str) + "|";
      }
      dojo.addOnLoad(function(){
        dojo.byId("output1").innerHTML = show("   one");
        dojo.byId("output2").innerHTML = show("two ");
        dojo.byId("output3").innerHTML = show("   three ");
        dojo.byId("output4").innerHTML = show("\tfour\r\n");
        dojo.byId("output5").innerHTML = show("\f\n\r\t\vF I V E\f\n\r\t\v");
      });
    </script>

  Minimalistic HTML for our example.

  .. html::
    :label: Minimal HTML.

    <p id="output1"></p>
    <p id="output2"></p>
    <p id="output3"></p>
    <p id="output4"></p>
    <p id="output5"></p>
