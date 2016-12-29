<?
	include_once ($_SERVER['DOCUMENT_ROOT'].'/core/mysql.php');
	
	function update_sql_query($arr, $table, $condition='')
	{
		$sql = "UPDATE $table SET ";
		
		$total = count($arr);
		$counter = 0;
		foreach ($arr as $k => $v)
		{
			$counter++;
			$sql .= "$k = '$v'";
			if ($counter != $total) $sql .= ","; $sql .= " ";
		}
		
		$sql .= $condition;		
		return $sql;
	}
	
	/*************************************************************************************************************************/
	class User
	{
		private $_id;
		private $_data;
		private $_group_data;
		
		public function __construct($id)
		{
			$this->_id = $id;
		}
		
		public function logout()
		{
			unset($_SESSION['password']);
			setCookie('password', '');			
		}
		
		public function checkPermission($name)
		{
			return $this->getGroupInfo($name);
		}
		
		public function diePermission($name)
		{
			if (!$this->checkPermission($name))	die;
		}
		
		public function getInfo($name='')
		{
			if (empty($this->_data)) $this->_data = mysql_fetch_assoc(sql("SELECT * FROM users WHERE id = {$this->_id}"));
			if (empty($name)) return $this->_data;
			else return $this->_data[$name];
		}
		
		public function getGroupInfo($name='')
		{
			$id = $this->getInfo('group_id');
			if (empty($this->_group_data)) $this->_group_data = mysql_fetch_assoc(sql("SELECT * FROM groups WHERE id = $id"));
			if (empty($name)) return $this->_group_data;
			else return $this->_group_data[$name];			
		}
		
		public function changeGroup($group_id)
		{
			sql("UPDATE users SET group_id = $group_id WHERE id = {$this->_id}");
			$this->_data = '';
			$this->_group_data='';
		}
		
		public function save($data)
		{
			$query = update_sql_query($data, 'users', "WHERE id = {$this->_id}");
			sql($query);
			$this->_data = '';
		}
	}
	
	/*************************************************************************************************************************/
	class AuthManager
	{
		private $_user = null;
		
		public function __construct()
		{
			//
		}
		
		public function authorise()
		{
			session_start();			
			$this->checkPost();
			$this->checkArrays();
			if ($this->_user == null) $this->showAuthForm();
		}
		
		private function checkArrays()
		{			
			if ( !isset($_SESSION['password']) && !isset($_COOKIE['password']) )
			{								
				$this->showAuthForm();
			}
			
			if (isset($_SESSION['password'])) $this->checkSession();
			if (isset($_COOKIE['password'])) $this->checkCookie();
		}
		
		private function isUserExist($password)
		{
			$query = sql("SELECT * FROM users WHERE password='$password'");
			$len = mysql_num_rows($query);
			return ($len == 1);
		}
		
		private function checkPost()
		{
			if (isset($_POST['password']))
			{
				$name = $_POST['name'];
				$password = $_POST['password'];
				$password = md5($name.$password);
				
				if ($this->isUserExist($password))
				{   
					$this->userAuth($password);					
					header('Refresh: 2; URL=http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI']);
					die('Пароль верный.');					
				}
				else 
				{			
					header('Refresh: 2; URL='.$_SERVER['REQUEST_URI']);
					die('Неверный пароль.');
				}
			}
		}
		
		private function checkSession()
		{
			$password = $_SESSION['password'];
			if ($this->isUserExist($password)) $this->userAuth($password);			 
		}
		
		private function checkCookie()
		{
			$password = $_COOKIE['password'];
			if ($this->isUserExist($password)) $this->userAuth($password);
		}
		
		private function showAuthForm()
		{
			include($_SERVER['DOCUMENT_ROOT']."/inc/login_form.php");
			die();
		}
		
		private function userAuth($password)
		{			
			$_SESSION['password'] = $password;
			if (isset($_POST['remember'])) setCookie('password', $password, time() + 3000000); // на месяц
			
			$res = mysql_fetch_assoc( sql("SELECT * FROM users WHERE password='$password'"));
			$this->_user = new User($res['id']);
		}
		
		public function getUser()
		{
			return $this->_user;
		}
	}
	
	/*************************************************************************************************************************/
	class Auth
	{
		public function getUser()
		{
			$manager = new AuthManager();
			$manager->authorise();
			return $manager->getUser();
		}
	}
	
	/*************************************************************************************************************************/
?>