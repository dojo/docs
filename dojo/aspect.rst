.. _dojo/aspect:

===========
dojo/aspect
===========

:Authors: Kris Zyp
:Project owner: Kris Zyp
:since: 1.7.0

.. contents ::
  :depth: 2

The dojo/aspect module provides aspect oriented programming facilities to attach additional functionality to existing methods. The dojo/aspect module returns three functions.  Note: If you are connecting to DOM Events rather than regular JS objects and functions, use dojo/on rather than dojo/aspect.

dojo/aspect API
===============

.. _dojo/aspect#after:

after()
-------

The module includes an after function that provides after advice to a method. The provided advising function will be called after the main method is called. The after function's signature is:

.. js ::

  after(target, methodName, advisingFunction, receiveArguments);

The target is the object with the method. The methodName is the name of the method to advice. The advisingFunction is the function that will be called after the original method is called. The return value from the method will be provided as the first argument to the advising function. The advising function can return a value to replace the final return value of the method call. For example:

.. js ::

  define(["dojo/aspect"], function(aspect){
    aspect.after(dojo, "xhr", function(deferred){
      // this is called after any dojo.xhr call
    });
    // this will execute the original dojo.xhr method and then our advising function
    dojo.xhr("GET", {...});
  });

We can also load dojo/aspect with dojo.require("dojo.aspect") to make it available globally as dojo.aspect:

.. js ::

  dojo.require("dojo.aspect");
  dojo.aspect.after(dojo, "xhr", function(response){
    ...
  });

The advising function can return a value to replace the final return value of the method call. For example:

.. js ::

  aspect.after(dojo, "xhr", function(deferred){
    // returning a value replaces the return value
    return deferred.then(function(response){
      return dojo.fromJson(response);
    });
  });
  var parsedResponse = dojo.xhr("GET", {...});
  
The advisory function can also be called with the original arguments of the method by setting the receiveArguments parameter to true. For example:

.. js ::

  aspect.after(dojo, "xhr", function(method, args){
    // now we have access to the original arguments
  }, true);

before()
--------

The module also includes a before function that provides before advice to a method. The provided advising function will be called before the main method is called. The before function's signature is:

.. js ::

  before(target, methodName, advisingFunction);

The target is the object with the method. The methodName is the name of the method to advice. The advisingFunction is the function that will be called before the original method is called. The arguments used to call the method will be provided as the arguments to the advising function. The advising function can return an array to replace the arguments passed to the original method (or the next before advice). For example:

.. js ::

  define(["dojo/aspect"], function(aspect){
    aspect.before(dojo, "xhr", function(method, args){
      // this is called before any dojo.xhr call
      if(method == "PUT"){
        // if the method is PUT, change it to a POST and put the method in the parameter string
        args.url += "?x-method=PUT";
        // return the new args
        return ["POST", args];
      }
    });
    // this will execute the original our advising function and then dojo.xhr
    dojo.xhr("PUT", {...});
  });

around()
--------

The module finally includes an around function that provides around advice to a method. The provided advising function will be called in place of the main method, and the advising function will be passed a chaining function that can be used to continue to call execution to the next advice or original method. The around function's signature is:

.. js ::

  around(target, methodName, advisingFactory);

The target is the object with the method. The methodName is the name of the method to advice. The advisingFactory is a  function that will be called immediately with a single argument that is a function that can be called to continue the execution. The advisingFactory should return a function that will be called when the method is called. The arguments used to call the method will be provided as the arguments to the returned advising function. The advising function's return value will be returned from the method call. For example:

.. js ::

  define(["dojo/aspect"], function(aspect){
    aspect.around(dojo, "xhr", function(originalXhr){
      return function(method, args){
        // doing something before the original call
        var deferred = originalXhr(method, args);
        // doing something after the original call
        return deferred;
      }
    });
    dojo.xhr("PUT", {...});
  });
