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

	private function load_tabel_laporan($id_jenis_trans, $tgl_awal, $tgl_akhir)
	{
		$data_laporan = $this->t_transaksi->get_laporan_transaksi($this->input->get('jenis'), $tgl_awal, $tgl_akhir);
				
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
			<table class="table table-bordered">
				<thead>
					<tr>
						<th style="text-align:center">No.</th>
						<th style="text-align:center">Tanggal</th>
						<th style="text-align:center">Kode</th>
						<th style="text-align:center">Jenis member</th>
						<th style="text-align:center">Member</th>
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
							<td>'.$value->nama_member.'</td>
							<td align="right">'.number_format($value->harga_satuan, 0 ,',','.').'</td>
						</tr>
					';
				}		
		$html .= '
				<tr>
					<td colspan="5" align="center"><strong>Jumlah Total</strong></td>
					<td align="right"><strong>'.number_format($total_harga, 0 ,',','.').'</strong></td>
				<tr>
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
						<th style="text-align:center">No.</th>
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
							<td>'.($key+1).'</td>
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
				<tr>
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
				<tr>
			</tbody>
		</table>';

		return $html;
	}
}
