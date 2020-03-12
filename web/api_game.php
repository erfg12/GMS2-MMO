<?PHP
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include("functions.php");

if (isset($_POST['get_coords'])) {
    $sql = "SELECT last_x,last_y FROM acc WHERE id='$_POST[accid]' LIMIT 1";
    if ($result = $conn->query($sql)) {
        $res = $result->fetch_assoc();
        //if ($wp_hasher->CheckPassword($myPass, $res['password'])) {
        echo $res['last_x'] . "," . $res['last_y'];
        //} else {
        //    echo 'FAILED';
        //}
    } else {
        echo $conn->error;
    }
} else if (isset($_POST['login'])) {
        if (isset($_POST['newage_password']) && isset($_POST['newage_login'])) {
            $wp_hasher = new PasswordHash(8, FALSE);
            $sql = "SELECT id,password,username,isAdmin FROM acc WHERE username='$_POST[newage_login]' OR email='$_POST[newage_login]' LIMIT 1";
            //echo 'DEBUG: pass(hash)='.$hashedPassword.' pass='.$_POST['newage_password'].' user='.$_POST['newage_login'];
            $myPass = $_POST['newage_password'];
            //$result = $conn->query($sql);
            if ($result = $conn->query($sql)) {
                $res = $result->fetch_assoc();
                if ($wp_hasher->CheckPassword($myPass, $res['password'])) {
                    echo $res['id'];
                } else {
                    echo 'FAILED';
                }
            } else {
                echo $conn->error;
            }
        } else {
            echo 'ERROR: No username/password posted.';
        }
} else if (isset($_POST['save_coords'])) {
    $sql = "UPDATE acc SET last_x = '$_POST[last_x]', last_y = '$_POST[last_y]' WHERE id='$_POST[accid]' LIMIT 1";
    if ($result = $conn->query($sql)) {
        $res = $result->fetch_assoc();
        //if ($wp_hasher->CheckPassword($myPass, $res['password'])) {
        echo $res['last_x'] . "," . $res['last_y'];
        //} else {
        //    echo 'FAILED';
        //}
    } else {
        echo $conn->error;
    }
} else if (isset($_POST['create_character'])) {
        $sql = "INSERT INTO characters (accid, name, race, sex) VALUES ('$_POST[accid]', '$_POST[name]', '$_POST[race]', '$_POST[sex]')";
        if (!$conn->query($sql)) {
            echo 'FAILED';
            //echo $conn->error;
        } else {
            echo 'SUCCESS';
        }
} else if (isset($_POST['character_list'])) {
    $sql = "SELECT * FROM characters WHERE accid='$_POST[accid]'";
    if (!$conn->query($sql)) {
        echo 'FAILED';
        //echo $conn->error;
    } else {
        if ($result = $conn->query($sql)) {
            $chars = array();
            while ($row = $result->fetch_array()) {
                array_push($chars, $row['name']);
            }
            echo implode(',',$chars);
        }
    }
}