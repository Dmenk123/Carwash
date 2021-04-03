<?php
//defined('BASEPATH ') OR exit('No direct script access allowed');

class Home extends CI_Controller {
	
	public function __construct()
	{
		parent::__construct();
		$this->load->model('m_user');

		if($this->session->userdata('logged_in') === false) {
			return redirect('login');
		}
	}

	public function index()
	{	
		$tahun = date('Y');
		$bulan = date('m');
		$hari = date('d');
		$id_user = $this->session->userdata('id_user');
		$data_user = $this->m_user->get_detail_user($id_user);

		
		$data_dashboard = [];
		
		/**
		 * data passing ke halaman view content
		 */
		$data = array(
			'title' => 'Dashboard Aplikasi',
			'data_user' => $data_user
		);

		/**
		 * content data untuk template
		 * param (css : link css pada direktori assets/css_module)
		 * param (modal : modal komponen pada modules/nama_modul/views/nama_modal)
		 * param (js : link js pada direktori assets/js_module)
		 */
		$content = [
			'css' 	=> null,
			'modal' => null,
			'js'	=> 'dashboard.js',
			'view'	=> 'dashboard/view_dashboard'
		];

		$this->template_view->load_view($content, $data);
	}


	public function oops()
	{	
		$this->load->view('login/view_404');
	}

	public function bulan_indo($bulan)
	{
		$arr_bulan =  [
			1 => 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
		];

		return $arr_bulan[(int) $bulan];
	}

	public function monitoring()
	{
		$tahun = $this->input->post('tahun');
		$user   = ["tes"];
		$data['judul'] = "Grafik Penjualan per Tahun ".$tahun;
		$data['label'] = ["Januari","Februari","Maret","April","Mei","Juni","Juli","Agustus","September","Oktober","November","Desember"];
		// $result        = $this->model_app->eksekusi(jumlah_disposisi_user::sql_tahun($usercomma, $tahun2))->result_array();
		$data_mentah   = array();
		// foreach ($result as $key) {
		//   $data_mentah[$key['dari_user']][$key['bulan']] = $key['jumlah'];
		// }
		$label          = $data['label'];
		$data['data']   = array();
		$data_grafik    = array();

		for ($i=0; $i < count($label); $i++) {
		  if($i == 0) $no = '01';
		  elseif($i == 1) $no = '02';
		  elseif($i == 2) $no = '03';
		  elseif($i == 3) $no = '04';
		  elseif($i == 4) $no = '05';
		  elseif($i == 5) $no = '06';
		  elseif($i == 6) $no = '07';
		  elseif($i == 7) $no = '08';
		  elseif($i == 8) $no = '09';
		  elseif($i == 9) $no = '10';
		  elseif($i == 10) $no = '11';
		  elseif($i == 11) $no = '12';
			for ($j=0;$j<count($user);$j++) {
			  if($i==0) {
				$data_grafik[$j] = array();
				$data_grafik[$j]['data'] = array();
				// $aktif = "(Aktif)";
				// if($data_user[$user[$j]]['status'] <> 1) {
				//   $aktif = "(Tidak Aktif)";
				// }
				$data_grafik[$j]['label']       = 'tes';
				$data_grafik[$j]['backgroundColor'] = "#".$this->random_color();
				$data_grafik[$j]['fill']        = true;
			  }

			//   if(isset($data_mentah[$user[$j]][$no])) {
				$data_grafik[$j]['data'] = array(10,12,1,3,4,56,7,46,36,22,31,21);
			//   }
			//   else {
			// 	$data_grafik[$j]['data'][] = 0;
			//   }
			}
		}
		$data['datasets'] = $data_grafik;
		$data['status'] = true;
		echo json_encode($data);
	}

	function random_color(){
		mt_srand((double)microtime()*1000000);
		$c = '';
		while(strlen($c)<6){
		  $c .= sprintf("%02X", mt_rand(0, 255));
		}
		return $c;
	}
  

}
