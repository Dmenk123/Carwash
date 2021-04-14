<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Master_supplier extends CI_Controller {
	
	public function __construct()
	{
		parent::__construct();
		if($this->session->userdata('logged_in') === false) {
			return redirect('login');
		}

		$this->load->model('m_member');
		$this->load->model('m_user');
		$this->load->model('m_global');
		$this->load->model('set_role/m_set_role', 'm_role');
	}

	public function get_select_supplier()
	{
		$term = $this->input->get('term');
		$data = $this->m_global->multi_row('*', ['deleted_at' => null, 'nama_supplier like' => '%'.$term.'%'], 'm_supplier', null, 'nama_supplier');
		if($data) {
			foreach ($data as $key => $value) {
				$row['id'] = $value->id;
				$row['text'] = $value->nama_supplier;
				$retval[] = $row;
			}
		}else{
			$retval = false;
		}
		echo json_encode($retval);
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
			'title' => 'Pengelolaan Data Member',
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
			'modal' => 'modal_master_member',
			'js'	=> 'master_member.js',
			'view'	=> 'view_master_member'
		];

		$this->template_view->load_view($content, $data);
	}

	public function list_member()
	{
		$list = $this->m_member->get_datatable_user();
		$data = array();
		$no =$_POST['start'];
		foreach ($list as $member) {
			$no++;
			$row = array();
			//loop value tabel db
			$row[] = $no;
			$row[] = $member->kode_member;
			$row[] = $member->nama;
			$row[] = $member->alamat;
			$row[] = $member->email;
			$row[] = $member->hp;
			$jk = ($member->jenis_kelamin == 'L') ? 'Laki-laki' : 'Perempuan';
			$row[] = $jk;
			$row[] = $member->counter_diskon;

			
			$str_aksi = '
				<div class="btn-group">
					<button type="button" class="btn btn-sm btn_1 dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> Opsi</button>
					<div class="dropdown-menu">
						<button class="dropdown-item" onclick="edit_member(\''.$member->id.'\')">
							<i class="la la-pencil"></i> Edit Member
						</button>
						<button class="dropdown-item" onclick="delete_member(\''.$member->id.'\')">
							<i class="la la-trash"></i> Hapus
						</button>
			';


			$str_aksi .= '</div></div>';
			$row[] = $str_aksi;

			$data[] = $row;
		}//end loop

		$output = [
			"draw" => $_POST['draw'],
			"recordsTotal" => $this->m_member->count_all(),
			"recordsFiltered" => $this->m_member->count_filtered(),
			"data" => $data
		];
		
		echo json_encode($output);
	}

	public function edit_member()
	{
		$this->load->library('Enkripsi');
		$id_user = $this->session->userdata('id_user');
		$data_user = $this->m_user->get_by_id($id_user);
	
		$id = $this->input->post('id');
		//$oldData = $this->m_user->get_by_id($id);

		$where = ['m_member.id' => $id];

		$oldData = $this->m_global->getSelectedData('m_member', $where)->row();
		if(!$oldData){
			return redirect($this->uri->segment(1));
		}
		// var_dump($oldData);exit;
		if($oldData->img_foto) {
			$url_foto = base_url('upload/member/').$oldData->img_foto;
		}else{
			$url_foto = base_url('upload/member/user_default.png');
		}
		
		$foto = base64_encode(file_get_contents($url_foto));  
		
		$data = array(
			'data_user' => $data_user,
			'old_data'	=> $oldData,
			'foto_encoded' => $foto
		);
		
		echo json_encode($data);
	}

	
	/**
	 * Hanya melakukan softdelete saja
	 * isi kolom updated_at dengan datetime now()
	 */
	public function delete_member()
	{
		$id = $this->input->post('id');
		$del = $this->m_member->softdelete_by_id($id);
		if($del) {
			$retval['status'] = TRUE;
			$retval['pesan'] = 'Data Master Member dihapus';
		}else{
			$retval['status'] = FALSE;
			$retval['pesan'] = 'Data Master Member dihapus';
		}

		echo json_encode($retval);
	}

	

	// ===============================================
	private function rule_validasi($is_update=false, $skip_pass=false)
	{
		$data = array();
		$data['error_string'] = array();
		$data['inputerror'] = array();
		$data['status'] = TRUE;

		if ($this->input->post('nama') == '') {
			$data['inputerror'][] = 'nama';
			$data['error_string'][] = 'Wajib mengisi Nama';
			$data['status'] = FALSE;
		}

		if ($this->input->post('kode_member') == '') {
			$data['inputerror'][] = 'kode_member';
			$data['error_string'][] = 'Wajib mengisi Kode Member';
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
