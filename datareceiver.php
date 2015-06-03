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
$client->updateRecord($_POST['done']);
$client->updateComment($_POST['comm']);
$client->resetRecords($_POST['reset'], $date);
$date = $client->loadRecords($date);

function addRec($rec, $name) {
	echo '<div class="recentry">';
	echo "<input type='hidden' class='idholder' name='id' value='{$rec['id']}' />";
	echo "<div class='recchk recelem'> <label><input type='checkbox' name='$name' value='{$rec['id']}' "
		.($rec['checked'] == 0 ? "" : "checked='checked'")." onchange='recChanged();' class='isdone' />"
		."<span></span></label></div>";
	echo "<div class='recname recelem'>{$rec['task_name']}</div>"; 
	echo "<div class='recsummary recelem'>{$rec['summary']}</div>";
	echo "<div class='reccommentedt recelem'><div>Comment : </div> <input type='text' value='{$rec['comment']}' "
		."onchange='recChanged();' onblur='editorclose(this);' class='comment' placeholder='Comment !!' /></div>";
	echo "<div class='reccomment recelem'>{$rec['comment']}<span class='editbtn' onclick='editcomment(this);'></span></div>";
	echo '</div>';
}
?>
<div id="dateshower"><?php echo $date->format('d M Y'); ?></div>
<div id="dailyrec" class="recar">
	<div class="rechead">Daily notifiers</div>
	<?php if(count($client->daily) == 0) { ?>
    <div class="notiempty">
    	There are no notifiers today.<br  />
        Please <a href="setnotify.php">add</a> some notifiers.<br />
        <a href="setnotify.php"> Click here to add some notifiers. </a><br  />
    </div>
    <?php } else { ?>
    <div class="notirec">
    <?php foreach($client->daily as $d){addRec($d, 'dailyrecchk');} ?>
    </div>
    <?php } ?>
</div>
<div id="weeklyrec" class="recar">
	<div class="rechead">Weekly notifiers</div>
	<?php if(count($client->weekly) == 0) { ?>
    <div class="notiempty">
    	There are no weakly notifiers today.<br  />
    </div>
    <?php } else { ?>
    <div class="notirec">
    <?php foreach($client->weekly as $d){addRec($d, 'weeklyrecchk');} ?>
    </div>
    <?php } ?>
</div>

<?php
}catch(PDOException $e){
?>
	<div id="waiter" class="failure">Sorry for the inconvenience. <br />Some error occured ... </div>
<?php 
}
?>
 
 
 
 