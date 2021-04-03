<style>
  .select2-selection__clear {
    top: 26%!important;
  }
</style>
<!-- begin:: Content -->
<div class="kt-content  kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor" id="kt_content">

  <!-- begin:: Content Head -->
  <div class="kt-subheader   kt-grid__item" id="kt_subheader">
    <div class="kt-container  kt-container--fluid ">
      <div class="kt-subheader__main">
        <h3 class="kt-subheader__title">
          <?= $title ?>
        </h3>
      </div>
    </div>
  </div>
  <!-- end:: Content Head -->

  <!-- begin:: Content -->
  <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
    
    <div class="kt-portlet kt-portlet--mobile">
      <div class="kt-portlet__head kt-portlet__head--lg">
        <div class="kt-portlet__head-label">
          <span class="kt-portlet__head-icon">
            <i class="kt-font-brand flaticon2-line-chart"></i>
          </span>
          <h3 class="kt-portlet__head-title">
            <?= $title; ?>
          </h3>
        </div>
        <div class="kt-portlet__head-toolbar">
          <div class="kt-portlet__head-wrapper">
            <div class="kt-portlet__head-actions">
            </div>
          </div>
        </div>
      </div>
      <div class="kt-portlet__body">
      <!-- body -->
      <div class="serach-navbar d-none d-lg-block d-xl-block" data-select2-id="14">
        <form id="form-pegawai">
          <div class="row no-gutters custom-search-input-3">
            <div class="col-lg-7">
              <div class="form-group">
              <select class="form-control select2" id="selReg" name="jenis_penjualan" style="width: 100%;border-radius: 0px;">
                <!-- <select class="wide select2 " multiple=""  name="mediaCtg"  data-select2-id="liveSrchMedia" tabindex="-1" aria-hidden="true"> -->
                  <option value="" data-select2-id="6">Semua Media</option>
                                    <option value="1" >Billboard</option>
                                    <option value="2" >Baliho</option>
                                    <option value="3" >JPO</option>
                                    <option value="4" >Videotron</option>
                                    <option value="5" >Road Sign</option>
                                    <option value="6" >Midi Board</option>
                                    <option value="8" >Bando Jalan</option>
                                    <option value="9" >Indoor</option>
                                    <option value="10" >Pusat Perbelanjaan</option>
                                    <option value="11" >Gedung</option>
                                    <option value="12" >Stasiun</option>
                                    <option value="13" >Terminal</option>
                                    <option value="14" >Bandara</option>
                                    <option value="15" >Pelabuhan</option>
                                    <option value="16" >Branding</option>
                                    <option value="17" >Transportasi</option>
                                    <option value="18" >Taman</option>
                                    <option value="19" >Toko</option>
                                    <option value="20" >Mural</option>
                                    <option value="21" >Neonbox</option>
                                    <option value="22" >Display Screen</option>
                                  </select>
                                 
                <div class="clearfix"></div>
              </div>
            </div>
            <div class="col-lg-3" data-select2-id="38">
              <div class="form-group" data-select2-id="37">
                <select id="liveSrchCity" class="wide select2-hidden-accessible select2" name="tahun" style="width: 100%;border-radius: 0px;" data-select2-id="liveSrchCity" tabindex="-1" aria-hidden="true">
                              <?php for ($i=2020;$i<=date("Y");$i++) { ?>
                              <option value="<?=$i?>" <?php if ($i == date('Y')) {
                                echo "selected"; } ?> ><?=$i?></option>
                              <?php } ?>
                                    
                </select>
                                  
                <div class="clearfix"></div>
              </div>
            </div>
            <div class="col-lg-2 col-md-2">
              <input type="submit" class="btn_search" onclick="search()">
            </div>
          </div>
        </form>
      </div>
      <br>
      <br>
        <div class="col-lg-12">
          <canvas id="line-chart" width="800" height="450"></canvas>
        </div>
      <!-- body -->
      </div>
    </div>
  </div>
  
</div>



