#format dojo_rst

dojox.data.AppStore
===================

:Status: Draft
:Version: 1.0
:Project owner: Benjamin Schell
:Available: since V1.3

.. contents::
   :depth: 2

A store implementing an Atom store with complete ATOM Publishing Protocol support. Allows reading and writing of ATOM formatted feeds.

============
Introduction
============

The dojox.data.AppStore is data store implementation of the ATOM Publishing Protocol (APP).  It makes use of the dojox.atom subproject for handling ATOM feeds and entries.  

===========
Limitations
===========

The AppStore makes use of dojo.xhr to get and modify feeds and entries.  Because of this, the AppStore is limited by the browser same domain policy, where xhr can only open connections back to the server that originated the page.  If you require accessing ATOM feeds from external services, you will need to make use of a proxy.

==============
Supported APIs
==============

The following dojo.data APIs are implemented by AppStore

* `dojo.data.api.Read <dojo/data/api/Read>`_
* `dojo.data.api.Write <dojo/data/api/Write>`_
* `dojo.data.api.Identity <dojo/data/api/Identity>`_

======================
Constructor Parameters
======================

+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| **Parameter**  | **Required** | **Description**                                                                                | **Since** |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| url            | No           |This parameter specifies what URL from which to load the ATOM feed document, and is also the    |1.3        |
|                |              |base url used for publishing new feed entries if the feed supports it.                          |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+

=================
Input Data Format
=================

The input data format is the standard `ATOM <http://en.wikipedia.org/wiki/Atom_(standard)>`_ feed format.  An example of an ATOM feed is below:

.. code-block :: javascript
 :linenos:

  <?xml version='1.0' encoding='utf-8'?>
  <feed xmlns='http://www.w3.org/2005/Atom' xml:lang='en-US'>
	<title>Example.com</title>
	<link rel="alternate" type="text/html" href="http://example.com/" hreflang="en" title="Example.com" />
	<subtitle type='text'>Example.com's Sample Feed</subtitle>
	<rights>Copyright Example.com</rights>
	<id>http://example.com/samplefeed.xml</id>
	<updated>2007-08-07T20:00:00-05:00</updated>
	<link rel="self" type="application/atom+xml" href="http://www.example.com/samplefeed.xml"/>
	<entry>
		<title>Test Entry #1</title>
		<id>http://example.com/samplefeed.xml/entry/1</id>
		<link rel='alternate' href='http://example.com/1.html'/>
		<summary type='html'>
			<p>This is a sample entry in our Atom feed.  It is simply a large paragraph in the summary.<p>
			<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Cras cursus. Aliquam eget metus sed leo lacinia 
			rutrum. Nunc lacus lacus, viverra placerat, laoreet nec, placerat vel, eros. Donec nec magna id sem commodo rutrum. 
			Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Aenean pede. Quisque vel 
			leo. In vitae nisi. Curabitur sodales congue nibh. Maecenas ultrices ante nec ipsum. Aenean quis nibh. Aenean semper, 
			quam vitae ullamcorper euismod, arcu leo tincidunt nunc, vel pulvinar turpis dolor a elit. Praesent nonummy nunc 
			faucibus nibh. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus laoreet, 
			ante auctor condimentum venenatis, magna quam varius elit, at feugiat dolor metus id quam. Etiam enim.<p>
		</summary>
		<author>
			<name>Test User</name>
			<email>test@example.com</email>
		</author>
		<updated>2007-08-07T04:00:00-05:00</updated>
	</entry>
	<entry>
		<title>Test Entry #2</title>
		<id>http://example.com/samplefeed.xml/entry/2</id>
		<link rel='alternate' href='http://example.com/2.html'/>
		<summary type='text'>
			This is a sample entry in our Atom feed.  It is simply a large paragraph in the summary. This is straight text.
			Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Cras cursus. Aliquam eget metus sed leo lacinia 
			rutrum. Nunc lacus lacus, viverra placerat, laoreet nec, placerat vel, eros. Donec nec magna id sem commodo rutrum. 
			Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Aenean pede. Quisque vel 
			leo. In vitae nisi. Curabitur sodales congue nibh. Maecenas ultrices ante nec ipsum. Aenean quis nibh. Aenean semper, 
			quam vitae ullamcorper euismod, arcu leo tincidunt nunc, vel pulvinar turpis dolor a elit. Praesent nonummy nunc 
			faucibus nibh. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus laoreet, 
			ante auctor condimentum venenatis, magna quam varius elit, at feugiat dolor metus id quam. Etiam enim.
		</summary>
		<author>
			<email>test@example.com</email>
		</author>
		<updated>2007-08-07T06:00:00-05:00</updated>
	</entry>
  </feed>

=====
Usage
=====

The AppStore conforms to the dojo.data APIs and all example usage scenarios for them apply here as well  Please refer to the `dojo.data API <dojo/data/api>`_ page for more details.  In general, since it conforms to the dojo.data API, all databound widgets in dijit can connect to, and make us of, the ATOM data.  Please refer to the examples section for more usage details.

========
Examples
========

Example 1: Programmatic instantiation and querying of ATOM Feeds.
-----------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.data.AppStore");

      //This function performs some basic dojo initialization and will do the fetch calling for this example
      function initSimple () {
        var appStore = new dojox.data.AppStore({url:});
      }
      //Set the init function to run when dojo loading and page parsing has completed.
      dojo.addOnLoad(initSimple);
    </script>

  .. cv :: html 

    <div dojoType="dijit.form.Button" jsId="button">Click me to search the store and display feed titles</div>
    <br>
    <br>
    <span id="list">
    </span>

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
