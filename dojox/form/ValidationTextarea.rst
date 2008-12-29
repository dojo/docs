#format dojo_rst

dojox.form.ValidationTextarea
=============================

:Status: Draft | Contributed
:Version: 1.3
:Author: Mike Wilcox

Basic Description
-----------------

Extends and acts just as the dijit.form.Textarea, but with validation. Specifically handles *maxLength*, *required*, and *promptMessage*.  


Example
-------

.. cv-compound::
 
  The JavaScript:

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojox.form.ValidationTextarea");
    </script>

  The HTML:

  .. cv:: html
    
    <span class="noticeMessage"> ValidationTextarea, Attributes: {maxLength:20, required:false, promptMessage:no}</span>
    <textarea dojoType="dojox.form.ValidationTextarea" class="TextArea" maxLength="20" value="0123456789012345678"></textarea>
    <span class="noticeMessage"> ValidationTextarea, Attributes: {maxLength:20, required:true, promptMessage:yes}</span>
    <textarea dojoType="dojox.form.ValidationTextarea" class="TextArea" maxLength="20" value="" required="true" promptMessage="You need to put some text here."></textarea>


In the above examples, the *maxLength* is set to 20 characters, and any typing beyond that will be prevented. The second textarea will give a user hint if the field is empty, and a validation error if it is blank.
