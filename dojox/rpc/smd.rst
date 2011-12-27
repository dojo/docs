.. _dojox/rpc/smd:

====================================
Service Mapping Description Proposal
====================================

.. contents ::
  :depth: 2

Abstract
========

A Service Mapping Description (SMD) is a JSON representation describing web services. An SMD can defines the various aspects of a web service such that clients can coherently interact with the web services. An SMD can be used by generic tools to generate interfaces, human and programmatic, to access available web services. A wide array of web services can be described with SMD including REST services and JSON-RPC services. The SMD format is designed to be flexible, compact, simple, readable, and easily implemented.
Conventions

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in RFC 2119.

JSON Schema is based on JSON, therefore it shares the same basic types as JSON (see http://www.json.org or RFC 4627). Whenever this document refers to any JSON type, the first letter is always capitalized: Object, Array, String, Number, True, False, Null

Requirements
============

This document is intended to be used by service providers to properly author SMDs, and for web service clients to properly understand SMDs and generate methods to call the services. SMDs provide information about available services, but servers may be limited in their knowledge of the services, and clients may be limited in their ability to communicate to every possible service type. Therefore compliance to this specification does not require servers or clients to fully utilize or comprehend every service type and service attribute defined. For clients, compliance to this specification requires that clients that do utilize services as described in an SMD, utilize those services in accordance with the service's non-optional requirements in its definition. Clients that do not implement certain service types, may simply not utilize those services. For servers, compliance requires that services be operable in some form in accordance to their service definition. However, there is no requirement about how much information is provided about services, and therefore there can be no guarantee that a service request sent according to the service definition will behave as one expects. The more information that a server provides about services according to the specification, the greater level of interaction and utility a client may derive from the services as a result of the SMD. There are a few required properties in the SMD, that must be included to be a valid SMD.

Terminology
===========

Service - A service is a web endpoint that can perform an action and/or return specific information in response to a defined network request.

Method - A method is a subroutine that, in the context of this document, will execute a service and return a value corresponding to the value returned by the service.
Specification

An SMD is represented as a JSON Object with properties that are used to define the interaction of the available web services. At the root level an SMD can have service properties and a methods property with an Array value, with items that correspond to the available services. Each of the services can have their own service properties. The service properties defined at the root level are inherited by the service for each property that the service does not define itself. This allows service properties that are shared by all services to be defined once in the SMD. All service properties are optional unless otherwise stated. Below are the available service properties:

- **transport**
    The transport property defines the transport mechanism to be used to deliver service calls to servers. The following values are defined:

    - "POST" - The service call should be sent to the server using the HTTP POST method with the service message in the post body.
    - "GET" - The service call should be sent to the server using the HTTP GET method with the service message in URL query string.
    - "REST" - The service call can be sent to the server using standard REST HTTP methods (GET, PUT, DELETE, and POST) with parameters in the URL query string. All clients do not necessarily have authorization to use all the available HTTP methods for the provided service. A PUT and POST method require a content body for the service.
    - "JSONP" - The service call should be sent to the server using the HTTP GET method with parameters in the URL using standard parameter encoding and the response should be prepended with a call using the JSONP protocol. The callback parameter name should be defined with the jsonpCallbackParameter property.
    - "TCP/IP" - The service call should take place directly over TCP/IP. 

    The transport property defaults to "POST".
    
- **envelope**
    An envelope defines how a service message string is created from the provided parameters.

    - "URL" - The response should be value returned from the method call. For example: ``name=value`` would be included the query string or request body. URL encoded parameters allow multiple parameters with the same name, so it is recommended that lists/arrays should correspond to multiple parameters with the same name.
    - "PATH" - The parameters should be included in the path of the URL. For example: ``name/value`` would be appended the request path.
    - "JSON" - The parameters will be transferred as a JSON string. For example: ``{"name":"value"}`` would be included in the query string or request body.
    - "JSON-RPC-1.0" - The JSON-RPC 1.0 protocol should be used. For example: ``{"id":1,"method":"foo","params":["value"] }`` would be included in the request body.
    - "JSON-RPC-1.1" - The JSON-RPC 1.1 protocol is deprecated and should not be used.
    - "JSON-RPC-2.0" - The JSON-RPC 2.0 protocol should be used. For example: ``{"id":1,"method":"foo","version":"json-rpc-2.0","params":{"name":"value"}}`` would be included in the request body.
    
    The envelope property defaults to "URL".
    
- **contentType**
    This is the expected content type of the content returned by a service. Any valid MIME type is acceptable. This property defaults to ``application/json``.
    
- **jsonpCallbackParameter**
    This indicates the parameter named to be used to indicate the callback prepended on the JSON response. This defaults to "callback". For example, a the following jsonp exchange may take place::
    
      --> GET http://domain.com/service?id=3&callback=call1
      <-- call1({"name":"returned json object"});
    
- **target**
    This should indicate what URL (or IP address in the case of TCP/IP transport) to use for the method call requests. A URL may be an absolute URL or a relative URL
    When a relative URL is used at the root level, the URL should be considered relative to the relevant context of the SMD (presumably based on the URL used to retrieve the SMD resource). When a relative URL is used in a specific service definition (instead of at the root level) it should be considered relative to the root level target (whether computed or explicit).
    
- **additionalParameters**
    If additionalParameters is false, only parameters specified on a method will be allowed. Otherwise additional unnamed parameters can be included in the requests. If the additionalParameters is an object, it is a parameter definition for any additional parameters. This property defaults to true. For example::
    
      parameters:[{"name":"foo","type":"string"}],
      additionalParameters:{"type":"number"}
    
    would indicate that the parameter foo should be a string and all other parameters must be numbers. The following would be valid parameters::
    
      foo:"a string",bar:4,baz:10
      
- **parameters**
    This indicates what parameters may be supplied for the service calls. A parameters value MUST be an Array. Each value in the parameters Array should describe a parameter and follow the JSON Schema property definition. Each of parameters that are defined at the root level are inherited by each of service definition's parameters. The parameter definition follows the JSON Schema property definition with the additional properties:
    
    - **name**
        This is the name of the parameter. If names are not provided for all the parameters, this indicates positional/ordered parameter calls MUST be used. If names are provided in the parameters this indicates that named parameters SHOULD be issued by the client making the service call, and the server MUST support named parameters, but positional parameters MAY be issued by the client and servers SHOULD support positional parameters.
    - **optional**
        This indicates whether or not the parameter is required to be sent on service calls.
    - **default**
        This defines the default value for a parameter. When used in conjunction with the ``optional`` property being true, the parameter does not need to be sent on the service call, the server will treat the omission of the property as the default value. If the ``optional`` property is not true, than the client MUST send the property, and SHOULD use the default value when a user does not provide a value.
- **returns**
    This indicates the expected type of value returned from the method call. This value of this property should follow JSON Schema type definition.
- **name**
    This indicates the name of the method call. This can be used by libraries for referring to methods by name. This should be unique for each method and therefore should not be inherited from the root level.

Any additional custom properties can be defined for services as well.

At the root Object level only, the SMD can define the following properties (in addition to being able to OPTIONALLY define service properties at the root level):

- **services**
    This should be an Object value where each property in the Object represents one of the available services. The property name represents the name of the service, and the value is the service description. This property MUST be included.
- **SMDVersion**
    This is a string that indicates the version level of the SMD being used. This specification is at version level "2.0". This property SHOULD be included.
- **id**
    This is a unique identifier for the service. When possible, the id should represent the URL from which service descriptor can be accessed (relative URLs are acceptable). This property SHOULD be included.
- **description**
    This a description of the service. This property SHOULD be included.

Examples
========

::

    {
        "transport": "POST",
        "envelope": "URL",
        "target": "/service/",
        "additionalParameters": true,
        "parameters": [
            {
            "name":"outputType",
                "default": "json"
            },
            {
            "name":"ignoreErrors",
                "optional": true
            }
        ],
        "services": {
            "foo": {
                "transport": "GET",
                "target": "executeFoo.php",
                "parameters": [
                    {"name":"paramOne", "type": "string"},
                    {"name":"paramTwo", "type": "integer", "default": 5},
                    {"name":"paramThree", "type": "integer", "optional": true}
                ]
            },
            "add": {
                "transport": "POST",
                "envelope": "JSON-RPC-2.0",
                "additionalParameters": {"type": "integer", "default": 0},
                "parameters": [
                    {"type": "integer", "default": 0},
                    {"type": "integer", "default": 0}
                ]
            }
        }
    }

In the above example, two methods are defined: foo and add. foo is declared to take named parameters, with a service endpoint of /service/executeFoo.php (derived as a relative URL) with url-encoded parameters. The following is an example of a valid service call for the ``foo`` method::

    GET /service/executeFoo.php?paramOne=value&paramTwo=3&outputType=json

The ``add`` service is defined to use the service endpoint of /service/ (inherited from the root level), and takes positional parameters using JSON-RPC version 2.0. The following is an example of a valid service call for the add method::

    POST /service/

    {"id":1,"method":"add","params":[4,7,9]}

Note that all service definition properties are optional. Therefore, a service could be defined::

    "simple": {}

and this would indicate that any parameters may be passed in, and return value can be returned.


=========================
Type Defined Sub-Services
=========================

Some services may not only exist as services themselves, but the satisfied service (with provided parameters), may actually be an endpoint for other sub-services. In particular, it is possible for a REST service calls to be used as endpoints for JSON-RPC calls. A JSON Schema may define a methods property that has an array of available services with SMD service definitions. Service A may then define the return type of a service with a JSON Schema that defines additional available services on the objects returned by service A. This enables services to utilize object-oriented typing capabilities with method/service definitions that mirror the capabilities of programming language classes.

Examples of Sub-Services
========================

::

    {
       "services":{
           "person": {
                "transport": "REST",
                "envelope": "PATH",
                "target": "person",
                "parameters": [{
                    "name":"id",
                    "type": "string"
                }],
                "returns": {
                    "type": {
                        "id":{"type":"string" },
                        "firstName":{"type":"string"},
                        "lastName":{"type":"string"},
                        "age":{"type":"number","maximum":125,"minimum":0},
                        "address":{"type":"string"}}
                    },
                    "services":{
                        "sendMessage": {
                            "type": "method",
                            "transport": "RAW_POST",
                            "envelope": "JSON-RPC-2.0",
                            "parameters": [
                                {"type": "string", "optional": true},
                                {"type":"object"}],
                            "returns": {"type": "boolean"}
                        }
                    }
                }
            }
        }
    }