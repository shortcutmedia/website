<?php
/**
This script subscribes a user to the VIP mailing list on Mailchimp.
**/
require_once 'inc/MCAPI.class.php';
require_once 'inc/config.inc.php'; //contains apikey

// skip bot imputs
if (!empty($_POST["b_740414b556da9e032d9a2d94a_042d776c18"])) {
  die();
}

$api = new MCAPI($apikey);

$merge_vars = null;

$my_email = $_POST["EMAIL"];
$listId = '69fc4222a5';
$email_type = "html";
$double_optin = false;

$retlists = $api->lists();

$retval = $api->listSubscribe( $listId, $my_email, $merge_vars, $email_type, $double_optin);

if ($api->errorCode){
	echo "Unable to load listSubscribe()!\n";
	echo "\tCode=".$api->errorCode."\n";
	echo "\tMsg=".$api->errorMessage."\n";
} else {
  $redirect_url = $_POST["REDIRECT_URL"];
  if (empty($redirect_url )) {
    echo "Thanks for subscribing!\n";
  } else {
    header("Location: {$redirect_url}");
    die();
  }
}

?>
