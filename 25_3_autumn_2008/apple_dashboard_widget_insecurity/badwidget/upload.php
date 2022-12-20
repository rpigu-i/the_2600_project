<?php
	/**
	 * This is upload.php
	 * This file dumps the uploaded file into the file/ directory and renames it
	 * 
	 * @author Zeitgeist <zeitgeist@geisterstunde.org>
	 */
	
	$uploaddir = 'files/';
	$uploadfile = $uploaddir . "screen-" . md5(time()) . ".jpg";

	move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile);

?>
