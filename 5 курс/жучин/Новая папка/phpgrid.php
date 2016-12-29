<?php
// Подключение и выбор БД
$mysql_host = "localhost";
$mysql_dbname = "mpexp_mpexp";
$mysql_login = "mpexp_mpexp";
$mysql_psswd = "R38rh4Co";
  
$db = mysql_connect($mysql_host, $mysql_login, $mysql_psswd);
mysql_select_db($mysql_dbname);

# ВНИМАНИЕ!!!
# Данный код не имеет проверок запрашиваемых данных
# что может стать причиной взлома! Обязательно проверяйте все данные
# поступающие от клиента

$page = $_GET['page'];      // Номер запришиваемой страницы
$limit = $_GET['rows'];     // Количество запрашиваемых записей
$sidx = $_GET['sidx'];      // Номер элемента массива по котору следует производить сортировку
                            // Проще говоря поле, по которому следует производить сортировку
$sord = $_GET['sord'];      // Направление сортировки

// Если не указано поле сортировки, то производить сортировку по первому полю
if(!$sidx) $sidx =1;
//$sidx =1;
// Выполним запрос, который вернет суммарное кол-во записей в таблице
$result = mysql_query("SELECT COUNT(*) AS count FROM history");
$row = mysql_fetch_array($result,MYSQL_ASSOC);
$count = $row['count'];     // Теперь эта переменная хранит кол-во записей в таблице

// Рассчитаем сколько всего страниц займут данные в БД
if( $count > 0 && $limit > 0) {
    $total_pages = ceil($count/$limit);
} else {
    $total_pages = 0;
}
// Если по каким-то причинам клиент запросил
if ($page > $total_pages) $page=$total_pages;

// Рассчитываем стартовое значение для LIMIT запроса
$start = $limit*$page - $limit;
// Зашита от отрицательного значения
if($start <0) $start = 0;

// Запрос выборки данных
$query = "SELECT * FROM history ORDER BY ".$sidx." ".$sord." LIMIT ".$start.", ".$limit;
//echo $query;
$result = mysql_query($query);


// Начало xml разметки
$s = "<?xml version='1.0' encoding='utf-8'?>";
$s .=  "<rows>";
$s .= "<page>".$page."</page>";
$s .= "<total>".$total_pages."</total>";
$s .= "<records>".$count."</records>";

// Строки данных для таблицы
// Не забудьте обернуть текстовые данные в <![CDATA[]]>
while($row = mysql_fetch_assoc($result)) {
	
	$s .= "<row id='". $row['id']."'>";	   
	$s .= "<cell>". $row[id]."</cell>";  
    $s .= "<cell>". $row[user_id]."</cell>";  
	$s .= "<cell>". $row[production_name]."</cell>";  	
    $s .= "</row>";
}
$s .= "</rows>";

// Перед выводом не забывайте выставить header
// с типом контента и кодировкой
header("Content-type: text/xml;charset=utf-8");
echo $s;
?>