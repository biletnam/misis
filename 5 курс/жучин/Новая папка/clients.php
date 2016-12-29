<?
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/mysql.php');
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/users.php');		
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/class.client.php');	
	include($_SERVER['DOCUMENT_ROOT'].'/inc/top.php');
	$man = new ClientManager();	
	
	if (isset($_POST['add']))
	{
		$data = $_POST['data'];
		if($data['id'] && $data['name'] && $data['translit'])
		{					
			$man->addClient($data);
		}
	}
	
	if (isset($_POST['delete_x']))
	{
		$client = $man->getClient($_POST['id']);
		$client->delete();
	}

	
	if (isset($_POST['save_x']))
	{
		$id = $_POST['id'];
		$client = $man->getClient($id);
		$client->updateData($_POST['data']);
	}
?>


<script>
	$('document').ready(function(){
		$('input').addClass('ui-widget ui-widget-content ui-corner-all required');		
		$("input:submit").button();
		
		$('.delete_button').click(function(){
			return confirm("Bы действительно хотите удалить клиента?");
		});
	});
</script>

<h1 class="header">Добавить клиента</h1>
<div style="width: 600px;" class="ui-widget ui-widget-content">
<form method="post">
	<table width="100%" cellpadding="5">
		<tr>
			<td>id: </td>
			<td><input style="width: 100%;" type="text" name="data[id]"></td>
		</tr>
		
		<tr>
			<td>Имя: </td>
			<td><input style="width: 100%;" type="text" name="data[name]"></td>
		</tr>
		
		<tr>
			<td>Транслит: </td>
			<td><input style="width: 100%;" type="text" name="data[translit]"></td>
		</tr>	
		
		<tr>
			<td>&nbsp;</td>
			<td><input style="width: 100%;" type="submit" name="add" value="Добавить"></td>
		</tr>
	</table>
</form>
</div>

<br><br>

<h1 class="header">Список клиентов</h1>
<table class="ui-widget ui-widget-content" width="100%" cellpadding="5">
	<tr>
		<td>id</td>
		<td>Имя</td>
		<td>Транслит</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<?
		$clients = $man->getClients();
		foreach ($clients as $client)
		{
			$data = $client->getData();
			?>
			<form method="post">			
			<input type="hidden" name="id" value="<?=$data['id']?>">
			<tr>
				<td><input style="width: 100%;" type="text" name="data[id]" value="<?=$data['id']?>"></td>				
				<td><input style="width: 100%;" type="text" name="data[name]" value="<?=$data['name']?>"></td>
				<td><input style="width: 100%;" type="text" name="data[translit]" value="<?=$data['translit']?>"></td>				
				<td><input name="save" type="image" src="/pic/apply.png"></td>
				<td><input class="delete_button" name="delete" type="image" src="/pic/delete.png"></td>
			</tr>
			</form>
			<?
		}
	?>
</table>
