<?
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/mysql.php');
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/class.history.php');
	
	$histman = new History();
	$record = $histman->getRecord($_GET['id']);
	$record->delete();
?>