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
		$this->load->library('thermalprint_lib');
	}

	public function cetak_struk($id_trans)
	{
		$id_user = $this->session->userdata('id_user'); 
		$data_profile = $this->m_global->single_row("*",NULL,'m_profil');
		$select = 'trans.*, trans_det.id as id_det, trans_det.id_item_trans, trans_det.harga_satuan, m_item_trans.nama';
		$join = [ 
			['table' => 't_transaksi_det as trans_det', 'on' => 'trans.id = trans_det.id_transaksi'],
			['table' => 'm_item_trans', 'on' => 'trans_det.id_item_trans = m_item_trans.id and m_item_trans.id_jenis_trans = 1']
		];
		$data_penjualan = $this->m_global->multi_row($select, ['trans.id' =>  $id_trans,'trans.deleted_at' => null], 't_transaksi as trans', $join);
		// echo $this->db->last_query();exit;
		
		$data_user = $this->m_user->get_detail_user($id_user);
		
		$this->thermalprint_lib->cek_cetak($data_user, $data_profile, $data_penjualan);
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
			'list_item' => $list_item,
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
	
	public function get_detail_item($kode_member = null)
	{
		$html = '';
		$total = 0;
		$counter_mobil = 0;
		$counter_motor = 0;

		if($kode_member != null) {
			$data_member = $this->m_global->single_row('*', ['kode_member' => $kode_member, 'deleted_at' => null], 'm_member');
			$counter = $this->lib_fungsi->cek_counter($data_member->id);
			//var_dump($counter);exit;
			if ($counter != null) {
				foreach ($counter as $key => $value) {
					if ($value->id_jenis_counter == '1') {
						$counter_mobil = $value->total_count;
					} else if ($value->id_jenis_counter == '2') {
						$counter_motor = $value->total_count;
					}
				}
			}
		}

		// var_dump((int)$counter_mobil, (int)$counter_motor);exit;
		
		if($this->input->get('arrItem') != '') {
			for ($i=0; $i < count($this->input->get('arrItem')); $i++) { 
				$id_item = $this->input->get('arrItem')[$i];
				$det_item = $this->m_global->single_row('*', ['id_jenis_trans' => 1, 'deleted_at' => null, 'id' => $id_item], 'm_item_trans');
				if($det_item) {
					if((int)$counter_mobil >= 9) {
						
						if($det_item->id_jenis_counter == '1') {
							$total += 0;
							$harga_fix = 0;
						}else{
							$total += (float)$det_item->harga;
							$harga_fix = $det_item->harga;
						}

					}else{
						if ((int)$counter_motor >= 9) {
							if ($det_item->id_jenis_counter == '2') {
								$total += 0;
								$harga_fix = 0;
							} else {
								$total += (float)$det_item->harga;
								$harga_fix = $det_item->harga;
							}
						}else{
							$total += (float)$det_item->harga;
							$harga_fix = $det_item->harga;
						}
					}
					
					$html .= '<tr>
								<td>'.$det_item->nama.'</td>
								<td>
									<input type="hidden" class="form-control" value='.$det_item->id.' name="id_item[]">
									<input type="hidden" class="form-control" value='.$harga_fix.' name="harga[]">
								</td>
								<td class="kt-font-danger kt-font-lg" style="text-align: right;"><div><span class="pull-left">Rp. </span><span class="pull-right">'.number_format($harga_fix,2,',','.').'</span></td>
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

	private function get_div_button()
	{
		return '
			<button type="button" class="btn btn-secondary" onclick="location.reload()">Transaksi Selanjutnya</button>
			<button type="button" class="btn btn-brand" onclick="printStruk()">Print</button>
		';
	}

	public function get_no_invoice()
	{
		$nomor = $this->t_transaksi->get_invoice();
		echo json_encode($nomor);
	}

	public function get_data_penjualan_edit()
	{
		$id = $this->input->post('id');
		$join = [ 
			['table' => 'm_member', 'on' => 't_transaksi.id_member = m_member.id']
		];

		$data_trans = $this->m_global->single_row('t_transaksi.*, m_member.kode_member', ['t_transaksi.id' => $id, 't_transaksi.is_kunci' => '0'], 't_transaksi', $join);
		
		if($data_trans) {
			$data_det = $this->m_global->multi_row('*', ['id_transaksi' => $data_trans->id], 't_transaksi_det');
			$retval = [
				'data' => $data_trans,
				'data_det' => $data_det,
				'status' => true,
			];
		}else{
			$retval = [
				'data' => null,
				'data_det' => null,
				'status' => false,
			];
		}
		echo json_encode($retval);
	}

	public function simpan_trans_reg()
	{
		$data_log_arr = [];
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
			'created_at' => $timestamp,
			'bulan_trans' => (int)$obj_date->format('m'),
			'tahun_trans' => (int)$obj_date->format('Y'),
			'tgl_trans' => $obj_date->format('Y-m-d')
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
					'created_at' => $timestamp
				];

				$insert_det = $this->t_transaksi_det->save($data_ins_det);
				$data_log_arr[] = $data_ins_det;
			}

			$data_upd_header = [
				'harga_total' => $total,
				'harga_bayar' => $this->input->post('pembayaran_reg_raw'),
				'harga_kembalian' => $this->input->post('kembalian_reg_raw'),
			];

			$update = $this->t_transaksi->update(['id'=> $id_header], $data_upd_header);

			$data_log = json_encode($data_log_arr);
			$this->lib_fungsi->catat_log_aktifitas('CREATE', null, $data_log);
		}
				
		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['id_trans'] = $id_header;
			$retval['status'] = false;
			$retval['button'] = false;
			$retval['pesan'] = 'Gagal memproses Data Transaksi';
		}else{
			$this->db->trans_commit();
			$retval['id_trans'] = $id_header;
			$retval['status'] = true;
			$retval['button'] = $this->get_div_button();
			$retval['pesan'] = 'Sukses memproses Data Transaksi';
		}

		echo json_encode($retval);
	}

	public function simpan_trans_mem()
	{
		$data_log_arr = [];
		$counter_mobil = 0;
		$counter_motor = 0;
		$is_add_cnt_mobil = false;
		$is_add_cnt_motor = false;

		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$list_item = $this->input->post('list_item_mem'); 
		$kode_member = $this->input->post('member_id');
		$data_member = $this->m_global->single_row('*', ['deleted_at' => null, 'kode_member' => $kode_member], 'm_member');

		if(!$data_member) {
			$data['inputerror'][] = 'member_id';
            $data['error_string'][] = 'Kode Member Tidak Ditemukan';
			$data['status'] = FALSE;
			$data['is_select2'][] = FALSE;
			echo json_encode($data);
			return;
		}
		
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
			'id_member' => $data_member->id,
			'id_user' => $this->session->userdata('id_user'),
			'created_at' => $timestamp,
			'bulan_trans' => (int)$obj_date->format('m'),
			'tahun_trans' => (int)$obj_date->format('Y'),
			'tgl_trans' => $obj_date->format('Y-m-d')
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
				$data_log_arr[] = $data_ins_det;
			}

			$data_upd_header = [
				'harga_total' => $total,
				'harga_bayar' => $this->input->post('pembayaran_mem_raw'),
				'harga_kembalian' => $this->input->post('kembalian_mem_raw')
			];

			$update = $this->t_transaksi->update(['id'=> $id_header], $data_upd_header);

			### cek tipe item
			for ($z = 0; $z < count($list_item); $z++) {
				$id_item = $this->input->post('id_item')[$z];
				$cek = $this->m_global->single_row('*', ['id' => $id_item], 'm_item_trans');
				if($cek->id_jenis_counter && $cek->id_jenis_counter == '1') {
					$is_add_cnt_mobil = true;
				}

				if ($cek->id_jenis_counter && $cek->id_jenis_counter == '2') {
					$is_add_cnt_motor = true;
				}
			}

			if($update) {
				$counter = $this->lib_fungsi->cek_counter($data_member->id);
				if ($counter != null) {
					foreach ($counter as $key => $value) {
						if ($value->id_jenis_counter == '1') {
							$counter_mobil = $value->total_count;
						} else if ($value->id_jenis_counter == '2') {
							$counter_motor = $value->total_count;
						}
					}
				}

				$ins_count = $this->lib_fungsi->insert_counter($data_member->id, $counter_mobil, $counter_motor, $is_add_cnt_mobil, $is_add_cnt_motor);

				if($ins_count === FALSE) {
					$this->db->trans_rollback();
					$retval['status'] = false;
					$retval['button'] = false;
					$retval['pesan'] = 'Gagal memproses Data Transaksi';
				}
			}

			$data_log = json_encode($data_log_arr);
			$this->lib_fungsi->catat_log_aktifitas('CREATE', null, $data_log);
		}
				
		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$retval['status'] = false;
			$retval['button'] = false;
			$retval['pesan'] = 'Gagal memproses Data Transaksi';
		}else{
			$this->db->trans_commit();
			$retval['status'] = true;
			$retval['button'] = $this->get_div_button();
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
		echo '<table border="1" width="100%">';
		for ($i=1; $i <= 30; $i++) { 
			
			$rundom = 'M'.rand();
			echo '<tr height="100px">';
			echo '<td width="5%">'.$i.'</td>';
			echo  '<td align="center">'.$this->barcode_lib->generate_html($rundom).'</td>';
			echo '<td>'.$rundom.'</td>';
			echo '</tr>';

		}
		echo '</table>';
		

	}

	public function simpan_barcode($value = '123456')
	{
		$this->barcode_lib->save_jpg($value);
	}


	////////////////////////////////////////////////////////////////////////////////

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
