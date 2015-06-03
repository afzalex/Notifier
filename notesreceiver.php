<?php
require_once("res/utils.php");
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
<div id="dateshower"><?php echo $date->format('d M Y'); ?></div>
<?php
$notelen = count($client->notes);
if($notelen != 0) {
	$page = min($page, $notelen - 1);
	$content = $client->getNote($client->notes[$page]["id"]);
	?>
<notehead>
   	<div id="dateno"><?php echo $date->format('d'); ?></div>
    <div id="datemonth"><?php echo $date->format('F'); ?></div>
    <div id="datemonth"><?php echo $date->format('l'); ?></div>
	<div id="pagenumber">Page <?php echo ($page + 1); ?></div>
<notehead>
<note><?php echo $content; ?></note>
<controls>
	<?php if($page > 0) { ?><div id="notectrlprev" class="notectrl" onclick="getnote(<?php echo ($page - 1); ?>);">Prev</div><?php } ?>
    <?php if($page >= 0 && $page < $notelen) { ?><div id="notectrlsave" class="notectrl" onclick="savenote(<?php echo $page; ?>);">Save</div><?php } ?>
    <?php if($page >= 0 && $page < $notelen) { ?><div id="notectrlrefresh" class="notectrl" onclick="getnote(<?php echo $page; ?>);">Refresh</div><?php } ?>
    <?php if($page < $notelen - 1) { ?><div id="notectrlnext" class="notectrl" onclick="getnote(<?php echo ($page + 1); ?>);">Next</div><?php } ?>
    <?php if($page == ($notelen - 1)) { ?><div id="notectrladd" class="notectrl" onclick="addnote();">Add</div><?php } ?>
    <?php if($page >= 0 && $page < $notelen) { ?><div id="notectrldel" class="notectrl" onclick="delnote(<?php echo ($page); ?>);">Delete</div><?php } ?>
<controls>
	<?php
} else {
	?>

 	<?php
}
?>

<?php
}catch(PDOException $e){
	print_r($e);
?>
<div id="waiter" class="failure">Sorry for the inconvenience. <br />Some error occured ... </div>
<?php 
}
?>
 
 
 
 