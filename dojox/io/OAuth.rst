#format dojo_rst

dojox.io.OAuth
===============

:Status: Draft
:Version: 1.0
:Project owner: Tom Trenka
:Available: since V1.3

.. contents::
   :depth: 2

dojox.io.OAuth is a helper class that allows you to "sign" any kwArgs object you might use with any of the dojo Ajax methods. It was designed to be as simple to use as possible, without exposing the user to the overhead and specification of OAuth.


============
Introduction
============

dojox.io.OAuth, a singleton (i.e. you never instantiate it), enables OAuth-signed Ajax requests to be made as if they were native to the Dojo Toolkit.

The main method to be used is the "sign" method; what this method does is to create an OAuth-compatible signature for any URL-based request. It includes everything needed to accomplish this signature--which includes attaching all of the tokens required, the signature method used, a nonce (random number), and the signature check/hash.

As web applications, services and mashups evolve, a perennial problem begins to assert itself—the issue of authorization (or in layman’s terms, making sure both application and service know who you are). A number of different approaches have been developed; one such approach is the OAuth specification, which is designed as a fool-proof way of validating requests.

Because of the growing popularity of the OAuth protocol, we’ve added support for it to the Dojo Toolkit in the form of dojox.io.OAuth—which can be used to sign any request made with the Dojo Toolkit’s various Ajax methods, including XHR, IFrame and Script transports.

What is OAuth?
--------------

The OAuth scheme involves the use of key/token pairs to sign a request. Unlike standard authentication schemes, OAuth was designed so that authentication only needs to happen once—and this authentication can be accomplished without requiring participation on the part of the consuming web application.

Base concepts
-------------

OAuth is an authorization protocol that enables a consumer application to apply for authorization to access a resource while leaving the actual authentication to the issuing resource.

To an OAuth service, there are three participants: the issuing resource (i.e. the service against which authorization is performed), the consumer application (i.e. the application accessing protected resources), and the user (i.e. the person authorizing the consumer application to access the resources protected by the issuing resource). OAuth attempts to negotiate and define how these three participants interact, without compromising sensitive information.

The basic idea behind the OAuth protocol is that there is a pair of token sets—one pair created for the consumer application, and one pair for the user of that application. These token sets take the form of a key and a token secret. The consumer application is issued this token set upon registering with the service to be consumed, while the user pair is issued only after the OAuth handshake is completed.

Once both token pairs are created, the consuming application will then use these tokens to generate a signature for every request made to the issuing service. The issuing service then validates that signature before responding with any information.

The OAuth handshake
-------------------

The OAuth handshake is the most critical part of the authorization process. A request is made by the consumer application to the service for a request token; the service provider issues the token, and then asks the consumer to redirect the user directly to the service, where the actual authentication takes place.

Once the user has been authenticated by the service, the service will then redirect the user back to the consumer application—at which point the consumer application will ask the service for an access token, using the information provided by the redirect (which is a temporary token set). From here, the service provides the consumer application with a real token set for the user, at which point protected resources can be accessed.

Note that the initial request token, granted to the consumer application at the beginning of the handshake process, is used by the service to identify which user has authorized the consumer application to access protected resources; equally important is the fact that the consumer application never has access to the user’s authentication process. By placing the actual authentication outside of the realm of the consumer application, the OAuth protocol ensures that the consumer application has no access to login information—thereby ensuring that at all times, the user’s information remains secured.

The OAuth token set
-------------------

An OAuth token set consists of a pair of strings—a key and a token secret. A token set might look like the following:

oauth_token=bzb8aexfpvz56m4da82gksvf
&oauth_token_secret=Zp4eJkFMRLiT
&application_name=myApplication

The only time the token secret is broadcast is during the handshake process; this is critical for the remainder of the application’s lifetime, since it is the token secret that is used to sign an OAuth request.
Constructing an OAuth signature

Once the handshake process is complete, each and every request made to the OAuth-based service must be signed. The OAuth signature process is complex but relatively straight-forward; it consists of assembling the base string, adding a timestamp and a nonce, and generating the actual signature digest.
Assembling the base string

The base string is created by concatenating the HTTP method, a URL-encoded version of the URI to be requested, and an alphabetical list of all the request’s parameters—including all of the OAuth parameters, with the exception of the oauth_signature. The OAuth parameters required for every request are:

    * oauth_consumer_key
    * oauth_token
    * oauth_signature_method
    * oauth_nonce
    * oauth_timestamp
    * oauth_version

The oauth_consumer_key is the key provided to the consumer application by the issuing service, and the oauth_token is the key provided to the user by the service during the handshake process. In addition, a nonce and timestamp must be generated for each and every request. Finally, the signature method (i.e. how the request signature was generated) and the version is provided.
Generating the nonce

The nonce is simply a randomly generated string of variable length; the longer the string, the better the chances are of providing uniqueness to the request. The combination of nonce and timestamp (which takes the form of a UNIX timestamp, to the second) ensures that each request is unique—similar to the way many UUIDs are generated. Most nonces look similar to a base64-encoded string, but usually only uses numbers and both upper and lower case characters.

Creating the signature
----------------------

Once all of the parameters of the request are provided, the signature process does the following:

   1. Assembles all of the parameters of the request in alphabetical order, and concatenates them with the & character;
   2. Prepends the HTTP method and the URL-encoded URI to the list, also using the & character;
   3. Generates a signature using the specified signature method;
   4. Appends the signature to the URI request using the oauth_signature parameter. 

The OAuth protocol supports three signature methods: PLAINTEXT, HMAC-SHA1, and RSA-SHA1. The PLAINTEXT method simply passes back the consumer and user token secrets; for obvious reasons, this signature method is not recommended. Both the HMAC and RSA methods use their respective encryption algorithms to generate a digest. The most common method used is HMAC-SHA1, since this method does not require the exchange of private keys.

Once the base string is assembled (steps 1 and 2, above), a signature is then generated using the consumer token secret and, if available, the user’s token secret. A typical signature would be generated something like this:

.. code-block :: javascript
 :linenos:

 var signature = SHA1_HMAC(consumer_secret + "&" + user_secret, baseString);


If there is no user token secret available, the key should end with the & character:

.. code-block :: javascript
 :linenos:

 var signature = SHA1_HMAC(consumer_secret + "&", baseString);


This digest is then base64-encoded and added to the original URL string with the oauth_signature parameter, and then finally the entire request is sent to the service.

Validating the request
----------------------

Once the request is sent to the service, the entire process is duplicated; the service will break apart the URL, use the nonce and timestamp provided, reassemble the base string and then generate the signature using the provided signature method. If these digests match, the request is considered valid and a response is returned.

The benefits of signing a request this way are plentiful; at no time (unless the PLAINTEXT signature method is used) are any token secrets broadcast over the Internet, where a man-in-the-middle attack might be able to get at them. The user’s token secret is broadcast only once (during the initial handshake process) but at no time is the consumer application’s token secret transmitted. And because the signature is a secured digest, differing platforms with accurate SHA1 implementations can regenerate the same signature and be assured that the request was not tampered with en route.

=====
Usage
=====

To support the OAuth protocol, dojox.io.OAuth was added to the DojoX project with a very easy to use interface. This implementation was designed to work hand-in-hand with any Dojo Ajax method, such as dojo.xhrGet and dojo.io.iframe.send, using the same approach.

Signing a request
-----------------

To sign a request using dojox.io.OAuth, simply pass the keyword arguments object you would normally pass to the Ajax method with the HTTP method and an object containing the tokens for the consumer and user, like so:

.. code-block :: javascript
 :linenos:

 //	the access tokens
 var access = {
	consumer: {
		key: "4958gj86hj6g99",
		secret: "Zp4eJkFMRLiT"
	},
	user: {
		key: "bzb8aexfpvz56m4da82gksvf",
		secret: "dpf43f3p2l4k3l03"
	},
	sig_method: "HMAC-SHA1"
 };
 //	our request will be made with the HTTP GET verb
 var args = dojox.io.OAuth.sign("GET", kwArgs, access);


(Note that the keys and secrets here are fake.)

The kwArgs would be the same object you’d create for any Dojo Ajax method.

Using dojox.io.OAuth in conjunction with Dojo Ajax methods
----------------------------------------------------------

Once you have the signed object, simply pass it to any Dojo Ajax method the same way you’d pass your original keyword arguments:

.. code-block :: javascript
 :linenos:

 var dfd = dojo.xhrGet(args);


========
Examples
========

Example 1
---------

TODO: example

=======
Credits
=======
The contents of this article are excerpts used with permission from an original article by Tom Trenka at Sitepen:
* `Introducing OAuth in Dojox <http://www.sitepen.com/blog/2009/02/19/introducing-oauth-in-dojox/>`_
