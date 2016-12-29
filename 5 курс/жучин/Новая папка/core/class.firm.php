<?
	class Firm
	{
		private $data;
		
		public function __construct($id)
		{
			$this->data = new SqlData('firms', 'id', $id);
		}
		public function getData($field) {return $this->data->getData($field);}
		public function setData($data) {return $this->data->setData($data);}
		
	}
	
	class FirmManager
	{
		private $firms = array();
		
		public function __construct()
		{
		
		}
		
		public function createFirm($data)
		{
		
		}
		
		public function getFirm($id)
		{
			return new Firm($id);
		}
		
		public function getFirms()
		{
			if (!$this->firms)
			{
				$sql = sql('SELECT * FROM firms');
				while ($res = mysql_fetch_assoc($sql))
				{
					$firm = $this->getFirm($res['id']);
					$firm->setData($res);
					$this->firms[] = $firm;				
				}
			}
			return $this->firms;
		}
	}
?>