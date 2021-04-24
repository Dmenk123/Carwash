<?php 
  $obj_date = new DateTime();
  $timestamp = $obj_date->format('Y-m-d H:i:s');
  $bln_now = (int)$obj_date->format('m');
  $thn_now = (int)$obj_date->format('Y');
  $thn_awal = $thn_now - 20;
  $thn_akhir = $thn_now + 20;
?>
<div class="modal fade modal_detail" tabindex="-1" role="dialog" aria-labelledby="add_menu" aria-hidden="true" id="div-penggajian-modal">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="div_diagnosa_modal_title">Penggajian</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        </button>
      </div>
      
      <div class="modal-body">
        <form id="form_penggajian" name="form_penggajian">
          <input type="hidden" class="form-control form-control-sm" id="id_trans_gaji" name="id_trans_gaji" value="">
          <input type="hidden" class="form-control form-control-sm" id="id_jenis_gaji" name="id_jenis_gaji" value="">
          <div class="col-md-12">
            <div class="kt-portlet__body">
              <div class="form-group">       
                <div class="col-12 row">
                  <label class="col-12 col-form-label">Item Transaksi :</label>
                </div>

                <div class="col-12 row">
                  <div class="col-12">
                    <select class="form-control kt-select2" id="item_gaji" name="item_gaji" style="width: 100%;">
                      <option value="">Silahkan Pilih Transaksi</option>
                    </select>
                    <span class="help-block"></span>
                  </div>
                </div>

                <div class="col-12 row">
                  <label class="col-3 col-form-label">Tahun :</label>
                  <label class="col-4 col-form-label">Bulan :</label>
                  <label class="col-5 col-form-label">Nilai Total Gaji :</label>
                </div>

                <div class="col-12 row">
                  <div class="col-3">
                    <select class="form-control select2" id="tahun_gaji" name="tahun_gaji" style="width: 100%;">
                      <option value="">Silahkan Pilih Tahun</option>
                      <?php 
                        for ($i=$thn_awal; $i <= $thn_akhir; $i++) { 
                          if($i == $thn_now) {
                            echo '<option value="'.$i.'" selected>'.$i.'</option>';
                          }else{
                            echo '<option value="'.$i.'">'.$i.'</option>';
                          }
                          
                        }
                      ?>
                    </select>
                    <span class="help-block"></span>
                  </div>
                  <div class="col-4">
                    <select class="form-control select2" id="bulan_gaji" name="bulan_gaji" style="width: 100%;">
                      <option value="">Silahkan Pilih Bulan</option>
                      <?php 
                        for ($i=1; $i <= 12; $i++) { 
                          if($i == $bln_now) {
                            echo '<option value="'.$i.'" selected>'.bulan_indo($i).'</option>';
                          }else{
                            echo '<option value="'.$i.'">'.bulan_indo($i).'</option>';
                          }
                          
                        }
                      ?>
                    </select>
                  </div>
                  <div class="col-5">
                    <input type="text" data-thousands="." data-decimal="," id="harga_gaji" name="harga_gaji" class="form-control inputmask" onkeyup="hitungTotalGaji()" value="0">
                    <input type="hidden" id="harga_gaji_raw" name="harga_gaji_raw" class="form-control" value="">
                    <span class="help-block"></span>
                  </div>
                  
                </div>
              </div>
              
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" id="btnSave" class="btn btn-primary" onclick="save('form_penggajian')">Tambahkan</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
      </div>
    </div>
  </div>
</div>
