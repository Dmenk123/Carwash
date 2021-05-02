<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Lap_transaksi extends CI_Controller {
	const ID_JENIS_PENJUALAN = 1;
	const ID_JENIS_PEMBELIAN = 2;
	const ID_JENIS_PENGGAJIAN = 3;
	const ID_JENIS_INVESTASI = 4;
	const ID_JENIS_OPERSAIONAL = 5;
	const ID_JENIS_PENGELUARAN_LAIN = 6;
	const ID_JENIS_PENERIMAAN_LAIN = 7;

	public function __construct()
	{
		parent::__construct();
		if($this->session->userdata('logged_in') === false) {
			return redirect('login');
		}

		$this->load->model('t_transaksi');
		$this->load->model('t_transaksi_det');
		$this->load->model('m_user');
		$this->load->model('m_global');
	}

	public function index()
	{	
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		
		### deklarasi variabel
		$arr_valid = [];
		$data_laporan = null;
		$periode = null;
		$jenis_trans_txt = null;
		$html = '';

		$id_user = $this->session->userdata('id_user'); 
		$data_user = $this->m_user->get_detail_user($id_user);
		$jenis_trans	= $this->m_global->multi_row('*', ['deleted_at' => null], 'm_jenis_trans', NULL, 'kode_jenis asc');
		$profil = $this->m_global->single_row('*', ['deleted_at' => null], 'm_profil');

		if($this->input->get('mulai') != null){
			$tgl_awal = $obj_date->createFromFormat('d/m/Y', $this->input->get('mulai'))->format('Y-m-d');
			$arr_valid[] = true;
		}else{
			$arr_valid[] = false;
		}

		if($this->input->get('akhir') != null){
			$tgl_akhir = $obj_date->createFromFormat('d/m/Y', $this->input->get('akhir'))->format('Y-m-d');
			$arr_valid[] = true;
		}else{
			$arr_valid[] = false;
		}

		if($this->input->get('jenis') != null){
			## cek valid jenis
			$cek = $this->m_global->single_row('*', ['id' => $this->input->get('jenis')], 'm_jenis_trans');
			if($cek) {
				$arr_valid[] = true;
				$jenis_trans_txt = $cek->nama_jenis;
			}else{
				$arr_valid[] = false;
			}
		}else{
			$arr_valid[] = false;
		}
		
		if (!in_array(false, $arr_valid)){
			if(isset($tgl_awal) && isset($tgl_akhir)) {
				$periode = $this->input->get('mulai').' s/d '.$this->input->get('akhir');
				$html .= $this->load_tabel_laporan($this->input->get('jenis'), $tgl_awal, $tgl_akhir);
			}
		}

		

		/**
		 * data passing ke halaman view content
		 */
		$data = array(
			'title' => 'Silahkan Pilih Laporan Transaksi',
			'data_user' => $data_user,
			'jenis_trans' => $jenis_trans,
			'data_laporan' => $data_laporan,
			'periode' => $periode,
			'profil' => $profil,
			'jenis_trans_txt' => $jenis_trans_txt,
			'html' => $html
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
			'js'	=> 'lap_transaksi.js',
			'view'	=> 'view_lap_transaksi'
		];

		$this->template_view->load_view($content, $data);
	}

	private function load_tabel_laporan($id_jenis_trans, $tgl_awal, $tgl_akhir, $is_excel=false)
	{
		$data_laporan = $this->t_transaksi->get_laporan_transaksi($id_jenis_trans, $tgl_awal, $tgl_akhir);

		if($is_excel) {
			return $data_laporan;
		}
				
		switch ((int)$id_jenis_trans) {
			case self::ID_JENIS_PENJUALAN:
				return $this->list_penjualan($data_laporan);
				break;

			case self::ID_JENIS_PEMBELIAN:
				return $this->list_data_pembelian($data_laporan);
				break;

			case self::ID_JENIS_PENGGAJIAN:
				return $this->list_data_global($data_laporan);
				break;

			case self::ID_JENIS_INVESTASI:
				return $this->list_data_global($data_laporan);
				break;

			case self::ID_JENIS_OPERSAIONAL:
				return $this->list_data_global($data_laporan);
				break;

			case self::ID_JENIS_PENGELUARAN_LAIN:
				return $this->list_data_global($data_laporan);
				break;

			case self::ID_JENIS_PENERIMAAN_LAIN:
				return $this->list_data_global($data_laporan);
				break;
			
			default:
				return false;
				break;
		}
	}

	public function list_penjualan($data)
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$total_harga = 0;
		$html = '
			<table id="tbl_content" class="table table-bordered table-hover" cellspacing="0" width="100%" border="2">
				<thead>
					<tr>
						<th style="width: 5%;text-align:center">No.</th>
						<th style="width: 10%;text-align:center">Tanggal</th>
						<th style="width: 15%;text-align:center">Kode</th>
						<th style="width: 10%; text-align:center">Jenis member</th>
						<th style="width: 10%; text-align:center">Kode member</th>
						<th style="width: 30%;text-align:center">Member</th>
						<th style="text-align:center">Harga Satuan</th>
					</tr>
				</thead>
				<tbody>';
				foreach ($data as $key => $value) {
					$total_harga += $value->harga_satuan;
					$is_jenis = ($value->id_member == '1') ? 'Member' : 'Reguler';
					$html .= '
						<tr>
							<td>'.($key+1).'</td>
							<td>'.$obj_date->createFromFormat('Y-m-d', $value->tgl_trans)->format('d/m/Y').'</td>
							<td>'.$value->kode.'</td>
							<td>'.$is_jenis.'</td>
							<td>'.$value->kode_member.'</td>
							<td>'.$value->nama_member.'</td>
							<td align="right">'.number_format($value->harga_satuan, 0 ,',','.').'</td>
						</tr>
					';
				}		
		$html .= '
				<tr>
					<td colspan="6" align="center"><strong>Jumlah Total</strong></td>
					<td align="right"><strong>'.number_format($total_harga, 0 ,',','.').'</strong></td>
				</tr>
			</tbody>
		</table>';
		// var_dump($html);exit;
		return $html;
	}

	public function list_data_pembelian($data)
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$total_harga = 0;

		$html = '
			<table class="table table-bordered">
				<thead>
					<tr>
						<th style="width: 5%;text-align:center">No.</th>
						<th style="text-align:center">Tanggal</th>
						<th style="text-align:center">Nama</th>
						<th style="text-align:center">Supplier</th>
						<th style="text-align:center">Qty</th>
						<th style="text-align:center">Harga Satuan</th>
						<th style="text-align:center">Harga Total</th>
					</tr>
				</thead>
				<tbody>';
				foreach ($data as $key => $value) {
					$total_harga += $value->harga_total;
					$html .= '
						<tr>
							<td align="center">'.($key+1).'</td>
							<td>'.$obj_date->createFromFormat('Y-m-d', $value->tgl_trans)->format('d/m/Y').'</td>
							<td>'.$value->nama.'</td>
							<td>'.$value->nama_supplier.'</td>
							<td>'.number_format($value->qty, 0 ,',','.').'</td>
							<td align="right">'.number_format($value->harga_satuan, 0 ,',','.').'</td>
							<td align="right">'.number_format($value->harga_total, 0 ,',','.').'</td>
						</tr>
					';
				}		
		$html .= '
				<tr>
					<td colspan="6" align="center"><strong>Jumlah Total</strong></td>
					<td align="right"><strong>'.number_format($total_harga, 0 ,',','.').'</strong></td>
				</tr>
			</tbody>
		</table>';

		return $html;
	}

	public function list_data_global($data)
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$total_harga = 0;

		$html = '
			<table class="table table-bordered">
				<thead>
					<tr>
						<th style="text-align:center">No.</th>
						<th style="text-align:center">Tanggal</th>
						<th style="text-align:center">Nama</th>
						<th style="text-align:center">Bulan</th>
						<th style="text-align:center">Tahun</th>
						<th style="text-align:center">Harga Total</th>
					</tr>
				</thead>
				<tbody>';
				foreach ($data as $key => $value) {
					$total_harga += $value->harga_total;
					$html .= '
						<tr>
							<td>'.($key+1).'</td>
							<td>'.$obj_date->createFromFormat('Y-m-d', $value->tgl_trans)->format('d/m/Y').'</td>
							<td>'.$value->nama.'</td>
							<td>'.bulan_indo((int)$value->bulan_trans).'</td>
							<td>'.$value->tahun_trans.'</td>
							<td align="right">'.number_format($value->harga_total, 0 ,',','.').'</td>
						</tr>
					';
				}		
		$html .= '
				<tr>
					<td colspan="5" align="center"><strong>Jumlah Total</strong></td>
					<td align="right"><strong>'.number_format($total_harga, 0 ,',','.').'</strong></td>
				</tr>
			</tbody>
		</table>';

		return $html;
	}

	public function cetak_laporan()
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$mulai = $this->input->post('mulai');
		$akhir = $this->input->post('akhir');
		$jenis = $this->input->post('jenis');

		$tgl_awal = $obj_date->createFromFormat('d/m/Y', $mulai)->format('Y-m-d');
		$tgl_akhir = $obj_date->createFromFormat('d/m/Y', $akhir)->format('Y-m-d');
		
		$cek = $this->m_global->single_row('*', ['id' => $jenis], 'm_jenis_trans');
		$jenis_trans_txt = $cek->nama_jenis;
		$periode = $mulai.' s/d '.$akhir;

		#### nanti dilakukan pengecekan disini
		$data = $this->load_tabel_laporan($jenis, $tgl_awal, $tgl_akhir);
		$periode = $tgl_awal.' s/d '.$tgl_akhir;
		$profil = $this->m_global->single_row('*', ['deleted_at' => null], 'm_profil');

		$retval = [
			'data' => $data,
			'title' => 'Laporan Transaksi '.$jenis_trans_txt,
			'periode' => 'Periode '.$periode,
			'profil' => $profil,
		];
		
		// echo "<pre>";
		// print_r ($retval);
		// echo "</pre>";
		// exit;

		// $this->load->view('view_lap_transaksi_pdf', $retval);
		$html = $this->load->view('view_lap_transaksi_pdf', $retval, true);
	    $filename = 'laporan_transaksi_'.$jenis_trans_txt.'_'.time();
	    $this->lib_dompdf->generate($html, $filename, true, 'legal', 'potrait');
	}

	public function import_excel()
	{
		$obj_date = new DateTime();
		$timestamp = $obj_date->format('Y-m-d H:i:s');
		$mulai = $this->input->get('mulai');
		$akhir = $this->input->get('akhir');
		$jenis = $this->input->get('jenis');
		$tgl_awal = $obj_date->createFromFormat('d/m/Y', $mulai)->format('Y-m-d');
		$tgl_akhir = $obj_date->createFromFormat('d/m/Y', $akhir)->format('Y-m-d');
		
		#### nanti dilakukan pengecekan disini
		$data = $this->load_tabel_laporan($jenis, $tgl_awal, $tgl_akhir, true);
		$periode = $tgl_awal.' s/d '.$tgl_akhir;
		$profil = $this->m_global->single_row('*', ['deleted_at' => null], 'm_profil');
		$cek = $this->m_global->single_row('*', ['id' => $jenis], 'm_jenis_trans');
		$jenis_trans_txt = $cek->nama_jenis;
		// echo "<pre>";
		// print_r ($data);
		// echo "</pre>";
		// exit;

		if($data) {
			$counter = count($data)+1;
		}else{
			$counter = 1;
		}

		$spreadsheet = $this->excel->spreadsheet_obj();
		$writer = $this->excel->xlsx_obj($spreadsheet);
		$number_format_obj = $this->excel->number_format_obj();
		
		if($jenis == self::ID_JENIS_PENJUALAN) {
			$spreadsheet
				->getActiveSheet()
				->getStyle('A1:G'.$counter)
				->getNumberFormat()
				->setFormatCode('#');

			$sheet = $spreadsheet->getActiveSheet();

			$sheet
				->setCellValue('A1', 'No')
				->setCellValue('B1', 'Tanggal')
				->setCellValue('C1', 'Kode')
				->setCellValue('D1', 'Jenis Member')
				->setCellValue('E1', 'Kode Member')
				->setCellValue('F1', 'Member')
				->setCellValue('G1', 'Harga Satuan');
			
			$no = 1;
			$startRow = 2;
			$row = $startRow;
			if($data){
				$grand_total = 0;
				foreach ($data as $key => $val) {
					$harga_total = 0;
					$is_jenis = ($val->id_member == '1') ? 'Member' : 'Reguler';
					$harga_total += $val->harga_total;
					$grand_total += $val->harga_total;						
					
					$sheet
						->setCellValue("A{$row}", $no++)
						->setCellValue("B{$row}", $obj_date->createFromFormat('Y-m-d', $val->tgl_trans)->format('d/m/Y'))
						->setCellValue("C{$row}", $val->kode)
						->setCellValue("D{$row}", $is_jenis)
						->setCellValue("E{$row}", $val->kode_member)
						->setCellValue("F{$row}", $val->nama_member)
						->setCellValue("G{$row}", $harga_total);
					$row++;
				}
	
				$sheet->mergeCells("A{$row}:F{$row}");
				$sheet
						->setCellValue("A{$row}", 'Grand Total')
						->setCellValue("G{$row}", $grand_total);
					$row++;
	
				$endRow = $row - 1;
			}
		} else if($jenis == self::ID_JENIS_PEMBELIAN) {
			$spreadsheet
				->getActiveSheet()
				->getStyle('A1:G'.$counter)
				->getNumberFormat()
				->setFormatCode('#');

			$sheet = $spreadsheet->getActiveSheet();

			$sheet
				->setCellValue('A1', 'No')
				->setCellValue('B1', 'Tanggal')
				->setCellValue('C1', 'Nama')
				->setCellValue('D1', 'Supplier')
				->setCellValue('E1', 'Qty')
				->setCellValue('F1', 'Harga Satuan')
				->setCellValue('G1', 'Harga Total');
			
			$no = 1;
			$startRow = 2;
			$row = $startRow;
			if($data){
				$grand_total = 0;
				foreach ($data as $key => $val) {
					$grand_total += $val->harga_total;						
					
					$sheet
						->setCellValue("A{$row}", $no++)
						->setCellValue("B{$row}", $obj_date->createFromFormat('Y-m-d', $val->tgl_trans)->format('d/m/Y'))
						->setCellValue("C{$row}", $val->nama)
						->setCellValue("D{$row}", $val->nama_supplier)
						->setCellValue("E{$row}", number_format($val->qty, 0 ,',','.'))
						->setCellValue("F{$row}", $val->harga_satuan)
						->setCellValue("G{$row}", $val->harga_total);
					$row++;
				}
	
				$sheet->mergeCells("A{$row}:F{$row}");
				$sheet
						->setCellValue("A{$row}", 'Grand Total')
						->setCellValue("G{$row}", $grand_total);
					$row++;
	
				$endRow = $row - 1;
			}
		} else {
			$spreadsheet
				->getActiveSheet()
				->getStyle('A1:F'.$counter)
				->getNumberFormat()
				->setFormatCode('#');

			$sheet = $spreadsheet->getActiveSheet();

			$sheet
				->setCellValue('A1', 'No')
				->setCellValue('B1', 'Tanggal')
				->setCellValue('C1', 'Nama')
				->setCellValue('D1', 'Bulan')
				->setCellValue('E1', 'Tahun')
				->setCellValue('F1', 'Harga Total');
			
			$no = 1;
			$startRow = 2;
			$row = $startRow;
			if($data){
				$grand_total = 0;
				foreach ($data as $key => $val) {
					$grand_total += $val->harga_total;						
					
					$sheet
						->setCellValue("A{$row}", $no++)
						->setCellValue("B{$row}", $obj_date->createFromFormat('Y-m-d', $val->tgl_trans)->format('d/m/Y'))
						->setCellValue("C{$row}", $val->nama)
						->setCellValue("D{$row}", bulan_indo((int)$val->bulan_trans))
						->setCellValue("E{$row}", $val->tahun_trans)
						->setCellValue("F{$row}", $val->harga_total);
					$row++;
				}
	
				$sheet->mergeCells("A{$row}:E{$row}");
				$sheet
						->setCellValue("A{$row}", 'Grand Total')
						->setCellValue("F{$row}", $grand_total);
					$row++;
	
				$endRow = $row - 1;
			}
		}
		
		
		$filename = 'laporan_transaksi_'.$jenis_trans_txt.'_'.time();
		
		header('Content-Type: application/vnd.ms-excel');
		header('Content-Disposition: attachment;filename="'. $filename .'.xlsx"'); 
		header('Cache-Control: max-age=0');

		$writer->save('php://output');
		
	}
}
