<?
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/mysql.php');

	$page = $_GET['page']; // get the requested page
	$limit = $_GET['rows']; // get how many rows we want to have into the grid
	$sidx = $_GET['sidx']; // get index row - i.e. user click to sort
	$sord = $_GET['sord']; // get the direction
	if(!$sidx) $sidx =1;
	
	$result = sql("SELECT COUNT(*) AS count FROM history");
	$row = mysql_fetch_array($result,MYSQL_ASSOC);
	$count = $row['count'];
	
	if( $count >0 ) {
		$total_pages = ceil($count/$limit);
	} else {
		$total_pages = 0;
	}
	
	if ($page > $total_pages) $page=$total_pages;
	$start = $limit*$page - $limit; // do not put $limit*($page - 1)
	
	$SQL = "SELECT * FROM history ORDER BY $sidx $sord LIMIT $start , $limit";
	$result = sql($SQL);
	
	$et = ">";
	header("Content-type: text/xml;charset=cp1251");
	echo "<?xml version='1.0' encoding='cp1251'?$et\n";
	echo "<rows>";
	echo "<page>".$page."</page>";
	echo "<total>".$total_pages."</total>";
	echo "<records>".$count."</records>";
	// be sure to put text data in CDATA
	while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
		echo "<row id='". $row[id]."'>";
		echo "<cell><![CDATA[". $row[user_id]."]]></cell>";
		echo "<cell><![CDATA[". $row[time]."]]></cell>";
		echo "<cell><![CDATA[". $row[temp_id]."]]></cell>";
		echo "<cell><![CDATA[". $row[file]."]]></cell>";
		echo "<cell><![CDATA[". $row[protocol_number]."]]></cell>";
		echo "<cell><![CDATA[". $row[protocol_date]."]]></cell>";
		echo "<cell><![CDATA[". $row[select_date]."]]></cell>";
		echo "<cell><![CDATA[". $row[test_date]."]]></cell>";
		echo "<cell><![CDATA[". $row[client_id]."]]></cell>";
		echo "<cell><![CDATA[". $row[production_name]."]]></cell>";
		echo "<cell><![CDATA[". $row[production_description]."]]></cell>";
		echo "<cell><![CDATA[". $row[manufacturer]."]]></cell>";
		echo "<cell><![CDATA[". $row[declarant]."]]></cell>";
		echo "<cell><![CDATA[". $row[normative_document]."]]></cell>";
		echo "<cell><![CDATA[". $row[objectives]."]]></cell>";
		echo "<cell><![CDATA[". $row[test_count]."]]></cell>";
		echo "<cell><![CDATA[". $row[standart]."]]></cell>";	
		echo "</row>";
	}
	echo "</rows>";	
?>