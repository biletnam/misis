<?
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/mysql.php');
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/users.php');	
	include($_SERVER['DOCUMENT_ROOT'].'/inc/top.php');
	$user->diePermission('admin_panel');
	
	
?>
<script>
	$('document').ready(function(){
		$('input:text').addClass('ui-widget ui-widget-content ui-corner-all required');		
		$("input:submit").button();
	});
</script>
<?
	if (isset($_POST['add']))
	{
		$login = $_POST['login'];
		$pass = $_POST['pass'];
		$pass = md5($login.$pass);
		
		$sql = sql("SELECT * FROM users WHERE name = '$login'");
		$num = mysql_num_rows($sql);
		
		if ($num>0)
		{
			echo 'Такой логин уже существует!';
		}
		else
		{
			sql("INSERT INTO users(name, password) VALUES ('$login', '$pass')");
			echo 'Пользователь успешно добавлен!';
		}
	}
?>

<h1 class="header" style="font-size: 26px;">Управление пользователями</h1>	
<span class="header">Список пользователей:</span>
<ol class="ui-widget ui-widget-content">	
	<?
		$res = sql("SELECT * FROM users");
		while ($row = mysql_fetch_assoc($res)):
		$id = $row['id'];
		$login = $row['name'];
		$fio = $row['FIO_F'].' '.$row['FIO_I'].' '.$row['FIO_O'];
		$u = new User($id);
		$group = $u->getGroupInfo('name');
		$text = $login.' - '.$fio." ({$group})";
	?>
	
	
		<li><a href="/admin/user_edit.php?id=<?=$id?>"><?=$text?></a></li>
	
	
	<?endwhile;?>	
</ol>
<br>
<span class="header">Добавить нового пользователя:</span>
<form method="post">
<table class="ui-widget ui-widget-content" cellpadding="5">
<tr>
	<td>Логин: </td> 
	<td><input type="text" name="login"></td>
</tr>
<tr>
	<td>Пароль: </td>
	<td><input type="text" name="pass"></td>
</tr>
<tr>	
	<td align="center" colspan="2"><input style="width: 100%;" type="submit" name="add" value="Добавить"></td>
</tr>
</table>	
</form>
