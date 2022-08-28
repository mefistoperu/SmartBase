function openModalEdit()
{
	$('#ModalMarcaEdit').modal('show');

	var arr = [];

	$('#tblistado > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#update_id').val(arr[0]);
			$('#update_nombre').val(arr[1]);
		});
}



function openModalDel()
{
	$('#ModalMarcaDelete').modal('show');

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
