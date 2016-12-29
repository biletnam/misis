<?
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/users.php');	
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/navigation.php');	
	if (isset($_GET['action']))
	{
		if ($_GET['action'] == 'logout')
		{
			session_start();
			unset($_SESSION['password']);
			setCookie('password', '');	
			
			header('Refresh: 2; URL=http://'.$_SERVER['SERVER_NAME']);
			die('Выход из системы.');		
		}
	}
	$user = Auth::getUser();
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
<head>
 <title>МАШПРОМЭКСПЕРТ</title>
 <meta http-equiv="Content-Type" content="text/html; charset=windows-1251"> 
 <link rel="stylesheet" type="text/css" href="/css/style.css">
 <link rel="shortcut icon" href="/pic/favicon.ico" type="image/ico">
 <script type="text/javascript" src="/scripts/jquery-1.4.2.min.js"></script>
 <script type="text/javascript" src="/scripts/jquery-ui-1.8.2.custom.min.js"></script>
 <script type="text/javascript" src="/scripts/ui.datepicker-ru.js"></script>
 <script type="text/javascript" src="/scripts/jquery.validate.min.js"></script>
 <script type="text/javascript" src="/scripts/jquery.simpleCombo.js"></script> 
 <link rel="stylesheet" href="/scripts/css/jquery-ui-1.8.2.custom.css" type="text/css" /> 
</head>
<body>

<div id="user" class="ui-widget ui-widget-content">	
	<p class="text">
		<span class="header">Пользователь: </span><?=$user->getInfo('name');?> <a href="?action=logout">Выйти<a>
	</p>
	<?
		$nav = new Navigation($user);
		$nav->show();
	?>
</div>
<br>
<br>