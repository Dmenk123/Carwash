<?php 
  $obj_date = new DateTime();
  $timestamp = $obj_date->format('Y-m-d H:i:s');
  $bln_now = (int)$obj_date->format('m');
  $thn_now = (int)$obj_date->format('Y');
  $thn_awal = $thn_now - 20;
  $thn_akhir = $thn_now + 20;
?>
<div class="modal fade modal_detail" tabindex="-1" role="dialog" aria-labelledby="add_menu" aria-hidden="true" id="div-penerimaan-lain-lain-modal">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Penerimaan Lain-Lain</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        </button>
      </div>
      
      <div class="modal-body">
        <form id="form_in_lain" name="form_in_lain">
          <div class="col-md-12">
            <div class="kt-portlet__body">
              <div class="form-group">         
                <div class="col-12 row">
                  <label class="col-12 col-form-label">Pilih Penerimaan :</label>
                </div>

                <div class="col-12 row">
                  <div class="col-12">
                    <select class="form-control kt-select2" id="item_in" name="item_in" style="width: 100%;">
                      <option value="">Silahkan Pilih Penerimaan</option>
                    </select>
                    <span class="help-block"></span>
                  </div>
                </div>

                <div class="col-12 row">
                  <label class="col-6 col-form-label">Tahun :</label>
                  <label class="col-6 col-form-label">Bulan :</label>
                </div>

                <div class="col-12 row">
                  <div class="col-6">
                    <select class="form-control select2" id="tahun_in" name="tahun_in" style="width: 100%;">
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
                  <div class="col-6">
                    <select class="form-control select2" id="bulan_in" name="bulan_in" style="width: 100%;">
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
                </div>

                <div class="col-12 row">
                  <label class="col-2 col-form-label">Qty :</label>
                  <label class="col-5 col-form-label">Harga Satuan :</label>
                  <label class="col-5 col-form-label">Harga Total :</label>
                </div>

                <div class="col-12 row">
                  <div class="col-2">
                    <input type="text" class="form-control form-control-sm numberformat" id="qty_in" name="qty_in" value="" onkeyup="hitungTotalIn()">
                    <span class="help-block"></span>
                  </div>
                  <div class="col-5">
                    <input type="text" data-thousands="." data-decimal="," id="harga_in" name="harga_in" class="form-control form-control-sm inputmask" onkeyup="hitungTotalIn()" value="0">
                    <input type="hidden" id="harga_in_raw" name="harga_in_raw" class="form-control form-control-sm" value="">
                    <span class="help-block"></span>
                  </div>
                  <div class="col-5">
                    <input type="text" data-thousands="." data-decimal="," id="hargatot_in" name="hargatot_in" class="form-control form-control-sm inputmask" value="0">
                    <input type="hidden" id="hargatot_in_raw" name="hargatot_in_raw" class="form-control form-control-sm" value="">
                    <span class="help-block"></span>
                  </div>
                </div>
                <br>
                <div class="col-12">
                  <button type="button" id="btnSave" class="btn btn-primary" onclick="save('form_in_lain')">Tambahkan</button>
                </div>
                <div class="kt-separator kt-separator--border-dashed kt-separator--space-lg kt-separator--portlet-fit"></div>
               
                <div class=" col-lg-12 col-sm-12">
                  <h4>Tabel Penerimaan (10 Transaksi Terakhir)</h4>
                  <table class="table table-striped- table-bordered table-hover" id="tabel_modal_penerimaan_lain">
                    <thead>
                      <tr>
                        <th>No</th>
                        <th>Tanggal</th>
                        <th>Nama</th>
                        <th>Bulan</th>
                        <th>Tahun</th>
                        <th>Harga</th>
                        <th>Qty</th>
                        <th>Total</th>
                        <th style="width: 10%;">Aksi</th>
                      </tr>
                    </thead>
                    <tbody>
                    </tbody>
                  </table>
                </div>
              </div>
              
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
      </div>
    </div>
  </div>
</div>

