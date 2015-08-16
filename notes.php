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
pagetrav={
    nextdate:null,
    prevdate:null
};
function tinymceintegrate(){
    tinymce.init({
        selector: "div#note",
		inline: true,
    	plugins: [
	        "advlist autolink lists link image hr charmap print preview anchor",
        	"searchreplace visualblocks code fullscreen textcolor",
    	    "insertdatetime table contextmenu paste emoticons"
	    ],
    	toolbar: "undo redo | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent |" 
			+ "link forecolor backcolor hr emoticons | print preview"
    });
}

function showLoaderOp($loaderop, $loaderval, $showcheck = false, $toshow){
    if($loaderval.length > 0){
        $loaderop.html($loaderval.text());
        if($showcheck) {
            $toshow = $toshow || $loaderop;
            $toshow.show(0);
        }
    }
}

function addCondClass(condition, $elem, className){
    className = className || "disable";
    if(condition){
        $elem.addClass(className);
    } else {
        $elem.removeClass(className);
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
function receivenote(todo, date, noteid, content) {
    todo = todo || "none";
    date = date || getRecDate();
    noteid = noteid || -1;
    content = content || "Content not found";
    var data = {
        "todo": todo,
        "date": date,
	"noteid": noteid,
        "content": content
    };
    $("#signal").css("background-image","url('/notifier/images/yellowsignal.png')");
    $.ajax("http://localhost/notifier/notesreceiver.php", {
        type: 'POST',
        data: data,
        dataType: "xml"
    }).done(function(data, textStatus, jqXHR){
        if($(data).length > 0){
            var mindate = new Date('<?php echo $crton->format('Y M d'); ?>');
            var $xml = $(data).first();
            var $dateshower = $xml.find("dateshower");
            var gotdate = new Date($dateshower.text());
            var $notepane = $xml.find("notepane");
            var $createnote = $xml.find("createnote");
            var $notefailure = $xml.find("notefailure");
            pagetrav.prevdate = $($xml.find("prevpagedate")).text();
            pagetrav.nextdate = $($xml.find("nextpagedate")).text();
            addCondClass(!pagetrav.prevdate, $("#prvpage"));
            addCondClass(!pagetrav.nextdate, $("#nxtpage"));
            addCondClass(gotdate <= mindate, $("#back"));
            $("div.loaderop").hide(0);
            showLoaderOp($("#dateshower"), $dateshower, true);
            showLoaderOp($("#writenotetxt"), $createnote, true, $("#writenote"));
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
        ?>
        dateFormat: "d M, yy"
    });
    $("#datepicker").change(function(e) {
        receivenote(getRecDate());
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
    $("#prvpage").click(function(e) {
        if(pagetrav.prevdate){
            var $dtpkr = $("#datepicker")
            var date = new Date(pagetrav.prevdate.toString());
            $dtpkr.datepicker("setDate", date); 
            $("#datepicker").change();
        }
    });
    $("#nxtpage").click(function(e) {
        if(pagetrav.nextdate){
            var $dtpkr = $("#datepicker")
            var date = new Date(pagetrav.nextdate.toString());
            $dtpkr.datepicker("setDate", date); 
            $("#datepicker").change();
        }
    });
    $("#gotoday").click(function(e) {
        var date = new Date();
        var $dtpkr = $("#datepicker")
        $dtpkr.datepicker("setDate", date); 
        $("#datepicker").change();
    });
    tinymceintegrate();
    receivenote();
});
function getRecDate() {
    var date = $("#datepicker").datepicker("getDate");
    var datestr = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
    return datestr;
}
function addnote() {
    receivenote("addnote", getRecDate());
}
function getnote(noteid, date) {
    if(date){
        var $dtpkr = $("#datepicker")
        $dtpkr.datepicker("setDate", date); 
        $("#datepicker").change();
    } else date = getRecDate();
    receivenote("getnote", date, noteid);
}
function savenote(noteid) {
    receivenote("savenote", getRecDate(), noteid, $("#note").html());
}
function delnote(noteid) {
    if(confirm("Are you sure you want to delete this page?")) {
        receivenote("delnote", getRecDate(), noteid);
    }
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
            <div id="prvpage" class="mover">Prev Page</div>
            <div id="back" class="mover">Prev Day</div>
            <div id="gotoday" class="mover">Today</div>
            <div id="frwd" class="mover">Next Day</div>
            <div id="nxtpage" class="mover">Next Page</div>
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
            <div class="loaderop" id="writenote" onclick="addnote();">
            	<div id="writenoteimg"></div>
                <div id="writenotetxt">Write a note?</div>
            </div>
            <div class="loaderop" class="failure" id="notefailure"></div>
        </div>
          	<div id="datepickercontainer">
            	<input id="datepicker" type="text" value="<?php echo $today->format("d M, Y"); ?>" />
            </div>
    </div>
  </div></div>
  <div id="today">Today : <?php echo $today->format('d M, Y D'); ?></div>
<?php include("templateinpost.php"); ?>
</body>
</html>