<?
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/mysql.php');
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/users.php');	
	include($_SERVER['DOCUMENT_ROOT'].'/inc/top.php');
	$user->diePermission('admin_panel');	
	
	$id = $_GET['id'];
	$user = new User($id);
?>
<?
	if (isset($_POST['change_permission']))
	{
		$group_id = $_POST['group_id'];
		$user->changeGroup($group_id);
		echo 'Права доступа успешно изменены';
	}
	
	if (isset($_POST['save']))
	{
		$data = $_POST['data'];
		$user->save($data);
		echo 'Сохранено!';
	}
	
	if (isset($_POST['change_password']))
	{
		$data = $_POST['data'];
		$login = $user->getInfo('name');		
		$data['password'] = md5($login.$data['password']);		
		$user->save($data);
		echo 'Сохранено!';
	}
?>
<?
	$group_id = $user->getGroupInfo('id');	
	
	$login = $user->getInfo('name');
	$FIO_F = $user->getInfo('FIO_F');
	$FIO_I = $user->getInfo('FIO_I');
	$FIO_O = $user->getInfo('FIO_O');	
?>
<script>
	$('document').ready(function(){
		$('input:text').addClass('ui-widget ui-widget-content ui-corner-all required');		
		$("input:submit").button();
		$('#date').datepicker({
			changeMonth: true,
			changeYear: true
		});
		
		$('#date').datepicker( "option", "yearRange", '1900:2000' );
		$('#date').datepicker('option', {dateFormat: 'yy-mm-dd'});
		var date = new Date('<?=$user->getInfo('birthday');?>');
		$('#date').datepicker( "setDate" , date );
	});
</script>

<h1 class="header" style="font-size: 26px;">Редактирование пользователя <?=$login?></h1>	

<form method="post">
<table class="ui-widget ui-widget-content" cellpadding="5">

<tr>
	<td class="header">Фамилия: </td>
	<td><input type="text" name="data[FIO_F]" value=<?=$FIO_F?>></td>
</tr>

<tr>
	<td class="header">Имя: </td>
	<td><input type="text" name="data[FIO_I]" value=<?=$FIO_I?>></td>
</tr>

<tr>
	<td class="header">Отчество: </td>
	<td><input type="text" name="data[FIO_O]" value=<?=$FIO_O?>></td>
</tr>

<tr>
	<td class="header">e-mail: </td>
	<td><input type="text" name="data[email]" value="<?=$user->getInfo('email');?>"></td>
</tr>

<tr>
	<td class="header">Контактный телефон: </td>
	<td><input type="text" name="data[tel]" value="<?=$user->getInfo('tel');?>"></td>
</tr>

<tr>
	<td class="header">Должность: </td>
	<td><input type="text" name="data[post]" value="<?=$user->getInfo('post');?>"></td>
</tr>

<tr>
	<td class="header">Дата рождения: </td>
	<td><input type="text" name="data[birthday]" id="date" ></td>	
</tr>

<tr>
	<td class="header">Адрес прописки: </td>
	<td><input type="text" name="data[adress]" value="<?=$user->getInfo('adress');?>"></td>
</tr>

<tr>	
	<td align="center" colspan="2"><input style="width: 100%;" type="submit" name="save" value="Сохранить изменения"></td>
</tr>
</table>
</form>


<br>

<span class="header">Права доступа:</span>
<form method="post">
<table class="ui-widget ui-widget-content" cellpadding="5">

<tr>	
	<td>
		<select name="group_id">
		<?
			$res = sql("SELECT * FROM groups");
			while ($row = mysql_fetch_assoc($res)):
				$name = $row['name'];
				$id = $row['id'];				
				if ($id == $group_id) $add='selected';else $add='';
			?>
			<option <?=$add?> value="<?=$id?>"><?=$name?></option>
			<?
			endwhile;
		?>
		</select>
	</td>
</tr>

<tr>	
	<td align="center"><input style="width: 100%;" type="submit" name="change_permission" value="Изменить"></td>
</tr>
</table>
</form>

<br>
<span class="header">Изменить пароль:</span>
<form method="post">
<table class="ui-widget ui-widget-content" cellpadding="5">

<tr>	
	<td>
		<input type="text" name="data[password]">
	</td>
</tr>

<tr>	
	<td align="center"><input style="width: 100%;" type="submit" name="change_password" value="Изменить"></td>
</tr>
</table>
</form>