<?
	include($_SERVER['DOCUMENT_ROOT'].'/inc/sql_config.php');
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/users.php');		
	@header("Content-Type: text/html; charset=windows-1251");
	@header("Pragma: no-cache");
	
	$limit = 10;
	$sql = mysql_query("SELECT * FROM history ORDER BY id DESC LIMIT $limit", $mysql_cont);
		
	
	while($row = mysql_fetch_assoc($sql))
	{
		$user = new User($row['user_id']);		
		$user = $user->getInfo('name');
		$date = $row['time'];
		$doc_name = $row['file'];
		
		$template_name = $row['time'];
		
		$servUrl='http://'.$_SERVER['SERVER_NAME'].'/';
		$url = $row['file'];
		$url_delete = 'http://'.$_SERVER['SERVER_NAME'].'/delete_doc.php?id='.$row['id'];
		
		?>
			<div class="doc_item ui-widget ui-widget-content">
				<table>
				<td>					
					<img border="0" src="<?=$servUrl?>pic/rtf.png">					
				</td>
				<td><div class="description">
					 <br>
					<?=$user?><br><?=$date?><br>
					
					<a class="download" href="<?=$url?>">Скачать</a> <small><span class="delete" name="<?=$url_delete?>">Удалить</span></small>
					
				</div></td>
				</table>
			</div>
		<?
	}
?>