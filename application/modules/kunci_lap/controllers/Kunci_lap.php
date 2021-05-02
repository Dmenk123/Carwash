<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Kunci_lap extends CI_Controller {
	
	public function __construct()
	{
		parent::__construct();
		if($this->session->userdata('logged_in') === false) {
			return redirect('login');
		}

		$this->load->model('t_log_kunci');
		$this->load->model('m_user');
		$this->load->model('m_global');
		$this->load->model('set_role/m_set_role', 'm_role');
	}

	public function index()
	{
		$id_user = $this->session->userdata('id_user'); 
		$data_user = $this->m_user->get_detail_user($id_user);
		$data_role = $this->m_role->get_data_all(['aktif' => '1'], 'm_role');
			
		/**
		 * data passing ke halaman view content
		 */
		$data = array(
			'title' => 'Kunci Laporan',
			'data_user' => $data_user,
			'data_role'	=> $data_role
		);

		/**
		 * content data untuk template
		 * param (css : link css pada direktori assets/css_module)
		 * param (modal : modal komponen pada modules/nama_modul/views/nama_modal)
		 * param (js : link js pada direktori assets/js_module)
		 */
		$content = [
			'css' 	=> null,
			'modal' => 'modal_kunci_lap',
			'js'	=> 'kunci_lap.js',
			'view'	=> 'view_kunci_lap'
		];

		$this->template_view->load_view($content, $data);
	}

	public function list_kunci_laporan()
	{
		$list = $this->t_log_kunci->get_datatable_log_kunci();
		$data = array();
		$no =$_POST['start'];
		foreach ($list as $val) {
			$no++;
			$row = array();
			//loop value tabel db
			$row[] = $no;
			$row[] = $val->bulan;
			$row[] = $val->tahun;
			$row[] = $val->nama;
			$row[] = $val->created_at;
			
			$str_aksi = '
				
						<button class="btn btn-sm btn-danger" onclick="delete_kuncian(\''.$val->id.'\')">
							<i class="la la-trash"></i> Hapus
						</button>
			';


			$str_aksi .= '</div></div>';
			$row[] = $str_aksi;

			$data[] = $row;
		}//end loop

		$output = [
			"draw" => $_POST['draw'],
			"recordsTotal" => $this->t_log_kunci->count_all(),
			"recordsFiltered" => $this->t_log_kunci->count_filtered(),
			"data" => $data
		];
		
		echo json_encode($output);
	}

	public function add_kunci_lap()
	{
		$this->load->library('Enkripsi');
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		
		$arr_valid = $this->rule_validasi();
		
		$bulan = (int)$this->input->post('bulan');
		$tahun = (int)$this->input->post('tahun');
		$id_user = $this->session->userdata('id_user');

		$cek = $this->m_global->single_row('*', ['bulan' => $bulan, 'tahun' => $tahun, 'deleted_at' => null], 't_log_kunci');
		if($cek) {
			$retval['status'] = false;
			$retval['pesan'] = 'Bulan dan Tahun sudah terkunci !!!';
			$retval['is_exist'] = true;
			echo json_encode($retval);
			return;
		}

		if ($arr_valid['status'] == FALSE) {
			echo json_encode($arr_valid);
			return;
		}

		$this->db->trans_begin();
		
		$data_ins = [
			'bulan' => $bulan,
			'tahun' => $tahun,
			'id_user' => $id_user,
			'created_at' => $timestamp
		];
		
		$insert = $this->t_log_kunci->save($data_ins);

		$data_log = json_encode($data_ins);
		$this->lib_fungsi->catat_log_aktifitas('CREATE', null, $data_log);
		
		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['status'] = false;
			$retval['pesan'] = 'Gagal menambahkan Kunci Laporan';
		}else{
			$this->db->trans_commit();
			$retval['status'] = true;
			$retval['pesan'] = 'Sukses menambahkan Kunci Laporan';
		}

		echo json_encode($retval);
	}

	
	/**
	 * Hanya melakukan softdelete saja
	 * isi kolom updated_at dengan datetime now()
	 */
	public function delete_kunci_lap()
	{
		$id = $this->input->post('id');
		$old_data = $this->m_global->single_row_array('*', ['id' => $id], 't_log_kunci');
		$del = $this->t_log_kunci->softdelete_by_id($id);
		
		$data_log_old = json_encode($old_data);
		$this->lib_fungsi->catat_log_aktifitas('DELETE', $data_log_old, null);
		if($del) {
			$retval['status'] = TRUE;
			$retval['pesan'] = 'Data Kuncian dihapus';
		}else{
			$retval['status'] = FALSE;
			$retval['pesan'] = 'Data Kuncian dihapus';
		}

		echo json_encode($retval);
	}

	

	// ===============================================
	private function rule_validasi()
	{
		$data = array();
		$data['error_string'] = array();
		$data['inputerror'] = array();
		$data['status'] = TRUE;

		if ($this->input->post('tahun') == '') {
			$data['inputerror'][] = 'tahun';
			$data['error_string'][] = 'Wajib mengisi tahun';
			$data['status'] = FALSE;
		}

		if ($this->input->post('bulan') == '') {
			$data['inputerror'][] = 'bulan';
			$data['error_string'][] = 'Wajib mengisi bulan';
			$data['status'] = FALSE;
		}
	

        return $data;
	}

	private function seoUrl($string) {
	    //Lower case everything
	    $string = strtolower($string);
	    //Make alphanumeric (removes all other characters)
	    $string = preg_replace("/[^a-z0-9_\s-]/", "", $string);
	    //Clean up multiple dashes or whitespaces
	    $string = preg_replace("/[\s-]+/", " ", $string);
	    //Convert whitespaces and underscore to dash
	    $string = preg_replace("/[\s_]/", "-", $string);
	    return $string;
	}
}
