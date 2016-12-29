<?
include($_SERVER['DOCUMENT_ROOT'].'/inc/sql_config.php');
$month = $_GET['month'];
$client = $_GET['client'];
$sql = mysql_query("SELECT * FROM history WHERE (date LIKE '__.$month.__')AND(doc_name LIKE '%$client%') ORDER BY id", $mysql_cont);


if($sql)
{
	$fields_num =  mysql_num_fields($sql);	
	echo '<table cellpadding="0" cellspacing="0">';
	for ($i=0; $i<$fields_num; $i++)
	{
		$filed = mysql_field_name($sql, $i);
		echo '<td>'.$filed.'</td>';
	}
	while ($row = mysql_fetch_array($sql, MYSQL_NUM)):
		echo '<tr>';
		for($i=0; $i<sizeof($row); $i++):			
			$val = $row[$i];
			?>
			<td><?=$val?></td>
			<?
		endfor;		
		echo '</tr>';
	endwhile;
	echo '</table>';
}
else
{  
  exit();
}
?>