#format dojo_rst

dojo.xhrPost
============

:Status: Draft
:Version: 1.0
:Available: since V0.9

.. contents::
   :depth: 2


============
Introduction
============

The dojo.xhrPost() function is another the cornerstone function of AJAX development.  Much like its `GET counterpart <dojo/xhrGet>`_ (dojo.xhrGet), its purpose is to provide an easy to use and consistent interface to making asynchronous calls.  The dojo.xhrPost is geared towards  sending data to the server, most often by posting FORM data, or some content body.  This function, in essence, implements making an asynchronous HTTP 'POST' call.

The following information should get you up and going with dojo.xhrPost().  As with all dojo functions, always refer to the API docs for detailed information.

===========
Limitations
===========

The limitations are the same as `dojo.xhrGet <dojo/xhrGet>`_

=====
Usage
=====

The xhrPost() function takes an object as its parameter.  This object defines how the xhrPost should operate.  All the `dojo.xhrGet parameters <dojo/xhrGet#dojo-xhrget-supported-object-properties>`_ are valid, including how to set the load and errors handlers.  So, for specific information about those parameters, please refer to dojo.xhrGet.  This page only lists out the parameters which are usually only used in conjunction with with a POST.

dojo.xhrPost supported object properties
----------------------------------------

All of the dojo.xhrGet `object properties <dojo/xhrGet#dojo-xhrget-supported-object-properties>`_

+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**form**          |For posting FORM data, you can provide a either the DOM node of your form or the ID of the form.  The xhrPost will convert  |
|                  |this into proper POST format and send it with the post data.  If a url is not set in the args to dojo.xhrPost, then it tries|
|                  |to extract the url from the form 'action' attribute.                                                                        |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**postData**      |A string of data you wish to send as the post body.  dojo.xhrPost (and dojo.rawXhrPost), do not do any processing of this   |
|                  |It is merely passed through as the POST body.                                                                               |
|                  |                                                                                                                            |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+


Return type (dojo.Deferred)
---------------------------

The return type is the same as dojo.xhrGet.  Please refer to the `return type <dojo/xhrGet#return-type-dojo-deferred>`_ documentation for details.

Handling Status Codes
---------------------

Handling status codes for xhrPost is the same as handling them for xhrGet.  Please refer to the dojo.xhrGet `status code documentation <dojo/xhrGet#handling-status-codes>`_ for details.

========
Examples
========


For specific examples of how to use dojo.xhrPost, please refer to the following.  You can use Firebug with Firefox to see dojo making the xhr requests and the generated POST data.  For Internet Explorer, you will need to use a debugging proxy like 'Charles'.
 
Example 1: dojo.xhrPost call to send a form
-------------------------------------------


.. code-example::
  :djConfig: parseOnLoad: false

  .. javascript::

    <script type="text/javascript">
     
    </script>

  .. html::

    <h1>hi</h1>

Example 2: dojo.xhrPost call to send some text data
---------------------------------------------------


========
See also
========

* `dojo.xhrGet <dojo/xhrGet>`_
* `dojo.xhrPut <dojo/xhrPut>`_
* `dojo.rawXhrPut <dojo/rawXhrPut>`_
* `dojo.xhrDelete <dojo/xhrDelete>`_
