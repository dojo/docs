#format dojo_rst

dojox.data.FilStore
===================

:Status: Contributed, Draft
:Version: 1.0

The dojox.data.FileStore is a lightweight javascript implementation for accessing details about a remote FileSystem.  This includes being able to search the filesystem to locate file names, display path information, file sizes, if it’s a directory or not, and if a directory, what children files are contained within it.   The dojox.data.FileStore is also an excellent example of how DataStores can do lazy-loading.   

The datastore implementation and its example PHP back-end by default do not inflate the child file objects of a DataStore file item.  This allows it to quickly return information about a file without having to return everything, while at the same time providing hooks that allow for the information to be gathered on-demand.  

"Features"
#n The client javascript and example server php script implement the following dojo.data APIs:  dojo.data.api.Read, dojo.data.api.Identity.
#n A deliberately simple client side implementation for use as a reference when implementing other server side stores that wish to provide lazy-loading as defined by the dojo.data.api.Read spec.  The client code is deliberately small to make it easy to understand.
