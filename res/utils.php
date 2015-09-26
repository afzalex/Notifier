<?php

/**
 * Salts created with base64_encode(mcrypt_create_iv(24))
 */
define('PASSWORD_SALT', "cNzENAueT12tKvPWh+3Dfy2wQ9jchPNz");
define('LOGGEDIN_SALT', "fgOyyHmxkJDeX2O4jwuLbcgLT0/mq+tu");
date_default_timezone_set('Asia/Kolkata');

/* It will help to use single Connection. */

class Connector {

    const dsn = "mysql:dbname=notifier";
    const username = "root";

    private static $pdo;

    public static function getConn() {
        $passwd = mcrypt_decrypt(MCRYPT_RIJNDAEL_128, PASSWORD_SALT, base64_decode(file_get_contents("res/databasepassword.dat")), MCRYPT_MODE_ECB);
        if (!isset(Connector::$pdo)) {
            Connector::$pdo = new PDO(Connector::dsn, Connector::username, $passwd);
            Connector::$pdo->setAttribute(PDO::ATTR_PERSISTENT, true);
            Connector::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        }
        return Connector::$pdo;
    }

}

/**
 * This class represent all the operations done for the user.
 */
class Client {

    const CODE_ERROR = 1;
    const CODE_SUCCESS = 2;
    const CODE_AVAILABLE = 3;
    const CODE_UNAVAILABLE = 4;
    const CODE_FAIL = 5;
    const CODE_BLANK = 6;
    const CODE_NONE = 7;
    const PROCESS_SIGNUP = 11;
    const PROCESS_LOGIN = 12;
    const PROCESS_NONE = 13;

    public $username;
    public $userid;
    public $createdon;

    private function __construct() {
        
    }

    public static function getInstance() {
        return new Client();
    }

    /**
     * Result will be sent in the form of array.
     * @param type $code The code representing the status of result.
     * @param type $message The textual message of result
     * @param type $process The process in which the result is obtained.
     * @return type
     */
    public static function installResult($code = Client::CODE_NONE, $message = "", $process = Client::PROCESS_NONE) {
        return Array(
            "code" => $code,
            "message" => $message,
            "process" => $process
        );
    }

    public function verifyKeepLogged(&$logged_in_flag) {
        if (Client::e($logged_in_flag) && $logged_in_flag == 'on')
            try {
                if (Client::e($_COOKIE['logged_in_id']) && Client::e($_COOKIE['logged_in_user_name']) &&
                        Client::e($_COOKIE['logged_in_hash']) && Client::e($_COOKIE['logged_in_user_id'])) {
                    $unique_id = $_COOKIE['logged_in_id'];
                    $user_id = $_COOKIE['logged_in_user_id'];
                    $user_name = $_COOKIE['logged_in_user_name'];
                    $user_hash = $_COOKIE['logged_in_hash'];
                    $hash = crypt(LOGGEDIN_SALT . $unique_id . $user_name
                            . $_SERVER['REMOTE_ADDR'], LOGGEDIN_SALT);
                    if ($user_hash === $hash) {
                        $res = Connector::getConn()->query("SELECT * FROM users WHERE username = '$user_name' and"
                                        . " id = " . $user_id)->fetchAll();
                        if (count($res) && $hash === $res[0]["loggedin_hash"] &&
                                (time() - strtotime($res[0]["loggedin_last"])) < (60 * 60 * 24 * 15)) {
                            $this->username = strval($res[0]["username"]);
                            $this->userid = intval($res[0]["id"]);
                            $this->createdon = new DateTime($res[0]["createdon"]);
                            $code = Client::CODE_SUCCESS;
                            $msg = "Logged in";
                            return true;
                        }
                    }
                }
            } catch (Exception $ex) {
                Client::log("utils.php > Client > verifyKeepLogged(...) > ERROR : " . $ex);
            }
        return false;
    }

    public static function removeLoggedinSettings() {
        setcookie('logged_in_flag', null, -1);
        setcookie('logged_in_id', null, -1);
        setcookie('logged_in_user_id', null, -1);
        setcookie('logged_in_user_name', null, -1);
        setcookie('logged_in_hash', null, -1);
    }

    /**
     * This function add cookies that will be used for "keep me logged in" feature.
     * Every time when a user logged in successfully with "keep me logged in" on, these cookies will be reset.
     */
    public function resetLoggedinSettings() {
        $time = date('Y-m-d H:i:s');
        $this->removeLoggedinSettings();
        try {
            $unique_id = uniqid();
            $expires = time() + 60 * 60 * 24 * 15;  // expires after 15 days
            $hash = crypt(LOGGEDIN_SALT . $unique_id . $this->username
                    . $_SERVER['REMOTE_ADDR'], LOGGEDIN_SALT);
            $query = "UPDATE users SET loggedin_last = '" . $time
                    . "', loggedin_hash = '" . $hash . "' WHERE id = " . $this->userid
                    . " AND username = '" . $this->username . "'";
            if (Connector::getConn()->exec($query)) {
                setcookie('logged_in_flag', 'on', $expires);
                setcookie('logged_in_id', $unique_id, $expires);
                setcookie('logged_in_user_id', $this->userid, $expires);
                setcookie('logged_in_user_name', $this->username, $expires);
                setcookie('logged_in_hash', $hash, $expires);
            }
        } catch (Exception $ex) {
            Client::log("utils.php > Client > resetLoggedinSettings() > ERROR : " . $ex);
        }
    }

    /**
     * This function will authenticate user, and return result
     * in the form of array obtained through <i>installResult(...)</i>.
     * It will also check the availability of the user in database.
     * @param type $name The name of the user.
     * @param type $pass The password of the user.
     * @return type resulting array.
     */
    public function authenticate($name, $pass, &$keeplogged = NULL) {
        $code = Client::CODE_ERROR;
        $msg = "";
        try {
            if ($this->isAvailable($name)) {
                $res = Connector::getConn()->query("SELECT * FROM users WHERE username = '$name' and"
                                . " userpass = '" . crypt($pass, PASSWORD_SALT) . "'")->fetchAll();
                if (count($res) == 1) {
                    $this->username = strval($res[0]["username"]);
                    $this->userid = intval($res[0]["id"]);
                    $this->createdon = new DateTime($res[0]["createdon"]);
                    if (Client::e($keeplogged) && $keeplogged == 'on') {
                        $this->resetLoggedinSettings();
                    }
                    $code = Client::CODE_SUCCESS;
                    $msg = "Logged in";
                } else {
                    $code = Client::CODE_FAIL;
                    $msg = "Username and passwords are not matching";
                }
            } else {
                $code = Client::CODE_UNAVAILABLE;
                $msg = "User is not registered";
            }
        } catch (Exception $ex) {
            $code = Client::CODE_ERROR;
            $msg = "An error occured while logging in";
        }
        return Client::installResult($code, $msg, Client::PROCESS_LOGIN);
    }

    /**
     * It will let client to signup on this database. 
     * i.e. put entries for new user in database.
     * @param type $name Name of the user.
     * @param type $pass Password of the user.
     * @param type $cnfm Confirmation of the password.
     * @return type
     */
    public function signup($name, $pass, $cnfm) {
        $code = Client::CODE_ERROR;
        $msg = "";
        try {
            if ($cnfm != $pass) {
                $code = Client::CODE_FAIL;
                $msg = "Passwords are not matching";
            } elseif ($this->isAvailable($name)) {
                $code = Client::CODE_AVAILABLE;
                $msg = "User already registered";
            } else {
                Connector::getConn()->exec("INSERT INTO users (username, userpass) VALUES ('$name', '"
                        . crypt($pass, PASSWORD_SALT) . "')");
                $code = Client::CODE_SUCCESS;
                $msg = "User account is successfully created";
            }
        } catch (Exception $ex) {
            $code = Client::CODE_ERROR;
            $msg = "An error occured while signing up";
        }
        return Client::installResult($code, $msg, Client::PROCESS_SIGNUP);
    }

    public function isAvailable($name) {
        $res = Connector::getConn()->query("SELECT * FROM users WHERE username = '$name'")->fetchAll();
        return count($res) == 1;
    }

    /*     * *********************************************************************************************************
     * ***********************************************************************************************************
     * ********************************************************************************************************* */

    const PROCESS_ADD_CATEGORY = 101;
    const PROCESS_ADD_DAILY = 102;
    const PROCESS_ADD_WEAKLY = 103;
    const PROCESS_ADD_YEARLY = 104;
    const PROCESS_DEL_CATEGORY = 121;
    const PROCESS_DEL_DAILY = 122;
    const PROCESS_DEL_WEAKLY = 123;
    const PROCESS_DEL_YEARLY = 124;
    const PROCESS_EDIT_CATEGORY = 131;
    const PROCESS_EDIT_DAILY = 132;
    const PROCESS_EDIT_WEAKLY = 133;
    const PROCESS_EDIT_YEARLY = 134;

    public $category = Array();
    public $dailynots = Array();
    public $weeklynots = Array();
    public $yearlynots = Array();
    public $notesnots = Array();

    private static function loadIntoArray(&$dest, $source) {
        settype($dest, 'array');
        $dest = $source;
    }

    public function loadNotifiers() {
        $id = $this->userid;
        try {
            $conn = Connector::getConn();
            Client::loadIntoArray($this->category, $conn->query("SELECT * FROM category WHERE user_id = $id")->fetchAll());
            Client::loadIntoArray($this->dailynots, $conn->query("SELECT t.*, c.name as category_name FROM task_daily t "
                            . "INNER JOIN category c ON t.category_id = c.id WHERE t.user_id = $id ORDER BY category_name, id")->fetchAll());
            Client::loadIntoArray($this->weeklynots, $conn->query("SELECT w.*, c.name as category_name FROM task_weekly w "
                            . "INNER JOIN category c ON w.category_id = c.id WHERE w.user_id = $id ORDER BY category_name, id")->fetchAll());
            Client::loadIntoArray($this->yearlynots, $conn->query("SELECT y.*, c.name as category_name FROM task_yearly y "
                            . "INNER JOIN category c ON y.category_id = c.id WHERE y.user_id = $id ORDER BY category_name, id")->fetchAll());
        } catch (Exception $e) {
            Client::log("Client > loadNotifiers() > Error : " . $e);
        }
    }

    public static function e(&$val) {
        return isset($val) && (gettype($val) == 'array' && count($val) > 0) || (strlen(strval($val)) > 0);
    }

    public function addCategory(&$name, &$summ) {
        $code = Client::CODE_FAIL;
        $msg = "";
        $prs = Client::PROCESS_ADD_CATEGORY;
        try {
            if (Client::e($name) && Client::e($summ)) {
                Connector::getConn()->exec("INSERT INTO category (user_id, name, summary) "
                        . "VALUES ($this->userid, '$name', '$summ')");
                $code = Client::CODE_SUCCESS;
                $msg = "A new category is created";
            } else {
                $code = Client::CODE_BLANK;
                $msg = "!! Please enter all required entries to create new category !!";
            }
        } catch (Exception $ex) {
            $code = Client::CODE_ERROR;
            $msg = "!! Some error occured while adding category !!";
        }
        return Client::installResult($code, $msg, $prs);
    }

    public function editCategory(&$id, &$summ) {
        $code = Client::CODE_FAIL;
        $msg = "";
        $prs = Client::PROCESS_EDIT_CATEGORY;
        try {
            if (Client::e($id) && Client::e($summ)) {
                Connector::getConn()->exec("UPDATE category SET summary = '$summ'"
                        . "WHERE user_id = $this->userid and id = $id");
                $code = Client::CODE_SUCCESS;
                $msg = "Category updated";
            } else {
                $code = Client::CODE_BLANK;
                $msg = "!! Please enter all required entries to update category !!";
            }
        } catch (Exception $ex) {
            $code = Client::CODE_ERROR;
            $msg = "!! Some error occured while updating category !!";
        }
        return Client::installResult($code, $msg, $prs);
    }

    public function delCategory(&$todel) {
        $code = Client::CODE_FAIL;
        $msg = "";
        $prs = Client::PROCESS_DEL_CATEGORY;
        try {
            if (Client::e($todel)) {
                foreach ($todel as $id) {
                    Connector::getConn()->exec("DELETE FROM category WHERE user_id = "
                            . "$this->userid and id = $id");
                }
                $code = Client::CODE_SUCCESS;
                $msg = "Selected categories are deleted.";
            } else {
                $code = Client::CODE_BLANK;
                $msg = "!! Please select required categories to delete !!";
            }
        } catch (Exception $ex) {
            $code = Client::CODE_ERROR;
            $msg = "!! Some error occured while deleting categories !!";
        }
        return Client::installResult($code, $msg, $prs);
    }

    private function processNoteSummary(&$summ) {
        if (!Client::e($summ))
            $summ = "";
        /*
        else {
            $summ = preg_replace_callback('/(?<=\s|^)http(s?):\/\/.*(?=\s|$)/iU', function($matches) {
                print_r($matches);
                return "<a href='$matches[0]'>$matches[0]</a>";
            }, $summ);
        }
         */
    }

    private function filterEntry(&$entry) {
        if (Client::e($entry)) {
            $entry = str_replace("'", "''", $entry);
        }
    }

    public function addDaily(&$name, &$summ, &$catid) {
        $code = Client::CODE_FAIL;
        $msg = "";
        $prs = Client::PROCESS_ADD_DAILY;
        try {
            if (Client::e($name) && Client::e($catid)) {
                $this->processNoteSummary($summ);
                $this->filterEntry($summ);
                Connector::getConn()->exec("INSERT INTO task_daily (user_id, "
                        . "category_id, name, summary) VALUES ($this->userid, $catid, "
                        . "'$name', '$summ')");
                $code = Client::CODE_SUCCESS;
                $msg = "New Daily Notifier is added.";
            } else {
                $code = Client::CODE_BLANK;
                $msg = "!! Please enter all required entries to create new Daily Notifier !!";
            }
        } catch (Exception $ex) {
            $code = Client::CODE_ERROR;
            $msg = "!! Some error occured while adding new Daily Notifier !!";
        }
        return Client::installResult($code, $msg, $prs);
    }

    public function editDaily(&$id, &$summ, &$catid) {
        $code = Client::CODE_FAIL;
        $msg = "";
        $prs = Client::PROCESS_EDIT_DAILY;
        try {
            if (Client::e($id) && Client::e($catid)) {
                $this->processNoteSummary($summ);
                $this->filterEntry($summ);
                Client::log("UPDATE task_daily SET category_id = $catid, summary = '$summ' "
                        . "WHERE user_id = $this->userid and id = $id");
                Connector::getConn()->exec("UPDATE task_daily SET category_id = $catid, summary = '$summ' "
                        . "WHERE user_id = $this->userid and id = $id");
                $code = Client::CODE_SUCCESS;
                $msg = "Selected Daily Notifier is updated.";
            } else {
                $code = Client::CODE_BLANK;
                $msg = "!! Please enter all required entries to update Daily Notifier !!";
            }
        } catch (Exception $ex) {
            $code = Client::CODE_ERROR;
            $msg = "!! Some error occured updating Daily Notifier !!";
        }
        return Client::installResult($code, $msg, $prs);
    }

    public function delDaily(&$todel) {
        $code = Client::CODE_FAIL;
        $msg = "";
        $prs = Client::PROCESS_DEL_DAILY;
        try {
            if (Client::e($todel)) {
                foreach ($todel as $id) {
                    Connector::getConn()->exec("DELETE FROM task_daily WHERE user_id = $this->userid and id = $id");
                }
                $code = Client::CODE_SUCCESS;
                $msg = "Selected Daily Notifiers are deleted";
            } else {
                $code = Client::CODE_BLANK;
                $msg = "!! Please select required Daily Notifiers to delete !!";
            }
        } catch (Exception $ex) {
            $code = Client::CODE_ERROR;
            $msg = "!! Some error occured while removing selected Daily Notifiers !!";
        }
        return Client::installResult($code, $msg, $prs);
    }

    public function addWeekly(&$name, &$day, &$summ, &$catid) {
        $code = Client::CODE_FAIL;
        $msg = "";
        $prs = Client::PROCESS_ADD_WEAKLY;
        try {
            if (Client::e($name) && Client::e($day) && Client::e($catid)) {
                $this->processNoteSummary($summ);
                Connector::getConn()->exec("INSERT INTO task_weekly (user_id, category_id, name, day, summary) VALUES "
                        . "($this->userid, $catid, '$name', '$day', '$summ')");
                $code = Client::CODE_SUCCESS;
                $msg = "New Weekly Notifier is added.";
            } else {
                $code = Client::CODE_BLANK;
                $msg = "!! Please enter all required entries to add new Weekly Notifier !!";
            }
        } catch (Exception $ex) {
            $code = Client::CODE_ERROR;
            $msg = "!! Some error occured while adding new Weekly Notifier !!";
        }
        return Client::installResult($code, $msg, $prs);
    }

    public function editWeekly(&$id, &$day, &$summ, &$catid) {
        $code = Client::CODE_FAIL;
        $msg = "";
        $prs = Client::PROCESS_EDIT_WEAKLY;
        try {
            if (Client::e($id) && Client::e($day) && Client::e($catid)) {
                $this->processNoteSummary($summ);
                Connector::getConn()->exec("UPDATE task_weekly SET day = '$day', summary = '$summ', category_id = $catid "
                        . "WHERE user_id = $this->userid AND id = $id");
                $code = Client::CODE_SUCCESS;
                $msg = "Weekly Notifier is updated.";
            } else {
                $code = Client::CODE_BLANK;
                $msg = "!! Please enter all required entries to update Weekly Notifier !!";
            }
        } catch (Exception $ex) {
            $code = Client::CODE_ERROR;
            $msg = "!! Some error occured while updating Weekly Notifier !!";
        }
        return Client::installResult($code, $msg, $prs);
    }

    public function delWeekly(&$todel) {
        $code = Client::CODE_FAIL;
        $msg = "";
        $prs = Client::PROCESS_DEL_WEAKLY;
        try {
            if (Client::e($todel)) {
                foreach ($todel as $id) {
                    Connector::getConn()->exec("DELETE FROM task_weekly WHERE user_id = $this->userid and id = $id");
                }
                $code = Client::CODE_SUCCESS;
                $msg = "Selected Weekly Notifiers are deleted";
            } else {
                $code = Client::CODE_BLANK;
                $msg = "!! Please select required Weekly Notifiers to delete !!";
            }
        } catch (Exception $ex) {
            $code = Client::CODE_ERROR;
            $msg = "!! Some error occured while deleting selected Weekly Notifiers !!";
        }
        return Client::installResult($code, $msg, $prs);
    }

    /*     * *********************************************************************************************************
     * ***********************************************************************************************************
     * ********************************************************************************************************* */

    public $daily;
    public $weekly;
    public $yearly;

    public static function dateToStr($date) {
        return $date->format("Y-m-d h:i:s a");
    }

    public function loadRecords($dateToQuery) {
        $max = new DateTime('now');
        $max->setTime(23, 59, 59);
        $min = new DateTime($this->createdon->format('Y-m-d'));
        $min->setTime(0, 0, 0);
        if ($dateToQuery >= $min && $dateToQuery <= $max) {
            $date = new DateTime($dateToQuery->format('Y-m-d'));
            $date->setTime(0, 0, 0);
        } else {
            $date = new DateTime();
            $date->setTime(0, 0, 0);
        }
        $dateStr = $date->format('Y-m-d');
        $conn = Connector::getConn();
        $recorderQuery = "SELECT * FROM recorder WHERE user_id = $this->userid AND date LIKE '$dateStr%'";
        $recorder = $conn->query($recorderQuery)->fetchAll();
        if (count($recorder) == 0) {
            $conn->exec("INSERT INTO recorder (date, user_id) VALUES ('$dateStr 0:0:0', $this->userid)");
            $recorder = $conn->query($recorderQuery)->fetchAll();
        }
        if ($recorder[0]["added"] == 0) {
            foreach ($this->dailynots as $dailynot) {
                $tdate = new DateTime($dailynot["createdon"]);
                $tdate->setTime(0, 0, 0);
                if ($tdate <= $date)
                    $conn->exec("INSERT INTO record (task_name, task_type, recorder_id, user_id) VALUES "
                            . "('{$dailynot['name']}', 'daily', {$recorder[0]['id']}, $this->userid)");
            }
            foreach ($this->weeklynots as $weeklynot) {
                $wdate = new DateTime($weeklynot["createdon"]);
                $wdate->setTime(0, 0, 0);
                if ($wdate <= $date && $weeklynot['day'] == strtolower($date->format('D'))) {
                    $conn->exec("INSERT INTO record (task_name, task_type, recorder_id, user_id) VALUES "
                            . "('{$weeklynot['name']}', 'weekly', {$recorder[0]['id']}, $this->userid)");
                }
            }
            $conn->exec("UPDATE recorder SET added = 1 WHERE date LIKE '$dateStr%'");
        }
        $this->daily = $conn->query("SELECT r.*, ifnull(summary, 'Notifier is removed') summary FROM "
                        . "record r LEFT JOIN task_daily t ON r.user_id = t.user_id AND r.task_name = t.name WHERE "
                        . "r.user_id = $this->userid AND recorder_id = {$recorder[0]['id']} AND task_type = 'daily'")
                ->fetchAll();
        $this->weekly = $conn->query("SELECT r.*, ifnull(summary, 'Notifier is removed') summary FROM "
                        . "record r LEFT JOIN task_weekly t ON r.user_id = t.user_id AND r.task_name = t.name WHERE "
                        . "r.user_id = $this->userid AND recorder_id = {$recorder[0]['id']} AND task_type = 'weekly'")
                ->fetchAll();
        return $date;
    }

    public function updateRecord(&$recdone) {
        if (Client::e($recdone) && gettype($recdone) == 'array') {
            $conn = Connector::getConn();
            foreach ($recdone as $k => $v) {
                $conn->exec("UPDATE record SET checked = $v "
                        . "WHERE id = $k AND user_id = $this->userid");
            }
        }
    }

    public function resetRecords(&$reset, &$dateToQuery) {
        if (Client::e($reset) && $reset == 'reset') {
            $max = new DateTime('now');
            $max->setTime(23, 59, 59);
            $min = new DateTime($this->createdon->format('Y-m-d'));
            $min->setTime(0, 0, 0);
            if ($dateToQuery >= $min && $dateToQuery <= $max) {
                $date = new DateTime($dateToQuery->format('Y-m-d'));
                $date->setTime(0, 0, 0);
                $dateStr = $date->format('Y-m-d');
                $conn = Connector::getConn();
                Connector::getConn()->exec("DELETE FROM recorder WHERE user_id = $this->userid AND date LIKE '$dateStr%'");
            }
        }
    }

    public function updateComment(&$comments) {
        if (Client::e($comments) && gettype($comments) == 'array') {
            $conn = Connector::getConn();
            foreach ($comments as $k => $v) {
                $conn->exec("UPDATE record SET comment = '$v' "
                        . "WHERE id = $k AND user_id = $this->userid");
            }
        }
    }

    /*     * **********************************************************************************************************
     * ***********************************************************************************************************
     * ********************************************************************************************************* */

    public $notes;
    public $prevPageDate;
    public $nextPageDate;

    private function reloadNotes($dateStr) {
        $noteQuery = "SELECT id, date, user_id FROM notes WHERE user_id = $this->userid AND date LIKE '$dateStr%' ORDER BY id";
        $prevPageQuery = "SELECT date FROM notes WHERE user_id = $this->userid AND date<'$dateStr' ORDER BY id DESC LIMIT 1";
        $nextPageQuery = "SELECT date FROM notes WHERE user_id = $this->userid AND date>'$dateStr' ORDER BY id ASC LIMIT 1";
        $conn = Connector::getConn();
        $this->notes = $conn->query($noteQuery)->fetchAll();
        $this->prevPageDate = $conn->query($prevPageQuery)->fetchAll();
        $this->nextPageDate = $conn->query($nextPageQuery)->fetchAll();
    }

    public function loadNotes($dateToQuery) {
        $min = new DateTime($this->createdon->format('Y-m-d'));
        $min->setTime(0, 0, 0);
        if ($dateToQuery >= $min) {
            $date = new DateTime($dateToQuery->format('Y-m-d'));
            $date->setTime(0, 0, 0);
        } else {
            $date = new DateTime();
            $date->setTime(0, 0, 0);
        }
        $dateStr = $date->format('Y-m-d');
        $conn = Connector::getConn();
        $this->reloadNotes($dateStr);
        return $date;
    }

    public function addNote($date) {
        $dateStr = $date->format('Y-m-d');
        $conn = Connector::getConn();
        $prep = $conn->prepare("SELECT content FROM notes WHERE id = (SELECT default_note FROM users WHERE user_id = $this->userid)");
        $prep->execute();
        $prep->bindColumn(1, $content, PDO::PARAM_LOB);
        $prep->fetch(PDO::FETCH_BOUND);
        $prep = $conn->prepare("INSERT INTO notes (user_id, date, content) VALUES ($this->userid, '$dateStr 0:0:0', :cont)");
        $prep->bindParam(':cont', $content, PDO::PARAM_LOB);
        $prep->execute();
        $this->reloadNotes($dateStr);
    }

    public function updateNote($noteid, $content) {
        $conn = Connector::getConn();
        $prep = $conn->prepare("UPDATE notes SET content = :cont WHERE user_id = $this->userid AND id = $noteid");
        $prep->bindParam(':cont', $content, PDO::PARAM_LOB);
        $prep->execute();
    }

    public function setDefault($noteid) {
        $conn = Connector::getConn();
        $conn->exec("UPDATE users SET default_note = $noteid WHERE id = $this->userid");
    }

    public function getNote($noteid) {
        $prep = Connector::getConn()->prepare("SELECT content FROM notes WHERE user_id = $this->userid AND id = $noteid");
        $prep->execute();
        $prep->bindColumn(1, $content, PDO::PARAM_LOB);
        $prep->fetch(PDO::FETCH_BOUND);
        return $content;
    }

    public function deleteNote($date, $noteid) {
        $dateStr = $date->format('Y-m-d');
        Connector::getConn()->exec("DELETE FROM notes WHERE user_id = $this->userid and id = $noteid");
        $this->reloadNotes($dateStr);
    }

    /*     * *********************************************************************************************************
     * ***********************************************************************************************************
     * ********************************************************************************************************* */

    public static function log($txt, $app = true) {
        $filename = 'res/logfile.dat';
        $file = fopen($filename, ($app == true) ? "a" : "w");
        fwrite($file, $txt . "\n");
        fclose($file);
    }

}

?>
