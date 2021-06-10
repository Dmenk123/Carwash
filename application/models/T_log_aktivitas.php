<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class T_log_aktivitas extends CI_Model
{
	var $table = 't_log_aktivitas';
	var $column_search = ['t_log_aktivitas.created_at','m_menu.nama','m_user.nama','t_log_aktivitas.aksi'];
	
	var $column_order = [
		null, 
		't_log_aktivitas.created_at',
		'm_menu.nama',
		'm_user.nama',
		't_log_aktivitas.aksi',
		null
	];

	var $order = ['t_log_kunci.created_at' => 'desc']; 

	public function __construct()
	{
		parent::__construct();
		//alternative load library from config
		$this->load->database();
	}

	private function _get_datatables_query($term='',$tgl_awal, $tgl_akhir, $menu, $aksi)
	{
		$this->db->select('
			t_log_aktivitas.*,
			m_menu.nama as nama_menu,
			m_user.nama as nama_user
		');

		$this->db->from('t_log_aktivitas');	
		$this->db->join('m_menu', 't_log_aktivitas.id_m_menu = m_menu.id', 'left');
		$this->db->join('m_user', 't_log_aktivitas.id_m_user = m_user.id', 'left');
		$this->db->where('t_log_aktivitas.deleted_at is null');
		$this->db->where('t_log_aktivitas.created_at >=', $tgl_awal);
		$this->db->where('t_log_aktivitas.created_at <=', $tgl_akhir);
		if($menu != '0') {
			$this->db->where('t_log_aktivitas.id_m_menu', $menu);
		}

		if($aksi != 'semua') {
			$this->db->where('t_log_aktivitas.aksi', strtoupper(strtolower($menu)));
		}
		
		$i = 0;
		// loop column 
		foreach ($this->column_search as $item) 
		{
			// if datatable send POST for search
			if($_POST['search']['value']) 
			{
				// first loop
				if($i===0) 
				{
					// open bracket. query Where with OR clause better with bracket. because maybe can combine with other WHERE with AND.
					$this->db->group_start();
					$this->db->like($item, $_POST['search']['value']);
				}
				else
				{
					$this->db->or_like($item, $_POST['search']['value']);
				}
				//last loop
				if(count($this->column_search) - 1 == $i) 
					$this->db->group_end(); //close bracket
			}
			$i++;
		}

		if(isset($_POST['order'])) // here order processing
		{
			$this->db->order_by($this->column_order[$_POST['order']['0']['column']], $_POST['order']['0']['dir']);
		} 
		else if(isset($this->order))
		{
			$order = $this->order;
            $this->db->order_by(key($order), $order[key($order)]);
		}
	}

	function get_datatable_log($tgl_awal, $tgl_akhir, $menu, $aksi)
	{
		$term = $_REQUEST['search']['value'];
		$this->_get_datatables_query($term, $tgl_awal, $tgl_akhir, $menu, $aksi);
		if($_REQUEST['length'] != -1)
		$this->db->limit($_REQUEST['length'], $_REQUEST['start']);

		$query = $this->db->get();
		return $query->result();
	}

	function count_filtered($tgl_awal, $tgl_akhir, $menu, $aksi)
	{
		$this->_get_datatables_query('', $tgl_awal, $tgl_akhir, $menu, $aksi);
		$query = $this->db->get();
		return $query->num_rows();
	}

	public function count_all()
	{
		$this->db->from($this->table);
		return $this->db->count_all_results();
	}

	public function get_detail_user($id_user)
	{
		$this->db->select('*');
		$this->db->from('m_user');
		$this->db->where('id', $id_user);

        $query = $this->db->get();

        if ($query->num_rows() > 0) {
            return $query->result();
        }
	}
	
	public function get_by_id($id)
	{
		$this->db->from($this->table);
		$this->db->where('id',$id);
		$query = $this->db->get();

		return $query->row();
	}

	public function get_by_condition($where, $is_single = false)
	{
		$this->db->from($this->table);
		$this->db->where($where);
		$query = $this->db->get();
		if($is_single) {
			return $query->row();
		}else{
			return $query->result();
		}
	}

	public function save($data)
	{
		$this->db->insert($this->table, $data);	
		return $this->db->insert_id();
	}

	public function update($where, $data)
	{
		return $this->db->update($this->table, $data, $where);
	}

	public function softdelete_by_id($id)
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$where = ['id' => $id];
		$data = ['deleted_at' => $timestamp];
		return $this->db->update($this->table, $data, $where);
	}
	
	public function get_max_id_member()
	{
		$q = $this->db->query("SELECT MAX(id) as kode_max from m_member");
		$kd = "";
		if($q->num_rows()>0){
			$kd = $q->row();
			return (int)$kd->kode_max + 1;
		}else{
			return '1';
		} 
	}

	public function get_menu_by_log_aktivitas()
	{
		$query = $this->db->query("
			SELECT * 
			FROM m_menu 
			where 
				m_menu.id in (select id_m_menu from t_log_aktivitas where id_m_menu is not null group by id_m_menu)
				and m_menu.tingkat <> '1'
				and m_menu.aktif = '1'
			order by m_menu.nama
		")->result();
		
		return $query;
	}
}