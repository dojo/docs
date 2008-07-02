#format dojo_rst

dijit.form.ComboBox
===================

Combobox provides great functions

Examples
--------

.. codeviewer::

  <script type="text/javascript">
    dojo.require("dijit.form.ComboBox");
  </script>
  <div class="nihilo">
    <label for="setvaluetest">US State test 1</label> 
    <select id="setvaluetest"
        name="state1"
	dojoType="dijit.form.ComboBox"
	style="width:50%;font-size:100%;font-family:Tahoma;"
	name="foo.bar1"
	autoComplete="false"
	onChange="dojo.byId('oc1').value=arguments[0]"
	pageSize="30"
    >
    <option></option>
    <option>Alabama</option>
    <option>Alaska</option>
    <option>American Samoa</option>
    <option>Arizona</option>
    <option>Arkansas</option>
    <option>Armed Forces Europe</option>
    <option>Armed Forces Pacific</option>
    <option>Armed Forces the Americas</option>
    <option>California</option>
    <option>Colorado</option>
    <option>Connecticut</option>
    <option>Delaware</option>
    <option>District of Columbia</option>
    <option>Federated States of Micronesia</option>
    <option>Florida</option>
    <option>Georgia</option>
    <option>Guam</option>
    <option>Hawaii</option>
    <option>Idaho</option>
    <option>Illinois</option>
    <option>Indiana</option>
    <option selected>Iowa</option>
    <option>Kansas</option>
    <option>Kentucky</option>
    <option>Louisiana</option>
    <option>Maine</option>
    <option>Marshall Islands</option>
    <option>Maryland</option>
    <option>Massachusetts</option>
    <option>Michigan</option>
    <option>Minnesota</option>
    <option>Mississippi</option>
    <option>Missouri</option>
    <option>Montana</option>
    <option>Nebraska</option>
    <option>Nevada</option>
    <option>New Hampshire</option>
    <option>New Jersey</option>
    <option>New Mexico</option>
    <option>New York</option>
    <option>North Carolina</option>
    <option>North Dakota</option>
    <option>Northern Mariana Islands</option>
    <option>Ohio</option>
    <option>Oklahoma</option>
    <option>Oregon</option>
    <option>Pennsylvania</option>
    <option>Puerto Rico</option>
    <option>Rhode Island</option>
    <option>South Carolina</option>
    <option>South Dakota</option>
    <option>Tennessee</option>
    <option>Texas</option>
    <option>Utah</option>
    <option>Vermont</option>
    <option>Virgin Islands, U.S.</option>
    <option>Virginia</option>
    <option>Washington</option>
    <option>West Virginia</option>    
    <option>Wisconsin</option>
    <option>Wyoming</option>
    </select>
  </div>
