var save_method;
var table;
var active_div;

const getParameterByName = (name, url = window.location.href) => {
    name = name.replace(/[\[\]]/g, '\\$&');
    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, ' '));
}
const shortcutClass = function() {

    let divActive = '';
    // init function callback
    let defaultFn = function(param1 = 'reguler') {
        this.divActive = param1;
        keyboardJS.bind('f2', (e) => {
            if(this.divActive == 'reguler') {
                $('#selReg').select2('focus');
            }else if(this.divActive == 'member'){
                $('#selMem').select2('focus');
            }
        });
            
    };

     // init function callback
    let submitFn = function(param1 = 'reguler') {
        this.divActive = param1;
        keyboardJS.bind('ctrl + enter', (e) => {
            if(this.divActive == 'reguler') {
                $('#formPenjualanReg').submit();
            }else if(this.divActive == 'member'){
                $('#formPenjualanMem').submit();
            }
        });
        
    };


    return {
        // Init
        init: (param1) => {
            defaultFn(param1);
        },
        initSubmit : (param1) => { 
            submitFn(param1);
        },
        unbindAll : () => {
            keyboardJS.pause();
        }
    };
}();

$(document).ready(function() {
    
    shortcutClass.init();

    // if (sessionStorage.dariEditPenjualan == "true") {
    //     alert('asas');
    //     sessionStorage.removeItem("dariEditPenjualan");
    // }

    let cekUri = getParameterByName('token');
    if(cekUri !== null) {
        $.ajax({
            type: "post",
            url : base_url + 'penjualan/get_data_penjualan_edit',
            data: {id:cekUri},
            dataType: "json",
            success: function (response) {
                if(response.status) {
                    if(response.data.id_member != '1') {
                        $('#divReguler').css("display", "block");
                        $('#divMember').css("display", "none");
                        $('span#inv_reg').text(response.data.kode);
                        active_div = 'reguler';
                    }else{
                        $('#divReguler').css("display", "none");
                        $('#divMember').css("display", "block");
                        $('#inv_mem').text(response.data.kode);
                        active_div = 'member';
                        $('#member_id').focus();
                    }
            
                    $('html, body').animate({
                        scrollTop: $(".form_penjualan_area").offset().top
                    }, 300);
                    reInitSelectMulti();
                }else{
                    window.location = base_url+'penjualan';
                }
               
            }
        });
    }  

    $('#formPenjualanReg').submit(function (e) { 
        e.preventDefault();
        var form = $('#formPenjualanReg')[0];
        var data = new FormData(form);
        swalConfirm.fire({
            title: 'Simpan Data Transaksi ?',
            text: "(Klik/Enter untuk Simpan | Esc Untuk Batal)",
            type: 'warning',
            // showCancelButton: true,
            confirmButtonText: 'Ya, Simpan Data !',
            // cancelButtonText: 'Tidak, Batalkan!',
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
                            $('.div-button-area').html(data.button);
                            printStruk(data.id_trans);
                            disableAllBind();
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
            text: "(Klik/Enter untuk Simpan | Esc Untuk Batal)",
            type: 'warning',
            // showCancelButton: true,
            confirmButtonText: 'Ya, Simpan Data !',
            // cancelButtonText: 'Tidak, Batalkan!',
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
                            $('.div-button-area').html(data.button);
                            printStruk(data.id_trans);
                            disableAllBind();
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
                    active_div = 'reguler';
                }else{
                    $('#divReguler').css("display", "none");
                    $('#divMember').css("display", "block");
                    $('#inv_mem').text(response);
                    active_div = 'member';
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
    $('#kembalian_reg_raw').val(kembalianFix);

    if(kembalianFix < 0) {
        $('.btnSubmit').attr('disabled', 'disabled');
    }else{
        $('.btnSubmit').removeAttr('disabled');

        shortcutClass.initSubmit(active_div);
    }
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

    if(kembalianFix < 0) {
        $('.btnSubmit').attr('disabled', 'disabled');
    }else{
        $('.btnSubmit').removeAttr('disabled');

        keyboardJS.bind('ctrl + enter', (e) => {
            if(active_div == 'reguler') {
                $('#formPenjualanReg').submit();
            }else if(active_div == 'member'){
                $('#formPenjualanMem').submit();
            }
        });
    }
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
            
            $('#counter_member').text('Counter Member : '+response.counter);
        }
    });
}

function printStruk(id_trans) 
{
    $.ajax({
        type: "get",
        url:  base_url+"penjualan/cetak_struk/"+id_trans,
        dataType: "json",
        // data: {id_trans:id_trans},
        success: function (response) {
           return;     
        }
    });
    
}

function disableAllBind() {
    shortcutClass.unbindAll();
}
//////////////////////////////////////////////////////
