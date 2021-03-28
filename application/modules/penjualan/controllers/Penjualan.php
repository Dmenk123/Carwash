<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Penjualan extends CI_Controller {
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
		$this->load->library('barcode_lib');
	}

	public function index()
	{
		$id_user = $this->session->userdata('id_user'); 
		$data_user = $this->m_user->get_detail_user($id_user);
		$list_item = $this->m_global->multi_row('*', ['id_jenis_trans' => 1, 'deleted_at' => null], 'm_item_trans', NULL, 'nama');
		
		/**
		 * data passing ke halaman view content
		 */
		$data = array(
			'title' => 'Formulir Penjualan',
			'data_user' => $data_user,
			'list_item' => $list_item
		);

		// echo "<pre>";
		// print_r ($data);
		// echo "</pre>";
		// exit;

		/**
		 * content data untuk template
		 * param (css : link css pada direktori assets/css_module)
		 * param (modal : modal komponen pada modules/nama_modul/views/nama_modal)
		 * param (js : link js pada direktori assets/js_module)
		 */
		$content = [
			'css' 	=> null,
			'modal' => null,
			'js'	=> 'penjualan.js',
			'view'	=> 'form_data_penjualan'
		];

		$this->template_view->load_view($content, $data);
	}
	
	public function get_detail_item()
	{
		$html = '';
		$total = 0;
		
		if($this->input->get('arrItem') != '') {
			for ($i=0; $i < count($this->input->get('arrItem')); $i++) { 
				$id_item = $this->input->get('arrItem')[$i];
				$det_item = $this->m_global->single_row('*', ['id_jenis_trans' => 1, 'deleted_at' => null, 'id' => $id_item], 'm_item_trans');
				if($det_item) {
					$total += (float)$det_item->harga;
					$html .= '<tr>
								<td>'.$det_item->nama.'</td>
								<td>
									<input type="hidden" class="form-control" value='.$det_item->id.' name="id_item[]">
									<input type="hidden" class="form-control" value='.$det_item->harga.' name="harga[]">
								</td>
								<td class="kt-font-danger kt-font-lg" style="text-align: right;"><div><span class="pull-left">Rp. </span><span class="pull-right">'.number_format($det_item->harga,2,',','.').'</span></td>
							</tr>';
				}
			}
		}
		

		if($html != '') {
			$html .= '<tr>
						<th><span style="font-size:16px;font-weight:bold;">Grand Total</span></th>
						<th><input type="hidden" id="total_harga_global" class="form-control" value="'.$total.'" name="total"></th>
						<th class="kt-font-danger kt-font-lg" style="text-align: right;"><div><span class="pull-left">Rp. </span><span class="pull-right">'.number_format($total,2,',','.').'</span></th>
					</tr>';

			$html .= '<tr>
						<th><span style="font-size:16px;font-weight:bold;">Pembayaran</span></th>
						<th><input type="hidden" id="pembayaran_harga_global" class="form-control" name="pembayaran"></th>
						<th class="kt-font-success kt-font-lg" style="text-align: right;"><div><span class="pull-left">Rp. </span><span class="pull-right" id="span_pembayaran_harga_global">'.number_format(0,2,',','.').'</span></th>
					</tr>';

			$html .= '<tr>
						<th><span style="font-size:16px;font-weight:bold;">Kembalian</span></th>
						<th><input type="hidden" id="kembalian_harga_global" class="form-control" name="kembalian"></th>
						<th class="kt-font-primary kt-font-lg" style="text-align: right;"><div><span class="pull-left">Rp. </span><span class="pull-right" id="span_kembalian_harga_global">'.number_format(0,2,',','.').'</span></th>
					</tr>';
		}
		
		
		$retval = [
			'html' => $html,
			// 'data' => $det_item,
		];

		echo json_encode($retval);
	}

	public function get_no_invoice()
	{
		$nomor = $this->t_transaksi->get_invoice();
		echo json_encode($nomor);
	}

	public function simpan_trans_reg()
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$list_item = $this->input->post('list_item_reg'); 
		
		if($list_item == null) {
			$data['inputerror'][] = 'list_item_reg';
            $data['error_string'][] = 'Wajib mengisi Item Transaksi';
			$data['status'] = FALSE;
			$data['is_select2'][] = TRUE;
			echo json_encode($data);
			return;
		}

		$arr_valid = $this->rule_validasi('reguler');
		
		if ($arr_valid['status'] == FALSE) {
			echo json_encode($arr_valid);
			return;
		}

		$this->db->trans_begin();

		## insert header
		$id_header = gen_uuid();
		$data_ins = [
			'id' => $id_header,
			'kode' => $this->t_transaksi->get_invoice(),
			'id_jenis_trans' => self::ID_JENIS_TRANS,
			'id_user' => $this->session->userdata('id_user'),
			'created_at' => $timestamp
		];

		$insert = $this->t_transaksi->save($data_ins);
		if($insert) {
			$total = 0;
			for ($i=0; $i < count($list_item); $i++) {
				$total += $this->input->post('harga')[$i];
				
				$data_ins_det = [
					'id' => gen_uuid(),
					'id_transaksi' => $id_header,
					'id_item_trans' => $this->input->post('id_item')[$i],
					'harga_satuan' => $this->input->post('harga')[$i],
					'created_at' => $timestamp,
				];

				$insert_det = $this->t_transaksi_det->save($data_ins_det);
			}

			$data_upd_header = [
				'harga_total' => $total
			];

			$update = $this->t_transaksi->update(['id'=> $id_header], $data_upd_header);
		}
				
		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['status'] = false;
			$retval['pesan'] = 'Gagal memproses Data Transaksi';
		}else{
			$this->db->trans_commit();
			$retval['status'] = true;
			$retval['pesan'] = 'Sukses memproses Data Transaksi';
		}

		echo json_encode($retval);
	}

	public function simpan_trans_mem()
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$list_item = $this->input->post('list_item_mem'); 
		
		if($list_item == null) {
			$data['inputerror'][] = 'list_item_mem';
            $data['error_string'][] = 'Wajib mengisi Item Transaksi';
			$data['status'] = FALSE;
			$data['is_select2'][] = TRUE;
			echo json_encode($data);
			return;
		}

		$arr_valid = $this->rule_validasi('member');
		
		if ($arr_valid['status'] == FALSE) {
			echo json_encode($arr_valid);
			return;
		}

		$this->db->trans_begin();

		## insert header
		$id_header = gen_uuid();
		$data_ins = [
			'id' => $id_header,
			'kode' => $this->t_transaksi->get_invoice(),
			'id_jenis_trans' => self::ID_JENIS_TRANS,
			'id_user' => $this->session->userdata('id_user'),
			'created_at' => $timestamp
		];

		$insert = $this->t_transaksi->save($data_ins);
		if($insert) {
			$total = 0;
			for ($i=0; $i < count($list_item); $i++) {
				$total += $this->input->post('harga')[$i];
				
				$data_ins_det = [
					'id' => gen_uuid(),
					'id_transaksi' => $id_header,
					'id_item_trans' => $this->input->post('id_item')[$i],
					'harga_satuan' => $this->input->post('harga')[$i],
					'created_at' => $timestamp,
				];

				$insert_det = $this->t_transaksi_det->save($data_ins_det);
			}

			$data_upd_header = [
				'harga_total' => $total
			];

			$update = $this->t_transaksi->update(['id'=> $id_header], $data_upd_header);
		}
				
		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['status'] = false;
			$retval['pesan'] = 'Gagal memproses Data Transaksi';
		}else{
			$this->db->trans_commit();
			$retval['status'] = true;
			$retval['pesan'] = 'Sukses memproses Data Transaksi';
		}

		echo json_encode($retval);
	}

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
		$kode_member = trim($this->input->get('kode_member'));
		$data = $this->m_global->single_row('*', ['deleted_at' => null, 'kode_member' => $kode_member], 'm_member');
		
		if($data) {
			$retval = [
				'data' => $data,
				'status' => true
			];
		}else{
			$retval = [
				'data' => null,
				'status' => false
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
