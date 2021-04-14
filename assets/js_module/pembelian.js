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

$(document).ready(function() {
    
    $("#item_beli").select2({
        // tags: true,
        //multiple: false,
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

    // $('#diagnosa').on('select2:selecting', function(e) {
        // let data = e.params.args.data;
        
        // $('#nik').val(data.nik);
        // $('#no_rm').val(data.no_rm);
        // $('#tempat_lahir').val(data.tempat_lahir);
        // let tgl_lhr = data.tanggal_lahir;
        // $('#tanggal_lahir').val(tgl_lhr.split("-").reverse().join("/"));
        // $('#umur_reg').val(data.umur);
        // $('#pemetaan').val(data.pemetaan);
    // });
    
});

function reloadFormPembelian(){
    $('#CssLoader').removeClass('hidden');
    $.ajax({
        type: "post",
        url: base_url+"trans_lain/load_form_pembelian",
        data: {
            id_peg: id_peg,
            id_psn: id_psn,
            id_reg: id_reg
        },
        dataType: "json",
        success: function (response) {
           $('#CssLoader').addClass('hidden');
           $('#tabel_modal_diagnosa tbody').html(response.html);
        }
    });
}


function hapus_diagnosa_det(id) {
    swalConfirmDelete.fire({
        title: 'Hapus Data Diagnosa ?',
        text: "Data Akan dihapus ?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Ya, Hapus Data !',
        cancelButtonText: 'Tidak, Batalkan!',
        reverseButtons: true
      }).then((result) => {
        if (result.value) {
            $.ajax({
                url : base_url + 'trans_lain/delete_data_pembelian',
                type: "POST",
                dataType: "JSON",
                data : {id:id},
                success: function(data)
                {
                    swalConfirm.fire('Berhasil Hapus Data!', data.pesan, 'success');
                    reloadFormDiagnosa();
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
