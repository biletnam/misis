<?
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/mysql.php');
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/users.php');	
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/class.firm.php');	
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/class.template.php');	
	include($_SERVER['DOCUMENT_ROOT'].'/inc/top.php');
	$user->diePermission('admin_panel');
	$tempman = new TemplateManager();
	$firmman = new FirmManager();
	
	if (isset($_POST['add']))
	{
		
		$file = $_FILES['file'];
		if ($file)
		{
			$path = $_SERVER['DOCUMENT_ROOT'].'/templates/';
			$filename = md5(microtime(true)).'.rtf';
			copy($_FILES["file"]["tmp_name"], $path.$filename);
			chmod ($path.$filename, 0777);
			$data = $_POST['data'];
			
			$data['file'] = $filename;
			
			if ($data['name'])
			{
				$tempman->addTemplate($data);
			}
		}
	}

	if (isset($_POST['delete_x']))
	{
		$template = $tempman->getTemplate($_POST['id']);
		$template->delete();
	}
	
	if (isset($_POST['save_x']))
	{
		$template = $tempman->getTemplate($_POST['id']);
		$template->updateData($_POST['data']);
	}
?>
<script>
	$('document').ready(function(){
		$('input').addClass('ui-widget ui-widget-content ui-corner-all required');		
		$("input:submit").button();
		
		$('.delete_button').click(function(){
			return confirm("Bы действительно хотите удалить шаблон?");
		});
	});
</script>

<h1 class="header">Добавить шаблон</h1>
<div style="width: 600px;" class="ui-widget ui-widget-content">
<form method="post" enctype="multipart/form-data">
	<table width="100%" cellpadding="5">
		<tr>
			<td>Имя: </td>
			<td><input style="width: 100%;" type="text" name="data[name]"></td>
		</tr>
		
		<tr>
			<td>Организация: </td>
			<td>
				<select name="data[firm_id]" style="width: 100%;">
					<?
						$firm_man = new FirmManager();
						$firms = $firm_man->getFirms();
						foreach ($firms as $firm)
						{
							$id = $firm->getData('id');
							$name = $firm->getData('name');
							?>
							<option value="<?=$id?>"><?=$name?></option>
							<?
						}
					?>
				</select>
			</td>
		</tr>
		
		<tr>
			<td>Файл: </td>
			<td><input style="width: 100%;" type="file" name="file"></td>
		</tr>
		
		<tr>
			<td>&nbsp;</td>
			<td><input style="width: 100%;" type="submit" name="add" value="Добавить"></td>
		</tr>
	</table>
</form>
</div>

<br><br>

<h1 class="header">Список шаблонов</h1>
<table class="ui-widget ui-widget-content" width="100%" cellpadding="5">
	<tr>
		<td>id</td>
		<td>Организация</td>
		<td>Имя</td>
		<td>Файл</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<?
		$templates = $tempman->getTemplates();
		foreach ($templates as $temp)
		{
			$data = $temp->getData();
			?>
			<form method="post">
			<input type="hidden" name="id" value="<?=$data['id']?>">
			<tr>
				<td><?=$data['id']?></td>
				<td><?=$firmman->getFirm($data['firm_id'])->getData('name')?></td>
				<td><input style="width: 100%;" type="text" name="data[name]" value="<?=$data['name']?>"></td>
				<td><a href="/templates/<?=$data['file']?>">Скачать</a>&nbsp;&nbsp;&nbsp;Заменить</td>
				<td><input name="save" type="image" src="/pic/apply.png"></td>
				<td><input class="delete_button" name="delete" type="image" src="/pic/delete.png"></td>
			</tr>
			</form>
			<?
		}
	?>
</table>

</body>
</html>