<?
  $mysql_host = "localhost";
  $mysql_dbname = "mpexp_mpexp";
  $mysql_login = "mpexp_mpexp";
  $mysql_psswd = "R38rh4Co";
  
  $mysql_cont = mysql_connect($mysql_host, $mysql_login, $mysql_psswd) or die(mysql_error());
  mysql_select_db($mysql_dbname) or die(mysql_error());
  mysql_query("SET NAMES 'cp1251'");
?>