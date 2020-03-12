<?PHP
include("db.php");
include("class-phpass.php");

$conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
if ($conn->connect_error)
    die("Connection failed: " . $conn->connect_error);

function get_data( $url ) {
	$ch = curl_init();
    $timeout = 5;
    curl_setopt($ch,CURLOPT_URL,$url);
    curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
    curl_setopt($ch,CURLOPT_CONNECTTIMEOUT,$timeout);
    $data = curl_exec($ch);
    curl_close($ch);
    return $data;
}

function specialCash($num){
	$newNum = substr($num,0,-3);
	$newNum = $newNum.'.';
	$newNum = $newNum.substr($num, -3);
	$newNum = substr($newNum,0,-1);
	return $newNum;
}

//fake wordpress functions I made up
function username_exists($user){
	global $conn;
	
	$sql = "SELECT id,username FROM acc WHERE username = '$user'";

	if (!$result = $conn->query($sql)){
    	die('There was an error running the query [' . $conn->error . ']');
	} else 
		$res = $result->num_rows;
	
	if ($res > 0)
		return true;
	else
		return false;
}

function email_exists ($email){
	global $conn;
	
	$sql = "SELECT id,email FROM acc WHERE email = '$email'";

	if (!$result = $conn->query($sql)){
    	die('There was an error running the query [' . $conn->error . ']');
	} else 
		$res = $result->num_rows;
	
	if ($res > 0)
		return true;
	else
		return false;
}

function wp_hash_password($password) {
    $wp_hasher = new PasswordHash(8, false);
    return $wp_hasher->HashPassword( trim( $password ) );
}

?>
