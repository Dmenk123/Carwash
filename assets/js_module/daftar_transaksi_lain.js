var save_method;
var table;

const formatRupiah = new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
    maximumSignificantDigits: 1
});

const formatMoney = (number) => {
    var value = number.toLocaleString(
        'id-ID', 
        { minimumFractionDigits: 2 }
    );
    return value;
}

const formatTanggal = (tgl) => {
  let formatnya = 'DD-MM-YYYY HH:mm:ss';
  let objDate = new Date(tgl);
  return moment(objDate).format(formatnya);
};

const formatTanggalCustom = (tgl, format) => {
    let formatnya = format;
    let objDate = new Date(tgl);
    return moment(objDate).format(formatnya);
};

const filter_tabel = () => {
    //datatables
    let tglAwal = $('#tgl_filter_mulai').val();
    let tglAkhir = $('#tgl_filter_akhir').val();
    let jenis = $('#jenis').val();

	table = $('#tabel_list_transaksi').DataTable({
        destroy: true,
        responsive: true,
        searchDelay: 500,
        processing: true,
        serverSide: true,
		ajax: {
			url  : base_url + "daftar_transaksi_lain/list_transaksi",
			type : "POST",
            data : {tglAwal:tglAwal, tglAkhir:tglAkhir, jenis:jenis},
		},
        order: [[ 0, "desc" ]],

		//set column definition initialisation properties
		columnDefs: [
			{
				targets: [-1], //last column
				orderable: false, //set not orderable
			},
            // {
            //     targets: [4,5,6],
            //     className: 'dt-body-right'
            // }
		],
    });
};

const hitungTotalBeli = () => {
    let harga = $('#harga_beli').inputmask('unmaskedvalue');
    let qty = $('#qty_beli').inputmask('unmaskedvalue');
    
    harga = harga.replace(",", ".");
    hargaFix = parseFloat(harga).toFixed(2);
    
    let total = hargaFix * qty;
    let totalFix = Number(total).toFixed(2);
    $('#hargatot_beli').val(formatMoney(Number(totalFix)));

    // set raw value
    $('#harga_beli_raw').val(hargaFix);
    $('#hargatot_beli_raw').val(totalFix);
}

const loadModalPembelian = (dataTrans) => {
    (() => {
        $("#item_beli").select2({
            tokenSeparators: [',', ' '],
            minimumInputLength: 0,
            minimumResultsForSearch: 5,
            ajax: {
                url: base_url+'master_item_trans/get_select_pembelian',
                dataType: "json",
                type: "GET",
                data: function (params) {
    
                    var queryParameters = {
                        term: params.term
                    }
                    return queryParameters;
                },
                processResults: function (data) {
                    return {
                        results: $.map(data, function (item) {
                            return {
                                text: item.text,
                                id: item.id,
                                harga: item.harga
                            }
                        })
                    };
                }
            }
        });

        $("#sup_beli").select2({
            // tags: true,
            //multiple: false,
            tokenSeparators: [',', ' '],
            minimumInputLength: 0,
            minimumResultsForSearch: 5,
            ajax: {
                url: base_url+'master_supplier/get_select_supplier',
                dataType: "json",
                type: "GET",
                data: function (params) {
    
                    var queryParameters = {
                        term: params.term
                    }
                    return queryParameters;
                },
                processResults: function (data) {
                    return {
                        results: $.map(data, function (item) {
                            return {
                                text: item.text,
                                id: item.id,
                            }
                        })
                    };
                }
            }
        });
    })();

    $('#item_beli').on('select2:selecting', function(e) {
        let data = e.params.args.data;
        let hargaFix = Number(data.harga).toFixed(2);
        $('#harga_beli').val(formatMoney(Number(hargaFix)));
        $('#harga_beli_raw').val(hargaFix);
    });

    $('#tgl_beli').val(formatTanggalCustom(dataTrans.tgl_trans, 'DD/MM/YYYY'));
    // var $newOption = $("<option selected='selected'></option>").val("TheID").text("The text")
 
    $("#item_beli").append(() => {
        return $("<option selected='selected'></option>").val(dataTrans.id_item_trans).text(dataTrans.nama_item);
    }).trigger('change');    

    $("#sup_beli").append(() => {
        return $("<option selected='selected'></option>").val(dataTrans.id_supplier).text(dataTrans.nama_supplier);
    }).trigger('change');    

    $('#div-pembelian-modal').modal('show');
}
  
$(document).ready(function() {
    filter_tabel();

    //force integer input in textfield
    $('input.numberinput').bind('keypress', function (e) {
        return (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57) && e.which != 46) ? false : true;
    });

    //change menu status
    $(document).on('click', '.btn_edit_status', function(){
        var id = $(this).attr('id');
        var status = $(this).val();
        swalConfirmDelete.fire({
            title: 'Ubah Status Data Pegawai ?',
            text: "Apakah Anda Yakin ?",
            type: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Ya, Ubah Status!',
            cancelButtonText: 'Tidak, Batalkan!',
            reverseButtons: true
          }).then((result) => {
            if (result.value) {
                $.ajax({
                    url : base_url + 'master_pegawai/edit_status_pegawai',
                    type: "POST",
                    dataType: "JSON",
                    data : {status : status, id : id},
                    success: function(data)
                    {
                        swalConfirm.fire('Berhasil Ubah Status Pegawai!', data.pesan, 'success');
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
    });

    $(".modal").on("hidden.bs.modal", function(){
        reset_modal_form();
        reset_modal_form_import();
    });
});	


function detailTransLain(id) {
    $.ajax({
        url : base_url + 'daftar_transaksi_lain/get_detail_transaksi',
        type: "GET",
        dataType: "JSON",
        data : {id:id},
        success: function(response)
        {
            if(response.status) {
                $('#modal_detail_transaksi').modal('show');
                // $('#spn-invoice').text(response.data[0].kode);
                $('#spn-tanggal').text(formatTanggalCustom(response.data[0].tgl_trans, 'DD-MM-YYYY'));
                $('#spn-user').text(response.data[0].nama_user);
                $('#spn-total').text(formatRupiah.format(response.data[0].harga_total));
                $('#div_tabel_detail').html(response.html);
                $('#div_button_detail').html(response.html2);
                $('#div_supplier_modal').html(response.html3);
            }else{
                alert('Terjadi Kesalahan');
            }
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert('Error get data from ajax');
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

function toggleKunci(id_trans) {
    swalConfirm.fire({
        title: 'Perhatian !!!',
        text: "Yakin Buka/Kunci Transaksi ?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Ya!, Buka/Kunci Transaksi',
        cancelButtonText: 'Tidak, Batalkan!',
        reverseButtons: true
      }).then((result) => {
        if (result.value) {
            $.ajax({
                type: "POST",
                url : base_url + 'daftar_penjualan/toggle_kunci',
                data: {id_trans:id_trans},
                dataType: "JSON",
                // processData: false, // false, it prevent jQuery form transforming the data into a query string
                // contentType: false, 
                cache: false,
                timeout: 600000,
                success: function(data)
                {
                    if(data.status) {
                        swalConfirm.fire('Berhasil !!', data.pesan, 'success');
                        filter_tabel();
                    }else{
                        swalConfirm.fire('Gagal !!', data.pesan, 'error');
                        filter_tabel();
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
}

// function editPenjualan(id) {
//     sessionStorage.setItem("dariEditPenjualan", "true");
//     window.open(base_url+'penjualan?token='+id, '_blank');
// }

///////////////

function add_tindakan()
{
    reset_modal_form();
    save_method = 'add';
	$('#modal_pegawai_form').modal('show');
	$('#modal_title').text('Entry data Jenis Transaksi'); 
}

function editTransLain(id)
{
    // alert('tes'); exit;
    // reset_modal_form();
    save_method = 'update';
    //Ajax Load data from ajax
    $.ajax({
        url : base_url + 'daftar_transaksi_lain/edit_data',
        type: "POST",
        dataType: "JSON",
        data : {id:id},
        success: function(response)
        {
            if(response.status) {
                if(response.jenis_trans == 'pembelian') {
                    loadModalPembelian(response.data);
                }else if(response.jenis_trans == 'penggajian'){
                    loadModalPenggajian(response.data);
                }else if(response.jenis_trans == 'investasi'){
                    loadModalInvestasi(response.data);
                }else if(response.jenis_trans == 'operasional'){
                    loadModalOperasional(response.data);
                }else if(response.jenis_trans == 'out_lain'){
                    loadModalPengeluaranLain(response.data);
                }else if(response.jenis_trans == 'in_lain'){
                    loadModalPenerimaanLain(response.data);
                }
            }
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
        url = base_url + 'master_item_trans/add_data_item_trans';
        txtAksi = 'Tambah Item Transaksi';
    }else{
        url = base_url + 'master_item_trans/update_data_item_trans';
        txtAksi = 'Edit Item Transaksi';
    }
    
    var form = $('#form-pegawai')[0];
    var data = new FormData(form);
    
    $("#btnSave").prop("disabled", true);
    $('#btnSave').text('Menyimpan Data'); //change button text
    swalConfirmDelete.fire({
        title: 'Perhatian !!',
        text: "Apakah anda yakin menambah data ini ?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Ya',
        cancelButtonText: 'Tidak',
        reverseButtons: true
      }).then((result) => {
        if (result.value) {
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
                            if (data.inputerror[i] != 'jabatans') {
                                $('[name="'+data.inputerror[i]+'"]').addClass('is-invalid');
                                $('[name="'+data.inputerror[i]+'"]').next().text(data.error_string[i]).addClass('invalid-feedback'); //select span help-block class set text error string
                            }else{
                                $($('#jabatans').data('select2').$container).addClass('has-error');
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
      })
    
}

function delete_item_trans(id){
    swalConfirmDelete.fire({
        title: 'Peringatan !',
        text: "Data Akan dihapus permanen ?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Ya, Hapus Data !',
        cancelButtonText: 'Tidak, Batalkan!',
        reverseButtons: true
      }).then((result) => {
        if (result.value) {
            $.ajax({
                url : base_url + 'master_item_trans/delete_item_trans',
                type: "POST",
                dataType: "JSON",
                data : {id:id},
                success: function(data)
                {
                    swalConfirm.fire('Berhasil Hapus data item transaksi!', data.pesan, 'success');
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
    $('#form-pegawai')[0].reset();
    $('.append-opt').remove(); 
    $('div.form-group').children().removeClass("is-invalid invalid-feedback");
    $('span.help-block').text('');
    $('#div_pass_lama').css("display","none");
}

function reset_modal_form_import()
{
    $('#form_import_excel')[0].reset();
    $('#label_file_excel').text('Pilih file excel yang akan diupload');
}

function import_excel(){
    $('#modal_import_excel').modal('show');
	$('#modal_import_title').text('Import data pegawai'); 
}

function import_data_excel(){
    var form = $('#form_import_excel')[0];
    var data = new FormData(form);
    
    $("#btnSaveImport").prop("disabled", true);
    $('#btnSaveImport').text('Import Data');
    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: base_url + 'master_pegawai/import_data_master',
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