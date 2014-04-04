<?php

	// Replace this with your own email address
	$to="sales@shortcutmedia.com";

	// Extract form contents
	$upload_url = $_POST['upload_url'];
	$link_title = $_POST['link_title'];
	$url = $_POST['url'];
	$fullname = $_POST['fullname'];
	$company = $_POST['company'];
	$email = $_POST['email'];
	$homepage = $_POST['homepage'];
		
	// Validate email address
	function valid_email($str) {
		return ( ! preg_match("/^([a-z0-9\+_\-]+)(\.[a-z0-9\+_\-]+)*@([a-z0-9\-]+\.)+[a-z]{2,6}$/ix", $str)) ? FALSE : TRUE;
	}
	
	// Return errors if present
	$errors = "";
	
	if($upload_url =='') { $errors .= "upload_url,"; }
	if($link_title =='') { $errors .= "link_title,"; }
	if(valid_email($email)==FALSE) { $errors .= "email,"; }

	// Send email
	if($errors =='') {

		$headers =  'From: Shortcut Media <info@shortcutmedia.com>'. "\r\n" .
					'X-Mailer: PHP/' . phpversion();
		$email_subject = "Website Upload Form: $upload_url";
    $message="Uploaded asset: $upload_url \n\nLink title: $link_title \n\nLink URL: $url\n\nFullname: $fullname\n\nCompany: $company\n\nEmail: $email \n\nHomepage: @homepage\n\n";
	
		mail($to, $email_subject, $message, $headers);
		echo "true";
	
	} else {
		echo $errors;
	}
	
?>
