function openModalEdit()
{
	$('#ModalClientesEdit').modal('show');

	var arr = [];

	$('#datatable-ventas > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#update_id').val(arr[1]);
			$('#update_direccion').val(arr[5]);
			$('#update_departamento').val(arr[6]);
            $('#update_provincia').val(arr[7]);
            $('#update_distrito').val(arr[8]);
			$('#update_correo').val(arr[9]);
		});
}

