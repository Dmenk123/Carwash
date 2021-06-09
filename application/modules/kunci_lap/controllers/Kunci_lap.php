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
		$this->load->model('t_transaksi');
		$this->load->model('t_transaksi_det');
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
		
		$data_ins = [
			'bulan' => $bulan,
			'tahun' => $tahun,
			'id_user' => $id_user,
			'created_at' => $timestamp
		];
		
		$insert_id = $this->t_log_kunci->save($data_ins);

		$simpan_log = $this->simpan_log_laporan($bulan, $tahun, $insert_id);
		if($simpan_log) {
			$data_log = json_encode($data_ins);
			$this->lib_fungsi->catat_log_aktifitas('CREATE', null, $data_log);
			$retval['status'] = true;
			$retval['pesan'] = 'Sukses menambahkan Kunci Laporan';
		}else{
			$retval['status'] = false;
			$retval['pesan'] = 'Gagal menambahkan Kunci Laporan';
		}
		
		echo json_encode($retval);
	}

	private function simpan_log_laporan($bulan, $tahun, $id_log_kunci) {
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$this->db->trans_begin();
		
		### cek log bulan_terpilih, jika ada set deleted_at
		$cek_exist = $this->m_global->single_row('*', ['bulan' => $bulan, 'tahun' => $tahun, 'deleted_at' => null], 't_log_laporan');
		if($cek_exist) {
			$id_exist = $cek_exist->id;
			// update t_log_laporan
			$this->m_global->update('t_log_laporan', ['deleted_at' => $timestamp], ['id' => $id_exist]);
			// update t_log_laporan_det
			$this->m_global->update('t_log_laporan_det', ['deleted_at' => $timestamp], ['id_log_laporan' => $id_exist]);
		}

		$arr_periode = $this->ambil_periode_sebelum($bulan, $tahun);
		// cek saldo bulan sebelumnya untuk di olah 
		$cek_saldo = $this->m_global->single_row('*', ['bulan' => $arr_periode['bulan'], 'tahun' => $arr_periode['tahun'], 'deleted_at' => null], 't_log_laporan');
		if($cek_saldo) {
			// set saldo awal dari saldo akhir periode sebelumnya
			$saldo_fix = $cek_saldo->saldo_akhir;
		}else{
			//jika tidak ada terpaksa dihitung semua transaksi hingga sebelum bulan laporan terpilih
			$q_saldo = $this->t_transaksi->cari_saldo_by_hitung($bulan, $tahun);				
			
			if($q_saldo->saldo && (float)$q_saldo->saldo > 0) {
				$saldo_fix = (float)$q_saldo->saldo;
			}else{
				$saldo_fix = 'kosong';
			}

		}

		$data_laporan = $this->t_transaksi->get_laporan_keuangan($bulan, $tahun);
		
		// insert header
		$id_header = $this->m_global->last_id('id', 't_log_laporan');
		$data_ins = [
			'id' => $id_header,
			'id_user' => $this->session->userdata('id_user'),
			'bulan' => $bulan,
			'tahun' => $tahun,
			'id_log_kunci' => $id_log_kunci,
			'saldo_awal' => (float)$saldo_fix,
			'saldo_akhir' => 0,
			'created_at' => $timestamp
		];

		$this->m_global->store($data_ins, 't_log_laporan');
		
		// loop data_detail
		$tot_penerimaan = 0;
		$tot_pengeluaran = 0;

		if($saldo_fix == 'kosong') {
			// hasil hitungan
			$saldonya = 0;
		}else{
			// hasil hitungan
			$saldonya = (float)$saldo_fix;
		}

		$data_ins_det_row_1 = [
			'id' => $this->m_global->last_id('id', 't_log_laporan_det'),
			'id_log_laporan' => $id_header,
			'harga_total' => null,
			'id_jenis_trans' => null,
			'kode_trans' => null,
			'urut' => 0,
			'penerimaan' => 0,
			'pengeluaran' => 0,
			'saldo_akhir' => $saldonya,
			'created_at' => $timestamp
		];

		$this->m_global->store($data_ins_det_row_1, 't_log_laporan_det');

		foreach ($data_laporan as $key => $value) {
			$penerimaan = 0;
			$pengeluaran = 0;

			if($value->cashflow == 'in') {
				$saldonya += $value->total_harga;
				$penerimaan = $value->total_harga;
				$tot_penerimaan += $value->total_harga;
			}else{
				$saldonya -= $value->total_harga;
				$pengeluaran = $value->total_harga;
				$tot_pengeluaran += $value->total_harga;
			}

			$data_ins_det = [
				'id' => $this->m_global->last_id('id', 't_log_laporan_det'),
				'id_log_laporan' => $id_header,
				'harga_total' => $value->total_harga,
				'id_jenis_trans' => $value->id_jenis_trans,
				'kode_trans' => $value->kode_jenis,
				'urut' => $key+1,
				'penerimaan' => (float)$penerimaan,
				'pengeluaran' => (float)$pengeluaran,
				'saldo_akhir' => (float)$saldonya,
				'created_at' => $timestamp
			];

			$this->m_global->store($data_ins_det, 't_log_laporan_det');
		}

		// saldo akhir untuk diupdate pada tabel header
		$saldo_akhir_fix = $saldo_fix + $tot_penerimaan - $tot_pengeluaran;
		$this->m_global->update('t_log_laporan', ['saldo_akhir' => (float)$saldo_akhir_fix], ['id' => $id_header]);

		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			return false;
		}else{
			$this->db->trans_commit();
			return true;
		}
	}

	private function ambil_periode_sebelum($bulan, $tahun)
	{
		$objDate = new DateTime($tahun.'-'.$bulan.'-01');
		$tgl_fix =  $objDate->modify('-1 month')->format('Y-m-d');
		$bulan = $objDate->createFromFormat('Y-m-d', $tgl_fix)->format('m');
		$tahun = $objDate->createFromFormat('Y-m-d', $tgl_fix)->format('Y');
		return [
			'bulan' => (int)$bulan,
			'tahun' => (int)$tahun
		];
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
