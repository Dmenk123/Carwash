let slug_trans;
let activeModal;

$(document).ready(function() {

    //force integer input in textfield
    $('input.numberinput').bind('keypress', function (e) {
        return (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57) && e.which != 46) ? false : true;
    });

    $(document).on('click', '.div_menu', function(){
        var nama_menu = $(this).data('id');
        slug_trans = $(this).data('slug');
        activeModal =  nama_menu+'-modal';
        // cekDanSetValue(activeModal);
        $('#'+nama_menu+'-modal').modal('show');
        
    });
    
    //////////////////////////////////////////////////////////////
});

function formatMoney(number) {
    var value = number.toLocaleString(
        'id-ID', 
        { minimumFractionDigits: 2 }
    );
    return value;
}


function show_modal_pasien() {
    $('#modal_pilih_pasien').modal('show');
    $('#modal_pilih_pasien_title').text('Pilih Pasien'); 
}

function cari_pasien() {
    let form = $('#form_cari_pasien')[0];
    let data = new FormData(form);

    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: base_url+'rekam_medik/cari_pasien',
        data: data,
        dataType: "JSON",
        processData: false,
        contentType: false, 
        cache: false,
        timeout: 600000,
        success: function (response) {
            if(response.status) {
                $('#tabel_pilih_pasien tbody').html(response.data);
            }else{
                swalConfirm.fire('Gagal','Data Tidak Ditemukan','error');
            }
        }
    });
}

function pilih_pasien(enc_id){
    $.ajax({
        type: "post",
        url: base_url+'rekam_medik/hasil_pilih_pasien',
        data: {enc_id:enc_id},
        dataType: "json",
        success: function (response) {
            $('#tabel_pasien tbody').html(response.data);
            id_reg = response.data_id.id_reg;
            id_peg = response.data_id.id_peg;
            id_psn = response.data_id.id_psn;
            $('#modal_pilih_pasien').modal('hide');
        }
    });
}

function save(id_form)
{
    let str1 = '#';
    let id_element = str1.concat(id_form);
    var form = $(id_element)[0];
    //console.log(form);
    var data = new FormData(form);
    data.append('slug_trans', slug_trans);
    $("#btnSave").prop("disabled", true);
    $('#btnSave').text('Menyimpan Data'); //change button text
    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: base_url+'trans_lain/simpan_'+id_form,
        data: data,
        dataType: "JSON",
        processData: false,
        contentType: false, 
        cache: false,
        timeout: 600000,
        success: function (data) {
            if(data.status) {
                swal.fire({
                    title: "Sukses!!", 
                    text: data.pesan, 
                    type: "success"
                }).then(function() {
                    $("#btnSave").prop("disabled", false);
                    $('#btnSave').text('Simpan');      
                    if(id_form == 'form_pembelian') {
                        reloadFormPembelian();
                    }else if(id_form == 'form_tindakan'){
                        reloadFormTindakan();
                    }else if(id_form == 'form_logistik'){
                        reloadFormLogistik();
                    }else if(id_form == 'form_kamera'){
                        reloadFormKamera();
                    }else if(id_form == 'form_tindakanlab'){
                        reloadFormTindakanLab();
                    }else{
                        $('#'+activeModal).modal('hide');
                    }
                });
                // swal.fire("Sukses!!", data.pesan, "success");     
            }else {
                for (var i = 0; i < data.inputerror.length; i++) 
                {
                    if (data.is_select2[i] == false) {
                        $('[name="'+data.inputerror[i]+'"]').addClass('is-invalid');
                        $('[name="'+data.inputerror[i]+'"]').next().text(data.error_string[i]).addClass('invalid-feedback');
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
        }
    });
}

// function cekDanSetValue(txt_div_modal){
//     let menu = txt_div_modal.split("_");
//     let retval = $.ajax({
//         type: "post",
//         url: base_url+"rekam_medik/get_old_data",
//         data: {
//             menu:menu[1], 
//             id_peg:id_peg,
//             id_psn:id_psn,
//             id_reg:id_reg
//         },
//         dataType: "json",
//         success:setModalFieldValue,
//     });

//     function setModalFieldValue(objData){
//         console.log(objData);
//         if(objData.menu == 'anamnesa') {
//             $("#form_anamnesa input[name='id_anamnesa']").val(objData.data.id);
//             $("#form_anamnesa textarea[name='anamnesa']").val(objData.data.anamnesa);
//         }else if(objData.menu == 'diagnosa'){
//             reloadFormDiagnosa();
//         }else if(objData.menu == 'tindakan'){
//             reloadFormTindakan();
//         }else if(objData.menu == 'logistik'){
//             reloadFormLogistik();
//         }else if(objData.menu == 'kamera'){
//             reloadFormKamera();
//         }else if(objData.menu == 'tindakanlab'){
//             reloadFormTindakanLab();
//         }else if(objData.menu == 'diskon'){
//             reloadFormDiskon();
//         }
//     }
    
//     return;
// }



////////////////////////////////////////////////////////////////////////////

// function reload_table()
// {
//     table.ajax.reload(null,false); 
// }

// function reload_table2()
// {
//     table2.ajax.reload(null,false); 
// }

function reset_form(jqIdForm) {
    $(':input','#'+jqIdForm)
        .not(':button, :submit, :reset, :hidden')
        .val('')
        .prop('checked', false)
        .prop('selected', false);
}

function get_uri_segment(segment) {
    var pathArray = window.location.pathname.split( '/' );
    return pathArray[segment];
}