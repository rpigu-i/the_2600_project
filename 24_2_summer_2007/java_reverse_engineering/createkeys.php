if (isset($_GET) && count($_GET) > 0)
{
if (!isset($_GET["user"]) || !$_GET["user"])
$name = "0wn3d";
else
{
$name = $_GET["user"];
//fi rst 2 must not be lk
if (strcasecmp(substr($name,0,2),"lk") == 0)
{
$name = substr($name,2);
echo "The first 2 chars must not be lk<Br>";
}
}
if (strlen($name) <= 0)
$name = "0wn3d";
if (!isset($_GET["howmany"]))
$_GET["howmany"] = 0;
$howmany = intval($_GET["howmany"]);
if ($howmany <= 0)
$howmany = 2600;
if ($howmany > 2147483647)
{
$howmany = 2600;
echo "Limit of licenses is: 2147483647<br>";
}
if (!isset($_GET["seed"]))
$seed = "36";
else
{
if (intval($_GET["seed"]) >= 35 && intval($_GET["seed"]) <= 99)
$seed = $_GET["seed"];
else
$seed = "36";
}
$str = "Zend";
$hardcode = "0304";
$str .= $name;
$pad = '';
for ($i = ( 5 - strlen($name)); $i > 0; $i--)
$pad .= "0";
$pad .= "00";
$str .= $hardcode . $seed . $pad . "000" . $howmany;
printf ("LICENSE_KEY: %08X%s%s%s000%s<br>USER_NAME: %s", crc32($str),$hardcode,$seed,$pad,$howmany,$name);
echo "<br><br>Now find ZendIDE.confi g and replace the LICENSE_KEY and USER_NAME<br><br>";
}
echo "<form method='get'>
Enter the username: <br>
<input type='textbox' name='user' maxlength='50'><br>
Number of licenses: <br>
<input type='textbox' name='howmany'><br>
Enter a random number between 35 and 99: <br>
<input type='textbox' name='seed' maxlength='2'><br>
<input type='submit' name='Submit'>
</form>";
