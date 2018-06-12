<?php
date_default_timezone_set("Europe/Stockholm");
include_once("../kjellsyspw.php");
$pdo = null;

//---------------------------------------------------------------------------------------------------------------
// err - Displays nicely formatted error and exits
//---------------------------------------------------------------------------------------------------------------

function err ($errmsg,$hdr='')
{
	if(!empty($hdr)){
			echo($hdr);
	}
	print "<p><span class=\"err\">Serious Error: <br /><i>$errmsg</i>.";
	print "</span></p>\n";
	exit;
}

function dbConnect()
{
	$printHeaderFunction=0;
	// Send header info to err()?
	if ($printHeaderFunction) {
		$hdr = 'Database Connection Error';
	} else {
		$hdr = '';
	}

	// Connect to DB server
	$OC_db = mysql_connect(DB_HOST,DB_USER,DB_PASSWORD) or err("Could not connect to database ".mysql_errno(),$hdr);
	mysql_set_charset('utf8',$OC_db);
	// Select DB
	mysql_select_db(DB_NAME) or err("Could not select database \"".DB_NAME."\" error code".mysql_errno(),$hdr);
}

function pdoConnect()
{
	global $pdo;
	try {
		$pdo = new PDO(
			'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8',
			DB_USER,
			DB_PASSWORD
		);
	} catch (PDOException $e) {
		echo "Failed to get DB handle: " . $e->getMessage() . "</br>";
		exit;
	}
}

function getOP($name)
{
		if(isset($_POST[$name]))	return urldecode($_POST[$name]);
		else return "UNK";
}

pdoConnect();
session_start();

$cid = getOP('cid');
$opt = getOP('opt');
$coursevers = getOP('coursevers');
$fid = getOP('fid');
$filename = getOP('filename');
$kind = getOP('kind');
$debug = "NONE!";

$log_uuid = getOP('log_uuid');
$info = $opt . " " . $cid . " " . $coursevers . " " . $fid . " " . $filename . " " . $kind;

//------------------------------------------------------------------------------------------------
// Services
//------------------------------------------------------------------------------------------------

if (strcmp($opt, "DELFILE") === 0) {
    // Remove file link from database
    $querystring = 'DELETE FROM fileLink WHERE fileid=:fid';
    $query = $pdo->prepare($querystring);
    $query->bindParam(':fid', $fid);
    if (!$query->execute()) {
        $error = $query->errorInfo();
        $debug = "Error updating file list " . $error[2];
    }
}

//------------------------------------------------------------------------------------------------
// Retrieve Information			
//------------------------------------------------------------------------------------------------

$entries = array();

$query = $pdo->prepare("SELECT * FROM sw ;");
/*$query->bindParam(':cid', $cid);
$query->bindParam(':vers', $coursevers);
*/
if (!$query->execute()) {
    $error = $query->errorInfo();
    $debug = "Error reading files " . $error[2];
}

foreach ($query->fetchAll(PDO::FETCH_ASSOC) as $row) {
  
  $swid = $row['id'];
  $swname = $row['name'];

  $entry = array(
      'swname' => $swname
  );

  array_push($entries, $entry);

}

$array = array(
    'entries' => $entries,
    'debug' => $debug
);

echo json_encode($array);

?>
