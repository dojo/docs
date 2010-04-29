#format dojo_rst

dojo.eval
=========

:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

Evaluate some string of JavaScript in global context.


============
Introduction
============

Evaluates the given string into window (global) scope rather than in current scope. Use this rather than ``eval``.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
  dojo.declare('Foo', null, {
    foo: function() {
      eval('var fooBar = "bar"');
    }
  });

  var foo = new Foo();
  foo.foo();
  // This will generate a "ReferenceError fooBar is not defined"
  console.info(fooBar)


  dojo.declare('Bar', null, {
    bar: function() {
      dojo.eval('var barBaz = "baz"');
    }
  });
  var bar = new Bar();
  bar.bar();
  // Show "baz" !
  console.info(barBaz);
 </script>
