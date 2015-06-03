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
<script type="text/javascript" src="scripts/tinymce/tinymce.min.js"></script>
<link href="scripts/jquery-ui.css" rel="stylesheet" type="text/css"  />
<link type="image/icon-x" href="favicon.png" rel="shortcut icon"  />
<link href="styles/default.css" rel="stylesheet" type="text/css" />
<link href="styles/commpane.css" rel="stylesheet" type="text/css" />
<link href="styles/notes.css" rel="stylesheet" type="text/css" />
<title>Notifier</title>
<script type="text/javascript">
function tinymceintegrate(){
	tinymce.init({
    selector: "div.noteeditor",
	inline: true,
    	plugins: [
	        "advlist autolink lists link image charmap print preview anchor",
        	"searchreplace visualblocks code fullscreen",
    	    "insertdatetime media table contextmenu paste"
	    ],
    	toolbar: "insertfile undo redo | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image"
	});
}

function showLoaderOp($loaderop, $loaderval, $showcheck = false){
    if($loaderval.length > 0){
        $loaderop.html($loaderval.text());
        if($showcheck) $loaderop.show(0);
    }
}

/**
 * @description To send request to get note.
 * @param {String} todo value describing task.<br />
 * valid values : "none", "addnote"
 * @param {Date} date Date object whose note is to be received.
 * @param {Integer} page page number of note
 * @param {String} content content of page
 */
function receivenote(todo, date, page, content) {
    todo = todo || "none";
    page = page || 0;
    date = date || getRecDate();
    content = content || "Content not found";
    var data = {
        "todo": todo,
        "date": date,
        "page": page
    };
    $("#signal").css("background-image","url('/notifier/images/yellowsignal.png')");
    $.ajax("http://localhost/notifier/notesreceiver.php", {
        "data": data,
        "dataType": "xml"
    }).done(function(data, textStatus, jqXHR){
        if($(data).length > 0){
            $xml = $(data).first();
            $dateshower = $xml.find("dateshower");
            $notepane = $xml.find("notepane");
            $createnote = $xml.find("createnote");
            $notefailure = $xml.find("notefailure");
            $("div.loaderop").hide(0);
            showLoaderOp($("#dateshower"), $dateshower, true);
            showLoaderOp($("#writenote"), $createnote, true);
            showLoaderOp($("#notefailure"), $notefailure, true);
            if($notepane.length > 0) {
                $("#notepane").show(0);
                $notehead = $notepane.find("notehead");
                $note = $notepane.find("note");
                $controls = $notepane.find("controls");
                showLoaderOp($("#notehead"), $notehead);
                showLoaderOp($("#note"), $note);
                showLoaderOp($("#controls"), $controls);
            }
        }
        $("#signal").css("background-image","url('/notifier/images/greensignal.png')");
    }).fail(function(data, textStatus, jqXHR){
        $("#signal").css("background-image","url('/notifier/images/redsignal.png')");
    })
}
$(document).ready(function(e) {
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
            receivenote("");
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
    receivenote();
});
function saveNote(){
    receivenote();
}
function getRecDate() {
    var date = $("#datepicker").datepicker("getDate");
    var datestr = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
    return datestr;
}
function addnote() {
    receivenote("addnote", getRecDate());
}
</script>
</head>
<body>
<?php $tab="Notes"; include("templateinpre.php"); ?>
  <div id="inrem">
  	<div id="data">
    	<div id="datainner">
    	<div id="salutation">
        	Notes
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
            <div class="loaderop" id="dateshower"></div>
            <div class="loaderop" id="waiter">
            	<div id="waiterimg"></div>
                <div id="waitertxt">Wait while your data is loading ... </div>
            </div>
            <div class="loaderop" id="notepane">
		<div id="notehead"></div>
		<div id="note"></div>
		<div id="controls"></div>
            </div>
            <div class="loaderop" id="writenote">
            	<div id="writenoteimg"></div>
                <div id="writenotetxt">Write a note?</div>
            </div>
            <div class="loaderop" class="failure" id="notefailure"></div>
        </div>
    </div>
  </div></div>
  <div id="today">Today : <?php echo $today->format('d M, Y D'); ?></div>
<?php include("templateinpost.php"); ?>
</body>
</html>