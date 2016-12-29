<?
	class Client
	{
		private $data;
		
		public function __construct($id)
		{
			$this->data = new SqlData('clients', 'id', $id);
		}
		public function getData($field='') {return $this->data->getData($field);}
		public function setData($data) {return $this->data->setData($data);}
		public function updateData($data) {$this->data->updateData($data);}
		
		public function delete()
		{			
			$id = $this->getData('id');
			sql("DELETE FROM clients WHERE id='{$id}'");
		}
	}
	
	class ClientManager
	{
		private $clients = array();
		
		public function __construct()
		{
		
		}
		
		public function addClient($data)
		{
			sql("INSERT INTO clients(id, name, translit) VALUES ('{$data['id']}', '{$data['name']}', '{$data['translit']}')");
		}
		
		public function getClient($id)
		{
			return new Client($id);
		}
		
		public function getClients()
		{
			if (!$this->clients)
			{
				$sql = sql('SELECT * FROM clients ORDER BY id');
				while ($res = mysql_fetch_assoc($sql))
				{
					$client = $this->getClient($res['id']);
					$client->setData($res);
					$this->clients[] = $client;				
				}
			}
			return $this->clients;
		}
	}
?>