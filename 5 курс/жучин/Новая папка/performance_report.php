<?
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/mysql.php');
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/users.php');
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/class.firm.php');	
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/class.template.php');
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/class.client.php');
		
	include($_SERVER['DOCUMENT_ROOT'].'/inc/top.php');
	
?>
<link rel="stylesheet" type="text/css" href="/grid/css/flexigrid/flexigrid.css">
<script type="text/javascript" src="/grid/flexigrid.js"></script>

<script>
	$(function(){
		$('#result').flexigrid();
		
		$('input:text').addClass('ui-widget ui-widget-content ui-corner-all required');
		$('select').addClass('ui-widget ui-widget-content ui-corner-all');
		$("input:submit").button();
		
		$.datepicker.setDefaults($.datepicker.regional['ru']);
		$('#date_end').datepicker();
		$('#date_start').datepicker
		({
			onSelect: function(dateText, inst) 
			{				
				
				if (!$('#date_end').val()) $('#date_end').val(dateText);
				//alert($('#date_end').val());
				//alert('ghjghj');
			}
		});
		
		
	});	
</script>

<form method="post">
	Пользователь 
	<select name="user_id">
	<option <? if ($_POST['user_id'] == '-1') echo 'selected'?> id="-1">Все пользователи</option>
	<?		
		$res = sql("SELECT * FROM users");
		while ($row = mysql_fetch_assoc($res))
		{
			$id = $row['id'];
			$login = $row['name'];
			$fio = $row['FIO_F'].' '.$row['FIO_I'].' '.$row['FIO_O'];
			?>
			<option <? if ($id == $_POST['user_id']) echo 'selected'?> value="<?=$id?>"><?=$login?> - <?=$fio?></option>
			<?
		}
	?>
	</select>
	<br>
	Начало периода: <input value="<?=$_POST['date_start']?>" class="datepicker_edit" type="text" size="25" name="date_start" id="date_start">
	<br>
	Конец периода: <input value="<?=$_POST['date_end']?>" class="datepicker_edit" type="text" size="25" name="date_end" id="date_end">
	<br>
	<input type="submit" name="report" value="Отчет">
</form>
<br>
<?
	if (isset($_POST['report']))
	{
		//debug($_POST);
				
		$start = $_POST['date_start'];
		list($day, $month, $year) = sscanf($start, "%02d.%02d.%04d");
		$start="$year.$month.$day"; 
		
		$end = $_POST['date_end'];
		list($day, $month, $year) = sscanf($end, "%02d.%02d.%04d");
		$end="$year.$month.$day"; 
		
		if ($_POST['user_id'] > 0) $add = "user_id = '{$_POST['user_id']}' AND";
		else $add='';
		
		$sql = sql ("SELECT * FROM history WHERE $add DATE(time) BETWEEN '{$start}' AND '{$end}'");
		if (mysql_num_rows($sql))
		{
			$sql2 = sql("SELECT * FROM users");
			$users=array();
			while($res2 = mysql_fetch_assoc($sql2))
			{
				$id = $res2['id'];
				$fio = $res2['FIO_F'].' '.$res2['FIO_I'].' '.$res2['FIO_O'];
				$users[$id] = $fio;
			}
			?>
			<table id="result">
			
			<tr>
				<td>Пользователь</td>
				<td>Время</td>
				<td>Шаблон</td>
				<td>Файл</td>
				<td>Номер протокола</td>
				<td>Дата протокола</td>
				<td>Акт отбора образцов</td>
				<td>Дата проведения испытаний</td>
				<td>Клиент</td>
				<td>Наименование продукции</td>
				<td>Описание продукции</td>
				<td>Изготовитель</td>
				<td>Заявитель</td>
				<td>Нормативный документ</td>
				<td>Цель испытаний</td>
				<td>Количество испытаний</td>
				<td>ГОСТ</td>
			</tr>
			
			<?			
			while ($res = mysql_fetch_assoc($sql)) 
			{
			$tempman = new TemplateManager();
			$template = $tempman->getTemplate($res['temp_id']);
			$template = $template->getData('name');
			
			$man = new ClientManager();	
			$client = $man->getClient($res['client_id']);
			$client = $client->getData('name');
			?>			
			<tr>
				<td><?=$users[$res['user_id']]?></td>
				<td><?=$res['time']?></td>
				<td><?=$template?></td>
				<td><a href="<?=$res['file']?>">Скачать</a></td>
				<td><?=$res['protocol_number']?></td>
				<td><?=$res['protocol_date']?></td>
				<td><?=$res['select_date']?></td>
				<td><?=$res['test_date']?></td>
				<td><?=$client?></td>
				<td><?=$res['production_name']?></td>
				<td><?=$res['production_description']?></td>
				<td><?=$res['manufacturer']?></td>
				<td><?=$res['declarant']?></td>
				<td><?=$res['normative_document']?></td>
				<td><?=$res['objectives']?></td>
				<td><?=$res['test_count']?></td>
				<td><?=$res['standart']?></td>
			</tr>
			
			<?
			}
			echo '</table>';
		}		
	}
?>