#format dojo_rst

Sooner or later, every Javascript programmer tries something like this:
<script>
  if(dayOfWeek == "Sunday"){
     document.musicPrefs.other.value = "Afrobeat";
  }
</script>
<form name="musicPrefs">
<input type="text" name="other">
...

It doesn't work because the "other" control is not defined yet. You can move the code to the bottom of the page, but that removes the linear nature of HTML. If you're reading the code, you want to zero in on a control, and see the code that influences it close by.

dojo.addOnLoad(...) defers script execution until all the HTML is loaded. So this code:
function setAfrobeat(){
   document.musicPrefs.other.value="Afrobeat";
}
dojo.addOnLoad(setAfrobeat);

conveniently replaces the one above. When the function is small, you may prefer to write it inline:
dojo.addOnLoad(
    function(){
        document.musicPrefs.other.value="Afrobeat";
    }
);

This is the function literal or anonymous function construct of JavaScript. If it looks really, really wierd to you, take a peek ahead at Functions as Variables for an explanation.
