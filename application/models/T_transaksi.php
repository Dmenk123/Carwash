<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class T_transaksi extends CI_Model
{
	var $table = 't_transaksi';
	public function __construct()
	{
		parent::__construct();
		$this->load->database();
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
		return $this->db->insert($this->table, $data);	
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
		$data = ['deleted_at' => $timestamp, 'status' => null];
		return $this->db->update($this->table, $data, $where);
	}

	public function get_invoice(){
		$obj_date = new DateTime();
		$tahun = $obj_date->format('y');
		$bulan = $obj_date->format('m');
		$hari = $obj_date->format('d');

		$q = $this->db->query("select MAX(RIGHT(kode,5)) as kode_max from $this->table");
		$kd = "";
		if($q->num_rows()>0){
			foreach($q->result() as $k){
				$tmp = ((int)$k->kode_max)+1;
				$kd = sprintf("%05s", $tmp);
			}
		}else{
			$kd = "00001";
		}
		return "INV-".$tahun.$bulan.$hari.$kd;
	}
	
	###################################### datatable penjualan
	protected $column_search_p = ['t_transaksi.kode','t_transaksi.created_at','jenis_member','m_user.nama','t_transaksi.harga_total', 't_transaksi.harga_bayar', 't_transaksi.harga_kembalian','status_kunci'];
	
	protected $column_order_p = ['t_transaksi.kode','t_transaksi.created_at','jenis_member','m_user.nama','t_transaksi.harga_total', 't_transaksi.harga_bayar', 't_transaksi.harga_kembalian', 'status_kunci',null];

	protected $order_p = ['t_transaksi.kode' => 'desc']; 

	function get_datatable_penjualan($tgl_awal, $tgl_akhir)
	{
		$term = $_REQUEST['search']['value'];
		$this->_get_datatable_penjualan_query($tgl_awal, $tgl_akhir, $term);
		if($_REQUEST['length'] != -1)
		$this->db->limit($_REQUEST['length'], $_REQUEST['start']);

		$query = $this->db->get();
		return $query->result();
	}

	private function _get_datatable_penjualan_query($tgl_awal, $tgl_akhir, $term='')
	{
		$this->db->select('
			t_transaksi.*,
            m_member.kode_member,
			CASE WHEN t_transaksi.id_member is null THEN \'Reguler\' ELSE \'Member\' END as jenis_member,
			CASE WHEN t_transaksi.is_kunci = 1 THEN \'Terkunci\' ELSE \'Terbuka\' END as status_kunci,
            m_user.nama
		');

		$this->db->from('t_transaksi');
        $this->db->join('m_member', 't_transaksi.id_member=m_member.id', 'left');
		$this->db->join('m_user', 't_transaksi.id_user=m_user.id', 'left');
		$this->db->where('t_transaksi.created_at >=' ,$tgl_awal);
		$this->db->where('t_transaksi.created_at <=' ,$tgl_akhir);
		$this->db->where('t_transaksi.deleted_at is null');
		
		$i = 0;

		// loop column 
		foreach ($this->column_search_p as $item) 
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
					if($item == 'jenis_member') {
						/**
						 * param both untuk wildcard pada awal dan akhir kata
						 * param false untuk disable escaping (karena pake subquery)
						 */
						$this->db->or_like('(CASE WHEN t_transaksi.id_member is null THEN \'Reguler\' ELSE \'Member\' END)', $_POST['search']['value'],'both',false);
					}
					elseif($item == 'status_kunci') {
						/**
						 * param both untuk wildcard pada awal dan akhir kata
						 * param false untuk disable escaping (karena pake subquery)
						 */
						$this->db->or_like('(CASE WHEN t_transaksi.is_kunci = 1 THEN \'Terkunci\' ELSE \'Terbuka\' END)', $_POST['search']['value'],'both',false);
					}
					else{
						$this->db->or_like($item, $_POST['search']['value']);
					}
				}
				//last loop
				if(count($this->column_search_p) - 1 == $i) 
					$this->db->group_end(); //close bracket
			}
			$i++;
		}

		if(isset($_POST['order'])) // here order processing
		{
			$this->db->order_by($this->column_order_p[$_POST['order']['0']['column']], $_POST['order']['0']['dir']);
		} 
		else if(isset($this->order_p))
		{
			$order = $this->order_p;
            $this->db->order_by(key($order), $order[key($order)]);
		}
	}

	function count_filtered_penjualan($tgl_awal, $tgl_akhir)
	{
		$this->_get_datatable_penjualan_query($tgl_awal, $tgl_akhir);
		$query = $this->db->get();
		return $query->num_rows();
	}

	public function count_all_penjualan($tgl_awal, $tgl_akhir)
	{
		$this->db->from($this->table);
		$this->db->where($this->table.'.created_at >=' ,$tgl_awal);
		$this->db->where($this->table.'.created_at <=' ,$tgl_akhir);
		$this->db->where($this->table.'.deleted_at is null');
		return $this->db->count_all_results();
	}
	###################################### end datatable penjualan
	

	public function get_detail_penjualan($id)
	{
		$this->db->select('
			t_transaksi.*,
			t_transaksi_det.id_item_trans,
			t_transaksi_det.harga_satuan,
			t_transaksi_det.is_disc_jual,
			t_transaksi_det.ket_disc_jual,
			m_item_trans.nama as nama_item,
            m_member.kode_member,
			m_member.nama as nama_member,
			CASE WHEN t_transaksi.id_member is null THEN \'Reguler\' ELSE \'Member\' END as jenis_member,
            m_user.nama
		');

		$this->db->from('t_transaksi');
		$this->db->join('t_transaksi_det', 't_transaksi.id = t_transaksi_det.id_transaksi', 'left');
		$this->db->join('m_item_trans', 't_transaksi_det.id_item_trans = m_item_trans.id', 'left');
        $this->db->join('m_member', 't_transaksi.id_member = m_member.id', 'left');
		$this->db->join('m_user', 't_transaksi.id_user = m_user.id', 'left');
		$this->db->where('t_transaksi.id', $id);
		$query = $this->db->get();

		if($query) {
			return $query->result();
		}else{
			return false;
		}
	}

	
}