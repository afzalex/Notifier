<?php
require_once("res/utils.php");
session_start();
$res = Client::installResult();
if (!isset($_SESSION["client"])) {
    header("Location: unauthenticated.php");
}
$client = $_SESSION["client"];
if(isset($_POST['ntype'])) {
	$option = $_POST['ntype'];
	if($option == 'addcategory') $res = $client->addCategory($_POST["name"], $_POST["summary"]);
	else if ($option == 'editcategory') $res = $client->editCategory($_POST["id"], $_POST["summary"]);
	else if ($option == 'delcategory') $res = $client->delCategory($_POST["todel"]);
	else if ($option == 'adddaily') $res = $client->addDaily($_POST["name"], $_POST["summary"], $_POST["category_id"]);
	else if ($option == 'editdaily') $res = $client->editDaily($_POST["id"], $_POST["summary"], $_POST["category_id"]);
	else if ($option == 'deldaily') $res = $client->delDaily($_POST["todel"]);
	else if ($option == 'addweekly') $res = $client->addWeekly($_POST["name"], $_POST["day"], $_POST["summary"], $_POST["category_id"]);
	else if ($option == 'editweekly') $res = $client->editWeekly($_POST["id"], $_POST["day"], $_POST["summary"], $_POST["category_id"]);
	else if ($option == 'delweekly') $res = $client->delWeekly($_POST["todel"]);
}
const NOTI_EMPTY = '<div class="nempty"><div>You have not added any notifiers here.</div> <div>Please add some.</div></div>';
function addRow($arr) {
	echo '<tr>';
	foreach($arr as $val) {
		echo "<td>$val</td>";
	}
	echo '</tr>';
}
function addOption($id, $val, $selectedId = -1) {
	$sel = $id === $selectedId ? 'selected="selected"' : "";
	echo "<option value='$id' $sel>$val</option>";
}
function addCheckbox($id, $val, $name) {
	echo "<input type='checkbox' name=".$name."[]' value='$id'>$val</input><br />";
}
$day = Array(
	'sun' => 'Sunday',
	'mon' => 'Monday',
	'tue' => 'Tuesday',
	'wed' => 'Wednesday',
	'thu' => 'Thursday',
	'fri' => 'Friday',
	'sat' => 'Saturday',
);
$client->loadNotifiers();
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <link type="image/icon-x" href="favicon.png" rel="shortcut icon"  />
        <link href="styles/default.css" rel="stylesheet" type="text/css" />
        <link href="styles/commpane.css" rel="stylesheet" type="text/css" />
        <link href="styles/setnotify.css" rel="stylesheet" type="text/css" />
        <title>Notifier</title>
        <script type="text/javascript">
			var ndat = [];
			<?php
			echo 'ndat["category"] = '.json_encode($client->category).";\n";
			echo 'ndat["dailynots"] = '.json_encode($client->dailynots)."\n";
			echo 'ndat["weeklynots"] = '.json_encode($client->weeklynots)."\n";
			echo 'ndat["yearlynots"] = '.json_encode($client->yearlynots)."\n";
			?>
			$(document).ready(function(e) {
                $(".selectall").change(function(e) {
					var chk = $(this).attr("checked");
                    $(this).siblings("input:checkbox").prop('checked', $(this).prop("checked"));
                });
				$(".notioption .button").click(function(e) {
					$elem = $(this).siblings(".body");
					$(".notioption .body").not($elem).slideUp(250);
                    $elem.slideToggle(250);
                });
            });
			function findWithId(matcher, type, todo) {
				var id = matcher;
				var arr = ndat[type];
				for(var i = 0; i < arr.length; i++) {
					var obj = arr[i];
					if(obj["id"] == id) {
						todo(obj);
						break;
					}
				}
			}
        </script>
    </head>
    <body>
		<?php $tab="Set Notifier"; include("templateinpre.php"); ?>
            <div id="inrem">
            	<?php 
				if($res["process"] != Client::PROCESS_NONE) { 
                	echo '<div id="message" class="'.(($res["code"] != Client::CODE_SUCCESS) ?
						"failure":"success").'" >'.$res["message"].'</div>';
				}
				if(count($client->category) != 0) { ?>
                <div id="dailynot" class="nblock">
                    <div class="nblockhead"> Daily notifiers </div>
                    <div class="nblockrem"><div class="notielems">
                    	<?php
                        if (count($client->dailynots) == 0) {
                        	echo NOTI_EMPTY;
                        } else {
                    	?>
                        <table class="noti" width="100%">
                        	<tr><th>Name</th><th>Category</th><th>Summary</th></tr>
                            <?php foreach($client->dailynots as $r){addRow(Array($r['name'], $r['category_name'], $r['summary']));} ?>
                        </table>
                    	<?php } ?>
                    	<div class="notioptions">
	                        <div class="notiadd notioption">
    	                    	<div class="button">Add</div>
                                <div class="body">
	        	                	<form method="post">
    	        	                	<input type="hidden" name="ntype" value="adddaily"  />
	    	        	                <label for="name">Name</label>
    	    	        	            <input type="text" name="name" placeholder="Newspaper etc" required="required" />
        	    	        	        <label for="summary">Summary</label>
            	    	        	    <textarea name="summary" placeholder="Read news paper on time etc."></textarea>
                                        <label for="category_id">Category</label>
                                        <select name="category_id">
                	                    <?php foreach($client->category as $r) addOption($r['id'], $r['name']); ?>
                    	                </select>
                        	        	<input type="submit" value="Add"  />
	                	    	    </form>
                                </div>
    	                    </div>
                            <?php if(count($client->dailynots) != 0) { ?>
                            <div class="notiedit notioption">
    	                    	<div class="button">Edit</div>
                                <div class="body">
	        	                	<form method="post">
    	        	                	<input type="hidden" name="ntype" value="editdaily"  />
	    	        	                <label for="id">Name</label>
            	                        <select name="id" class="editor">
                	                    	<?php foreach($client->dailynots as $r) addOption($r['id'], $r['name']); ?>
                    	                </select>
                                        <label for="summary">Summary</label>
                        	            <textarea name="summary"><?php echo $client->dailynots[0]["summary"] ?></textarea>
                                        <select name="category_id">
                	                    	<?php foreach($client->category as $r) addOption($r['id'], $r['name']); ?>
                    	                </select>
                            	        <input type="submit" value="Edit"  />
	                	        	</form>
                                    <script type="text/javascript">
										$("#dailynot select.editor").change(function(e) {
											var elem = $(this);
                                            findWithId($(elem).val(), "dailynots", function(obj){
												$(elem).siblings("textarea[name='summary']").val(obj["summary"]);
												$(elem).siblings("select[name='category_id']").val(obj["category_id"]);
											});
                                        });
                                    </script>
                                </div>
    	                    </div>
	                        <div class="notidel notioption">
    	                    	<div class="button">Delete</div>
                                <div class="body">
	        	                	<form method="post" onsubmit="return confirm('Are you sure you want to delete this notifier? \nDeleting it will also delete all the entries related to it.');">
    	        	                	<input type="hidden" name="ntype" value="deldaily"  />
                                        <?php foreach($client->dailynots as $r) addCheckbox($r['id'], $r['name'], "todel"); ?>
                                        <input type="checkbox" class="selectall">Select all</input>
                        	        	<input type="submit" value="Delete" />
	                	    	    </form>
                                </div>
    	                    </div>
                            <?php } ?>
                        </div>
                    </div></div>
                </div>
                <div id="weeklynot" class="nblock">
                    <div class="nblockhead"> Weekly notifiers </div>
                    <div class="nblockrem"><div class="notielems">
                    	<?php
                        if (count($client->weeklynots) == 0) {
                        	echo NOTI_EMPTY;
                        } else {
                    	?>
                        <table class="noti">
                        	<tr><th>Name</th><th>Day</th><th>Category</th><th>Summary</th></tr>
                            <?php foreach($client->weeklynots as $r){addRow(Array($r['name'], $day[$r['day']], $r['category_name'], $r['summary']));} ?>
                        </table>
                    	<?php } ?>
                    	<div class="notioptions">
	                        <div class="notiadd notioption">
    	                    	<div class="button">Add</div>
                                <div class="body">
	        	                	<form method="post">
    	        	                	<input type="hidden" name="ntype" value="addweekly"  />
	    	        	                <label for="name">Name</label>
    	    	        	            <input type="text" name="name" placeholder="TV Program etc" required="required" />
	    	        	                <label for="day">Day</label>
                                        <select name="day">
                                        <?php foreach($day as $k => $v) {addOption($k, $v);} ?>
                                        </select>
        	    	        	        <label for="summary">Summary</label>
            	    	        	    <textarea name="summary" placeholder="Watch TV serial etc."></textarea>
                                        <label for="category_id">Category</label>
                                        <select name="category_id">
                	                    <?php foreach($client->category as $r) addOption($r['id'], $r['name']); ?>
                    	                </select>
                        	        	<input type="submit" value="Add"  />
	                	    	    </form>
                                </div>
    	                    </div>
                            <?php if(count($client->weeklynots) != 0) { ?>
                            <div class="notiedit notioption">
    	                    	<div class="button">Edit</div>
                                <div class="body">
	        	                	<form method="post">
    	        	                	<input type="hidden" name="ntype" value="editweekly"  />
	    	        	                <label for="id">Name</label>
            	                        <select name="id" class="editor">
                	                    <?php foreach($client->weeklynots as $r) addOption($r['id'], $r['name']); ?>
                    	                </select>
                                        <label for="day">Day</label>
                                        <select name="day">
                                        <?php foreach($day as $k => $v) {addOption($k, $v, $client->weeklynots[0]["day"]);} ?>
                                        </select>
                                        <label for="summary">Summary</label>
                        	            <textarea name="summary"><?php echo $client->weeklynots[0]["summary"] ?></textarea>
                                        <select name="category_id">
                	                    <?php foreach($client->category as $r) addOption($r['id'], $r['name'], $client->weeklynots[0]["category_id"]); ?>
                    	                </select>
                            	        <input type="submit" value="Edit"  />
	                	        	</form>
                                    <script type="text/javascript">
										$("#weeklynot select.editor").change(function(e) {
											var elem = $(this);
                                            findWithId($(elem).val(), "weeklynots", function(obj){
												$(elem).siblings("textarea[name='summary']").val(obj["summary"]);
												$(elem).siblings("select[name='day']").val(obj["day"]);
												$(elem).siblings("select[name='category_id']").val(obj["category_id"]);
											});
                                        });
                                    </script>
                                </div>
    	                    </div>
							<div class="notidel notioption">
    	                    	<div class="button">Delete</div>
                                <div class="body">
	        	                	<form method="post" onsubmit="return confirm('Are you sure you want to delete this notifier? \nDeleting it will also delete all the entries related to it.');">
    	        	                	<input type="hidden" name="ntype" value="delweekly"  />
                                        <?php foreach($client->weeklynots as $r) addCheckbox($r['id'], $r['name'], "todel"); ?>
                                        <input type="checkbox" class="selectall">Select all</input>
                        	        	<input type="submit" value="Delete" />
	                	    	    </form>
                                </div>
    	                    </div>
                            <?php } ?>
                        </div>
                    </div></div>
                </div>
                <?php } ?>
                <div id="category" class="nblock">
                    <div class="nblockhead"> Categories </div>
                    <div class="nblockrem"><div class="notielems">
                    	<?php
                        if (count($client->category) == 0) {
                        	echo '<div class="nempty">Please add some categories of notifiers before starting up.</div>';
                        } else {
                    	?>
                        <table class="noti">
                        	<tr><th>Name</th><th>Summary</th></tr>
                            <?php foreach($client->category as $r){addRow(Array($r['name'], $r['summary']));} ?>
                        </table>
                    	<?php } ?>
                    	<div class="notioptions">
	                        <div class="notiadd notioption">
    	                    	<div class="button">Add</div>
                                <div class="body">
	        	                	<form method="post">
    	        	                	<input type="hidden" name="ntype" value="addcategory"  />
	    	        	                <label for="name">Name</label>
    	    	        	            <input type="text" name="name" placeholder="Important, Not necessary, College related etc." required="required" />
        	    	        	        <label for="summary">Summary</label>
            	    	        	    <textarea name="summary" placeholder="Must do, It is important etc." required="required"></textarea>
                        	        	<input type="submit" value="Add"  />
	                	    	    </form>
                                </div>
    	                    </div>
                            <?php if(count($client->category) != 0) { ?>
                            <div class="notiedit notioption">
    	                    	<div class="button">Edit</div>
                                <div class="body">
	        	                	<form method="post">
    	        	                	<input type="hidden" name="ntype" value="editcategory"  />
	    	        	                <label for="id">Name</label>
            	                        <select name="id" class="editor">
                	                    <?php foreach($client->category as $r) addOption($r['id'], $r['name'], $client->category[0]["id"]); ?>
                    	                </select>
                                        <label for="summary">Summary</label>
                        	            <textarea name="summary"><?php echo $client->category[0]["summary"] ?></textarea>
                            	        <input type="submit" value="Edit"  />
	                	        	</form>
                                    <script type="text/javascript">
										$("#category select.editor").change(function(e) {
											var elem = this;
											findWithId($(elem).val(), "category", function(obj) {
												$(elem).siblings("textarea").html(obj["summary"]);
											});
						                });
                                    </script>
                                    <div id="log"></div>
                                </div>
    	                    </div>
	                        <div class="notidel notioption">
    	                    	<div class="button">Delete</div>
                                <div class="body">
	        	                	<form method="post" onsubmit="return confirm('Are you sure? Deleting category will also delete all the entries related to it.');">
    	        	                	<input type="hidden" name="ntype" value="delcategory"  />
                                        <?php foreach($client->category as $r) addCheckbox($r['id'], $r['name'], "todel"); ?>
                                        <input type="checkbox" class="selectall">Select all</input>
                        	        	<input type="submit" value="Delete" />
	                	    	    </form>
                                </div>
    	                    </div>
                            <?php } ?>
                        </div>
                    </div></div>
                </div>
            </div>
    	<?php include("templateinpost.php"); ?>
    </body>
</html>
