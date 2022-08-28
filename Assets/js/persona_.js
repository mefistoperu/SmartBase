function openModalEdit()
{
	$('#ModalClientesEdit').modal('show');

	var arr = [];

	$('#datatable-responsive > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#update_id').val(arr[1]);
			$('#update_correo').val(arr[5]);
		});
}
