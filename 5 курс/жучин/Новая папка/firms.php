<?
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/mysql.php');
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/users.php');	
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/class.firm.php');	
	include($_SERVER['DOCUMENT_ROOT'].'/inc/top.php');
	$user->diePermission('admin_panel');
	$man = new FirmManager();
	$firms = $man->getFirms();
	debug($firms);
?>
В разработке...
</body>
</html>