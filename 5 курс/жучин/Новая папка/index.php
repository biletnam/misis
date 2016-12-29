<?
	include($_SERVER['DOCUMENT_ROOT'].'/inc/top.php');	
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/class.template.php');
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/class.client.php');
?>

	<table>
		<tr>
			<td valign="top"><?	include($_SERVER['DOCUMENT_ROOT'].'/forms/form1.php');	?></td>		
			<td valign="top"><div id="list"><?include($_SERVER['DOCUMENT_ROOT'].'/list_docs.php');?></div></td>
		</tr>
	</table>
	<div id="dialog" title="Удаление">Вы действительно хотите удалить файл? <input type="hidden" id="delete_link"> </div>
</body>
</html>

 <script type="text/javascript">

	function delete_doc(link)
	{
		$.ajax
			({
				url: link,
				success: function() 
				{
					$('#list').load('list_docs.php', function(){list_ready();});
				}
			});
	}
	
	function list_ready()
	{
		$('.delete').click
		( function()
		{
			var link = $(this).attr("name");
			$('#delete_link').val(link);
			$("#dialog").dialog("open");
		}		
		);
	}	 
 
	
	$(document).ready(function() {
		$.ajaxSetup ({
			// Disable caching of AJAX responses */
			cache: false,
			async: false
		});
		
		list_ready();
		form_ready();
		
		$("#dialog").dialog({
			resizable: false,			
			buttons: {
				'Отмена': function() {
					$(this).dialog('close');
				},
				'Удалить': function() {
					var link = $('#delete_link').val();
					delete_doc(link);
					$(this).dialog('close');
				}
			}
		});
		$("#dialog").dialog("close");		
	}); 
 </script>