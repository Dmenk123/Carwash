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
              <select class="form-control select2" id="selReg" name="jenis_penjualan" id="jenis_penjualan" style="width: 100%;border-radius: 0px;">
                <!-- <select class="wide select2 " multiple=""  name="mediaCtg"  data-select2-id="liveSrchMedia" tabindex="-1" aria-hidden="true"> -->
                  <?php foreach($penjualan as $row) { ?>
                    <option value="<?=$row->id?>" ><?=$row->nama?></option>
                  <?php } ?>
                </select>
                                 
                <div class="clearfix"></div>
              </div>
            </div>
            <div class="col-lg-3" data-select2-id="38">
              <div class="form-group" data-select2-id="37">
                <select id="liveSrchCity" class="wide select2-hidden-accessible select2" name="tahun" id="tahun" style="width: 100%;border-radius: 0px;" data-select2-id="liveSrchCity" tabindex="-1" aria-hidden="true">
                              <?php for ($i=2020;$i<=date("Y");$i++) { ?>
                              <option value="<?=$i?>" <?php if ($i == date('Y')) {
                                echo "selected"; } ?> ><?=$i?></option>
                              <?php } ?>
                                    
                </select>
                                  
                <div class="clearfix"></div>
              </div>
            </div>
            <div class="col-lg-2 col-md-2">
              <input type="submit" class="btn_search" onclick="search()" value="seacrh">
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



