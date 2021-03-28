var save_method;
var table;

$(document).ready(function() {
    $('#formPenjualanReg').submit(function (e) { 
        e.preventDefault();
        var form = $('#formPenjualanReg')[0];
        var data = new FormData(form);
        swalConfirm.fire({
            title: 'Simpan Data Transaksi ?',
            text: "Transaksi akan disimpan ?",
            type: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Ya, Simpan Data !',
            cancelButtonText: 'Tidak, Batalkan!',
            reverseButtons: true
          }).then((result) => {
            if (result.value) {
                $.ajax({
                    type: "POST",
                    enctype: 'multipart/form-data',
                    url : base_url + 'penjualan/simpan_trans_reg',
                    data: data,
                    dataType: "JSON",
                    processData: false, // false, it prevent jQuery form transforming the data into a query string
                    contentType: false, 
                    cache: false,
                    timeout: 600000,
                    success: function(data)
                    {
                        if(data.status) {
                            swalConfirm.fire('Berhasil Proses Transaksi!', data.pesan, 'success');
                            // table.ajax.reload();
                        }else{
                            for (var i = 0; i < data.inputerror.length; i++) 
                            {
                                if (data.inputerror[i] != 'list_item_reg') {
                                    $('[name="'+data.inputerror[i]+'"]').addClass('is-invalid');
                                    $('[name="'+data.inputerror[i]+'"]').next().text(data.error_string[i]).addClass('invalid-feedback'); //select span help-block class set text error string
                                }else{
                                    //ikut style global
                                    $('[name="'+data.inputerror[i]+'"]').next().next().text(data.error_string[i]).addClass('invalid-feedback-select');
                                }
                            }
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown)
                    {
                        Swal.fire('Terjadi Kesalahan');
                    }
                });
            } else if (
              /* Read more about handling dismissals below */
              result.dismiss === Swal.DismissReason.cancel
            ) {
              swalConfirm.fire(
                'Dibatalkan',
                'Aksi Dibatalakan',
                'error'
              )
            }
        });
    });

    $('#formPenjualanMem').submit(function (e) { 
        e.preventDefault();
        var form = $('#formPenjualanMem')[0];
        var data = new FormData(form);
        swalConfirm.fire({
            title: 'Simpan Data Transaksi Member?',
            text: "Transaksi akan disimpan ?",
            type: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Ya, Simpan Data !',
            cancelButtonText: 'Tidak, Batalkan!',
            reverseButtons: true
          }).then((result) => {
            if (result.value) {
                $.ajax({
                    type: "POST",
                    enctype: 'multipart/form-data',
                    url : base_url + 'penjualan/simpan_trans_mem',
                    data: data,
                    dataType: "JSON",
                    processData: false, // false, it prevent jQuery form transforming the data into a query string
                    contentType: false, 
                    cache: false,
                    timeout: 600000,
                    success: function(data)
                    {
                        if(data.status) {
                            swalConfirm.fire('Berhasil Proses Transaksi!', data.pesan, 'success');
                            // table.ajax.reload();
                        }else{
                            for (var i = 0; i < data.inputerror.length; i++) 
                            {
                                if (data.inputerror[i] != 'list_item_mem') {
                                    $('[name="'+data.inputerror[i]+'"]').addClass('is-invalid');
                                    $('[name="'+data.inputerror[i]+'"]').next().text(data.error_string[i]).addClass('invalid-feedback'); //select span help-block class set text error string
                                }else{
                                    //ikut style global
                                    $('[name="'+data.inputerror[i]+'"]').next().next().text(data.error_string[i]).addClass('invalid-feedback-select');
                                }
                            }
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown)
                    {
                        Swal.fire('Terjadi Kesalahan');
                    }
                });
            } else if (
              /* Read more about handling dismissals below */
              result.dismiss === Swal.DismissReason.cancel
            ) {
              swalConfirm.fire(
                'Dibatalkan',
                'Aksi Dibatalakan',
                'error'
              )
            }
        });
    });

    $(document).on('click', '.div_menu', function(){
        var nama_menu = $(this).data('id');
        
        $.ajax({
            type: "get",
            url : base_url + 'penjualan/get_no_invoice',
            // data: {},
            dataType: "json",
            success: function (response) {
                if(nama_menu == 'reguler') {
                    $('#divReguler').css("display", "block");
                    $('#divMember').css("display", "none");
                    $('span#inv_reg').text(response);
                }else{
                    $('#divReguler').css("display", "none");
                    $('#divMember').css("display", "block");
                    $('#inv_mem').text(response);
                    $('#member_id').focus();
                }
        
                $('html, body').animate({
                    scrollTop: $(".form_penjualan_area").offset().top
                }, 300);
                reInitSelectMulti();
            }
        });
    });

    $("#selReg").on('change', function (e) { 
        let totTransReg = 0;
        let strAppend = '';
        let arrItem = [];
        $.each($(this).find(":selected"), function (i, item) { 
            arrItem.push(item.value);
            // console.log(item.value);
        });

        $.ajax({
            type: "get",
            url  : base_url + "penjualan/get_detail_item",
            data: {arrItem : arrItem},
            dataType: "json",
            success: function (response) {
                $('tbody#list_penjualan_reg').html(response.html);
            }
        });
    }); 

    $("#selMem").on('change', function (e) { 
        let totTransReg = 0;
        let strAppend = '';
        let arrItem = [];
        $.each($(this).find(":selected"), function (i, item) { 
            arrItem.push(item.value);
            // console.log(item.value);
        });

        $.ajax({
            type: "get",
            url  : base_url + "penjualan/get_detail_item",
            data: {arrItem : arrItem},
            dataType: "json",
            success: function (response) {
                $('tbody#list_penjualan_mem').html(response.html);
            }
        });
    });

    //force integer input in textfield
    $('input.numberinput').bind('keypress', function (e) {
        return (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57) && e.which != 46) ? false : true;
    });
});	

function formatMoney(number) {
    var value = number.toLocaleString(
        'id-ID', 
        { minimumFractionDigits: 2 }
    );
    return value;
}


function hitungTotalReg(){
    let harga = $('#pembayaran_reg').inputmask('unmaskedvalue');
    let totalBiaya = $('#total_harga_global').val();

    harga = harga.replace(",", ".");
    hargaFix = parseFloat(harga).toFixed(2);
    totalBiayaFix = parseFloat(totalBiaya).toFixed(2);
    
    let kembalian = hargaFix - totalBiaya;
    
    if(Number.isNaN(kembalian)) {
        kembalianFix = 0;
    }else{
        kembalianFix = parseFloat(kembalian).toFixed(2);
    }

    // console.log(kembalianFix, Number(hargaFix));
    let kembalianNew = Number(kembalianFix).toFixed(2);
    
    $('#kembalian_reg').val(formatMoney(Number(kembalianNew)));
    $('#span_pembayaran_harga_global').text(formatMoney(Number(hargaFix)));
    $('#span_kembalian_harga_global').text(formatMoney(Number(kembalianNew)));
    
    // set raw value
    $('#pembayaran_reg_raw').val(hargaFix);
    $('#kembalian_reg_raw').val(kembalianFix)
}

function hitungTotalMem(){
    let harga = $('#pembayaran_mem').inputmask('unmaskedvalue');
    let totalBiaya = $('#total_harga_global').val();

    harga = harga.replace(",", ".");
    hargaFix = parseFloat(harga).toFixed(2);
    totalBiayaFix = parseFloat(totalBiaya).toFixed(2);
    
    let kembalian = hargaFix - totalBiaya;
    
    if(Number.isNaN(kembalian)) {
        kembalianFix = 0;
    }else{
        kembalianFix = parseFloat(kembalian).toFixed(2);
    }

    // console.log(kembalianFix, Number(hargaFix));
    let kembalianNew = Number(kembalianFix).toFixed(2);
    
    $('#kembalian_mem').val(formatMoney(Number(kembalianNew)));
    $('#span_pembayaran_harga_global').text(formatMoney(Number(hargaFix)));
    $('#span_kembalian_harga_global').text(formatMoney(Number(kembalianNew)));
    
    // set raw value
    $('#pembayaran_mem_raw').val(hargaFix);
    $('#kembalian_mem_raw').val(kembalianFix)
}

function cariMember(val){
    // console.log(val);
    $.ajax({
        type: "get",
        url  : base_url + "penjualan/get_detail_member",
        data: {kode_member:val},
        dataType: "json",
        success: function (response) {
            if(response.status) {
                $('#labelMemNama').text(response.data.nama);
                $('#labelMemAlamat').text(response.data.alamat);
                $('#labelMemHp').text(response.data.hp);
                $('#labelMemEmail').text(response.data.email);
            }else{
                $('#labelMemNama').text('');
                $('#labelMemAlamat').text('');
                $('#labelMemHp').text('');
                $('#labelMemEmail').text('');
            }
        }
    });
}

//////////////////////////////////////////////////////

function add_menu()
{
    reset_modal_form();
    save_method = 'add';
	$('#modal_user_form').modal('show');
	$('#modal_title').text('Tambah User Baru'); 
}

function edit_user(id)
{
    reset_modal_form();
    save_method = 'update';
    //Ajax Load data from ajax
    $.ajax({
        url : base_url + 'master_user/edit_user',
        type: "POST",
        dataType: "JSON",
        data : {id:id},
        success: function(data)
        {
            // data.data_menu.forEach(function(dataLoop) {
            //     $("#parent_menu").append('<option value = '+dataLoop.id+' class="append-opt">'+dataLoop.nama+'</option>');
            // });
            $('#div_pass_lama').css("display","block");
            $('#div_preview_foto').css("display","block");
            $('#div_skip_password').css("display", "block");
            $('[name="id_user"]').val(data.old_data.id);
            $('[name="username"]').val(data.old_data.username).attr('disabled', true);
            $('[name="role"]').val(data.old_data.id_role);
            $('[name="status"]').val(data.old_data.status);
            // $("#pegawai").val(data.old_data.id_pegawai).trigger("change");
            $('#preview_img').attr('src', 'data:image/jpeg;base64,'+data.foto_encoded);
            $('#modal_user_form').modal('show');
	        $('#modal_title').text('Edit User'); 

        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert('Error get data from ajax');
        }
    });
}

function reload_table()
{
    table.ajax.reload(null,false); //reload datatable ajax 
}

function save()
{
    var url;
    var txtAksi;

    if(save_method == 'add') {
        url = base_url + 'master_user/add_data_user';
        txtAksi = 'Tambah User';
    }else{
        url = base_url + 'master_user/update_data_user';
        txtAksi = 'Edit User';
    }
    
    var form = $('#form-user')[0];
    var data = new FormData(form);
    
    $("#btnSave").prop("disabled", true);
    $('#btnSave').text('Menyimpan Data'); //change button text
    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: url,
        data: data,
        dataType: "JSON",
        processData: false, // false, it prevent jQuery form transforming the data into a query string
        contentType: false, 
        cache: false,
        timeout: 600000,
        success: function (data) {
            if(data.status) {
                swal.fire("Sukses!!", "Aksi "+txtAksi+" Berhasil", "success");
                $("#btnSave").prop("disabled", false);
                $('#btnSave').text('Simpan');
                
                reset_modal_form();
                $(".modal").modal('hide');
                
                reload_table();
            }else {
                for (var i = 0; i < data.inputerror.length; i++) 
                {
                    if (data.inputerror[i] != 'pegawai') {
                        $('[name="'+data.inputerror[i]+'"]').addClass('is-invalid');
                        $('[name="'+data.inputerror[i]+'"]').next().text(data.error_string[i]).addClass('invalid-feedback'); //select span help-block class set text error string
                    }else{
                        //ikut style global
                        $('[name="'+data.inputerror[i]+'"]').next().next().text(data.error_string[i]).addClass('invalid-feedback-select');
                    }
                }

                $("#btnSave").prop("disabled", false);
                $('#btnSave').text('Simpan');
            }
        },
        error: function (e) {
            console.log("ERROR : ", e);
            $("#btnSave").prop("disabled", false);
            $('#btnSave').text('Simpan');

            reset_modal_form();
            $(".modal").modal('hide');
        }
    });
}

function delete_user(id){
    swalConfirmDelete.fire({
        title: 'Hapus Data User ?',
        text: "Data Akan dihapus permanen ?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Ya, Hapus Data !',
        cancelButtonText: 'Tidak, Batalkan!',
        reverseButtons: true
      }).then((result) => {
        if (result.value) {
            $.ajax({
                url : base_url + 'master_user/delete_user',
                type: "POST",
                dataType: "JSON",
                data : {id:id},
                success: function(data)
                {
                    swalConfirm.fire('Berhasil Hapus User!', data.pesan, 'success');
                    table.ajax.reload();
                },
                error: function (jqXHR, textStatus, errorThrown)
                {
                    Swal.fire('Terjadi Kesalahan');
                }
            });
        } else if (
          /* Read more about handling dismissals below */
          result.dismiss === Swal.DismissReason.cancel
        ) {
          swalConfirm.fire(
            'Dibatalkan',
            'Aksi Dibatalakan',
            'error'
          )
        }
    });
}

function reset_modal_form()
{
    $('#form-user')[0].reset();
    $('.append-opt').remove(); 
    $('div.form-group').children().removeClass("is-invalid invalid-feedback");
    $('span.help-block').text('');
    $('#div_pass_lama').css("display","none");
    $('#div_preview_foto').css("display","none");
    $('#div_skip_password').css("display", "none");
    $('#label_foto').text('Pilih gambar yang akan diupload');
    $('#username').attr('disabled', false);
}

function reset_modal_form_import()
{
    $('#form_import_excel')[0].reset();
    $('#label_file_excel').text('Pilih file excel yang akan diupload');
}

function import_excel(){
    $('#modal_import_excel').modal('show');
	$('#modal_import_title').text('Import data user'); 
}

function import_data_excel(){
    var form = $('#form_import_excel')[0];
    var data = new FormData(form);
    
    $("#btnSaveImport").prop("disabled", true);
    $('#btnSaveImport').text('Import Data');
    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: base_url + 'master_user/import_data_master',
        data: data,
        dataType: "JSON",
        processData: false, // false, it prevent jQuery form transforming the data into a query string
        contentType: false, 
        success: function (data) {
            if(data.status) {
                swal.fire("Sukses!!", data.pesan, "success");
                $("#btnSaveImport").prop("disabled", false);
                $('#btnSaveImport').text('Simpan');
            }else {
                swal.fire("Gagal!!", data.pesan, "error");
                $("#btnSaveImport").prop("disabled", false);
                $('#btnSaveImport').text('Simpan');
            }

            reset_modal_form_import();
            $(".modal").modal('hide');
            table.ajax.reload();
        },
        error: function (e) {
            console.log("ERROR : ", e);
            $("#btnSaveImport").prop("disabled", false);
            $('#btnSaveImport').text('Simpan');

            reset_modal_form_import();
            $(".modal").modal('hide');
            table.ajax.reload();
        }
    });
}

function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function(e) {
        $('#div_preview_foto').css("display","block");
        $('#preview_img').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    } else {
        $('#div_preview_foto').css("display","none");
        $('#preview_img').attr('src', '');
    }
}