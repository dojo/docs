## page was renamed from 1.2/dojo/Deferred
#format dojo_rst

dojo.when
=============

:Status: Draft
:Version: 1.0
:Available: since V1.5

.. contents::
    :depth: 2

dojo.when provides the ability to define a callback (and error handler) for the eventual completion of a Deferred or promise object, or any standard synchronous value. 


=====
Usage
=====

The first argument to the dojo.when may be any value, the second argument is the callback, and the optional third argument is the error callback. If the first argument is a promise (like a dojo.Deferred object), then the callback (or error callback) will be called when the promise is resolved. If the first argument is not a promise, the callback will be call immediately (with the value passed as the first argument.


Example 1:  Creating and calling a deferred.
-------------------------------------------------------

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
    dojo.when(4, print); // this will print 4

    var fourAsync = dojo.Deferred();
    dojo.when(fourAsync, print); // this will print 4, one second later when the Deferred is resolved
    setTimeout(function(){
      fourAsync.callback(4);
    }, 1000);

    function print(value){
      console.log(value);
    }
  </script>


========
See Also
========

* `dojo.Deferred() <dojo/Deferred>`_
* Article on the new design of Deferreds in 1.5: http://www.sitepen.com/blog/2010/05/03/robust-promises-with-dojo-deferred-1-5/
