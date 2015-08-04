<?php 
header('Content-Type: text/xml');
require_once("res/utils.php");
?>
<?xml version="1.0" encoding="utf-8"?>
<root>
<?php
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
        case "getnote":
            if(Client::e($_POST["noteid"])) {
                $noteid = intval($_POST["noteid"]);
                $notelen = count($client->notes);
                $found = false;
                for($i = 0; $i < $notelen; $i++) {
                    $note = $client->notes[$i];
                    if($note["id"] == $noteid) {
                        $found = true;
                        $page = $i;
                        break;
                    }
                }
                if(!$found){
                    $page = 0;
                }
            } else {
                $page = 0;
            }
            break;
        case "savenote":
            if(Client::e($_POST["noteid"])) {
                $noteid = intval($_POST["noteid"]);
                $found = false;
                $notelen = count($client->notes);
                for($i = 0; $i < $notelen; $i++) {
                    $note = $client->notes[$i];
                    if($note["id"] == $noteid) {
                        $found = true;
                        $page = $i;
		        if(Client::e($_POST["content"])){
                            $client->updateNote($noteid, $_POST["content"]);
                        }
                        break;
                    }
                }
                if(!$found) {
                    $page = 0;
                }
            }
            break;
        case "delnote": 
            if(Client::e($_POST["noteid"])) {
                $noteid = intval($_POST["noteid"]);
                $found = false;
                $notelen = count($client->notes);
                for($i = 0; $i < $notelen; $i++) {
                    $note = $client->notes[$i];
                    if($note["id"] == $noteid) {
                        $found = true;
                        foreach($client->notes as $cn)
                        $client->deleteNote($date, $noteid);
                        foreach($client->notes as $cn)
                        $page = $i - 1;
                        break;
                    }
                }
                if(!$found) {
                    $page = 0;
                }
            }
            break;
    }
}
?>
<dateshower><![CDATA[ <?php echo $date->format('d M Y'); ?> ]]></dateshower>
<?php
$notelen = count($client->notes);
if($notelen != 0) {
    $page = max(0, min($page, $notelen - 1));
    $content = $client->getNote($client->notes[$page]["id"]);
?>
<notepane>
    <notehead><![CDATA[
        <div id="dateno"><?php echo $date->format('d'); ?></div>
        <div id="datemonth"><?php echo $date->format('F'); ?></div>
        <div id="dateday"><?php echo $date->format('l'); ?></div>
        <div id="pagenumber">Page <?php echo ($page + 1); ?></div>
    ]]></notehead>
    <note><![CDATA[ <?php echo $content; ?> ]]></note>
    <controls><![CDATA[
        <?php if($page < $notelen - 1) { ?><div id="notectrlnext" class="notectrl" onclick="getnote(<?php echo $client->notes[$page + 1]["id"]; ?>);">Next</div><?php } ?>
        <?php if($page >= 0 && $page < $notelen) { ?><div id="notectrlrefresh" class="notectrl" onclick="getnote(<?php echo $client->notes[$page]["id"]; ?>);">Refresh</div><?php } ?>
        <?php if($page > 0) { ?><div id="notectrlprev" class="notectrl" onclick="getnote(<?php echo $client->notes[$page - 1]["id"]; ?>);">Prev</div><?php } ?>
        <?php if($page >= 0 && $page < $notelen) { ?><div id="notectrldel" class="notectrl" onclick="delnote(<?php echo $client->notes[$page]["id"]; ?>);">Delete</div><?php } ?>
        <?php if($page >= 0 && $page < $notelen) { ?><div id="notectrlsave" class="notectrl" onclick="savenote(<?php echo $client->notes[$page]["id"]; ?>);">Save</div><?php } ?>
        <?php if($page == ($notelen - 1)) { ?><div id="notectrladd" class="notectrl" onclick="addnote();">Add</div><?php } ?>
    ]]></controls>
</notepane>
	<?php
} else {
	?>
<createnote><![CDATA[ Create new note ]]></createnote>
 	<?php
    }
}catch(PDOException $e){
	Client::log("notereceiver.php > ERROR : {$e}");
?>
<notefailure><![CDATA[ Sorry for the inconvenience. <br />Some error occured ... ]]></notefailure>
<?php 
}
?>
</root>