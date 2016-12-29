<?
class SqlData
{
	private $_data = array();
	private $_table;
	private $_selector;
	private $_selector_value;
	
	public function __construct($table, $selector, $selector_value)
	{
		$this->_table = $table;
		$this->_selector = $selector;
		$this->_selector_value = $selector_value;
	}
	
	public function getData($field='')
	{
		if ($field == $this->_selector) return $this->_selector_value;		
		else
		{
			if (empty($this->_data)) 
			{
				$query = "SELECT * FROM {$this->_table} WHERE {$this->_selector} = '{$this->_selector_value}'";
				$this->_data = mysql_fetch_assoc(sql($query));
			}
			
			if (empty($field)) return $this->_data;
			else if (isset($this->_data[$field])) return $this->_data[$field];
			else
			{
				$query = "SELECT $field FROM {$this->_table} WHERE {$this->_selector} = '{$this->_selector_value}'";
				$result = mysql_fetch_assoc(sql($query));
				$this->_data[$field] = $result[$field];
				return $this->_data[$field];
			}
		}
	}
	
	public function setData($data)
	{
		$this->_data = $data;
	}
	
	public function updateData($data)
	{
		$query = update_sql_query($data, $this->_table, "WHERE {$this->_selector} = '{$this->_selector_value}'");		
		sql($query);		
		$this->_data = array_merge($this->_data, $data);
	}
	
	public function clear()
	{
		$this->_data = null;
	}
}
?>