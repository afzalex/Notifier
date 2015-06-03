<?php
require_once("res/utils.php");
session_start();
$res = Client::installResult();
if(!isset($_SESSION["client"])){
	header("Location: unauthenticated.php");
}
$client = $_SESSION["client"];
$client->loadNotifiers();
$crton = $client->createdon;
$today = new DateTime();
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="scripts/jquery.js"></script>
<script type="text/javascript" src="scripts/jquery-ui.js"></script>
<link href="scripts/jquery-ui.css" rel="stylesheet" type="text/css"  />
<link type="image/icon-x" href="favicon.png" rel="shortcut icon"  />
<link href="styles/default.css" rel="stylesheet" type="text/css" />
<link href="styles/commpane.css" rel="stylesheet" type="text/css" />
<link href="styles/panel.css" rel="stylesheet" type="text/css"  />
<title>Notifier</title>
<script type="text/javascript">
$(document).ready(function(e) {
	$("#loader").load("datareceiver.php", function(txt, stat){
		if(stat == 'success')
		$("#signal").css("background-image","url('/notifier/images/greensignal.png')");
		else $("#signal").css("background-image","url('/notifier/images/redsignal.png')");
	});
	$("#datepicker").datepicker({
		inline: true,
		<?php 
		echo 'defaultDate: new Date("'.$today->format('d M, Y').'"),';
		echo 'minDate: new Date("'.$crton->format('d M, Y').'"),';
		echo 'maxDate: new Date("'.$today->format('d M, Y').'"),';
		?>
		dateFormat: "d M, yy"
	});
	$("#datepicker").change(function(e) {
		$("#signal").css("background-image","url('/notifier/images/yellowsignal.png')");
		$("#loader").load("datareceiver.php", {"date": getRecDate()}, function(txt, stat){
			if(stat == 'success')
			$("#signal").css("background-image","url('/notifier/images/greensignal.png')");
			else $("#signal").css("background-image","url('/notifier/images/redsignal.png')");
		});
    });
	$("#refresh").click(function(e) {recChanged();});
	$("#reset").click(function(e) {
		$("#signal").css("background-image","url('/notifier/images/yellowsignal.png')");
        $("#loader").load("datareceiver.php", {"date": getRecDate(), "reset":"reset"}, function(txt, stat){
			if(stat == 'success')
			$("#signal").css("background-image","url('/notifier/images/greensignal.png')");
			else $("#signal").css("background-image","url('/notifier/images/redsignal.png')");
		});
    });
	$("#back").click(function(e) {
		var $dtpkr = $("#datepicker")
		var date = $dtpkr.datepicker("getDate");
		date.setDate(date.getDate() - 1);
        $dtpkr.datepicker("setDate", date); 
		$("#datepicker").change();
    });
	$("#frwd").click(function(e) {
		var $dtpkr = $("#datepicker")
		var date = $dtpkr.datepicker("getDate");
		date.setDate(date.getDate() + 1);
        $dtpkr.datepicker("setDate", date); 
		$("#datepicker").change();
    });
});
function editorclose(elem){
	$(elem).parents(".reccommentedt").hide(0);
}
function editcomment(elem){
	$editor = $(elem).parents(".recentry").find(".reccommentedt");
	$editor.show(0);
	$editor.find("input.comment").focus();
}
function recChanged(){
	$("#signal").css("background-image","url('/notifier/images/yellowsignal.png')");
	var done = {};
	var comm = {};
	$(".idholder").each(function(index, element) {
		comm[$(element).val()] = $(element).siblings(".reccommentedt").children(".comment").val();
    });
	$(".recar .isdone:checked").each(function(index, element) {
		done[$(element).val()] = 1;
    });
	$(".recar .isdone:not(:checked)").each(function(index, element) {
        done[$(element).val()] = 0;
    });
	$("#loader").load("datareceiver.php", {
		"date": getRecDate(),
		"done" : done,
		"comm" : comm
	}, function(txt, stat){
		if(stat == 'success')
		$("#signal").css("background-image","url('/notifier/images/greensignal.png')");
		else $("#signal").css("background-image","url('/notifier/images/redsignal.png')");
	});
}
function getRecDate() {
	var date = $("#datepicker").datepicker("getDate");
	var datestr = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
	return datestr;
}
</script>
</head>
<body>
<?php $tab="Panel"; include("templateinpre.php"); ?>
  <div id="inrem">
  	<div id="data">
    	<div id="datainner">
    	<div id="salutation">
        	Notifiers
        </div>
    	<div id="selector">
            <div id="signal"></div>
        	<div id="back" class="mover">Prev Day</div>
          	<div id="datepickercontainer">
            	<input id="datepicker" type="text" value="<?php echo $today->format("d M, Y"); ?>" />
            </div>
            <div id="frwd" class="mover">Next Day</div>
        </div>
        <div id="loader">
        	<div id="waiter">Wait while your data is loading ... </div>
        </div>
        <div class="inremftr">
        	<span id="reset" class="inrembtn">Reset</span>
        	<span id="refresh" class="inrembtn">Refresh</span>
        </div>
    </div>
  </div></div>
  <div id="today">Today : <?php echo $today->format('d M, Y D'); ?></div>
<?php include("templateinpost.php"); ?>
</body>
</html>