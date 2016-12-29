<?
	class HistoryRecord
	{
		private $data;
		
		public function __construct($id)
		{
			$this->data = new SqlData('history', 'id', $id);
		}
		public function getData($field='') {return $this->data->getData($field);}
		public function setData($data) {return $this->data->setData($data);}
		public function updateData($data) {$this->data->updateData($data);}

		public function delete()
		{
			$file = $_SERVER['DOCUMENT_ROOT'].$this->getData('file');
			unlink($file);
			sql("DELETE FROM history WHERE id='{$this->getData('id')}'");
		}
	}
	
	class History
	{
		private $records = array();
		
		public function addRecord($data)
		{
		}
		
		public function getRecord($id)
		{
			return new HistoryRecord($id);
		}
		
		public function getRecords()
		{
			if (!$this->records)
			{
				$sql = sql('SELECT * FROM records ORDER BY id');
				while ($res = mysql_fetch_assoc($sql))
				{
					$record = $this->getRecord($res['id']);
					$record->setData($res);
					$this->records[] = $record;				
				}
			}
			return $this->records;
		}
	}
?>