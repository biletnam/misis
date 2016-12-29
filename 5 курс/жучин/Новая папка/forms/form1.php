<script type="text/javascript">
	
	function make_str()
	{
		var client = $('#client').val();
		var number = $('#number').val();
		var number_date = $('#number_date').val();
		var count = $('#count').val();
		var str='';
		var arr = new Array('0', 'a', 'b', 'c', 'd', 'e', 'f');
		
		str += client + '-' + number + arr[1] + '/' + number_date;
		if (count>1) str += ' — ' + client + '-' + number + arr[count] + '/' + number_date;
		
		return str;
	}
	
	function form_ready()
	{	
		
		// Указываем дейтпикеру что выводить все нужно на русском
		$.datepicker.setDefaults($.datepicker.regional['ru']);
		
		
		$('.datepicker_edit').datepicker
		({
			onSelect: function(dateText, inst) 
			{				
				$(this).valid();			
			}
		});
		
		$('#date').datepicker
		({
			onSelect: function(dateText, inst) 
			{				
				$(this).valid();
				var dat = $.datepicker.parseDate('dd.mm.yy', dateText);
				dat = $.datepicker.formatDate('mm-yy', dat);
				$('#number_date').val(dat);
			}
		});		
		
		$('input:text').addClass('ui-widget ui-widget-content ui-corner-all required');
		$('select').addClass('ui-widget ui-widget-content ui-corner-all');
		$("input:submit").button();
		
		$.extend($.validator.messages, {required: "Поле необходимо заполнить!"});
		$("#main_form").validate();

		$(':submit').bind('click', function() {
			var text = $('#DateAct').val();
			if (text != 'данные отсутствуют') 
			{
				text = 'от ' + text + 'г.';
			}
			$('#dataDateAct').val(text);
				
			$('#str').val(make_str());
			
			make_history();
		});		
		
		$(".header").bind("click", function() { 
			$('#list').load('list_docs.php');
		})
		
		$("#main_form").bind("submit", function() { 			
			setTimeout("$('#list').load('list_docs.php', function(){list_ready();})",500);						
		})
		
		$('#count').change(function() {
			if ($('#count').val() == '6') $('#objectives').val('испытания на безопасность и электромагнитную совместимость');
		});
		
		//$('#simple_combo').simpleCombo();
		var selectDialog = $('#select_dialog');		
		selectDialog.dialog();
		selectDialog.dialog('close');
		
		$('#template_select').click(function(){
			selectDialog.dialog('open');
		});

		<?
		$tempman = new TemplateManager();
		$tempman->generateScript();
		?>
		$( "#autocomplite" ).autocomplete({
			source: availableTags
		});
		$( "#autocomplite" ).autocomplete({
			select: function(event, ui) {
				var id= ui.item.id;
				var file= ui.item.file;
				var caption = ui.item.label;
				$('#template_file').val(id);
				$('#template_file').val(file);
				$('#template_select').val(caption);
				$('#select_dialog').dialog('close');
			}
		});
	}
	
	function simple_history(str1, str2)
	{
		$('#'+str1).val($('#'+str2).val());
	}
	
	function make_history()
	{
		simple_history('history_protocol_number', 'number');
		simple_history('history_protocol_date', 'date');
		simple_history('history_select_date', 'DateAct');
		simple_history('history_test_date', 'DateTest');
		simple_history('history_production_name', 'prod_name');
		simple_history('history_production_description', 'prod_desc');
		simple_history('history_manufacturer', 'manufacturer');
		simple_history('history_declarant', 'declarant');
		simple_history('history_normative_document', 'normative_document');
		simple_history('history_objectives', 'objectives');
		simple_history('history_test_count', 'count');
		simple_history('history_standart', 'standart');
		
		simple_history('history_temp_id', 'template_id');
		simple_history('history_client_id', 'client');
		
		
		
		
	}
</script>
<form id="main_form" method="post" action="make_rtf.php">
<table>

<tr>
	<td class="header">Номер протокола: </td>
	<td align="right"><input id="number" type="text" size="70" name="data[ProtocolNumber]"></td>
</tr>

<tr>
	<td class="header">Дата протокола: </td>
	<td align="right">
		<input id="date" type="text" size="70" name="data[Date]">
		<input id="number_date" type="hidden"name="data[ProtocolNumberDate]">
	</td>
</tr>

<tr>
	<td class="header">Акт отбора образцов: </td>
	<td align="right">
		<input class="datepicker_edit" type="text" size="70" id="DateAct" value="данные отсутствуют">
		<input type="hidden" name="data[DateAct]" id="dataDateAct">
	</td>
</tr>

<tr>
	<td class="header">Дата проведения испытаний: </td>
	<td align="right"><input class="datepicker_edit" type="text" size="70" name="data[DateIsp]" id="DateTest"></td>
</tr>

<tr>
	<td class="header">Клиент: </td>
	<td align="right">
		<select id="client" name="data[Client]" style="width: 100%">
			<?
				$clientman = new ClientManager();
				$clients = $clientman->getClients();
				foreach ($clients as $client)
				{
					$data = $client->getData();
					?>
					<option value="<?=$data['id']?>"><?=$data['id']?> - <?=$data['name']?></option>
					<?
				}
			?>
		</select>
	</td>
</tr>

<tr>
	<td class="header">Наименование продукции: </td>
	<td align="right"><input type="text" size="70" name="data[ProductionName]" id="prod_name"></td>
</tr>

<tr>
	<td class="header">Описание продукции: </td>
	<td align="right"><input type="text" size="70" name="data[Description]" id="prod_desc"></td>
</tr>

<tr>
	<td class="header">Изготовитель: </td>
	<td align="right"><input type="text" size="70" name="data[Manufacturer]" id="manufacturer"></td>
</tr>

<tr>
	<td class="header">Заявитель: </td>
	<td align="right"><input type="text" size="70" name="data[Declarant]" id="declarant"></td>
</tr>

<tr>
	<td class="header">Нормативный документ: </td>
	<td align="right"><input type="text" size="70" name="data[NormativeDocument]" value="данные отсутствуют" id="normative_document"></td>
</tr>

<tr>
	<td class="header">Цель испытаний: </td>
	<td align="right">		
		<input id="objectives" type="text" size="70" name="data[Objectives]" value="испытания на безопасность">		
	</td>
</tr>

<tr>
	<td class="header">Количество испытаний: </td>
	<td align="right">
		<select id="count" style="width: 100%">
		<option value="1">1</option>
		<option value="2">2</option>
		<option value="3">3</option>
		<option value="4">4</option>
		<option value="5">5</option>
		<option value="6">6</option>
		</select>
	</td>
</tr>

<tr>
	<td class="header">ГОСТ: </td>
	<td align="right"><input type="text" size="70" name="data[Standart]" id="standart"></td>
</tr>

<tr>
	<td class="header">Шаблон: </td>
	<td align="right">
		<?
			$tempman = new TemplateManager();
			$default_template = $tempman->getFirstTemplate();			
		?>
		<input type="hidden" id="template_id" name="template_id" value="<?=$default_template->getData('id')?>">
		<input type="hidden" id="template_file" name="template" value="<?=$default_template->getData('file')?>">
		<input type="text" id="template_select" style="width: 100%" value="<?=$default_template->getData('name')?>">		
	</td>
</tr>



<tr>
	<td class="noborder"></td>
	<td align="right" class="noborder">
		<input id="str" type="hidden"name="data[RegisterNumbers]">
		<input type="submit" name="make_rtf" value="Обработать">
		<?//<br><br><input type="checkbox" name="is_test"> Тест ?>
	</td>
</tr>
</table>
<?
	session_start();	
	
	
	
	
	$I = substr($user->getInfo('FIO_I'), 0, 1);
	$O = substr($user->getInfo('FIO_O'), 0, 1);	
	$user_FIO = $I.'.'.$O.'. '.$user->getInfo('FIO_F');
?>
<input type="hidden" name="data[UserFIO]" value="<?=$user_FIO?>">

<input type="hidden" name="history[user_id]" value="<?=$user->getInfo('id')?>">
<input type="hidden" name="history[temp_id]" value="" id="history_temp_id">
<input type="hidden" name="history[protocol_number]" value="" id="history_protocol_number">
<input type="hidden" name="history[protocol_date]" value="" id="history_protocol_date">
<input type="hidden" name="history[select_date]" value="" id="history_select_date">
<input type="hidden" name="history[test_date]" value=""   id="history_test_date">
<input type="hidden" name="history[client_id]" value="" id="history_client_id">
<input type="hidden" name="history[production_name]" value=""  id="history_production_name">
<input type="hidden" name="history[production_description]" value="" id="history_production_description">
<input type="hidden" name="history[manufacturer]" value="" id="history_manufacturer">
<input type="hidden" name="history[declarant]" value="" id="history_declarant">
<input type="hidden" name="history[normative_document]" value="" id="history_normative_document">
<input type="hidden" name="history[objectives]" value="" id="history_objectives">
<input type="hidden" name="history[test_count]" value="" id="history_test_count">
<input type="hidden" name="history[standart]" value="" id="history_standart">

</form>

<div id="select_dialog" title="Выбор шаблона">
	Выберите шаблон:<br>
	<input type="text" style="width: 95%" id="autocomplite">
</div>