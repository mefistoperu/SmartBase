function openModalEdit()
{
	$('#ModalUnidadEdit').modal('show');

	var arr = [];

	$('#tblistado > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#update_id').val(arr[0]);
			$('#update_nombre').val(arr[1]);
			$('#update_codigo').val(arr[2]);
			$('#update_factor').val(arr[3]);
		});
}



function openModalDel()
{
	$('#ModalUnidadDelete').modal('show');

	var arr = [];

	$('#tblistado > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#delete_id').val(arr[0]);
			
		});
}
