<?php
$url = "http://www.your-domain.com/ip.php";
// this is the page on the web that returns your IP
$fn = "C:\ip.txt";
// this is the file that you'll write your IP to
$cmd = "ftp -s:E:\ipup.txt";
// this is the command-line call to the FTP program

echo "Getting IP from $url... // comment this out, if running invisibly
"; // comment this out, if running invisibly

// open the web page and nab the IP
$fp = fopen($url,"r") or die;
$data = fread($fp, 4096);
fclose($fp);

// write the IP to the file for upload
// open for overwriting
$fnew = fopen($fn,"w+") or die;

echo "Writing $data to local file... // comment this out, if running
invisibly
"; // comment this out, if running invisibly

if (is_writable($fn))
	{
	if (!$handle = fopen($fn, 'wb'))
		{
        exit;
		}
    if (fwrite($handle, $data) === FALSE)
		{
        exit;
		}
    fclose($handle);
	}

shell_exec($cmd);
// this executes the FTP command that uploads the file you just wrote

echo "FTP-ing $data to your-domain... // comment this out, if running
invisibly
"; // comment this out, if running invisibly
?>
