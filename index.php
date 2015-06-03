<?php
require_once("res/utils.php");
session_start();
$res = Client::installResult();
if(!isset($_SESSION["client"])){
	$_SESSION["client"] = Client::getInstance();
	session_write_close();
}
if(isset($_POST["logorsign"]) && isset($_POST["usernametxt"]) && isset($_POST["userpasstxt"])) {
	$client = $_SESSION["client"];
	if($_POST["logorsign"] == 'log') {
		$res = $client->authenticate($_POST["usernametxt"], $_POST["userpasstxt"]);
		if($res["code"] == Client::CODE_SUCCESS) {
        	header("Location: panel.php");
		}
	} elseif (isset($_POST["usercnfmtxt"]) && $_POST["logorsign"] = 'sign') {
		$res = $client->signup($_POST["usernametxt"], $_POST["userpasstxt"], $_POST["usercnfmtxt"]);
	}
} elseif (isset($_REQUEST["signout"]) && $_REQUEST["signout"] == "true" && session_status() != PHP_SESSION_NONE) {
    $_SESSION = array();
    session_destroy();
	session_write_close();
	header("Location: index.php");
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="scripts/jquery.js"></script>
<link type="image/icon-x" href="favicon.png" rel="shortcut icon"  />
<link href="styles/default.css" rel="stylesheet" type="text/css" />
<link href="styles/index.css" rel="stylesheet" type="text/css" />
<title>Notifier</title>
<script type="text/javascript">
$(document).ready(function(e) {
    $(".frmtoggle").click(function(e) {
        $(".form").slideToggle(500);
    });
});
</script>
</head>
<body>
<div id="header">
  <div id="icon"></div>
  <div id="logo"></div>
</div>
<div id="centerblock">
  <div id="intop"></div>
  <div id="inrem">
    <div id="formq">
      <div id="formlog" class="form" style="display:<?php 
	  	if($res["process"] == Client::PROCESS_SIGNUP && $res["code"] != Client::CODE_SUCCESS) echo "none" ;
		else echo "block";
	  ?>;">
        <div class="frmlabel"> Login </div>
        <div class="frmlabelspace"></div>
        <form method="post" action="index.php">
          <input type="hidden" name="logorsign" value="log" />
          <label for="usernametxt">Name</label>
          <input type="text" name="usernametxt" placeholder="Name" required="required" />
          <label for="userpasstxt">Password</label>
          <input type="password" name="userpasstxt" placeholder="Password" required="required" />
          <input type="submit" class="sbmt" value="Login"  />
        </form>
        <div class="frmtoggle">Signup</div>
      </div>
      <div id="formsign" class="form" style="display:<?php 
	  	if($res["process"] == Client::PROCESS_SIGNUP && $res["code"] != Client::CODE_SUCCESS) echo "block" ;
		else echo "none";
	  ?>;">
        <div class="frmlabel"> Signup </div>
        <div class="frmlabelspace"></div>
        <form method="post" action="index.php">
          <input type="hidden" name="logorsign" value="sign" />
          <label for="usernametxt">Name</label>
          <input type="text" name="usernametxt" placeholder="Name" required="required" />
          <label for="userpasstxt">Password</label>
          <input type="password" name="userpasstxt" placeholder="Password" required="required" />
          <label for="usercnfmtxt">Confirm</label>
          <input type="password" name="usercnfmtxt" placeholder="Password" required="required" />
          <input type="submit" class="sbmt" value="Signup"  />
        </form>
        <div class="frmtoggle">Login</div>
      </div>
      <div class="message"> <span class="success">
        <?php if($res["code"] == Client::CODE_SUCCESS) echo $res["message"]; ?>
        </span> <span class="failure">
        <?php if($res["code"] != Client::CODE_SUCCESS) echo $res["message"]; ?>
        </span> </div>
    </div>
  </div>
</div>
<div id="footer">Footer</div>
<?php
if(!(defined("CRYPT_BLOWFISH") && CRYPT_BLOWFISH)) {
?>
<script type="text/javascript">
alert("Crypt blowfish is not enabled !\nContact administrator.");
</script>
<?php
}
?>
</body>
</html>