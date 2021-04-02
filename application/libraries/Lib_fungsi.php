<?php
class Lib_fungsi extends CI_Controller {
    protected $_ci;
    
    function __construct(){
        $this->_ci = &get_instance();
    }
    
	/**
	 * $aksi : AKSI LOG (STRING)
	 * $old_data : DATA SEBELUMNYA (JSON)
	 * $new_data : DATA BARU (JSON)
	 */
	function catat_log_aktifitas($aksi=null, $old_data = null, $new_data=null) {
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$id_user = $this->_ci->session->userdata('id_user');
		$menu = $this->_ci->uri->segment(1);
		$q_menu = $this->_ci->db->query("select * from m_menu where link = '$menu'")->row();
		
		if($q_menu) {
			$id_menu = $q_menu->id;
		}else{
			$id_menu = null;
		}

		$data = [
			'id' => gen_uuid(),
			'id_m_menu' => $id_menu,
			'id_m_user' => $id_user,
			'aksi' => $aksi,
			'old_data' => $old_data,
			'new_data' => $new_data,
			'created_at' => $timestamp
		];
		$this->_ci->db->insert('t_log_aktivitas', $data);
	}


	###################
	public function insert_counter($id_member, $counter_existing)
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');

		if($counter_existing == 10) {
			## set deleted_at pada id_member
			$update = $this->_ci->db->update('t_log_counter_member', ['deleted_at' => $timestamp], ['id_member' => $id_member]);
			if($update) {
				return TRUE;
			}else{
				return FALSE;
			}
		}else{
			$data = [
				'id_member' => $id_member,
				'created_at' => $timestamp
			];

			$ins = $this->_ci->db->insert('t_log_counter_member', $data);
			if($ins) {
				# update pada m_member
				$upd = $this->_ci->db->update('m_member', ['counter_diskon' => (int)$counter_existing+1], ['id'=>$id_member]);

				if($upd) {
					return TRUE;
				}else{
					return FALSE;
				}
			}
			return TRUE;
		}
		
	}
	function cek_counter($id_member) {
		$query = $this->_ci->db->query("select count(*) as total_count from t_log_counter_member where id_member = '$id_member' and deleted_at is null")->row();
		if($query) {
			$counter = $query->total_count;
		}else{
			$counter = 0;
		}

		## update pada m_member
		$this->_ci->db->update('m_member', ['counter_diskon' => $counter], ['id'=>$id_member]);

		return $counter;		
	}
}