var input = document.getElementById('name');
input.onkeyup = function() {
  document.getElementById('tname').innerHTML = input.value;
}
var input2 = document.getElementById('desc');
input2.onkeyup = function() {
  document.getElementById('dname').innerHTML = input2.value;
}
var input3 = document.getElementById('bp');
input3.onkeyup = function() {
  document.getElementById('bpcount').innerHTML = input3.value;
}
 function colSwitch() {
  var currentc = document.querySelector('input[name="players"]:checked').value;
  var str = currentc.toString();
  if (str === 'cyan') {
    document.getElementById('bombastic').style.background = "";
    document.getElementById('bombastic').style.backgroundColor = "#023542";
    document.getElementById('bombastic').style.borderRightColor = "#042A36";
  } else if (str === 'yellow') {
    document.getElementById('bombastic').style.background = "";
    document.getElementById('bombastic').style.backgroundColor = "#433D05";
    document.getElementById('bombastic').style.borderRightColor = "#342C07";
  } else if (str === 'green') {
    document.getElementById('bombastic').style.background = "";
    document.getElementById('bombastic').style.backgroundColor = "#063806";
    document.getElementById('bombastic').style.borderRightColor = "#112B07";
  } else if (str === 'orange') {
    document.getElementById('bombastic').style.background = "";
    document.getElementById('bombastic').style.backgroundColor = "#452107";
    document.getElementById('bombastic').style.borderRightColor = "#361808";
  } else if (str === 'bnp') {
    document.getElementById('bombastic').style.background = "linear-gradient(90deg, rgba(0,173,197,1) 0%, rgba(163,63,105,1) 100%)";
    document.getElementById('bombastic').style.borderRightColor = "#370B17"; 
  } else if (str === 'custom') {
    var col = document.getElementById("ccolor").value;
    var col2 = document.getElementById("ccolor2").value;
    document.getElementById('bombastic').style.background = "";
    document.getElementById('bombastic').style.backgroundColor = col;
    document.getElementById('bombastic').style.borderRightColor = col2;
  } else {
    var grad = document.getElementById("gradc").value;
    var grad2 = document.getElementById("gradc2").value;
    var grad3 = document.getElementById("gradc3").value;
    document.getElementById('bombastic').style.background = `linear-gradient(90deg,${grad} 0%, ${grad2} 100%)`;
    document.getElementById('bombastic').style.borderRightColor = grad3;
  }
}
function buttonSwitch(num){
document.getElementById("bpiconc").src="img/bp" + num + ".png"; 
}


