<?php
require_once("res/utils.php");
session_start();
$res = Client::installResult();
if(!isset($_SESSION["client"])){
	header("Location: unauthenticated.php");
}
$client = $_SESSION["client"];
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
</head>
<body>
<div id="header">
  <div id="icon"></div>
  <div id="logo"></div>
</div>
<div id="centerblock">
  <div id="intop">
    <div id="intopl" class="intoplst">
      <ul>
        <li><span>Welcome <?php echo $client->username; ?></span></li>
      </ul>
    </div>
    <div id="intopr" class="intoplst">
      <ul>
        <li><a href="index.php?signout=true">Logout</a></li>
        <li><a href="setnotify.php">Set notifiers</a></li>
        <li><a href="panel.php">Panel</a></li>
      </ul>
    </div>
  </div>
  <div id="inrem">

  </div>
</div>
<div id="footer"> </div>
Footer
</body>
</html>