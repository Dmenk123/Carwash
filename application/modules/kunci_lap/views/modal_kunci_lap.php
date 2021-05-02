<?php 
  $obj_date = new DateTime();
  $timestamp = $obj_date->format('Y-m-d H:i:s');
  $bln_now = (int)$obj_date->format('m');
  $thn_now = (int)$obj_date->format('Y');
  $thn_awal = $thn_now - 20;
  $thn_akhir = $thn_now + 20;
?>
<div class="modal fade modal_add_form" tabindex="-1" role="dialog" aria-labelledby="add_menu" aria-hidden="true" id="modal_kunci_form">
  <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modal_title"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        </button>
      </div>
      <div class="modal-body">
        <form id="form-user" name="form-user">
          <div class="form-group">
            <input type="hidden" class="form-control" id="id" name="id">
            <label for="lbl_username" class="form-control-label">Bulan:</label>
            <select name="bulan" id="bulan" class="select2 form-control" style="width: 100%;">
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
            <span class="help-block"></span>
          </div>
          <div class="form-group">
            <label for="lbl_username" class="form-control-label">Tahun:</label>
            <select name="tahun" id="tahun" class="form-control select2" style="width: 100%;">
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
         
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn_outline" data-dismiss="modal">Batal</button>
        <button type="button" class="btn btn_1" id="btnSave" onclick="save()">Simpan</button>
      </div>
    </div>
  </div>
</div>
