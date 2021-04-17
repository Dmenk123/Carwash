<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Trans_lain extends CI_Controller {
	const ID_JENIS_TRANS = 1;

	public function __construct()
	{
		parent::__construct();
		if($this->session->userdata('logged_in') === false) {
			return redirect('login');
		}

		$this->load->model('m_user');
		$this->load->model('m_global');
		$this->load->model('t_transaksi');
		$this->load->model('t_transaksi_det');
	}

	######################################### BASE FUNCTION ############################################
	public function index()
	{
		$id_user = $this->session->userdata('id_user'); 
		$data_user = $this->m_user->get_detail_user($id_user);
		$list_transaksi = $this->m_global->multi_row('*', ['kode_jenis <>' => 'A-01', 'deleted_at' => null], 'm_jenis_trans', NULL, 'kode_jenis');
		
		/**
		 * data passing ke halaman view content
		 */
		$data = array(
			'title' => 'Transaksi Lain-Lain',
			'data_user' => $data_user,
			'list_transaksi' => $list_transaksi,
		);

		/**
		 * content data untuk template
		 * param (css : link css pada direktori assets/css_module)
		 * param (modal : modal komponen pada modules/nama_modul/views/nama_modal)
		 * param (js : link js pada direktori assets/js_module)
		 */
		$content = [
			'css' 	=> null,
			'modal' => ['modal_pembelian','modal_penggajian', 'modal_investasi', 'modal_operasional', 'modal_out_lain', 'modal_in_lain'],
			'js'	=> ['trans_lain.js', 'pembelian.js', 'penggajian.js', 'investasi.js', 'operasional.js', 'out_lain.js', 'in_lain.js'],
			'view'	=> 'view_trans_lain'
		];

		$this->template_view->load_view($content, $data);
	}

	private function clean_txt_div($text)
	{
		$slug = $text;
		$slug = str_ireplace('div-', "", $slug);
		$slug = str_ireplace('-modal', "", $slug);

		return $slug;
	}

	public function get_old_data()
	{
		$txt_div_modal = $this->input->post('menu');
		$slug = $this->clean_txt_div($this->input->post('menu'));
		$q_jenis = $this->m_global->single_row('*', ['slug' => $slug], 'm_jenis_trans');

		$select = "t_transaksi.*, t_transaksi_det.harga_satuan, m_item_trans.nama as nama_item, t_transaksi_det.qty";
		$where = ['t_transaksi.deleted_at' => null, 't_transaksi.id_jenis_trans' => $q_jenis->id];
		$table = 't_transaksi';
		$join = [ 
			['table' => 't_transaksi_det', 'on' => 't_transaksi.id = t_transaksi_det.id_transaksi'],
			['table' => 'm_item_trans', 'on' => 't_transaksi_det.id_item_trans = m_item_trans.id']
		];
	
		$datanya = $this->m_global->multi_row($select,$where,$table, $join);
		
		switch ($slug) {
			case 'pembelian':	
				echo json_encode(['data' => $datanya, 'status' => true, 'menu' => $slug]);
				break;

			case 'penggajian':			
				echo json_encode(['data'=>$datanya, 'status' => true, 'menu' => $slug]);
				break;
			
			case 'investasi':
				echo json_encode(['data'=>$datanya, 'status' => true, 'menu' => $slug]);
				break;

			case 'operasional':
				echo json_encode(['data'=>$datanya, 'status' => true, 'menu' => $slug]);
				break;

			case 'pengeluaran-lain-lain':
				echo json_encode(['data'=>$datanya, 'status' => true, 'menu' => $slug]);
				break;

			case 'penerimaan-lain-lain':
				echo json_encode(['data'=>$datanya, 'status' => true, 'menu' => $slug]);
				break;
						
			default:
				$datanya = null;
				echo json_encode(['data'=> null, 'status' => false, 'menu' => false]);
				break;
		}
	}
	######################################### END BASE FUNCTION ############################################

	################################ PEMBELIAN AREA #############################################
	private function rule_validasi_pembelian()
	{
		$data = array();
		$data['error_string'] = array();
		$data['inputerror'] = array();
		$data['status'] = TRUE;

		if ($this->input->post('item_beli') == '') {
			$data['inputerror'][] = 'item_beli';
			$data['error_string'][] = 'Wajib Mengisi Pembelian';
			$data['status'] = FALSE;
			$data['is_select2'][] = TRUE;
		}

		if ($this->input->post('sup_beli') == '') {
			$data['inputerror'][] = 'sup_beli';
			$data['error_string'][] = 'Wajib Mengisi Supplier';
			$data['status'] = FALSE;
			$data['is_select2'][] = TRUE;
		}

		if ($this->input->post('qty_beli') == '') {
			$data['inputerror'][] = 'qty_beli';
			$data['error_string'][] = 'Wajib Mengisi qty';
			$data['status'] = FALSE;
			$data['is_select2'][] = FALSE;
		}

		if ($this->input->post('harga_beli') == '') {
			$data['inputerror'][] = 'harga_beli';
			$data['error_string'][] = 'Wajib Mengisi harga';
			$data['status'] = FALSE;
			$data['is_select2'][] = FALSE;
		}
			
        return $data;
	}
	
	public function simpan_form_pembelian()
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$datenow = $obj_date->format('Y-m-d');
		$arr_valid = $this->rule_validasi_pembelian();
		
		if ($arr_valid['status'] == FALSE) {
			echo json_encode($arr_valid);
			return;
		}

		$this->db->trans_begin();
		$id_header = gen_uuid();
		$slug_trans = $this->input->post('slug_trans');
		$item_beli = $this->input->post('item_beli');
		$sup_beli = $this->input->post('sup_beli');
		$qty_beli = $this->input->post('qty_beli');
		$harga_beli = $this->input->post('harga_beli_raw');
		$hargatot_beli = $this->input->post('hargatot_beli_raw');
		$cek_jenis = $this->m_global->single_row('id', ['slug' => $slug_trans], 'm_jenis_trans');
		###insert
		$data = [
			'id' => $id_header,
			'id_jenis_trans' => $cek_jenis->id,
			'id_supplier' => $sup_beli,
			'harga_total' => $hargatot_beli,
			'id_user' => $this->session->userdata('id_user'),
			'created_at' => $timestamp
		];
					
		$insert = $this->m_global->store($data, 't_transaksi');

		if($insert){
			$data_det = [
				'id' => gen_uuid(),
				'id_transaksi' => $id_header,
				'id_item_trans' => $item_beli,
				'harga_satuan' => $harga_beli,
				'qty' => $qty_beli,
				'created_at' => $timestamp
			];
						
			$insert_det = $this->m_global->store($data_det, 't_transaksi_det');
		}
		
		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['status'] = false;
			$retval['pesan'] = 'Gagal Menambah Data';
		}else{
			$this->db->trans_commit();
			$retval['status'] = true;
			$retval['pesan'] = 'Sukses Menambah Data';
		}

		echo json_encode($retval);
	}

	public function load_form_tabel_pembelian()
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$data = $this->input->post('data');
		
		$html = '';
		
		if($data){
			foreach ($data as $key => $value) {
				$html .= '<tr><td>'.($key+1).'</td><td>'.$obj_date->createFromFormat('Y-m-d H:i:s', $value['created_at'])->format('d-m-Y').'</td><td>'.$value['nama_item'].'</td><td align="right">'.number_format($value['harga_satuan'],0,',','.').'</td><td>'.number_format($value['qty'],0,',','.').'</td><td align="right">'.number_format($value['harga_total'],0,',','.').'</td><td><button type="button" class="btn btn-sm btn-danger" onclick="hapus_pembelian(\''.$value['id'].'\')"><i class="la la-trash"></i></button></td></tr>';
			}
		}else{
			$slug = $this->clean_txt_div($this->input->post('activeModal'));
			$q_jenis = $this->m_global->single_row('*', ['slug' => $slug], 'm_jenis_trans');

			$select = "t_transaksi.*, m_item_trans.nama as nama_item, t_transaksi_det.qty, t_transaksi_det.harga_satuan";
			$where = ['t_transaksi.deleted_at' => null, 't_transaksi.id_jenis_trans' => $q_jenis->id];
			$table = 't_transaksi';
			$join = [ 
				['table' => 't_transaksi_det', 'on' => 't_transaksi.id = t_transaksi_det.id_transaksi'],
				['table' => 'm_item_trans', 'on' => 't_transaksi_det.id_item_trans = m_item_trans.id']
			];
		
			$datanya = $this->m_global->multi_row($select,$where,$table, $join);

			if($datanya){
				foreach ($datanya as $key => $value) {
					$html .= '<tr><td>'.($key+1).'</td><td>'.$obj_date->createFromFormat('Y-m-d H:i:s', $value->created_at)->format('d-m-Y').'</td><td>'.$value->nama_item.'</td><td align="right">'.number_format($value->harga_satuan,0,',','.').'</td><td>'.number_format($value->qty,0,',','.').'</td><td align="right">'.number_format($value->harga_total,0,',','.').'</td><td><button type="button" class="btn btn-sm btn-danger" onclick="hapus_pembelian(\''.$value->id.'\')"><i class="la la-trash"></i></button></td></tr>';
				}
			}
		}

		echo json_encode([
			'html' => $html
		]);
	}

	public function delete_data_pembelian()
	{
		$id = $this->input->post('id');
		$this->db->trans_begin();
		
		$del_1 = $this->t_transaksi_det->softdelete_by_trans($id);
		$del_2 = $this->t_transaksi->softdelete_by_id($id);

		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['status'] = false;
			$retval['pesan'] = 'Gagal Menghapus Data';
		}else{
			$this->db->trans_commit();
			$retval['status'] = true;
			$retval['pesan'] = 'Sukses Menghapus Data';
		}

		echo json_encode($retval);
	}
	################################ END PEMBELIAN AREA #############################################

	################################ PENGGAJIAN AREA #############################################
	private function rule_validasi_penggajian()
	{
		$data = array();
		$data['error_string'] = array();
		$data['inputerror'] = array();
		$data['status'] = TRUE;

		if ($this->input->post('item_gaji') == '') {
			$data['inputerror'][] = 'item_gaji';
			$data['error_string'][] = 'Wajib Mengisi Gaji';
			$data['status'] = FALSE;
			$data['is_select2'][] = TRUE;
		}

		if ($this->input->post('tahun_gaji') == '') {
			$data['inputerror'][] = 'tahun_gaji';
			$data['error_string'][] = 'Wajib Mengisi Tahun Gaji';
			$data['status'] = FALSE;
			$data['is_select2'][] = TRUE;
		}

		if ($this->input->post('bulan_gaji') == '') {
			$data['inputerror'][] = 'bulan_gaji';
			$data['error_string'][] = 'Wajib Mengisi Bulan Gaji';
			$data['status'] = FALSE;
			$data['is_select2'][] = FALSE;
		}

		if ($this->input->post('harga_gaji') == '') {
			$data['inputerror'][] = 'harga_gaji';
			$data['error_string'][] = 'Wajib Mengisi Nilai Gaji Total';
			$data['status'] = FALSE;
			$data['is_select2'][] = FALSE;
		}
			
        return $data;
	}
	
	public function simpan_form_penggajian()
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$datenow = $obj_date->format('Y-m-d');
		$arr_valid = $this->rule_validasi_penggajian();
		
		if ($arr_valid['status'] == FALSE) {
			echo json_encode($arr_valid);
			return;
		}

		$this->db->trans_begin();
		$id_header = gen_uuid();
		$slug_trans = $this->input->post('slug_trans');
		$item_gaji = $this->input->post('item_gaji');
		$tahun = $this->input->post('tahun_gaji');
		$bulan = $this->input->post('bulan_gaji');
		$total_gaji = $this->input->post('harga_gaji_raw');
		
		$cek_jenis = $this->m_global->single_row('id', ['slug' => $slug_trans], 'm_jenis_trans');
		###insert
		$data = [
			'id' => $id_header,
			'id_jenis_trans' => $cek_jenis->id,
			'bulan_gaji' => $bulan,
			'tahun_gaji' => $tahun,
			'harga_total' => $total_gaji,
			'id_user' => $this->session->userdata('id_user'),
			'created_at' => $timestamp
		];
					
		$insert = $this->m_global->store($data, 't_transaksi');

		if($insert){
			$data_det = [
				'id' => gen_uuid(),
				'id_transaksi' => $id_header,
				'id_item_trans' => $item_gaji,
				'harga_satuan' => $total_gaji,
				'qty' => 1,
				'created_at' => $timestamp
			];
						
			$insert_det = $this->m_global->store($data_det, 't_transaksi_det');
		}
		
		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['status'] = false;
			$retval['pesan'] = 'Gagal Menambah Data';
		}else{
			$this->db->trans_commit();
			$retval['status'] = true;
			$retval['pesan'] = 'Sukses Menambah Data';
		}

		echo json_encode($retval);
	}

	public function load_form_tabel_penggajian()
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$data = $this->input->post('data');
		
		$html = '';
		
		if($data){
			foreach ($data as $key => $value) {
				$html .= '<tr><td>'.($key+1).'</td><td>'.$obj_date->createFromFormat('Y-m-d H:i:s', $value['created_at'])->format('d-m-Y').'</td><td>'.$value['nama_item'].'</td><td align="right">'.bulan_indo($value['bulan_gaji']).'</td><td>'.$value['tahun_gaji'].'</td><td align="right">'.number_format($value['harga_total'],0,',','.').'</td><td><button type="button" class="btn btn-sm btn-danger" onclick="hapus_penggajian(\''.$value['id'].'\')"><i class="la la-trash"></i></button></td></tr>';
			}
		}else{
			$slug = $this->clean_txt_div($this->input->post('activeModal'));
			$q_jenis = $this->m_global->single_row('*', ['slug' => $slug], 'm_jenis_trans');

			$select = "t_transaksi.*, m_item_trans.nama as nama_item, t_transaksi_det.qty, t_transaksi_det.harga_satuan";
			$where = ['t_transaksi.deleted_at' => null, 't_transaksi.id_jenis_trans' => $q_jenis->id];
			$table = 't_transaksi';
			$join = [ 
				['table' => 't_transaksi_det', 'on' => 't_transaksi.id = t_transaksi_det.id_transaksi'],
				['table' => 'm_item_trans', 'on' => 't_transaksi_det.id_item_trans = m_item_trans.id']
			];
		
			$datanya = $this->m_global->multi_row($select,$where,$table, $join);

			if($datanya){
				foreach ($datanya as $key => $value) {
					$html .= '<tr><td>'.($key+1).'</td><td>'.$obj_date->createFromFormat('Y-m-d H:i:s', $value->created_at)->format('d-m-Y').'</td><td>'.$value->nama_item.'</td><td align="right">'.bulan_indo($value->bulan_gaji).'</td><td>'.$value->tahun_gaji.'</td><td align="right">'.number_format($value->harga_total,0,',','.').'</td><td><button type="button" class="btn btn-sm btn-danger" onclick="hapus_penggajian(\''.$value->id.'\')"><i class="la la-trash"></i></button></td></tr>';
				}
			}
		}

		echo json_encode([
			'html' => $html
		]);
	}

	public function delete_data_penggajian()
	{
		$id = $this->input->post('id');
		$this->db->trans_begin();
		
		$del_1 = $this->t_transaksi_det->softdelete_by_trans($id);
		$del_2 = $this->t_transaksi->softdelete_by_id($id);

		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['status'] = false;
			$retval['pesan'] = 'Gagal Menghapus Data';
		}else{
			$this->db->trans_commit();
			$retval['status'] = true;
			$retval['pesan'] = 'Sukses Menghapus Data';
		}

		echo json_encode($retval);
	}
	################################ END PENGGAJIAN AREA #############################################

	################################ INVESTASI AREA #############################################
	private function rule_validasi_investasi()
	{
		$data = array();
		$data['error_string'] = array();
		$data['inputerror'] = array();
		$data['status'] = TRUE;

		if ($this->input->post('item_inves') == '') {
			$data['inputerror'][] = 'item_inves';
			$data['error_string'][] = 'Wajib Mengisi Investasi';
			$data['status'] = FALSE;
			$data['is_select2'][] = TRUE;
		}

		if ($this->input->post('tahun_op') == '') {
			$data['inputerror'][] = 'tahun_op';
			$data['error_string'][] = 'Wajib Mengisi Tahun';
			$data['status'] = FALSE;
			$data['is_select2'][] = TRUE;
		}

		if ($this->input->post('bulan_inves') == '') {
			$data['inputerror'][] = 'bulan_inves';
			$data['error_string'][] = 'Wajib Mengisi Bulan';
			$data['status'] = FALSE;
			$data['is_select2'][] = FALSE;
		}

		if ($this->input->post('harga_inves') == '') {
			$data['inputerror'][] = 'harga_inves';
			$data['error_string'][] = 'Wajib Mengisi Nilai Investasi';
			$data['status'] = FALSE;
			$data['is_select2'][] = FALSE;
		}
			
        return $data;
	}
	
	public function simpan_form_investasi()
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$datenow = $obj_date->format('Y-m-d');
		$arr_valid = $this->rule_validasi_investasi();
		
		if ($arr_valid['status'] == FALSE) {
			echo json_encode($arr_valid);
			return;
		}

		$this->db->trans_begin();
		$id_header = gen_uuid();
		$slug_trans = $this->input->post('slug_trans');
		$item_inves = $this->input->post('item_inves');
		$tahun = $this->input->post('tahun_inves');
		$bulan = $this->input->post('bulan_inves');
		$total_inves = $this->input->post('harga_inves_raw');
		
		$cek_jenis = $this->m_global->single_row('id', ['slug' => $slug_trans], 'm_jenis_trans');
		###insert
		$data = [
			'id' => $id_header,
			'id_jenis_trans' => $cek_jenis->id,
			'bulan_gaji' => $bulan,
			'tahun_gaji' => $tahun,
			'harga_total' => $total_inves,
			'id_user' => $this->session->userdata('id_user'),
			'created_at' => $timestamp
		];
					
		$insert = $this->m_global->store($data, 't_transaksi');

		if($insert){
			$data_det = [
				'id' => gen_uuid(),
				'id_transaksi' => $id_header,
				'id_item_trans' => $item_inves,
				'harga_satuan' => $total_inves,
				'qty' => 1,
				'created_at' => $timestamp
			];
						
			$insert_det = $this->m_global->store($data_det, 't_transaksi_det');
		}
		
		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['status'] = false;
			$retval['pesan'] = 'Gagal Menambah Data';
		}else{
			$this->db->trans_commit();
			$retval['status'] = true;
			$retval['pesan'] = 'Sukses Menambah Data';
		}

		echo json_encode($retval);
	}

	public function load_form_tabel_investasi()
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$data = $this->input->post('data');
		
		$html = '';
		
		if($data){
			foreach ($data as $key => $value) {
				$html .= '<tr><td>'.($key+1).'</td><td>'.$obj_date->createFromFormat('Y-m-d H:i:s', $value['created_at'])->format('d-m-Y').'</td><td>'.$value['nama_item'].'</td><td align="right">'.bulan_indo($value['bulan_gaji']).'</td><td>'.$value['tahun_gaji'].'</td><td align="right">'.number_format($value['harga_total'],0,',','.').'</td><td><button type="button" class="btn btn-sm btn-danger" onclick="hapus_investasi(\''.$value['id'].'\')"><i class="la la-trash"></i></button></td></tr>';
			}
		}else{
			$slug = $this->clean_txt_div($this->input->post('activeModal'));
			$q_jenis = $this->m_global->single_row('*', ['slug' => $slug], 'm_jenis_trans');

			$select = "t_transaksi.*, m_item_trans.nama as nama_item, t_transaksi_det.qty, t_transaksi_det.harga_satuan";
			$where = ['t_transaksi.deleted_at' => null, 't_transaksi.id_jenis_trans' => $q_jenis->id];
			$table = 't_transaksi';
			$join = [ 
				['table' => 't_transaksi_det', 'on' => 't_transaksi.id = t_transaksi_det.id_transaksi'],
				['table' => 'm_item_trans', 'on' => 't_transaksi_det.id_item_trans = m_item_trans.id']
			];
		
			$datanya = $this->m_global->multi_row($select,$where,$table, $join);

			if($datanya){
				foreach ($datanya as $key => $value) {
					$html .= '<tr><td>'.($key+1).'</td><td>'.$obj_date->createFromFormat('Y-m-d H:i:s', $value->created_at)->format('d-m-Y').'</td><td>'.$value->nama_item.'</td><td align="right">'.bulan_indo($value->bulan_gaji).'</td><td>'.$value->tahun_gaji.'</td><td align="right">'.number_format($value->harga_total,0,',','.').'</td><td><button type="button" class="btn btn-sm btn-danger" onclick="hapus_investasi(\''.$value->id.'\')"><i class="la la-trash"></i></button></td></tr>';
				}
			}
		}

		echo json_encode([
			'html' => $html
		]);
	}

	public function delete_data_investasi()
	{
		$id = $this->input->post('id');
		$this->db->trans_begin();
		
		$del_1 = $this->t_transaksi_det->softdelete_by_trans($id);
		$del_2 = $this->t_transaksi->softdelete_by_id($id);

		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['status'] = false;
			$retval['pesan'] = 'Gagal Menghapus Data';
		}else{
			$this->db->trans_commit();
			$retval['status'] = true;
			$retval['pesan'] = 'Sukses Menghapus Data';
		}

		echo json_encode($retval);
	}
	################################ END INVESTASI AREA #############################################

	################################ OPERASIONAL AREA #############################################
	private function rule_validasi_operasional()
	{
		$data = array();
		$data['error_string'] = array();
		$data['inputerror'] = array();
		$data['status'] = TRUE;

		if ($this->input->post('item_op') == '') {
			$data['inputerror'][] = 'item_op';
			$data['error_string'][] = 'Wajib Memilih Operasional';
			$data['status'] = FALSE;
			$data['is_select2'][] = TRUE;
		}

		if ($this->input->post('tahun_op') == '') {
			$data['inputerror'][] = 'tahun_op';
			$data['error_string'][] = 'Wajib Mengisi Tahun';
			$data['status'] = FALSE;
			$data['is_select2'][] = TRUE;
		}

		if ($this->input->post('bulan_op') == '') {
			$data['inputerror'][] = 'bulan_op';
			$data['error_string'][] = 'Wajib Mengisi Bulan';
			$data['status'] = FALSE;
			$data['is_select2'][] = FALSE;
		}

		if ($this->input->post('harga_op') == '') {
			$data['inputerror'][] = 'harga_op';
			$data['error_string'][] = 'Wajib Mengisi Nilai';
			$data['status'] = FALSE;
			$data['is_select2'][] = FALSE;
		}
			
        return $data;
	}
	
	public function simpan_form_operasional()
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$datenow = $obj_date->format('Y-m-d');
		$arr_valid = $this->rule_validasi_operasional();
		
		if ($arr_valid['status'] == FALSE) {
			echo json_encode($arr_valid);
			return;
		}

		$this->db->trans_begin();
		$id_header = gen_uuid();
		$slug_trans = $this->input->post('slug_trans');
		$item_op = $this->input->post('item_op');
		$tahun = $this->input->post('tahun_op');
		$bulan = $this->input->post('bulan_op');
		$total_op = $this->input->post('harga_op_raw');
		
		$cek_jenis = $this->m_global->single_row('id', ['slug' => $slug_trans], 'm_jenis_trans');
		###insert
		$data = [
			'id' => $id_header,
			'id_jenis_trans' => $cek_jenis->id,
			'bulan_gaji' => $bulan,
			'tahun_gaji' => $tahun,
			'harga_total' => $total_op,
			'id_user' => $this->session->userdata('id_user'),
			'created_at' => $timestamp
		];
					
		$insert = $this->m_global->store($data, 't_transaksi');

		if($insert){
			$data_det = [
				'id' => gen_uuid(),
				'id_transaksi' => $id_header,
				'id_item_trans' => $item_op,
				'harga_satuan' => $total_op,
				'qty' => 1,
				'created_at' => $timestamp
			];
						
			$insert_det = $this->m_global->store($data_det, 't_transaksi_det');
		}
		
		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['status'] = false;
			$retval['pesan'] = 'Gagal Menambah Data';
		}else{
			$this->db->trans_commit();
			$retval['status'] = true;
			$retval['pesan'] = 'Sukses Menambah Data';
		}

		echo json_encode($retval);
	}

	public function load_form_tabel_operasional()
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$data = $this->input->post('data');
		
		$html = '';
		
		if($data){
			foreach ($data as $key => $value) {
				$html .= '<tr><td>'.($key+1).'</td><td>'.$obj_date->createFromFormat('Y-m-d H:i:s', $value['created_at'])->format('d-m-Y').'</td><td>'.$value['nama_item'].'</td><td align="right">'.bulan_indo($value['bulan_gaji']).'</td><td>'.$value['tahun_gaji'].'</td><td align="right">'.number_format($value['harga_total'],0,',','.').'</td><td><button type="button" class="btn btn-sm btn-danger" onclick="hapus_operasional(\''.$value['id'].'\')"><i class="la la-trash"></i></button></td></tr>';
			}
		}else{
			$slug = $this->clean_txt_div($this->input->post('activeModal'));
			$q_jenis = $this->m_global->single_row('*', ['slug' => $slug], 'm_jenis_trans');

			$select = "t_transaksi.*, m_item_trans.nama as nama_item, t_transaksi_det.qty, t_transaksi_det.harga_satuan";
			$where = ['t_transaksi.deleted_at' => null, 't_transaksi.id_jenis_trans' => $q_jenis->id];
			$table = 't_transaksi';
			$join = [ 
				['table' => 't_transaksi_det', 'on' => 't_transaksi.id = t_transaksi_det.id_transaksi'],
				['table' => 'm_item_trans', 'on' => 't_transaksi_det.id_item_trans = m_item_trans.id']
			];
		
			$datanya = $this->m_global->multi_row($select,$where,$table, $join);

			if($datanya){
				foreach ($datanya as $key => $value) {
					$html .= '<tr><td>'.($key+1).'</td><td>'.$obj_date->createFromFormat('Y-m-d H:i:s', $value->created_at)->format('d-m-Y').'</td><td>'.$value->nama_item.'</td><td align="right">'.bulan_indo($value->bulan_gaji).'</td><td>'.$value->tahun_gaji.'</td><td align="right">'.number_format($value->harga_total,0,',','.').'</td><td><button type="button" class="btn btn-sm btn-danger" onclick="hapus_operasional(\''.$value->id.'\')"><i class="la la-trash"></i></button></td></tr>';
				}
			}
		}

		echo json_encode([
			'html' => $html
		]);
	}

	public function delete_data_operasional()
	{
		$id = $this->input->post('id');
		$this->db->trans_begin();
		
		$del_1 = $this->t_transaksi_det->softdelete_by_trans($id);
		$del_2 = $this->t_transaksi->softdelete_by_id($id);

		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['status'] = false;
			$retval['pesan'] = 'Gagal Menghapus Data';
		}else{
			$this->db->trans_commit();
			$retval['status'] = true;
			$retval['pesan'] = 'Sukses Menghapus Data';
		}

		echo json_encode($retval);
	}
	################################ END OPERASIONAL AREA #############################################

	################################ PENGELUARAN LAIN AREA #############################################
	private function rule_validasi_pengeluaran_lain()
	{
		$data = array();
		$data['error_string'] = array();
		$data['inputerror'] = array();
		$data['status'] = TRUE;

		if ($this->input->post('item_out') == '') {
			$data['inputerror'][] = 'item_out';
			$data['error_string'][] = 'Wajib Memilih Pengeluaran';
			$data['status'] = FALSE;
			$data['is_select2'][] = TRUE;
		}

		if ($this->input->post('tahun_out') == '') {
			$data['inputerror'][] = 'tahun_out';
			$data['error_string'][] = 'Wajib Mengisi Tahun';
			$data['status'] = FALSE;
			$data['is_select2'][] = TRUE;
		}

		if ($this->input->post('bulan_out') == '') {
			$data['inputerror'][] = 'bulan_out';
			$data['error_string'][] = 'Wajib Mengisi Bulan';
			$data['status'] = FALSE;
			$data['is_select2'][] = FALSE;
		}

		if ($this->input->post('qty_out') == '') {
			$data['inputerror'][] = 'qty_out';
			$data['error_string'][] = 'Wajib Mengisi Qty';
			$data['status'] = FALSE;
			$data['is_select2'][] = TRUE;
		}

		if ($this->input->post('harga_out') == '') {
			$data['inputerror'][] = 'harga_out';
			$data['error_string'][] = 'Wajib Mengisi Nilai';
			$data['status'] = FALSE;
			$data['is_select2'][] = FALSE;
		}
			
        return $data;
	}
	
	public function simpan_form_out_lain()
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$datenow = $obj_date->format('Y-m-d');
		$arr_valid = $this->rule_validasi_pengeluaran_lain();
		
		if ($arr_valid['status'] == FALSE) {
			echo json_encode($arr_valid);
			return;
		}

		$this->db->trans_begin();
		$id_header = gen_uuid();
		$slug_trans = $this->input->post('slug_trans');
		$item_out = $this->input->post('item_out');
		$tahun = $this->input->post('tahun_out');
		$bulan = $this->input->post('bulan_out');
		$qty = $this->input->post('qty_out');
		$harga_out = $this->input->post('harga_out_raw');
		$total_out = $this->input->post('hargatot_out_raw');
		
		$cek_jenis = $this->m_global->single_row('id', ['slug' => $slug_trans], 'm_jenis_trans');
		###insert
		$data = [
			'id' => $id_header,
			'id_jenis_trans' => $cek_jenis->id,
			'bulan_gaji' => $bulan,
			'tahun_gaji' => $tahun,
			'harga_total' => $total_out,
			'id_user' => $this->session->userdata('id_user'),
			'created_at' => $timestamp
		];
					
		$insert = $this->m_global->store($data, 't_transaksi');

		if($insert){
			$data_det = [
				'id' => gen_uuid(),
				'id_transaksi' => $id_header,
				'id_item_trans' => $item_out,
				'harga_satuan' => $harga_out,
				'qty' => $qty,
				'created_at' => $timestamp
			];
						
			$insert_det = $this->m_global->store($data_det, 't_transaksi_det');
		}
		
		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['status'] = false;
			$retval['pesan'] = 'Gagal Menambah Data';
		}else{
			$this->db->trans_commit();
			$retval['status'] = true;
			$retval['pesan'] = 'Sukses Menambah Data';
		}

		echo json_encode($retval);
	}

	public function load_form_tabel_pengeluaran_lain()
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$data = $this->input->post('data');
		
		$html = '';
		
		if($data){
			foreach ($data as $key => $value) {
				$html .= '<tr><td>'.($key+1).'</td><td>'.$obj_date->createFromFormat('Y-m-d H:i:s', $value['created_at'])->format('d-m-Y').'</td><td>'.$value['nama_item'].'</td><td align="right">'.bulan_indo($value['bulan_gaji']).'</td><td>'.$value['tahun_gaji'].'</td><td align="right">'.number_format($value['harga_satuan'],0,',','.').'</td><td align="right">'.number_format($value['qty'],0,',','.').'</td><td align="right">'.number_format($value['harga_total'],0,',','.').'</td><td><button type="button" class="btn btn-sm btn-danger" onclick="hapus_pengeluaran_lain(\''.$value['id'].'\')"><i class="la la-trash"></i></button></td></tr>';
			}
		}else{
			$slug = $this->clean_txt_div($this->input->post('activeModal'));
			$q_jenis = $this->m_global->single_row('*', ['slug' => $slug], 'm_jenis_trans');

			$select = "t_transaksi.*, m_item_trans.nama as nama_item, t_transaksi_det.qty, t_transaksi_det.harga_satuan";
			$where = ['t_transaksi.deleted_at' => null, 't_transaksi.id_jenis_trans' => $q_jenis->id];
			$table = 't_transaksi';
			$join = [ 
				['table' => 't_transaksi_det', 'on' => 't_transaksi.id = t_transaksi_det.id_transaksi'],
				['table' => 'm_item_trans', 'on' => 't_transaksi_det.id_item_trans = m_item_trans.id']
			];
		
			$datanya = $this->m_global->multi_row($select,$where,$table, $join);

			if($datanya){
				foreach ($datanya as $key => $value) {
					$html .= '<tr><td>'.($key+1).'</td><td>'.$obj_date->createFromFormat('Y-m-d H:i:s', $value->created_at)->format('d-m-Y').'</td><td>'.$value->nama_item.'</td><td align="right">'.bulan_indo($value->bulan_gaji).'</td><td>'.$value->tahun_gaji.'</td><td align="right">'.number_format($value->harga_satuan,0,',','.').'</td><td align="right">'.number_format($value->qty,0,',','.').'</td><td align="right">'.number_format($value->harga_total,0,',','.').'</td><td><button type="button" class="btn btn-sm btn-danger" onclick="hapus_pengeluaran_lain(\''.$value->id.'\')"><i class="la la-trash"></i></button></td></tr>';
				}
			}
		}

		echo json_encode([
			'html' => $html
		]);
	}

	public function delete_data_pengeluaran_lain()
	{
		$id = $this->input->post('id');
		$this->db->trans_begin();
		
		$del_1 = $this->t_transaksi_det->softdelete_by_trans($id);
		$del_2 = $this->t_transaksi->softdelete_by_id($id);

		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['status'] = false;
			$retval['pesan'] = 'Gagal Menghapus Data';
		}else{
			$this->db->trans_commit();
			$retval['status'] = true;
			$retval['pesan'] = 'Sukses Menghapus Data';
		}

		echo json_encode($retval);
	}
	################################ END PENGELUARAN LAIN AREA #############################################

	################################ PENERIMAAN LAIN AREA #############################################
	private function rule_validasi_penerimaan_lain()
	{
		$data = array();
		$data['error_string'] = array();
		$data['inputerror'] = array();
		$data['status'] = TRUE;

		if ($this->input->post('item_in') == '') {
			$data['inputerror'][] = 'item_in';
			$data['error_string'][] = 'Wajib Memilih Penerimaan';
			$data['status'] = FALSE;
			$data['is_select2'][] = TRUE;
		}

		if ($this->input->post('tahun_in') == '') {
			$data['inputerror'][] = 'tahun_in';
			$data['error_string'][] = 'Wajib Mengisi Tahun';
			$data['status'] = FALSE;
			$data['is_select2'][] = TRUE;
		}

		if ($this->input->post('bulan_in') == '') {
			$data['inputerror'][] = 'bulan_in';
			$data['error_string'][] = 'Wajib Mengisi Bulan';
			$data['status'] = FALSE;
			$data['is_select2'][] = FALSE;
		}

		if ($this->input->post('qty_in') == '') {
			$data['inputerror'][] = 'qty_in';
			$data['error_string'][] = 'Wajib Mengisi Qty';
			$data['status'] = FALSE;
			$data['is_select2'][] = TRUE;
		}

		if ($this->input->post('harga_in') == '') {
			$data['inputerror'][] = 'harga_in';
			$data['error_string'][] = 'Wajib Mengisi Nilai';
			$data['status'] = FALSE;
			$data['is_select2'][] = FALSE;
		}
			
        return $data;
	}
	
	public function simpan_form_in_lain()
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$datenow = $obj_date->format('Y-m-d');
		$arr_valid = $this->rule_validasi_penerimaan_lain();
		
		if ($arr_valid['status'] == FALSE) {
			echo json_encode($arr_valid);
			return;
		}

		$this->db->trans_begin();
		$id_header = gen_uuid();
		$slug_trans = $this->input->post('slug_trans');
		$item_in = $this->input->post('item_in');
		$tahun = $this->input->post('tahun_in');
		$bulan = $this->input->post('bulan_in');
		$qty = $this->input->post('qty_in');
		$harga_in = $this->input->post('harga_in_raw');
		$total_in = $this->input->post('hargatot_in_raw');
		
		$cek_jenis = $this->m_global->single_row('id', ['slug' => $slug_trans], 'm_jenis_trans');
		###insert
		$data = [
			'id' => $id_header,
			'id_jenis_trans' => $cek_jenis->id,
			'bulan_gaji' => $bulan,
			'tahun_gaji' => $tahun,
			'harga_total' => $total_in,
			'id_user' => $this->session->userdata('id_user'),
			'created_at' => $timestamp
		];
					
		$insert = $this->m_global->store($data, 't_transaksi');

		if($insert){
			$data_det = [
				'id' => gen_uuid(),
				'id_transaksi' => $id_header,
				'id_item_trans' => $item_in,
				'harga_satuan' => $harga_in,
				'qty' => $qty,
				'created_at' => $timestamp
			];
						
			$insert_det = $this->m_global->store($data_det, 't_transaksi_det');
		}
		
		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['status'] = false;
			$retval['pesan'] = 'Gagal Menambah Data';
		}else{
			$this->db->trans_commit();
			$retval['status'] = true;
			$retval['pesan'] = 'Sukses Menambah Data';
		}

		echo json_encode($retval);
	}

	public function load_form_tabel_penerimaan_lain()
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$data = $this->input->post('data');
		
		$html = '';
		
		if($data){
			foreach ($data as $key => $value) {
				$html .= '<tr><td>'.($key+1).'</td><td>'.$obj_date->createFromFormat('Y-m-d H:i:s', $value['created_at'])->format('d-m-Y').'</td><td>'.$value['nama_item'].'</td><td align="right">'.bulan_indo($value['bulan_gaji']).'</td><td>'.$value['tahun_gaji'].'</td><td align="right">'.number_format($value['harga_satuan'],0,',','.').'</td><td align="right">'.number_format($value['qty'],0,',','.').'</td><td align="right">'.number_format($value['harga_total'],0,',','.').'</td><td><button type="button" class="btn btn-sm btn-danger" onclick="hapus_penerimaan_lain(\''.$value['id'].'\')"><i class="la la-trash"></i></button></td></tr>';
			}
		}else{
			$slug = $this->clean_txt_div($this->input->post('activeModal'));
			$q_jenis = $this->m_global->single_row('*', ['slug' => $slug], 'm_jenis_trans');

			$select = "t_transaksi.*, m_item_trans.nama as nama_item, t_transaksi_det.qty, t_transaksi_det.harga_satuan";
			$where = ['t_transaksi.deleted_at' => null, 't_transaksi.id_jenis_trans' => $q_jenis->id];
			$table = 't_transaksi';
			$join = [ 
				['table' => 't_transaksi_det', 'on' => 't_transaksi.id = t_transaksi_det.id_transaksi'],
				['table' => 'm_item_trans', 'on' => 't_transaksi_det.id_item_trans = m_item_trans.id']
			];
		
			$datanya = $this->m_global->multi_row($select,$where,$table, $join);

			if($datanya){
				foreach ($datanya as $key => $value) {
					$html .= '<tr><td>'.($key+1).'</td><td>'.$obj_date->createFromFormat('Y-m-d H:i:s', $value->created_at)->format('d-m-Y').'</td><td>'.$value->nama_item.'</td><td align="right">'.bulan_indo($value->bulan_gaji).'</td><td>'.$value->tahun_gaji.'</td><td align="right">'.number_format($value->harga_satuan,0,',','.').'</td><td align="right">'.number_format($value->qty,0,',','.').'</td><td align="right">'.number_format($value->harga_total,0,',','.').'</td><td><button type="button" class="btn btn-sm btn-danger" onclick="hapus_penerimaan_lain(\''.$value->id.'\')"><i class="la la-trash"></i></button></td></tr>';
				}
			}
		}

		echo json_encode([
			'html' => $html
		]);
	}

	public function delete_data_penerimaan_lain()
	{
		$id = $this->input->post('id');
		$this->db->trans_begin();
		
		$del_1 = $this->t_transaksi_det->softdelete_by_trans($id);
		$del_2 = $this->t_transaksi->softdelete_by_id($id);

		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['status'] = false;
			$retval['pesan'] = 'Gagal Menghapus Data';
		}else{
			$this->db->trans_commit();
			$retval['status'] = true;
			$retval['pesan'] = 'Sukses Menghapus Data';
		}

		echo json_encode($retval);
	}
	################################ END PENERIMAAN LAIN AREA #############################################

	private function rule_validasi($flag)
	{
		$data = array();
		$data['error_string'] = array();
		$data['inputerror'] = array();
		$data['status'] = TRUE;

		if($flag == 'reguler') {
			if ($this->input->post('pembayaran_reg') == '') {
				$data['inputerror'][] = 'pembayaran_reg';
				$data['error_string'][] = 'Wajib Mengisi Pembayaran';
				$data['status'] = FALSE;
				$data['is_select2'][] = FALSE;
			}
			
		}else{
			if ($this->input->post('pembayaran_mem') == '') {
				$data['inputerror'][] = 'pembayaran_mem';
				$data['error_string'][] = 'Wajib Mengisi Pembayaran';
				$data['status'] = FALSE;
				$data['is_select2'][] = FALSE;
			}
			
		}

        return $data;
	}

	public function get_detail_member()
	{
		$counter_mobil = 0;
		$counter_motor = 0;

		$kode_member = trim($this->input->get('kode_member'));
		$data = $this->m_global->single_row('*', ['deleted_at' => null, 'kode_member' => $kode_member], 'm_member');
		if($data) {
			$counter = $this->lib_fungsi->cek_counter($data->id);
			if($counter != null) {
				foreach ($counter as $key => $value) {
					if($value->id_jenis_counter == '1') {
						$counter_mobil = $value->total_count;
					}else if($value->id_jenis_counter == '2') {
						$counter_motor = $value->total_count;
					}
				}
			}
		}
		
		if($data) {
			$retval = [
				'data' => $data,
				'status' => true,
				'counter_mobil' => $counter_mobil,
				'counter_motor' => $counter_motor,
			];
		}else{
			$retval = [
				'data' => null,
				'status' => false,
				'counter_mobil' => $counter_mobil,
				'counter_motor' => $counter_motor,
			];
		}

		echo json_encode($retval);
	}

	public function tampil_barcode()
	{
		//var_dump($this->barcode_lib->generate());exit;
		echo $this->barcode_lib->generate_html('M210328001');
		echo '<br>';
		echo $this->barcode_lib->generate_html('M210328002');
		echo '<br>';
	}

	public function simpan_barcode($value = '123456')
	{
		$this->barcode_lib->save_jpg($value);
	}








	////////////////////////////////////////////////////////////////////////////////

	private function umur_dan_pemetaan($tanggal_lahir, $flag_cari = 'umur')
	{
		$tgl_lhr = new DateTime($tanggal_lahir);
		$skrg  = new DateTime('today');
		$umur = $tgl_lhr->diff($skrg)->y;
		
		if($flag_cari == 'umur') {
			$retval = $umur;
		}else{
			$data = $this->m_global->single_row('*', ['umur_awal <=' => $umur, 'umur_akhir >=' => $umur], 'm_pemetaan');
			$retval = $data->id;
		}

		return $retval;
	}

	public function get_select_pasien()
	{
		$term = $this->input->get('term');
		$data_pasien = $this->m_global->multi_row('*', ['deleted_at' => null, 'is_aktif' => '1', 'nama like' => '%'.$term.'%'], 'm_pasien', null, 'no_rm');
		if($data_pasien) {
			foreach ($data_pasien as $key => $value) {
				$row['id'] = $value->id;
				$row['text'] = '['.$value->no_rm.' - '.$value->nik.'] '.$value->nama;
				$row['nik'] = $value->nik;
				$row['no_rm'] = $value->no_rm;
				$row['tanggal_lahir'] = $value->tanggal_lahir;
				$row['tempat_lahir'] = $value->tempat_lahir;
				$row['umur'] = $this->umur_dan_pemetaan($value->tanggal_lahir, 'umur');
				$row['pemetaan'] = $this->umur_dan_pemetaan($value->tanggal_lahir, 'pemetaan');
				$retval[] = $row;
			}
		}else{
			$retval = false;
		}
		echo json_encode($retval);
	}

	public function get_select_dokter()
	{
		$term = $this->input->get('term');
		$id_jabatan = 1; // jabatan dokter
		$data_pasien = $this->m_global->multi_row('*', ['deleted_at' => null, 'is_aktif' => '1', 'nama like' => '%'.$term.'%', 'id_jabatan' => $id_jabatan], 'm_pegawai', null, 'nama');
		if($data_pasien) {
			foreach ($data_pasien as $key => $value) {
				$row['id'] = $value->id;
				$row['text'] = '['.$value->kode.'] '.$value->nama;
				$retval[] = $row;
			}
		}else{
			$retval = false;
		}
		echo json_encode($retval);
	}

	public function get_data_form_penjamin()
	{
		$enc_id = $this->input->post('id_regnya');
		
		$this->load->library('Enkripsi');
		$id = $this->enkripsi->enc_dec('decrypt', $enc_id);

		$select = "reg.id_asuransi, reg.no_asuransi, asu.nama as nama_asuransi, asu.keterangan";
		$where = ['reg.deleted_at is null' => null, 'reg.id' => $id];
		$table = 't_registrasi as reg';
		$join = [ 
			['table' => 'm_asuransi as asu', 'on' => 'reg.id_asuransi = asu.id']
		];

		$data_reg = $this->m_global->single_row($select,$where,$table, $join);
		
		$jenis = $this->input->post('jenis_penjamin');
		// $data_asuransi = $this->m_global->multi_row('*', ['deleted_at' => null], 'm_asuransi', null, 'nama');
		if($jenis == '1') {
			$html = '
				<div class="form-group row form-group-marginless kt-margin-t-20">
					<label class="col-lg-2 col-form-label">Asuransi:</label>
					<div class=" col-lg-6">
					<select class="form-control kt-select2" id="asuransi" name="asuransi">
						<option value="">Silahkan Pilih Nama Asuransi</option>
			';
			if($id != null) {
				$html .= '<option value="'.$data_reg->id_asuransi.'" selected>'.$data_reg->nama_asuransi.'</option>';
			}

			$html .= '
				</select>
				<span class="help-block"></span>
				</div>
				<div class="col-lg-2">
					<button type="button" class="btn btn-sm btn-success" onclick="tambah_data_asuransi()">
						Tambah data Asuransi
					</button>
				</div>
			</div>
			<div><br /></div>
			<div class="form-group row form-group-marginless kt-margin-t-20">
				<label class="col-lg-2 col-form-label">No. Asuransi:</label>
				<div class=" col-lg-8">
			';
			if($id != null) {
				$html .= '<input type="text" class="form-control" id="no_asuransi" name="no_asuransi" autocomplete="off" value="'.$data_reg->no_asuransi.'">';
			}else{
				$html .= '<input type="text" class="form-control" id="no_asuransi" name="no_asuransi" autocomplete="off" value="">';
			}
			$html .= '	
					<span class="help-block"></span>
					</div>
				</div>
			';
		}else{
			$html = '';
		}

		echo json_encode($html);
	}

	public function add()
	{
		$id_user = $this->session->userdata('id_user'); 
		$data_user = $this->m_user->get_detail_user($id_user);
		$pemetaan = $this->m_global->multi_row('*', ['deleted_at' => null], 'm_pemetaan', null, 'umur_awal');
			
		/**
		 * data passing ke halaman view content
		 */
		$data = array(
			'title' => 'Tambah data Registrasi',
			'data_user' => $data_user,
			'data_pemetaan' => $pemetaan
		);

		/**
		 * content data untuk template
		 * param (css : link css pada direktori assets/css_module)
		 * param (modal : modal komponen pada modules/nama_modul/views/nama_modal)
		 * param (js : link js pada direktori assets/js_module)
		 */
		$content = [
			'css' 	=> null,
			'modal' => 'modal_data_reg',
			'js'	=> 'reg_pasien.js',
			'view'	=> 'form_data_reg'
		];

		$this->template_view->load_view($content, $data);
	}

	public function edit($enc_id)
	{
		if(strlen($enc_id) != 32) {
			return redirect(base_url($this->uri->segment(1)));
		}
		
		$id_user = $this->session->userdata('id_user'); 
		$data_user = $this->m_user->get_detail_user($id_user);

		$pemetaan = $this->m_global->multi_row('*', ['deleted_at' => null], 'm_pemetaan', null, 'umur_awal');

		/**
		 * data passing ke halaman view content
		 */
		$data = array(
			'title' => 'Edit Data Registrasi',
			'data_user' => $data_user,
			'data_pemetaan' => $pemetaan
		);
		

		/**
		 * content data untuk template
		 * param (css : link css pada direktori assets/css_module)
		 * param (modal : modal komponen pada modules/nama_modul/views/nama_modal)
		 * param (js : link js pada direktori assets/js_module)
		 */
		$content = [
			'css' 	=> null,
			'modal' => 'modal_data_reg',
			'js'	=> 'reg_pasien.js',
			'view'	=> 'form_data_reg'
		];

		$this->template_view->load_view($content, $data);
	}

	public function get_data_form_reg()
	{
		$enc_id = $this->input->post('enc_id');

		if(strlen($enc_id) != 32) {
			$status = false;
		}

		$this->load->library('Enkripsi');
		$id = $this->enkripsi->enc_dec('decrypt', $enc_id);

		$select = "reg.id, reg.id_pasien, reg.id_pegawai, reg.no_reg, reg.tanggal_reg, reg.jam_reg, reg.tanggal_pulang, reg.jam_pulang, reg.is_pulang, reg.is_asuransi, reg.id_asuransi, reg.umur, reg.no_asuransi, reg.id_pemetaan, psn.nama as nama_pasien, psn.no_rm, psn.tanggal_lahir, psn.tempat_lahir, psn.nik, psn.jenis_kelamin, peg.kode as kode_dokter, peg.nama as nama_dokter, asu.nama as nama_asuransi, asu.keterangan, pem.keterangan, CASE WHEN reg.is_asuransi = 1 THEN 'Asuransi' ELSE 'Umum' END as penjamin, CASE WHEN psn.jenis_kelamin = 'L' THEN 'Laki-Laki' ELSE 'Perempuan' END as jenkel";
		$where = ['reg.deleted_at is null' => null, 'reg.id' => $id];
		$table = 't_registrasi as reg';
		$join = [ 
			['table' => 'm_pasien as psn', 'on'	=> 'reg.id_pasien = psn.id'],
			['table' => 'm_pegawai as peg', 'on'=> 'reg.id_pegawai = peg.id'],
			['table' => 'm_asuransi as asu', 'on' => 'reg.id_asuransi = asu.id'],
			['table' => 'm_pemetaan as pem', 'on' => 'reg.id_pemetaan = pem.id']
		];
		$data_reg = $this->m_global->single_row($select,$where,$table, $join);
		
		if(!$data_reg) {
			$status = false;
		}else{
			$status = true;
		}

		echo json_encode([
			'status' => $status,
			'data' => $data_reg,
			'txt_opt_pasien' => '['.$data_reg->no_rm.' - '.$data_reg->nik.'] '.$data_reg->nama_pasien,
			'txt_opt_dokter' => '['.$data_reg->kode_dokter.'] '.$data_reg->nama_dokter
		]);
	}

	public function simpan_data()
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		
		if($this->input->post('asuransi') !== null){
			$flag_asuransi = true;
			$id_asuransi = $this->input->post('asuransi');
			$no_asuransi = $this->input->post('no_asuransi');
		}else{
			$flag_asuransi = false;
			$id_asuransi = null;
			$no_asuransi = null;
		}

		$arr_valid = $this->rule_validasi($flag_asuransi);
		
		if ($arr_valid['status'] == FALSE) {
			echo json_encode($arr_valid);
			return;
		}

		$id_pasien = $this->input->post('nama');
		$tanggal_reg = contul($this->input->post('tanggal_reg'));
		$jam_reg = contul($this->input->post('jam_reg'));
		$id_pegawai = contul($this->input->post('dokter'));
		$is_asuransi = ($flag_asuransi) ? 1 : null;
		$umur = contul(trim($this->input->post('umur_reg')));
		$id_pemetaan = contul($this->input->post('pemetaan'));

		$this->db->trans_begin();
		
		$registrasi = [
			'id_pasien' => $id_pasien,
			'tanggal_reg' => $obj_date->createFromFormat('d/m/Y', $tanggal_reg)->format('Y-m-d'),
			'jam_reg' => $jam_reg,
			'id_pegawai' => $id_pegawai,
			'is_asuransi' => $is_asuransi,
			'id_asuransi' => $id_asuransi,
			'no_asuransi' => $no_asuransi,
			'umur' => $umur,
			'id_pemetaan' => $id_pemetaan
		];

		if($this->input->post('id_reg') != '') {
			###update
			$registrasi['updated_at'] = $timestamp;
			$where = ['id' => $this->input->post('id_reg')];
			$update = $this->t_registrasi->update($where, $registrasi);
			$pesan = 'Sukses Mengupdate data Registrasi';
		}else{
			###insert
			$registrasi['id'] = $this->t_registrasi->get_max_id();
			$registrasi['no_reg'] = $this->t_registrasi->get_kode_reg();
			$registrasi['created_at'] = $timestamp;
			$insert = $this->t_registrasi->save($registrasi);
			$pesan = 'Sukses Menambah data Registrasi';
		}
				
		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['status'] = false;
			$retval['pesan'] = 'Gagal memproses Data Registrasi';
		}else{
			$this->db->trans_commit();
			$retval['status'] = true;
			$retval['pesan'] = $pesan;
		}

		echo json_encode($retval);
	}

	public function list_data()
	{
		$tgl_awal = contul(DateTime::createFromFormat('d/m/Y', $this->input->post('tgl_awal'))->format('Y-m-d'));
		$tgl_akhir = contul(DateTime::createFromFormat('d/m/Y', $this->input->post('tgl_akhir'))->format('Y-m-d'));
		
		$this->load->library('Enkripsi');
		$list = $this->t_registrasi->get_datatable($tgl_awal, $tgl_akhir);

		// echo "<pre>";
		// print_r ($list);
		// echo "</pre>";
		// exit;

		$data = array();
		// $no =$_POST['start'];
		foreach ($list as $val) {
			// $no++;
			$row = array();
			//loop value tabel db
			// $row[] = $no;
			$row[] = $val->no_reg;
			$row[] = $val->nama_pasien;
			$row[] = DateTime::createFromFormat('Y-m-d', $val->tanggal_reg)->format('d/m/Y');
			$row[] = $val->jam_reg;
			$row[] = ($val->is_pulang == '1') ? 'Pulang' : '-';
			$row[] = ($val->tanggal_pulang) ? DateTime::createFromFormat('Y-m-d', $val->tanggal_pulang)->format('d/m/Y') : '-';
			$row[] = $val->jam_pulang;
			$row[] = $val->no_rm;
			$row[] = $val->tempat_lahir;
			$row[] = DateTime::createFromFormat('Y-m-d', $val->tanggal_lahir)->format('d/m/Y');
			$row[] = $val->nik;
			$row[] = $val->jenkel;
			$row[] = $val->nama_dokter;
			$row[] = $val->penjamin;
			$row[] = $val->nama_asuransi;
			$row[] = $val->no_asuransi;
			$row[] = $val->umur;
			$row[] = $val->keterangan;
			
			$str_aksi = '
				<div class="btn-group">
					<button type="button" class="btn btn-sm btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> Opsi</button>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="'.base_url('reg_pasien/edit/').$this->enkripsi->enc_dec('encrypt', $val->id).'"">
							<i class="la la-pencil"></i> Edit Registrasi
						</a>
						<button class="dropdown-item" onclick="delete_reg(\''.$this->enkripsi->enc_dec('encrypt', $val->id).'\')">
							<i class="la la-trash"></i> Hapus
						</button>
						<a class="dropdown-item" target="_blank" href="'.base_url('reg_pasien/cetak_data_individu/').$this->enkripsi->enc_dec('encrypt', $val->id).'">
							<i class="la la-print"></i> Cetak Data Ini
						</a>
					</div>
				</div>
			';

			$row[] = $str_aksi;

			$data[] = $row;
		}//end loop

		$output = [
			"draw" => $_POST['draw'],
			"recordsTotal" => $this->t_registrasi->count_all(),
			"recordsFiltered" => $this->t_registrasi->count_filtered($tgl_awal, $tgl_akhir),
			"data" => $data
		];
		
		echo json_encode($output);
	}	

	/**
	 * Hanya melakukan softdelete saja
	 * isi kolom updated_at dengan datetime now()
	 */
	public function delete_data()
	{
		$this->load->library('Enkripsi');
		$enc_id = $this->input->post('id');
		
		if(strlen($enc_id) != 32) {
			echo json_encode([
				'status' => false,
				'pesan' => 'Data Tidak Valid'
			]);
			return;
		}

		$id_pasien = $this->enkripsi->enc_dec('decrypt', $enc_id);
		$del = $this->t_registrasi->softdelete_by_id($id_pasien);
		if($del) {
			$retval['status'] = TRUE;
			$retval['pesan'] = 'Data Pasien Sukses dihapus';
		}else{
			$retval['status'] = FALSE;
			$retval['pesan'] = 'Data Pasien Gagal dihapus';
		}

		echo json_encode($retval);
	}

	public function export_excel()
	{
		$tgl_awal = $this->input->get('tgl_awal');
		$tgl_akhir = $this->input->get('tgl_akhir');

		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$tgl_awal_fix = $obj_date->createFromFormat('d/m/Y', $tgl_awal)->format('Y-m-d');
		$tgl_akhir_fix = $obj_date->createFromFormat('d/m/Y', $tgl_akhir)->format('Y-m-d');

		// var_dump($tgl_awal, $tgl_akhir);
		$data = $this->t_registrasi->get_data_ekspor($tgl_awal_fix,$tgl_akhir_fix);
		
		if($data) {
			$counter = count($data)+1;
		}else{
			$counter = 1;
		}

		$spreadsheet = $this->excel->spreadsheet_obj();
		$writer = $this->excel->xlsx_obj($spreadsheet);
		$number_format_obj = $this->excel->number_format_obj();
		
		$spreadsheet
			->getActiveSheet()
			->getStyle('A1:AA'.$counter)
			->getNumberFormat()
			//format text masih ada bug di nip. jadi kacau
			//->setFormatCode($number_format_obj::FORMAT_TEXT);
			// solusi pake format custom
			->setFormatCode('#');
		
		$sheet = $spreadsheet->getActiveSheet();

		$sheet
			->setCellValue('A1', 'No Reg')
			->setCellValue('B1', 'Nama')
			->setCellValue('C1', 'Tgl Masuk')
			->setCellValue('D1', 'Pukul Masuk')
			->setCellValue('E1', 'Pulang')
			->setCellValue('F1', 'Tgl Keluar')
			->setCellValue('G1', 'Pkl Keluar')
			->setCellValue('H1', 'No RM')
			->setCellValue('I1', 'Tempat Lahir')
			->setCellValue('J1', 'Tgl Lahir')
			->setCellValue('K1', 'NIK')
			->setCellValue('L1', 'Jenis Kelamin')
			->setCellValue('M1', 'Dokter')
			->setCellValue('N1', 'Jenis Penjamin')
			->setCellValue('O1', 'Asuransi')
			->setCellValue('P1', 'No Asuransi')
			->setCellValue('Q1', 'Umur')
			->setCellValue('R1', 'Pemetaan');
					
		$startRow = 2;
		$row = $startRow;
		if($data){
			foreach ($data as $key => $val) {
				$is_pulang = ($val->is_pulang == '1') ? 'Pulang' : '-';
				$tgl_plg = ($val->tanggal_pulang) ? DateTime::createFromFormat('Y-m-d', $val->tanggal_pulang)->format('d/m/Y') : '-';
				$sheet
					->setCellValue("A{$row}", $val->no_reg)
					->setCellValue("B{$row}", $val->nama_pasien)
					->setCellValue("C{$row}", DateTime::createFromFormat('Y-m-d', $val->tanggal_reg)->format('d/m/Y'))
					->setCellValue("D{$row}", $val->jam_reg)
					->setCellValue("E{$row}", $is_pulang)
					->setCellValue("F{$row}", $tgl_plg)
					->setCellValue("G{$row}", $val->jam_pulang)
					->setCellValue("H{$row}", $val->no_rm)
					->setCellValue("I{$row}", $val->tempat_lahir)
					->setCellValue("J{$row}", DateTime::createFromFormat('Y-m-d', $val->tanggal_lahir)->format('d/m/Y'))
					->setCellValue("K{$row}", $val->nik)
					->setCellValue("L{$row}", $val->jenkel)
					->setCellValue("M{$row}", $val->nama_dokter)
					->setCellValue("N{$row}", $val->penjamin)
					->setCellValue("O{$row}", $val->nama_asuransi)
					->setCellValue("P{$row}", $val->no_asuransi)
					->setCellValue("Q{$row}", $val->umur)
					->setCellValue("R{$row}", $val->keterangan);
				$row++;
			}

			$endRow = $row - 1;
		}
		
		
		$filename = 'data-registrasi_'.$tgl_awal_fix.'_'.$tgl_akhir_fix.'_'.time();
		
		header('Content-Type: application/vnd.ms-excel');
		header('Content-Disposition: attachment;filename="'. $filename .'.xlsx"'); 
		header('Cache-Control: max-age=0');

		$writer->save('php://output');
		
	}

	public function cetak_data_individu($enc_id)
	{
		if(strlen($enc_id) != 32) {
			return redirect(base_url($this->uri->segment(1)));
		}

		$this->load->library('Enkripsi');
		$id = $this->enkripsi->enc_dec('decrypt', $enc_id);

		$data = $this->t_registrasi->get_data_ekspor(false,false,$id);
		$data_klinik = $this->m_global->single_row('*', 'deleted_at is null', 'm_klinik');

		$retval = [
			'data' => $data,
			'data_klinik' => $data_klinik,
			'title' => 'Detail Data Registrasi'
		];

		$this->load->view('pdf_individu', $retval);
		$html = $this->load->view('pdf_individu', $retval, true);
	    $filename = 'detail_registrasi_'.$data->no_reg.'_'.time();
	    $this->lib_dompdf->generate($html, $filename, true, 'A4', 'potrait');
	}

	public function cetak_data()
	{
		$tgl_awal = $this->input->get('tgl_awal');
		$tgl_akhir = $this->input->get('tgl_akhir');

		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$tgl_awal_fix = $obj_date->createFromFormat('d/m/Y', $tgl_awal)->format('Y-m-d');
		$tgl_akhir_fix = $obj_date->createFromFormat('d/m/Y', $tgl_akhir)->format('Y-m-d');

		// var_dump($tgl_awal, $tgl_akhir);
		$data = $this->t_registrasi->get_data_ekspor($tgl_awal_fix,$tgl_akhir_fix);
		$data_klinik = $this->m_global->single_row('*', 'deleted_at is null', 'm_klinik');

		$retval = [
			'data' => $data,
			'title' => 'Data Registrasi',
			'periode' => 'Periode '.$tgl_awal.' - '.$tgl_akhir,
			'data_klinik' => $data_klinik
		];

		// $this->load->view('pdf', $retval);
		$html = $this->load->view('pdf', $retval, true);
	    $filename = 'data_registrasi'.$tgl_awal_fix.'_'.$tgl_akhir_fix.'_'.time();
	    $this->lib_dompdf->generate($html, $filename, true, 'legal', 'landscape');
	}
}
