<?php 
header('Content-Type: text/xml');
require_once("res/utils.php");
?>
<?xml version="1.0" encoding="utf-8"?>
<root>
<?php
Client::log("notereceiver.php > received", FALSE);
session_start();
$client = $_SESSION["client"];
$now = new DateTime();
if(Client::e($_POST["date"])) {
	$date = new DateTime($_POST["date"]);
} else {
	$date = new DateTime();
}
try {
$page = 0;
$date = $client->loadNotes($date);
if(Client::e($_POST["todo"]) && is_string($_POST["todo"])) {
    switch($_POST["todo"]) {
        case "addnote":
            $client->addNote($date);
            $page = count($client->notes) - 1;
            break;
    }
}
?>
<dateshower><![CDATA[ <?php echo $_POST["date"]." : ".$date->format('d M Y'); ?> ]]></dateshower>
<?php
$notelen = count($client->notes);
if($notelen != 0) {
	$page = min($page, $notelen - 1);
	$content = $client->getNote($client->notes[$page]["id"]);
?>
<notepane>
    <notehead><![CDATA[
        <div id="dateno"><?php echo $date->format('d'); ?></div>
        <div id="datemonth"><?php echo $date->format('F'); ?></div>
        <div id="datemonth"><?php echo $date->format('l'); ?></div>
        <div id="pagenumber">Page <?php echo ($page + 1); ?></div>
    ]]></notehead>
    <note><![CDATA[ <?php echo $content; ?> ]]></note>
    <controls><![CDATA[
        <?php if($page > 0) { ?><div id="notectrlprev" class="notectrl" onclick="getnote(<?php echo ($page - 1); ?>);">Prev</div><?php } ?>
        <?php if($page >= 0 && $page < $notelen) { ?><div id="notectrlsave" class="notectrl" onclick="savenote(<?php echo $page; ?>);">Save</div><?php } ?>
        <?php if($page >= 0 && $page < $notelen) { ?><div id="notectrlrefresh" class="notectrl" onclick="getnote(<?php echo $page; ?>);">Refresh</div><?php } ?>
        <?php if($page < $notelen - 1) { ?><div id="notectrlnext" class="notectrl" onclick="getnote(<?php echo ($page + 1); ?>);">Next</div><?php } ?>
        <?php if($page == ($notelen - 1)) { ?><div id="notectrladd" class="notectrl" onclick="addnote();">Add</div><?php } ?>
        <?php if($page >= 0 && $page < $notelen) { ?><div id="notectrldel" class="notectrl" onclick="delnote(<?php echo ($page); ?>);">Delete</div><?php } ?>
    ]]></controls>
</notepane>
	<?php
} else {
	?>
<createnote><![CDATA[ Create new note ]]></createnote>
 	<?php
    }
}catch(PDOException $e){
	print_r($e);
?>
<notefailure><![CDATA[ Sorry for the inconvenience. <br />Some error occured ... ]]></notefailure>
<?php 
}
?>
</root>