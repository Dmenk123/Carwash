<?php
$obj_date = new DateTime();
?>
<!-- begin:: Content -->
<div class="kt-content  kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor" id="kt_content">

  <!-- begin:: Content Head -->
  <div class="kt-subheader   kt-grid__item" id="kt_subheader">
    <div class="kt-container  kt-container--fluid ">
      <div class="kt-subheader__main">
        <h3 class="kt-subheader__title">
          <?= $this->template_view->nama('judul').' - '.$title; ?>
        </h3>
      </div>
    </div>
  </div>
  <!-- end:: Content Head -->

  <!-- begin:: Content -->
  <div class="kt-container  kt-container--fluid  kt-grid__item kt-grid__item--fluid">
    <!-- form data -->
    <div class="kt-portlet kt-portlet--mobile">
      <div class="kt-portlet__head kt-portlet__head--lg">
        <div class="kt-portlet__head-label">
          <h3 class="kt-portlet__head-title">
            Pilih Jenis Customer
          </h3>
        </div>
      </div>
      <div class="kt-portlet__body">
        <div class="form-group row form-group-marginless kt-margin-t-20">
          <div class="col-lg-6 div_menu" data-id="div_nonmember" style="cursor:pointer">
            <div class="kt-portlet kt-iconbox kt-iconbox--warning kt-iconbox--animate-slow">
              <div class="kt-portlet__body">
                <div class="kt-iconbox__body">
                  <div class="kt-iconbox__icon">
                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1" class="kt-svg-icon">
                      <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                          <polygon points="0 0 24 0 24 24 0 24"/>
                          <path d="M12,11 C9.790861,11 8,9.209139 8,7 C8,4.790861 9.790861,3 12,3 C14.209139,3 16,4.790861 16,7 C16,9.209139 14.209139,11 12,11 Z" fill="#000000" fill-rule="nonzero" opacity="0.3"/>
                          <path d="M3.00065168,20.1992055 C3.38825852,15.4265159 7.26191235,13 11.9833413,13 C16.7712164,13 20.7048837,15.2931929 20.9979143,20.2 C21.0095879,20.3954741 20.9979143,21 20.2466999,21 C16.541124,21 11.0347247,21 3.72750223,21 C3.47671215,21 2.97953825,20.45918 3.00065168,20.1992055 Z" fill="#000000" fill-rule="nonzero"/>
                      </g>
                  </svg>
                  </div>
                  <div class="kt-iconbox__desc">
                    <h5 class="kt-iconbox__title">
                      Non Member
                    </h5>
                    <div class="kt-iconbox__content">
                    Reguler
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-6 div_menu" data-id="div_member" style="cursor:pointer">
            <div class="kt-portlet kt-iconbox kt-iconbox--success kt-iconbox--animate-slow">
              <div class="kt-portlet__body">
                <div class="kt-iconbox__body">
                  <div class="kt-iconbox__icon">
                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1" class="kt-svg-icon">
                      <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                          <rect x="0" y="0" width="24" height="24"/>
                          <path d="M18,2 L20,2 C21.6568542,2 23,3.34314575 23,5 L23,19 C23,20.6568542 21.6568542,22 20,22 L18,22 L18,2 Z" fill="#000000" opacity="0.3"/>
                          <path d="M5,2 L17,2 C18.6568542,2 20,3.34314575 20,5 L20,19 C20,20.6568542 18.6568542,22 17,22 L5,22 C4.44771525,22 4,21.5522847 4,21 L4,3 C4,2.44771525 4.44771525,2 5,2 Z M12,11 C13.1045695,11 14,10.1045695 14,9 C14,7.8954305 13.1045695,7 12,7 C10.8954305,7 10,7.8954305 10,9 C10,10.1045695 10.8954305,11 12,11 Z M7.00036205,16.4995035 C6.98863236,16.6619875 7.26484009,17 7.4041679,17 C11.463736,17 14.5228466,17 16.5815,17 C16.9988413,17 17.0053266,16.6221713 16.9988413,16.5 C16.8360465,13.4332455 14.6506758,12 11.9907452,12 C9.36772908,12 7.21569918,13.5165724 7.00036205,16.4995035 Z" fill="#000000"/>
                      </g>
                    </svg>
                  </div>
                  <div class="kt-iconbox__desc">
                    <h5 class="kt-iconbox__title">
                      Member
                    </h5>
                    <div class="kt-iconbox__content">
                    Member
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="kt-portlet kt-portlet--mobile">
      <div class="kt-portlet__head kt-portlet__head--lg">
        <div class="kt-portlet__head-label">
          <h3 class="kt-portlet__head-title" id="title_form_penjualan"></h3>
        </div>
      </div>

      <!-- div reguler -->
      <div class="kt-portlet__body" id="divReguler">
        <div class="col-12 row">
          <div class="kt-portlet col-7">
            <div class="kt-portlet__head">
              <div class="kt-portlet__head-label">
                <h3 class="kt-portlet__head-title">
                  Formulir Penjualan
                </h3>
              </div>
            </div>

            <!--begin::Form-->
            <form class="kt-form kt-form--label-right" id="formPenjualanReg">
              <div class="kt-portlet__body">
                <div class="form-group">
                  <label>List Penjualan:</label>
                    <select class="form-control select2_multi" id="selReg" name="list_reg[]" multiple="multiple">
                      <?php foreach ($list_item as $key => $value) {
                        echo '<option value="'.$value->id.'">'.$value->nama.'</option>';
                      } ?>
                    </select>
                  <span class="help-block"></span>
                </div>
              </div>
              <div class="kt-portlet__foot">
                <div class="kt-form__actions kt-form__actions--right">
                  <button type="reset" class="btn btn-brand">Submit</button>
                  <button type="reset" class="btn btn-secondary">Cancel</button>
                </div>
              </div>
            </form>

            <!--end::Form-->
          </div>
          
          <div class="kt-portlet col-5">
            <div class="kt-portlet__head">
              <div class="kt-portlet__head-label">
                <h3 class="kt-portlet__head-title"></h3>
              </div>
            </div>

            <!--begin::Form-->
            <form class="kt-form kt-form--label-right" id="formPenjualanReg">
              <div class="kt-portlet__body" id="list_penjualan_reg"></div>
              <div class="kt-portlet__foot">
                <div class="kt-form__actions kt-form__actions--right">
                  <!-- <button type="reset" class="btn btn-brand">Submit</button>
                  <button type="reset" class="btn btn-secondary">Cancel</button> -->
                </div>
              </div>
            </form>

            <!--end::Form-->
          </div>
        </div>
      </div>
      
      <!-- div member -->
      <div class="kt-portlet__body" id="divMember">
        <div class="col-12 row">
          <div class="kt-portlet col-7">
            <div class="kt-portlet__head">
              <div class="kt-portlet__head-label">
                <h3 class="kt-portlet__head-title">
                  Formulir Penjualan
                </h3>
              </div>
            </div>

            <!--begin::Form-->
            <form class="kt-form kt-form--label-right" id="formPenjualanReg">
              <div class="kt-portlet__body">
                <div class="form-group">
                  <label>Nama:</label>
                  <input type="text" class="form-control" readonly>
                </div>
                <div class="form-group">
                  <label>Alamat:</label>
                  <input type="text" class="form-control" readonly>
                </div>
                <div class="form-group">
                  <label>Hp:</label>
                  <input type="text" class="form-control" readonly>
                </div>
                <div class="form-group">
                  <label>Email:</label>
                  <input type="text" class="form-control" readonly>
                </div>
              </div>
              <div class="kt-portlet__foot">
                <div class="kt-form__actions kt-form__actions--right">
                  <button type="reset" class="btn btn-brand">Submit</button>
                  <button type="reset" class="btn btn-secondary">Cancel</button>
                </div>
              </div>
            </form>

            <!--end::Form-->
          </div>
          
          <div class="kt-portlet col-5">
            <div class="kt-portlet__head">
              <div class="kt-portlet__head-label">
                <h3 class="kt-portlet__head-title">
                  Right Action Bar
                </h3>
              </div>
            </div>

            <!--begin::Form-->
            <form class="kt-form kt-form--label-right" id="formPenjualanReg">
              <div class="kt-portlet__body">
                <div class="form-group">
                  <label>Full Name:</label>
                  <input type="email" class="form-control" placeholder="Enter full name">
                  <span class="form-text text-muted">Please enter your full name</span>
                </div>
                <div class="form-group">
                  <label>Email address:</label>
                  <input type="email" class="form-control" placeholder="Enter email">
                  <span class="form-text text-muted">We'll never share your email with anyone else</span>
                </div>
                <div class="form-group">
                  <label>Communication:</label>
                  <div class="kt-checkbox-list">
                    <label class="kt-checkbox">
                      <input type="checkbox"> Email
                      <span></span>
                    </label>
                    <label class="kt-checkbox">
                      <input type="checkbox"> SMS
                      <span></span>
                    </label>
                    <label class="kt-checkbox">
                      <input type="checkbox"> Phone
                      <span></span>
                    </label>
                  </div>
                </div>
              </div>
              <div class="kt-portlet__foot">
                <div class="kt-form__actions kt-form__actions--right">
                  <!-- <button type="reset" class="btn btn-brand">Submit</button>
                  <button type="reset" class="btn btn-secondary">Cancel</button> -->
                </div>
              </div>
            </form>

            <!--end::Form-->
          </div>
        </div>
        


        <!-- <div class="form-group row form-group-marginless kt-margin-t-20">
          <label class="col-lg-1 col-form-label">Tanggal:</label>
          <div class="col-lg-2">
            <input type="text" class="form-control mask_tanggal" id="tanggal_reg" name="tanggal_reg" autocomplete="off" value="<?php if(isset($data_reg)) {echo DateTime::createFromFormat('Y-m-d', $data_reg->tanggal_reg)->format('d/m/Y');}else{echo $obj_date->format('d/m/Y');} ?>">
            <span class="help-block"></span>
          </div>
          <label class="col-lg-1 col-form-label">Pukul:</label>
          
          <div class="col-lg-2">
            <div class="input-group timepicker">
              <input class="form-control" id="jam_reg" name="jam_reg" readonly placeholder="Pilih Jam" type="text" value="<?php if(isset($data_reg)) {echo $data_reg->jam_reg;}?>">
              <div class="input-group-append">
                <span class="input-group-text">
                  <i class="la la-clock-o"></i>
                </span>
              </div>
            </div>
            <span class="help-block"></span>
          </div>

          <label class="col-lg-1 col-form-label">Umur:</label>
          <div class="col-lg-1">
            <input type="text" class="form-control numberinput" id="umur_reg" name="umur_reg" autocomplete="off" value="<?php if(isset($data_reg)) {echo $data_reg->umur;} ?>">
            <span class="help-block"></span>
          </div>

          <label class="col-lg-1 col-form-label">Pemetaan:</label>
          <div class="col-lg-3">
            <select class="form-control required" name="pemetaan" id="pemetaan">
              <?php
                foreach ($data_pemetaan as $keys => $vals) { ?>
                  <option value='<?= $vals->id; ?>' <?php if(isset($data_reg) && $data_reg->id_pemetaan == $vals->id) {echo "selected";} ?>> <?= $vals->keterangan; ?> </option>;
              <?php } ?>
            </select>
            <span class="help-block"></span>
          </div>

        </div> -->
        
      </div>

      <!-- <div class="kt-portlet__foot">
        <div class="kt-form__actions">
          <div class="row">
            <div class="col-lg-5"></div>
            <div class="col-lg-7">
              <button type="button" class="btn btn-brand" onclick="save()">Simpan</button>
              <a type="button" class="btn btn-secondary" href="<?= base_url($this->uri->segment(1))?>">Batal</a>
            </div>
          </div>
        </div>
      </div> -->
    </div>
  </div>
</div>



