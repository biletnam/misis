<?
	class Template
	{
		private $data;

		public function __construct($id)
		{
			$this->data = new SqlData('templates', 'id', $id);
		}
		public function getData($field='') {return $this->data->getData($field);}
		public function setData($data) {return $this->data->setData($data);}
		public function updateData($data) {$this->data->updateData($data);}
		
		public function delete()
		{
			$path = $_SERVER['DOCUMENT_ROOT'].'/templates/';
			$file = $this->getData('file');
			unlink($path.$file);
			$id = $this->getData('id');
			sql("DELETE FROM templates WHERE id='{$id}'");
		}
	}
	
	class TemplateManager
	{
		private $templates = array();
		
		public function __construct()
		{
			
		}
		
		public function generateScript()
		{
			?>
			var availableTags = [
			<?
				$templates = $this->getTemplates();
				$count = count($templates)-1;
				foreach ($templates as $k=>$template)
				{
					$value = $template->getData('file');
					$label = $template->getData('name');
					$id = $template->getData('id');
					?>
					{value: "<?=$label?>",	label: "<?=$label?>", file: "<?=$value?>", id: "<?=$id?>"}
					<?
					if ($count != $k) echo ',';
				}
			?>			
			];
			<?
		}
		
		public function addTemplate($data)
		{
			sql("INSERT INTO templates(firm_id, name, file) VALUES ('{$data['firm_id']}', '{$data['name']}', '{$data['file']}')");
		}
		
		public function getTemplate($id)
		{
			return new Template($id);
		}
		
		public function getFirstTemplate()
		{
			$sql = mysql_fetch_assoc(sql('SELECT * FROM templates LIMIT 1'));
			return new Template($sql['id']);
		}
		
		public function getTemplates()
		{
			if (!$this->templates)
			{				
				$sql = sql('SELECT * FROM templates');
				while ($res = mysql_fetch_assoc($sql))
				{					
					$temp = $this->getTemplate($res['id']);					
					$temp->setData($res);					
					$this->templates[] = $temp;
				}				
			}
			
			return $this->templates;
		}
	}
?>