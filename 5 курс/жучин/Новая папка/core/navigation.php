<?
	class Navigation
	{
		private $_user;
		
		public function __construct($user)
		{
			$this->_user = $user;
		}
		
		public function show()
		{
			$user = $this->_user;
			echo '<div style="float: right">';		
				if ($user->checkPermission('admin_panel'))
				{
					echo '<a href="/report.php">Отчеты</a> &nbsp;&nbsp;&nbsp;';
				}
				
				if ($user->checkPermission('admin_panel'))
				{
					echo '<a href="/clients.php">Клиенты</a> &nbsp;&nbsp;&nbsp;';
				}
				/*
				if ($user->checkPermission('admin_panel'))
				{
					echo '<a href="/firms.php">Организации</a> &nbsp;&nbsp;&nbsp;';
				}	
				*/
				if ($user->checkPermission('admin_panel'))
				{
					echo '<a href="/templates.php">Шаблоны</a> &nbsp;&nbsp;&nbsp;';
				}	
				
				if ($user->checkPermission('admin_panel'))
				{
					echo '<a href="/admin/users.php">Пользователи</a> &nbsp;&nbsp;&nbsp;';
				}				
				
				echo '<a href="/">На главную</a>';
			echo '</div>';
		}
	}
?>