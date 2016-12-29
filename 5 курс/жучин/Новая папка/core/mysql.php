<?
/*--------------------------------------
Класс DB, предназначенный для работы с базой данных MySql. Реализован на основе шаблона проектирования Singleton.
Экземпляр класса существует в единственном варианте. Подключается в начале 'core.php'.

Доступ к базе данных:
$db = DB::get();

Пример запроса:
$result = sql('SELECT * FROM table');
--------------------------------------*/
class DB 
{
	private static $instance = null;
	private $connection = null;
	
	private function __construct()
	{
		include ($_SERVER['DOCUMENT_ROOT'].'/inc/sql_config.php');
		$this->connection = mysql_connect($mysql_host, $mysql_login, $mysql_psswd) or die(mysql_error);
		mysql_select_db($mysql_dbname);
		mysql_query("SET NAMES 'cp1251'");
	}
	
	public static function get()
	{
		if ( !(self::$instance instanceof DB) )
		{
			self::$instance = new DB();				
		}
		return self::$instance;
	}
	
	public function sql($query)
	{
		$result = mysql_query($query, $this->connection) or die(mysql_error());
		return $result;
	}	
}

function sql($query)
{
	return DB::get()->sql($query);
}

include_once ($_SERVER['DOCUMENT_ROOT'].'/core/mysql_data.php');	

function debug($var=null)
	{
		if ($var === null) debug(debug_backtrace());
		echo '<pre>';
			print_r($var);
		echo '</pre>';
	}
?>