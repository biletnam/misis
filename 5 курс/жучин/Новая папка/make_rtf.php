<?	
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/users.php');
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/mysql.php');
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/class.client.php');
	
	if (!isset($_POST['is_test']))
	{///////////////////////////////////////////////////////
	
	// Функция преобразует строковый параметр в строку юникод символов параметра для сохранения в rtf	
	function vutf($str_par) 
	{ 
		$str_par = urlencode($str_par);
		$count = substr_count($str_par,'%');
		for ( $i=0; $i < $count; $i++) 
		{
			$str_par = substr_replace($str_par, '\\\'', strpos($str_par, '%'),1);
		}
		//$str_par = strtolower($str_par);
		$str_par = strtr($str_par, '+', ' ');
		return $str_par;
	}	
	
	$file = file_get_contents('templates/'.$_POST['template']) or Die('file error');
	
	$data = $_POST['data'];
	foreach ($data as $k => $v) 
	{		
		//echo vutf(stripcslashes($v));
		//echo '<br>';
		$file = str_replace('AAA'.$k.'AAA', vutf(stripcslashes($v)), $file);		
	}
	
	
	
	$clman = new ClientManager();	
	$client = new Client($_POST['data']['Client']);
	$client = $client->getData('translit');

	$date_today = date("d.m.y");	
	$filename = date("H-i-s_d-m-y_").$client;
	$dir_name = $_SERVER['DOCUMENT_ROOT'].'/documents/'.$date_today;
	if (!is_dir($dir_name)) mkdir($dir_name, 0777);	
	
	$fhandle = fopen($dir_name.'/'.$filename.".rtf","w");
	fwrite($fhandle,$file);
	fclose($fhandle);
	
	//history
	$user = Auth::getUser();	
	$h_user = $user->getInfo('name');
	$h_date = $date_today;	
	$h_doc_name = $filename.'.rtf';
	$h_time = date("H:i:s");
	$h_template = $_POST['template'];
	
	//$query = "('$h_user', '$h_date', '$h_doc_name', '$h_time', '$h_template')";	
	//$sql = sql("INSERT INTO history (user, date, doc_name, time, template_name) VALUES".$query);
	function convert_date($date)
	{
		return date('Y-m-d', strtotime($date));
	}
	
	{
		$data = $_POST['history'];
		
		$data['protocol_date'] = convert_date($data['protocol_date']);
		$data['select_date'] = convert_date($data['select_date']);
		$data['test_date'] = convert_date($data['test_date']);
		
		$mysqldate = date('Y-m-d H:i:s');
		$file_path = '/documents/'.$date_today.'/'.$filename.".rtf";
		
		$query = 'INSERT INTO history (user_id, time, temp_id, file, protocol_number, protocol_date, select_date, test_date, client_id, production_name, production_description, manufacturer, declarant, normative_document, objectives, test_count, standart) VALUES ('.
		"'{$data['user_id']}', ".
		"'{$mysqldate}', ".
		"'{$data['temp_id']}', ".
		"'{$file_path}', ".
		"'{$data['protocol_number']}', ".
		"'{$data['protocol_date']}', ".		
		"'{$data['select_date']}', ".		
		"'{$data['test_date']}', ".		
		"'{$data['client_id']}', ".		
		"'{$data['production_name']}', ".		
		"'{$data['production_description']}', ".		
		"'{$data['manufacturer']}', ".		
		"'{$data['declarant']}', ".		
		"'{$data['normative_document']}', ".		
		"'{$data['objectives']}', ".		
		"'{$data['test_count']}', ".		
		"'{$data['standart']}')";
		
		sql($query);
	}
	
	
	
	
		
	$servUrl='http://'.$_SERVER['SERVER_NAME'].'/';
	$url = $servUrl.'documents/'.$date_today.'/'.$filename.".rtf";
	header('Content-Disposition: attachment; filename="'.$filename.'.rtf"');    
	header('Content-type: application/msword');
	header("Expires: 0");
	header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
	header("Pragma: public");
	echo $file;
	
	
	}///////////////////////////////////////////////////////////////////
	else
	{
		debug($_POST);		
	}
	
?>